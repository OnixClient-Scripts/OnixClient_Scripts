DiscordRPC = {}

local connected = false
local clientId = nil
local dataDir = nil

local function getDataDir()
    if dataDir then return dataDir end
    local env = os.getenv("LOCALAPPDATA")
    if env then
        dataDir = env .. "\\Packages\\MICROSOFT.MINECRAFTUWP_8wekyb3d8bbwe\\RoamingState\\OnixClient\\Scripts\\Data"
    end
    return dataDir
end

local function writeFileRaw(fileName, content)
    local f = io.open(fileName, "w")
    if not f then return false end
    f:write(content)
    f:close()
    return true
end

local function writeDaemonScript()
    local script = [=[
$ErrorActionPreference = 'Stop'
$dataDir = $args[0]
$clientId = $args[1]
$cmdFile = Join-Path $dataDir 'discord_rpc_cmd.json'
$statusFile = Join-Path $dataDir 'discord_rpc_status.json'
$heartbeatFile = Join-Path $dataDir 'discord_rpc_heartbeat.txt'

function Write-Status($status, $msg) {
    $json = '{"status":"' + $status + '","message":"' + ($msg -replace '"','\"') + '","time":' + [int][double]::Parse((Get-Date -UFormat %s)) + '}'
    [System.IO.File]::WriteAllText($statusFile, $json)
}

function Write-Packet($stream, $opcode, $payload) {
    $bytes = [System.Text.Encoding]::UTF8.GetBytes($payload)
    $buf = New-Object byte[] (8 + $bytes.Length)
    [Array]::Copy([BitConverter]::GetBytes([int32]$opcode), 0, $buf, 0, 4)
    [Array]::Copy([BitConverter]::GetBytes([int32]$bytes.Length), 0, $buf, 4, 4)
    [Array]::Copy($bytes, 0, $buf, 8, $bytes.Length)
    $stream.Write($buf, 0, $buf.Length)
    $stream.Flush()
}

function Read-Packet($stream) {
    $header = New-Object byte[] 8
    $read = $stream.Read($header, 0, 8)
    if ($read -lt 8) { return $null }
    $opcode = [BitConverter]::ToInt32($header, 0)
    $length = [BitConverter]::ToInt32($header, 4)
    if ($length -gt 0) {
        $payload = New-Object byte[] $length
        $totalRead = 0
        while ($totalRead -lt $length) {
            $r = $stream.Read($payload, $totalRead, $length - $totalRead)
            if ($r -eq 0) { break }
            $totalRead += $r
        }
        return @{ Op = $opcode; Data = [System.Text.Encoding]::UTF8.GetString($payload, 0, $totalRead) }
    }
    return @{ Op = $opcode; Data = '' }
}

try {
    Write-Status 'connecting' 'Looking for Discord...'

    $pipe = $null
    for ($i = 0; $i -le 9; $i++) {
        try {
            $p = New-Object System.IO.Pipes.NamedPipeClientStream('.', "discord-ipc-$i", [System.IO.Pipes.PipeDirection]::InOut)
            $p.Connect(2000)
            $pipe = $p
            break
        } catch {
        }
    }

    if (-not $pipe) {
        Write-Status 'error' 'No Discord pipe found'
        exit 1
    }

    $handshake = '{"v":1,"client_id":"' + $clientId + '"}'
    Write-Packet $pipe 0 $handshake
    $resp = Read-Packet $pipe
    if (-not $resp -or $resp.Op -eq 2) {
        Write-Status 'error' 'Handshake rejected'
        $pipe.Close()
        exit 1
    }
    Write-Status 'connected' 'Connected to Discord'

    $lastCmdTime = $null

    while ($true) {
        Start-Sleep -Milliseconds 500

        if (-not $pipe.IsConnected) {
            Write-Status 'error' 'Discord disconnected'
            break
        }

        if (Test-Path $heartbeatFile) {
            $hbTime = [int64][System.IO.File]::ReadAllText($heartbeatFile).Trim()
            $now = [DateTimeOffset]::UtcNow.ToUnixTimeSeconds()
            if (($now - $hbTime) -gt 10) {
                $nonce = [guid]::NewGuid().ToString()
                $clearFrame = '{"cmd":"SET_ACTIVITY","args":{"pid":0},"nonce":"' + $nonce + '"}'
                try {
                    Write-Packet $pipe 1 $clearFrame
                    $r = Read-Packet $pipe
                } catch {}
                Write-Packet $pipe 2 '{}'
                Write-Status 'closed' 'Game closed'
                $pipe.Close()
                break
            }
        }

        if (Test-Path $cmdFile) {
            $cmdContent = [System.IO.File]::ReadAllText($cmdFile)
            $cmd = $cmdContent | ConvertFrom-Json

            if ($cmd.time -ne $lastCmdTime) {
                $lastCmdTime = $cmd.time

                if ($cmd.action -eq 'set_activity') {
                    $nonce = [guid]::NewGuid().ToString()
                    $frame = '{"cmd":"SET_ACTIVITY","args":{"pid":0,"activity":' + $cmd.activity_json + '},"nonce":"' + $nonce + '"}'
                    Write-Packet $pipe 1 $frame
                    $resp2 = Read-Packet $pipe
                    if ($resp2 -and $resp2.Op -eq 1) {
                        Write-Status 'connected' 'Activity updated'
                    } else {
                        Write-Status 'error' 'Failed to set activity'
                    }
                }
                elseif ($cmd.action -eq 'clear_activity') {
                    $nonce = [guid]::NewGuid().ToString()
                    $frame = '{"cmd":"SET_ACTIVITY","args":{"pid":0},"nonce":"' + $nonce + '"}'
                    Write-Packet $pipe 1 $frame
                    $resp2 = Read-Packet $pipe
                    Write-Status 'connected' 'Activity cleared'
                }
                elseif ($cmd.action -eq 'close') {
                    $nonce = [guid]::NewGuid().ToString()
                    $clearFrame = '{"cmd":"SET_ACTIVITY","args":{"pid":0},"nonce":"' + $nonce + '"}'
                    Write-Packet $pipe 1 $clearFrame
                    try { $r = Read-Packet $pipe } catch {}
                    Write-Packet $pipe 2 '{}'
                    Write-Status 'closed' 'Disconnected'
                    $pipe.Close()
                    break
                }
            }
        }
    }
} catch {
    Write-Status 'error' "$_"
}
finally {
    if ($pipe -and $pipe.IsConnected) {
        try { $pipe.Close() } catch {}
    }
}
]=]

    return writeFileRaw("discord_rpc_daemon.ps1", script)
end

local function writeLauncherVbs(scriptPath, dir, cId)
    local vbs = 'Set ws = CreateObject("WScript.Shell")\n' ..
        'ws.Run "powershell -NoProfile -WindowStyle Hidden -ExecutionPolicy Bypass -File ""' ..
        scriptPath .. '"" ""' .. dir .. '"" ""' .. cId .. '""", 0, False\n'
    return writeFileRaw("discord_rpc_launch.vbs", vbs)
end

local function readStatus()
    local jsonStr = jsonFromFile("discord_rpc_status.json")
    if not jsonStr or jsonStr == "" then return nil end
    local ok, result = pcall(jsonToTable, jsonStr)
    if ok and result then return result end
    return nil
end

local cmdCounter = 0

local function writeCommand(action, extraFields)
    cmdCounter = cmdCounter + 1
    local cmd = {
        action = action,
        time = tostring(os.time()) .. "-" .. tostring(cmdCounter)
    }
    if extraFields then
        for k, v in pairs(extraFields) do
            cmd[k] = v
        end
    end
    local jsonStr = tableToJson(cmd)
    local f = io.open("discord_rpc_cmd.json", "w")
    if f then
        f:write(jsonStr)
        f:close()
        return true
    end
    return false
end

function DiscordRPC.writeHeartbeat()
    local f = io.open("discord_rpc_heartbeat.txt", "w")
    if f then
        f:write(tostring(os.time()))
        f:close()
        return true
    end
    return false
end

local daemonLaunched = false

function DiscordRPC.connect(appId)
    if connected then return nil, "Already connected" end

    clientId = appId
    local dir = getDataDir()
    if not dir then return nil, "Cannot determine data directory" end

    local fStatus = io.open("discord_rpc_status.json", "w")
    if fStatus then fStatus:write(""); fStatus:close() end
    
    local fCmd = io.open("discord_rpc_cmd.json", "w")
    if fCmd then fCmd:write(""); fCmd:close() end
    
    DiscordRPC.writeHeartbeat()

    if not writeDaemonScript() then
        return nil, "Cannot write daemon script"
    end

    local scriptPath = dir .. "\\discord_rpc_daemon.ps1"

    writeLauncherVbs(scriptPath, dir, clientId)
    local vbsPath = dir .. "\\discord_rpc_launch.vbs"
    local launchCmd = 'wscript "' .. vbsPath .. '"'
    io.popen(launchCmd)
    daemonLaunched = true

    return true
end

function DiscordRPC.pollConnection()
    if connected or not daemonLaunched then return connected end
    local status = readStatus()
    if status then
        if status.status == "connected" then
            connected = true
            return true
        elseif status.status == "error" then
            daemonLaunched = false
            return false, status.message
        end
    end
    return false
end

function DiscordRPC.disconnect()
    if daemonLaunched then
        writeCommand("close")
    end
    connected = false
    daemonLaunched = false
    return true
end

function DiscordRPC.reconnect(appId)
    DiscordRPC.disconnect()
    return DiscordRPC.connect(appId or clientId)
end

function DiscordRPC.isConnected()
    if connected and daemonLaunched then
        local status = readStatus()
        if status and status.status == "error" then
            connected = false
        end
    end
    return connected
end

function DiscordRPC.setActivity(activity)
    if not connected then return nil, "Not connected" end
    local activityJson = tableToJson(activity)
    writeCommand("set_activity", { activity_json = activityJson })
    return true
end

function DiscordRPC.clearActivity()
    return DiscordRPC.setActivity(nil)
end

local activityBuilder = nil
local waitingForConnection = false
local connectionWaitTimer = 0
local reconnectTimer = 0
local RECONNECT_INTERVAL = 30
local updateTimer = 0
local UPDATE_INTERVAL = 15
local forceUpdateActivity = false

function DiscordRPC.init(appId, builderFn)
    activityBuilder = builderFn
    clientId = appId
    
    if not clientId or clientId == "" then
        return false, "Application ID is empty"
    end
    
    updateTimer = 0
    reconnectTimer = 0
    waitingForConnection = true
    connectionWaitTimer = 0
    forceUpdateActivity = false
    
    local ok, err = DiscordRPC.connect(clientId)
    return ok, err
end

function DiscordRPC.shutdown()
    DiscordRPC.disconnect()
    activityBuilder = nil
    waitingForConnection = false
end

function DiscordRPC.forceUpdate()
    forceUpdateActivity = true
    updateTimer = UPDATE_INTERVAL
end

function DiscordRPC.update(dt)
    if not clientId or clientId == "" then return end
    
    DiscordRPC.writeHeartbeat()
    
    if waitingForConnection then
        local result, err = DiscordRPC.pollConnection()
        if result == true then
            waitingForConnection = false
            DiscordRPC.forceUpdate()
            return
        end
        if err then
            waitingForConnection = false
        end
        connectionWaitTimer = connectionWaitTimer + dt
        if connectionWaitTimer > 10 then
            waitingForConnection = false
        end
        return
    end

    if not DiscordRPC.isConnected() then
        reconnectTimer = reconnectTimer + dt
        if reconnectTimer >= RECONNECT_INTERVAL then
            reconnectTimer = 0
            local ok, err = DiscordRPC.connect(clientId)
            if ok then
                waitingForConnection = true
                connectionWaitTimer = 0
            end
        end
        return
    end

    updateTimer = updateTimer + dt
    if updateTimer >= UPDATE_INTERVAL or forceUpdateActivity then
        forceUpdateActivity = false
        updateTimer = 0
        if activityBuilder then
            local act = activityBuilder()
            DiscordRPC.setActivity(act)
        end
    end
end
