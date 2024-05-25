--1.0.1
name="NGTools"
description="Improvements for the Nethergames server. By Lioncat6"

--importLib("DependentBoolean")

--vars
NGToolsPrefix = "§f[§l§eN§6G§bTools§r§f]§r "
version = "1.0.1"
currentLocation = "----"
--winning = true
handledWhereAmI = false
currentServerID  = ""
lastServerID = ""

function reloadLua()
    client.execute("lua reload")
end

--settings
client.settings.addTitle("NGTools • Version " .. version .. " • Lioncat6")
client.settings.addAir(5)
client.settings.addTitle("Global Settings (Require Reload):")
client.settings.addFunction("Reload Plugin", "reloadLua", "Reload")
registerAll = false
client.settings.addBool("Attempt to register all subcommands independently (May cause conflicts)", "registerAll")
hidePrefix = false
client.settings.addBool("Hide [NGTools] prefix from messages", "hidePrefix")
checkUpdates = true
client.settings.addBool("Check for updates on load", "checkUpdates")

client.settings.addAir(5)
client.settings.addCategory("Location Message")
locationMsg = true
client.settings.addBool("Show Location Message In Chat", "locationMsg")
locationNotif = true
client.settings.addBool("Show Location Message As Notification", "locationNotif")
client.settings.addInfo("Won't show on every server type due to inconsistencies")
showServerId = false
client.settings.addBool("Show server ID in Location Message", "showServerId")
showOnNewServer = true
client.settings.addBool("Only show location when joining a new server (Checks the server ID)", "showOnNewServer")
newLocation = false
client.settings.addBool("Only show on new location (Overrides above!)", "showOnNewServer")

client.settings.addAir(5)
client.settings.addCategory("AutoGG")
client.settings.addInfo("Automatically send a message upon winning or losing in a game")
client.settings.addInfo("Unsupported Game Modes:\nFactions, Skyblock")
autoGG = false
client.settings.addBool("Enable", "autoGG")
--ggDelay = client.settings.addNamelessFloat("Delay (sec)", 0, 5, 0)
client.settings.addAir(5)
client.settings.addInfo("Custom messages. Separated by \";;\" and will be randomly chosen.")
ggMsg = "GG"
client.settings.addTextbox("GG Message:", "ggMsg")

client.settings.addAir(5)
client.settings.addCategory("Vote helper")
client.settings.addInfo("Detects when you run /vote and automatically copies the url to your clipboard")
voteHelper = false
client.settings.addBool("Enable", "voteHelper")

client.settings.addAir(5)
client.settings.addCategory("Player Stats")
playerStats = false
client.settings.addInfo("Append selected stats to player join message")
client.settings.addBool("Enable", "playerStats")
psKdr = true
client.settings.addBool("K/DR", "psKdr")
client.settings.addInfo("More Coming Soon!")

client.settings.addAir(5)
playerMute = true
client.settings.addCategory("Local Player Mute")
client.settings.addInfo("Locally hide chat messages from players")
client.settings.addBool("Enable", "playerMute")
client.settings.addInfo("Muted Players. Separated by \";;\". Use .ng mute <player> to quick add")
muteList = client.settings.addNamelessTextbox("Muted Players:", "")
client.settings.addInfo("")
showMuteMsg = true
client.settings.addBool("Show \'Message Muted\' message in chat", "showMuteMsg")

client.settings.addAir(5)
client.settings.addCategory("Chat Debloater")
chatDebloat = false

client.settings.addBool("Enable", "chatDebloat")
client.settings.addTitle("Categories:")
cdWelcome = false
cdAnnouncement = false
cdJoinLeaveLobby = false
cdJoinLeaveGame = false
cdJoinLeaveFriend = false
cdJoinLeaveGuild = false
cdGameInstructions = false
client.settings.addBool("Welcome Message", "cdWelcome")
client.settings.addBool("Lobby Announcements", "cdAnnouncement")
client.settings.addBool("Lobby Player Join/Leave", "cdJoinLeaveLobby")
client.settings.addBool("In-Game Player Join/Leave", "cdJoinLeaveGame")
client.settings.addBool("Friend Player Join/Leave", "cdJoinLeaveFriend")
client.settings.addBool("Guild Player Join/Leave", "cdJoinLeaveGuild")
client.settings.addBool("Hide game instructions", "cdGameInstructions")



--reset vars
function postInit()
    --if server.ip():find("nethergames")  then
        currentLocation = "---"
        winning = true
        handledWhereAmI = false
        currentServerID = ""
        lastServerID = ""
        event.listen("ChatMessageAdded", chatListen)
        registerCommand("ngtools", ng)
        registerCommand("ng", ng)
        if registerAll == true then
            registerAllCommands()
        end
        if hidePrefix == true then
            NGToolsPrefix = ""
        end
        if checkUpdates == true then
            updateCheck()
        end
        function update(dt)
            if server.ip():find("nethergames") then
                checkGamemode()
            end
        end
    --else 
    --    registerCommand("ngtools", wrongServer)
    --    registerCommand("ng", wrongServer)
    --end
end

--Check github repo for updates
function updateCheck()
    network.get("https://raw.githubusercontent.com/OnixClient-Scripts/OnixClient_Scripts/master/Modules/NGTools.lua", "cUpdate")
end

--sigfigs :3
function sigFig(num, figures)
    -- Check if the input number is zero or has no decimal places
    if num == 0 or num == math.floor(num) then
        return num
    end

    local x = figures - math.ceil(math.log10(math.abs(num)))
    return math.floor(num * 10^x + 0.5) / 10^x
end

locationsScoreboard = {}
locationsScoreboard["SURVIVAL"] = "survivalGames"
locationsScoreboard["BEDWARS"] = "bedwars"
locationsScoreboard["SKYWARS"] = "skywars"
locationsScoreboard["DUELS"] = "duels"
locationsScoreboard["BRIDGE"] = "bridge"
locationsScoreboard["MURDER"] = "murderMystery"
locationsScoreboard["CONQUESTS"] = "conquests"
locationsScoreboard["SKYBLOCK"] = "skyblock"
locationsScoreboard["FACTIONS"] = "factions"
locationsScoreboard["UHC"] = "UHC"
locationsScoreboard["CREATIVE"] = "creative"
locationsScoreboard["SOCCER"] = "soccer"
locationsScoreboard["MOMMA"] = "mommaSays"
locationsScoreboard["LOBBY"] = "lobby"

locationsDisplay = {}
locationsDisplay["survivalGames"] = "§6Survival Games"
locationsDisplay["bedwars"] = "§cBedwars"
locationsDisplay["skywars"] = "§6Skywars"
locationsDisplay["duels"] = "§fDuels"
locationsDisplay["bridge"] = "§1The Bridge"
locationsDisplay["murderMystery"] = "§eMurder Mystery"
locationsDisplay["conquests"] = "§cConquests"
locationsDisplay["skyblock"] = "§3Skyblock"
locationsDisplay["factions"] = "§dFactions"
locationsDisplay["UHC"] = "§6UHC"
locationsDisplay["creative"] = "§aCreative"
locationsDisplay["soccer"] = "§4Soccer"
locationsDisplay["mommaSays"] = "§4Momma Says"
locationsDisplay["lobby"] = "§bLobby"

--Gamemode Tracking
function checkGamemode()   
    local scoreboard = server.scoreboard()
    local sidebar = scoreboard.getDisplayObjective("sidebar")
    if sidebar then
        local title = sidebar.displayName
        for index, value in pairs(locationsScoreboard) do
            --print(index, value)
            if string.find(title, index) then
                if currentLocation ~= value then
                    currentLocation = value
                    if locationMsg == true  or locationNotif == true then
                        if showServerId == true  or showOnNewServer == true then
                            handledWhereAmI = true
                            client.execute("execute /whereami")
                        end
                        
                    end
                end
            end
        end
    end
end

function sendGG(msg)
    local messages = {}
    for object in msg:gmatch("[^;;]+") do
        table.insert(messages, object:match("^%s*(.-)%s*$"))
    end
    local randomIndex = math.random(1, #messages)
    local selectedMsg = messages[randomIndex]
    client.execute("say " .. selectedMsg)
end

function handleDispLocation()
    if currentServerID ~= lastServerID then
        lastServerID = currentServerID
        if locationMsg == true then
            print(NGToolsPrefix .. "Connected to §l" .. locationsDisplay[currentLocation] .."§r")
            handledWhereAmI = false
            if showServerId == true then
                print(currentServerID)
            end
        end
        if locationNotif == true then
            client.notification("Connected to " .. currentServerID:gsub("§.", ""))
            handledWhereAmI = false
        end
    else
        handledWhereAmI = false
    end
end

gameInstructionsText = {
    --Skywars
    "§e§lGather resources and equipment on your island",
    "§e§lin order to eliminate every other person!",
    --Bridge
    "§e§lCross the bridge to score goals.",
    "§e§lKnock off your opponent to gain a clear path.",
    "§e§lFirst player to score 5 goals wins!",
    --Bedwars
    "§e§lProtect your bed and destroy the enemy beds.",
    "§e§lUpgrade yourself and your team by collecting",
    "§e§lIron, Gold, Emerald and Diamond from the generators",
    "§e§lto access powerful upgrades.",
    --Duels
    "§e§lEliminate your opponents!",
    --Conquests
    "§e§lProtect your flag and capture the enemy flags.",
    "§e§lUpgrade yourself and your team by collecting",
    "§e§lIron, Gold, Emerald and Diamond from the generators",
    "§e§lto access powerful upgrades.",
}

function chatListen(message, username, type)
    if server.ip():find("nethergames") then
        if playerStats == true then
            if message:find(" §ehas joined") and not message:find(":")  then
                local playerName = message:gsub("§.", ""):match("(.+) has joined")
                if psKdr == true then
                    --print("\""..playerName.."\"")
                    fetchPlayerStats(playerName, "kdr", message.." §eK/DR: §f", "§r")
                    return true
                end
            end
        end
        if handledWhereAmI == true then
            if message:find("You are currently online on")  then
                currentServerID = string.gsub(message, "§a You are currently online on ", "")
                handleDispLocation()
                return true
            end
        end
        -- Yes this second check is necessary lol
        if handledWhereAmI == true then
            if message:find("You are currently online on") then
                handledWhereAmI = false
                return true
            end
        end
        if autoGG == true then
            if message:find("§aQueued!") then
                sendGG(ggMsg)
            end
        end
        if newLocation == false then
            if message:gsub("§.", "") :find(player.name():gsub("§.", "") .. " has joined") then
                currentLocation = ""
            end
        end
    
        if voteHelper == true then
            if message:find("You haven't voted yet today.") then
                print(NGToolsPrefix .. "Copied voting site url!")
                client.notification("Copied voting site url!")
                setClipboard("https://minecraftpocket-servers.com/server/36864/vote")
            
            end
        end
        if playerMute == true then
            local msg = message
            for playerName in muteList.value:gmatch("[^;;]+") do
                local rawname = playerName:match("^%s*(.-)%s*$") :gsub("§.", "") 
                if (msg:find(rawname .. " §r§l»§r") or msg:find(rawname .. ": ") or msg:find("§e" .. rawname)) and (msg:find("§r§l»§r") or msg:find("§7Dead Chat > "))then
                    if showMuteMsg == true then
                        print(NGToolsPrefix .. "§4Muted Message from " .. playerName)
                    end
                    return true
                end
            end
        end
        if chatDebloat == true then
            if cdWelcome == true then
                if currentLocation == "lobby" and message:find("§aWelcome to §eNether§6Games§a!") then
                    return true
                end
            elseif cdAnnouncement == true then
                if currentLocation == "lobby" and message:find("§o§l§eN§6G§r§7:") then
                    return true
                end
            elseif cdJoinLeaveLobby == true then
                if currentLocation == "lobby" and message:find("§6 has joined the server!") then
                    return true
                end
            elseif cdJoinLeaveGame == true then
                if currentLocation ~= "lobby" and (message:find("§ehas joined (§b") or message:find("§ehas quit!") ) then
                    return true
                end
            elseif cdJoinLeaveFriend == true then
                if message:find("§aFriend > ") and (message:find("§e left") or message:find("§e joined") ) then
                    return true
                end
            elseif cdJoinLeaveGuild == true then
                if message:find("§2Guild >") and message:find("§e joined.")  then
                    return true
                end
                if message:find("§2Guild >") and message:find("§e left.")  then
                    return true
                end
            elseif cdGameInstructions == true then
                for x, text in pairs( gameInstructionsText) do
                    if message:find(text) then
                        return true
                    end
                end
            end
        end
    end
end

function format_seconds(minutes)
    local weeks = math.floor(minutes / 10080) -- 1 week = 7 days * 24 hours * 60 minutes
    local days = math.floor((minutes % 10080) / 1440) -- 1 day = 24 hours * 60 minutes
    local hours = math.floor((minutes % 1440) / 60)
    local remaining_minutes = minutes % 60
    return string.format("%dW %dD %dH %dM", weeks, days, hours, remaining_minutes)
end

function onNetworkData(code, identifier, data)
    if identifier == "basicStats" or identifier == "basicInfo" then
        local dataTable = {}
        dataTable = jsonToTable(data)
        if not data:find("does not have any stats") then
            statsData = dataTable
            print()
            if statsData ~= nil and statsData["name"] ~= nil  then
                if identifier == "basicStats" then
                    print("§6----- " .. NGToolsPrefix .. "§2§l" .. statsData["name"] .. "\'s §r§3Player Stats " .. "§6-----")
                    print("§l§5Kills: §f" .. statsData["kills"])
                    print("§l§4Deaths: §f" ..statsData["deaths"])
                    print("§l§eK/DR: §f" .. statsData["kdr"])
                    print("§l§2Wins: §f" ..statsData["wins"])
                    print("§l§cLosses: §f" ..statsData["losses"])
                    print("§l§aW/LR: §f" .. statsData["wlr"])
                    print("§l§4Credits: §f" .. statsData["credits"])
                    print("§l§dPlaytime: §f" ..format_seconds(statsData["extraNested"]["online"]["time"]))
                    print("§6-----                 " .. string.rep("  ", string.len(statsData["name"])) .. "                §6-----")
                elseif  identifier == "basicInfo" then
                    print("§6----- " .. NGToolsPrefix .. "§2§l" .. statsData["name"] .. "\'s §r§ePlayer Info " .. "§6-----")
                    local rank = ""
                    if next(statsData["ranks"]) ~= nil then
                        x, rank = next(statsData["ranks"])
                        rank = " §l" .. string.upper(rank)
                    end
                    local tier = ""
                    if statsData["tier"] == nil then
                        statsData["tier"] = ""
                    else
                        statsData["tier"] = " §l" .. string.upper(statsData["tier"])
                    end
                    if statsData["guild"] == nil then
                        statsData["guild"] = ""
                    end
                    local formattedName = statsData["formattedLevel"] .. statsData["tier"] .. rank .. " §r§e" .. statsData["name"] .. " §r§l" .. statsData["guild"]
                    print(formattedName)
                    if statsData["banned"] == true then
                        print("§l§cBanned Until: §f".. tostring(os.date("%c", statsData["bannedUntil"])):gsub("  ", " ") .. " §7(In " .. math.floor((statsData["bannedUntil"] - os.time()) / 86400) .. " days)")
                    end
                    if statsData["muted"] == true then
                        print("§l§cMuted Until: §f"..tostring(os.date("%c", statsData["mutedUntil"])):gsub("  ", " ") .. " §7(In " .. math.floor((statsData["mutedUntil"] - os.time()) / 86400) .. " days)")
                    end
                    if statsData["discordTag"] ~= nil and statsData["discordTag"] ~= "" then
                        print("§l§5Discord: §r§f@" .. statsData["discordTag"])
                    end
                    --print("§l§2Last Seen: §f" .. statsData["lastSeen"] .. " ago")
                    if statsData["online"] == true then
                        --print("§l§aCurrently Online")
                        print("§l§2Last Seen: §f" .. statsData["lastSeen"] .. " ago (§aCurrently Online§f)")
                    else
                        --print("§l§cCurrently Offline")
                        print("§l§2Last Seen: §f" .. statsData["lastSeen"] .. " ago (§cCurrently Offline§f)")
                    end
                    print("§l§6Last Location: §f" .. statsData["lastServer"])
                    
                    print("§l§dPlaytime: §f" ..format_seconds(statsData["extraNested"]["online"]["time"]))
                    local fjyear, fjmonth, fjday, fjhour, fjmin, fjsec = statsData["firstJoin"]:match("(%d+)-(%d+)-(%d+) (%d+):(%d+):(%d+)")
                    local daysAgo = (os.time() - os.time{year=fjyear, month=fjmonth, day=fjday, hour=fjhour, min=fjmin, sec=fjsec}) // 86400
                    if daysAgo < 1 then
                        print("§l§3First Join: §f" .. statsData["firstJoin"] .. " §7(Today)§r")
                    else
                        print("§l§3First Join: §f" .. statsData["firstJoin"] .. " §7(" .. daysAgo .. " days ago)§r")
                    end
                    
                    print("§6-----                 " .. string.rep("  ", string.len(statsData["name"])) .. "              §6-----")
                end
            else
                if data:find("does not have any stats") then
                    print(NGToolsPrefix .. "Player has no recorded statistics!")

                elseif data:find("Unknown Player") then
                    print(NGToolsPrefix .. "A player by this username does not exist on the server!")
                else 
                    if code == 0 then
                        print(NGToolsPrefix .. "Fetch Error: " .. data)
                    else
                        -- code 2 = spaces in url
                        print(NGToolsPrefix .. "Fetch Error: " .. "code " .. code)
                    end
                end
                return true
            end
        end
    --receive update check
    elseif identifier == "cUpdate" then
        if code == 0 then
            local lines = {}
            for line in data:gmatch("[^\n]+") do
                table.insert(lines, line)
                break -- we only need 1 line lol (why bother do the whole thing?)
            end
            local firstLine = lines[1]
            local serverVersion = firstLine:gsub("%-%-", ""):gsub("\n", "")
            if serverVersion ~= version then
                print(NGToolsPrefix .. "§eA new update is available! §f(".. serverVersion .."§f > " ..version .. "§f)")
                print("Copied download link to clipboard.")
                setClipboard("https://onixclient.com/scripting/repo?search=ngtools")
                client.notification("A new update is available! (".. serverVersion .." > " ..version .. ")")
            end
            
        end
    else
        local dataTable = {}
        dataTable = jsonToTable(data)
        local identifiers = {}
        for object in identifier:gmatch("[^||]+") do
            table.insert(identifiers, object)
        end
        local indexes = identifiers[1]
        local BeforeMsg = identifiers[2]
        local AfterMsg = identifiers[3]
        local indexedTable = {}
        local indexedData
        indexedTable = dataTable
        for object in indexes:gmatch("[^ ]+") do
            if indexedTable ~= nil and indexedTable["name"] ~= nil  then
                indexedTable = indexedTable[object:match("^%s*(.-)%s*$")]
            else
                if data:find("does not have any stats") then
                    indexedData = 0
                    
                else 
                    if code == 0 then
                        print(NGToolsPrefix .. "Fetch Error: " .. data)
                    else
                        -- code 2 = spaces in url
                        print(NGToolsPrefix .. "Fetch Error: " .. "code " .. code)
                    end
                    indexedData = "err"
                end
            end
        end
        if indexedTable ~= nil and indexedData ~= "err"  then
            if type(indexedTable) == "table" then
                indexedData = table.concat(indexedTable)
            elseif type(indexedTable) == "number" then
                indexedData = sigFig(indexedTable, 3)
            else
                indexedData = indexedTable
            end
        end
        if indexes == "kdr" and type(indexedData) == "number" and indexedData ~= "err" then
            if indexedData < 0.5 then
                indexedData = "§8" .. indexedData
            elseif indexedData < 1 then
                indexedData = "§7" .. indexedData
            elseif indexedData < 1.5 then
                indexedData = "§f" .. indexedData
            elseif indexedData < 2 then
                indexedData = "§a" .. indexedData
            elseif indexedData < 3 then
                indexedData = "§e" .. indexedData
            elseif indexedData < 5 then
                indexedData = "§6" .. indexedData
            elseif indexedData < 8 then
                indexedData = "§c" .. indexedData
            elseif indexedData < 15 then
                indexedData = "§d" .. indexedData
            elseif indexedData < 20 then
                indexedData = "§5" .. indexedData
            else
                indexedData = "§3" .. indexedData
            end
        end
        print(BeforeMsg .. indexedData .. AfterMsg)
    end
end

function fetchPlayerStats(Uname, index, BeforeMsg, AfterMsg)
    htmlName = Uname:gsub(" ", "%%20")
    network.get("https://api.ngmc.co/v1/players/"..htmlName, index .. "||" .. BeforeMsg .. "||" ..  AfterMsg)
end

function fetchServerStats(path, index, BeforeMsg, AfterMsg)
    network.get("https://api.ngmc.co/v1/servers/"..path, index .. "||" .. BeforeMsg .. "||" ..  AfterMsg)
end

function fetchKdr(Uname)
    name = autoCompleteName(Uname) :gsub("\"", "")
    fetchPlayerStats(name, "kdr", NGToolsPrefix.."§l§2".. name .." §eK/DR: §f", "§r")
end

function fetchBasicStats(Uname)
    print(NGToolsPrefix .. "Fetching...")
    name = autoCompleteName(Uname) :gsub("\"", "")
    htmlName = name:gsub(" ", "%%20")
    network.get("https://api.ngmc.co/v1/players/"..htmlName, "basicStats")
end

function fetchBasicInfo(Uname)
    print(NGToolsPrefix .. "Fetching...")
    name = autoCompleteName(Uname) :gsub("\"", "")
    htmlName = name:gsub(" ", "%%20")
    network.get("https://api.ngmc.co/v1/players/"..htmlName, "basicInfo")
end

function autoCompleteName(Uname)
    for x, name in pairs( server.players()) do
        if string.lower(name):find(string.lower(Uname)) then
            if not name:find("\"") then
                return "\"" .. name:gsub("§.", "") .. "\"", true
            else
                return Uname, true
            end
        end
    end
    return Uname, false
end

function fetchOnlinePlayers()
    fetchServerStats("ping", "players online", NGToolsPrefix.."§l§3Online Players: §f", "§r")
end

function copyServerID()
    local rawId = currentServerID:gsub("§.", "")
    setClipboard(rawId)
    print(currentServerID)
    print(NGToolsPrefix .. "Copied Server ID!")
    client.notification("Copied Server ID!")
end

function copyUname(name)
    local uname, autocompleted = autoCompleteName(name)
    local playername = uname:gsub("\"", "")
    local rawName = playername:gsub(".§", "")
    print("§e" .. playername)
    if autocompleted == false then
        print("§o§4Warning: §3User does not exist in current server")
    end
    print(NGToolsPrefix .. "Copied username!")
    setClipboard(rawName)
    client.notification("Copied username!")
end

function addMute(Uname)
    local name, autocompleted = autoCompleteName(Uname:gsub("§.", "")) 
    local playername = name:gsub("\"", "")
    if autocompleted == false then
        print("§o§4Warning: §3User does not exist in current server")
    end
    if muteList.value ~= "" then
        muteList.value = muteList.value .. ";;" .. playername
    else 
        muteList.value = muteList.value .. playername
    end
    client.settings.send()
    print(NGToolsPrefix .. "Added §l§2" .. playername .. "§r to mute list!")
end

function printHelp()
    print("§6----- " .. NGToolsPrefix .. "§6Commands " .. "§6-----")
    print("§b.ng§r §6serverid§7 - Copy the current ID of the server you're playing on to the clipboard")
    print("§b.ng§r §6uname <username>§7 - Copy targeted player's username to the clipboard")
    print("§b.ng§r §6mute <username>§7 - Add to the player mute list")
    --print("§b.ng§r §6unmute <username>§7 - Remove from the player mute list")
    print("§b.ng§r §6online§7 - Shows online player count")
    print("§b.ng§r §6kdr <username>§7 - Fetch player's K/DR")
    print("§b.ng§r §6stats <username>§7 - Fetch player's basic stats")
    --print("§b.ng§r §6fullstats <username>§7 - Fetch player's §lfull§r§7 stats")
    --print("§b.ng§r §6gstats <username> <gamemode> §7 - Fetch player's stats for the specified gamemode. Uses current game if not specified.")
    print("§b.ng§r §6info <username>§7 - Fetch player's account information")
    print("§b.ng§r §6update §7 - Check for updates on github")
    if registerAll == true then
        print("§b.ng §8is not required since all commands are registered!")
    end
    print("§6-----                            §6-----")
end

--------------------------
--For registering Subcommands independently
function registerAllCommands()
    registerCommand("serverid", scServerid)
    registerCommand("uname", scUname)
    registerCommand("mute", scMute)
    registerCommand("online", scOnline)
    registerCommand("kdr", scKdr)
    registerCommand("stats", scStats)
    registerCommand("info", scInfo)
    registerCommand("update", scUpdate)
end

function scServerid(data)
    if data then
        data = " " .. data
    end
    ng("serverid" .. data)
end

function scUname(data)
    if data then
        data = " " .. data
    end
    ng("uname" .. data)
end

function scMute(data)
    if data then
        data = " " .. data
    end
    ng("mute" .. data)
end


function scOnline(data)
    if data then
        data = " " .. data
    end
    ng("online" .. data)
end

function scKdr(data)
    if data then
        data = " " .. data
    end
    ng("kdr" .. data)
end

function scStats(data)
    if data then
        data = " " .. data
    end
    ng("stats" .. data)
end

function scInfo(data)
    if data then
        data = " " .. data
    end
    ng("info" .. data)
end

function scUpdate(data)
    if data then
        data = " " .. data
    end
    ng("update" .. data)
end

--------------------------

function ng(data)
    if server.ip():find("nethergames") then
        local cmdData = {}
        local in_quotes = false
        local currentString = ""
        for object in data:gmatch("[^ ]+") do
            if object:find("^\"") and not object:find("\"$") then
                in_quotes = true
                currentString = currentString .. object
            elseif  in_quotes == true and object:find("\"$") and not object:find("^\"") then
                in_quotes = false
                table.insert(cmdData, currentString .. " " .. object)
                currentString = ""
            elseif in_quotes == true then
                currentString = currentString .. " " .. object
            else
                table.insert(cmdData, object)
            end
        end
        cmd = cmdData[1]
        if cmd == "" or cmd == nil then
            printHelp()
        elseif cmd == "serverid" then
            copyServerID()
        elseif cmd == "kdr" then
            if cmdData[2] == nil then
                cmdData[2] = player.name():gsub("§.", "")
            end
            fetchKdr(cmdData[2])
        elseif cmd == "mute" then
            if cmdData[2] == nil then
                print(NGToolsPrefix .."Please enter a target player!")
                return true
            end
            addMute(cmdData[2])
        elseif cmd == "online" then
            fetchOnlinePlayers()
        elseif cmd == "stats" then
            if cmdData[2] == nil then
                cmdData[2] = player.name():gsub("§.", "")
            end
            fetchBasicStats(cmdData[2])
        elseif cmd == "info" then
            if cmdData[2] == nil then
                cmdData[2] = player.name():gsub("§.", "")
            end
            fetchBasicInfo(cmdData[2])
        elseif cmd == "uname" then
            if cmdData[2] == nil then
                cmdData[2] = player.name():gsub("§.", "")
            end
            copyUname(cmdData[2])
        elseif cmd == "update" then
            updateCheck()
        else
            print(NGToolsPrefix .. "Command not found: ".. cmd .. "!")
            printHelp()
        end
    else
        wrongServer()
    end
end

function wrongServer()
    print(NGToolsPrefix .. "Error: You are not on the NetherGames!")
end
