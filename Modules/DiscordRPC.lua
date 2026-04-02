name = "Discord RPC"
description = "Discord Rich Presence without external helper program"

importLib("DiscordRPC")
local updateTimer = 0
local UPDATE_INTERVAL = 15
local startTime = nil
local reconnectTimer = 0
local RECONNECT_INTERVAL = 30
local waitingForConnection = false

local prevCustomDetails = nil
local prevCustomState = nil
local prevShowServerInfo = nil

AppId = ""
ShowServerInfo = true
CustomState = ""
CustomDetails = ""

client.settings.addTextbox("Application ID", "AppId")
client.settings.addAir(4)
client.settings.addBool("Show Server Info", "ShowServerInfo")
client.settings.addTextbox("Details", "CustomDetails")
client.settings.addTextbox("State", "CustomState")

local function getServerInfo()
    local ok, ip = pcall(function() return server.ip() end)
    if not ok or not ip or ip == "" then return nil end
    local portOk, port = pcall(function() return server.port() end)
    if portOk and port and port ~= 0 and port ~= 19132 then
        return ip .. ":" .. tostring(port)
    end
    return ip
end

local function buildActivity()
    local activity = {}

    if CustomDetails ~= nil and CustomDetails ~= "" then
        activity.details = CustomDetails
    else
        activity.details = "Playing Minecraft Bedrock"
    end

    if CustomState ~= nil and CustomState ~= "" then
        activity.state = CustomState
    end

    if ShowServerInfo then
        local info = getServerInfo()
        if info then
            if activity.state then
                activity.state = activity.state .. " | " .. info
            else
                activity.state = "On " .. info
            end
        else
            if activity.state then
                activity.state = activity.state .. " | Singleplayer"
            else
                activity.state = "Singleplayer"
            end
        end
    end

    if startTime then
        activity.timestamps = {
            start = startTime
        }
    end

    activity.assets = {
        large_image = "large_image",
        large_text = "large_text",
        small_image = "small_image",
        small_text = "Small text: " .. (client.version or "")
    }

    return activity
end

local function updateActivity()
    if not DiscordRPC.isConnected() then
        return
    end
    local activity = buildActivity()
    DiscordRPC.setActivity(activity)
end

local function settingsChanged()
    local changed = false
    if prevCustomDetails ~= CustomDetails then changed = true end
    if prevCustomState ~= CustomState then changed = true end
    if prevShowServerInfo ~= ShowServerInfo then changed = true end
    prevCustomDetails = CustomDetails
    prevCustomState = CustomState
    prevShowServerInfo = ShowServerInfo
    return changed
end

function onEnable()
    startTime = os.time()

    prevCustomDetails = CustomDetails
    prevCustomState = CustomState
    prevShowServerInfo = ShowServerInfo

    if AppId == nil or AppId == "" then
        print("[Discord RPC] Set your Application ID in module settings")
        return
    end

    local ok, err = DiscordRPC.init(AppId, buildActivity)
    if not ok then
        print("[Discord RPC] " .. tostring(err))
    else
        print("[Discord RPC] Connecting...")
    end
end

function onDisable()
    DiscordRPC.shutdown()
    startTime = nil
    print("[Discord RPC] Disconnected")
end

function update(dt)
    if settingsChanged() then
        DiscordRPC.forceUpdate()
    end
    DiscordRPC.update(dt)
end