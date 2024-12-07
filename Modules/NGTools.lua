--1.0.6
name               = "NGTools"
description        = "Improvements for the Nethergames server. By Lioncat6 • Version 1.0.5"

--importLib("DependentBoolean")

--vars
NGToolsPrefix      = "§f[§l§eN§6G§bTools§r§f]§r "
version            = "1.0.6"
currentLocation    = "----"
--winning = true
handledWhereAmI    = false
currentServerID    = ""
lastServerID       = ""
node_id            = ""
proxy_region       = ""
node_gamemode      = ""
proxy_name         = ""
proxy_reigion      = ""
replyIGN           = ""
realNameTable      = {}
realNameNickName   = ""
handledWhisper     = false
handledGuildModal  = false
handledGuildMebers = false
scoreboardIsBlank  = true
positionX          = 10
positionY          = 100
sizeX              = 50
sizeY              = 6


function reloadLua()
    client.execute("lua reload")
end

--settings
client.settings.addTitle("NGTools • Version " .. version .. " • Lioncat6")
client.settings.addAir(5)
client.settings.addTitle("Global Settings (Require Reload):")
client.settings.addFunction("Reload Script", "reloadLua", "Reload")
registerAll = false
client.settings.addInfo("This removes the requirement to use .ng before any NGTools command!")
client.settings.addBool("Register all subcommands independently (May cause conflicts)",
    "registerAll")
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
client.settings.addBool("Only show on new gamemode (Overrides above!)", "newLocation")
checkLocationNoMatterWhat = false
client.settings.addBool("Show every time you join a new node (Overrides above!)", "checkLocationNoMatterWhat")

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
client.settings.addCategory("Middle Click")
client.settings.addInfo("Do various actions when middle clicking on a player")
middleClick = false
client.settings.addBool("Enable", "middleClick")
middleClickMode = client.settings.addNamelessEnum("Mode", 1, {
    { 1, "Player Stats (.stats)" },
    { 2, "Player Game Stats (.gstats)" },
    { 3, "Player Info (.info)" },
    { 4, "Add Friend (/friend)" },
    { 5, "Invite to Party (/party)" },
    { 6, "Copy Username (.uname)" },
    { 7, "View Bio (.bio)" },
    { 8, "View Punishments (.punishments)" },
})

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

client.settings.addAir(5)
client.settings.addCategory("Gui Settings")

textColorSetting = client.settings.addNamelessColor("Text Color", { 255, 255, 255, 255 })
bgColorSetting = client.settings.addNamelessColor("Background Color", { 51, 51, 51, 100 })
paddingSetting = client.settings.addNamelessFloat("Padding", 0, 10, 1)
locationGui = false
locationTextToRender = ""
client.settings.addBool("Show GUI with proxy and node ID", "locationGui")
client.settings.addInfo(
    "Enabling this will force the game to check the location every time you join a new node. You may want to disable notifications if you don't want to get spammed.")



--reset vars
function postInit()
    --if server.ip():find("nethergames")  then
    currentLocation = "---"
    winning = true
    handledWhereAmI = false
    handledWhisper = ""
    realNameNickName = ""
    currentServerID = ""
    lastServerID = ""
    event.listen("ChatMessageAdded", chatHandler)
    event.listen("MouseInput", clickHandler)
    event.listen("TitleChanged", titleHandler)
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
end

function titleHandler(text, type)
    if server.ip():find("nethergames") then
        if autoGG == true then
            if (type == "title" and (text:find("GAME OVER") or text:find("VICTORY"))) or (type == "subtitle" and text:find("spectator")) then
                sendGG(ggMsg)
            end
        end
    end
end

--Check github repo for updates
function updateCheck()
    network.get("https://raw.githubusercontent.com/OnixClient-Scripts/OnixClient_Scripts/master/Modules/NGTools.lua",
        "cUpdate")
end

--sigfigs :3
function sigFig(num, figures)
    -- Check if the input number is zero or has no decimal places
    if num == 0 or num == math.floor(num) then
        return num
    end

    local x = figures - math.ceil(math.log10(math.abs(num)))
    return math.floor(num * 10 ^ x + 0.5) / 10 ^ x
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

validLocations = {}
validLocations[1] = "bedwars"
validLocations[2] = "skywars"
validLocations[3] = "duels"
validLocations[4] = "bridge"
validLocations[5] = "murderMystery"
validLocations[6] = "conquests"
validLocations[7] = "factions"
validLocations[8] = "UHC"
validLocations[9] = "soccer"
validLocations[10] = "mommaSays"
validLocations[11] = "survivalGames"

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
        if scoreboardIsBlank == true then
            scoreboardIsBlank = false
            if locationGui == true or checkLocationNoMatterWhat == true then
                handledWhereAmI = true
                client.execute("execute /whereami")
            end
        end
        local title = sidebar.displayName
        for index, value in pairs(locationsScoreboard) do
            --print(index, value)
            if string.find(title, index) then
                if currentLocation ~= value then
                    currentLocation = value
                    if (locationMsg == true or locationNotif == true) and handledWhereAmI == false then
                        if showServerId == true or showOnNewServer == true then
                            handledWhereAmI = true
                            client.execute("execute /whereami")
                        end
                    end
                end
            end
        end
    else
        scoreboardIsBlank = true
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
            print(NGToolsPrefix .. "Connected to §l" .. locationsDisplay[currentLocation] .. "§r")
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

function isFacingPlayer()
    if player.facingEntity() and player.selectedEntity().type == "player" and player.selectedEntity().username ~= nil and player.selectedEntity().username ~= "" then
        return true
    else
        return false
    end
end

function clickHandler(button, press)
    if middleClick == true then
        if button == 3 and press == false then
            if isFacingPlayer() then
                local uname = player.selectedEntity().username
                local mode = middleClickMode.value
                if mode == 1 then
                    client.execute("ng stats " .. uname)
                elseif mode == 2 then
                    client.execute("ng gstats " .. uname)
                elseif mode == 3 then
                    client.execute("ng info " .. uname)
                elseif mode == 4 then
                    client.execute("execute /friend " .. uname)
                elseif mode == 5 then
                    client.execute("execute /party " .. uname)
                elseif mode == 6 then
                    client.execute("ng uname " .. uname)
                elseif mode == 7 then
                    client.execute("ng bio " .. uname)
                elseif mode == 8 then
                    client.execute("ng punishments " .. uname)
                end
            end
        end
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
    --Momma Says
    "§e§lFollow the instructions to gain points.",
    "§e§lThe player with the most points wins!",
    --Soccer
    "§e§lPass the ball between teammates.",
    "§e§lGet it down the field to the goal.",
    "§e§lThe team with the most goals at the end wins!"
}

function chatHandler(message, username, type)
    if server.ip():find("nethergames") then
        if playerStats == true then
            if message:find(" §ehas joined") and not message:find(":") then
                local playerName = message:gsub("§.", ""):match("(.+) has joined")
                if psKdr == true then
                    --print("\""..playerName.."\"")
                    fetchPlayerStats(playerName, "kdr", message .. " §eK/DR: §f", "§r")
                    return true
                end
            end
        end
        if handledWhereAmI == true then
            if message:find("You are currently online on") then
                currentServerID = string.gsub(message, "§a You are currently online on ", "")
                currentServerID = string.gsub(currentServerID, "§aYou are currently online on ", "")
                local formattedId = currentServerID:gsub("§.", ""):gsub("%-%-", "-"):gsub(" ", "") -- Extract the information with an updated pattern
                node_region, node_gamemode, node_id, proxy_name = formattedId:match(
                    "(%u+)%-(.-)%-(%w+%-%w+)%((%w+%-%d+)%)")

                if proxy_name == nil then
                    proxy_name = ""
                end
                proxy_region = proxy_name:match("(%a+)")
                if node_id == nil then
                    node_id = ""
                end
                if proxy_region == nil then
                    proxy_region = ""
                end
                if node_gamemode == nil then
                    node_gamemode = ""
                end

                if proxy_reigion == nil then
                    proxy_reigion = ""
                end
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
        --if autoGG == true then
        --    if message:find("§cYou have been eliminated!") then
        --        sendGG(ggMsg)
        --    end
        --end
        if newLocation == false then
            if message:gsub("§.", ""):find(player.name():gsub("§.", "") .. " has joined") then
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
                local rawname = playerName:match("^%s*(.-)%s*$"):gsub("§.", "")
                if (msg:find(rawname .. " §r§l»§r") or msg:find(rawname .. ": ") or msg:find("§e" .. rawname) or msg:find("§b§r§f" .. rawname)) and (msg:find("§r§l»§r") or msg:find("§7Dead Chat > ") or msg:find("§r§b whispered to you:")) then
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
            end
            if cdAnnouncement == true then
                if currentLocation == "lobby" and message:find("§o§l§eN§6G§r§7:") then
                    return true
                end
            end
            if cdJoinLeaveLobby == true then
                if currentLocation == "lobby" and message:find("§6 has joined the server!") then
                    return true
                end
            end
            if cdJoinLeaveGame == true then
                if currentLocation ~= "lobby" and (message:find("§ehas joined (§b") or message:find("§ehas quit!")) then
                    return true
                end
            end
            if cdJoinLeaveFriend == true then
                if message:find("§aFriend > ") and (message:find("§e left") or message:find("§e joined")) then
                    return true
                end
            end
            if cdJoinLeaveGuild == true then
                if message:find("§2Guild >") and message:find("§e joined.") then
                    return true
                end
                if message:find("§2Guild >") and message:find("§e left.") then
                    return true
                end
            end
            if cdGameInstructions == true then
                for x, text in pairs(gameInstructionsText) do
                    if message:find(text) then
                        return true
                    end
                end
            end
        end
        if message:find("§r§b whispered to you:") then
            replyIGN = message:match("§r§f(.-)§r§b whispered to you:")
        end
        if message:find("§bYou whispered to §r§f") then
            replyIGN = message:match("§bYou whispered to §r§f(.-)§r§b:")
        end
        if handledWhisper == true then
            if message:find("§r§bYou whispered to") then
                realNameTable[realNameNickName] = message:match("§bYou whispered to §r§f(.-)§r§b:")
            end
            if message:find("§c does not accept direct messages from you") then
                realNameTable[realNameNickName] = message:match("§b(.-)§c does not accept direct messages from you.")
            end
            handledWhisper = false
        end
    end
end

function format_seconds(minutes)
    local weeks = math.floor(minutes / 10080)         -- 1 week = 7 days * 24 hours * 60 minutes
    local days = math.floor((minutes % 10080) / 1440) -- 1 day = 24 hours * 60 minutes
    local hours = math.floor((minutes % 1440) / 60)
    local remaining_minutes = minutes % 60
    return string.format("%dW %dD %dH %dM", weeks, days, hours, remaining_minutes)
end

function findGameKey(gameList, targetKey)
    for _, game in ipairs(gameList) do
        if game.gameKey == targetKey then
            return game
        end
    end

    -- If not found, create a default game entry
    return {
        gameKey = targetKey,
        gameKeyFriendly = "Unknown Game",
        current = 0,
        best = 0
    }
end

function onNetworkData(code, identifier, data)
    if identifier == "basicStats" or identifier == "basicInfo" then
        local dataTable = {}
        dataTable = jsonToTable(data)
        if not data:find("does not have any stats") then
            statsData = dataTable
            if statsData ~= nil and statsData["name"] ~= nil then
                if identifier == "basicStats" then
                    print("§6----- " ..
                        NGToolsPrefix .. "§2§l" .. statsData["name"] .. "\'s §r§3Player Stats " .. "§6-----")
                    print("§l§5Kills: §f" .. statsData["kills"])
                    print("§l§4Deaths: §f" .. statsData["deaths"])
                    print("§l§eK/DR: §f" .. statsData["kdr"])
                    print("§l§2Wins: §f" .. statsData["wins"])
                    print("§l§cLosses: §f" .. statsData["losses"])
                    print("§l§aW/LR: §f" .. statsData["wins"] / statsData["losses"])
                    print("§l§4Credits: §f" .. statsData["credits"])
                    print("§l§3Crate Keys: §f" .. statsData["crateKeys"])
                    print("§l§dPlaytime: §f" ..
                        format_seconds(statsData["extraNested"]["online"]["time"]) ..
                        " §7(" .. math.floor(statsData["extraNested"]["online"]["time"] / 60) .. " hours)")
                    print("§6-----                 " ..
                        string.rep("  ", string.len(statsData["name"])) .. "                §6-----")
                elseif identifier == "basicInfo" then
                    print("§6----- " ..
                        NGToolsPrefix .. "§2§l" .. statsData["name"] .. "\'s §r§ePlayer Info " .. "§6-----")
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
                    local formattedName = statsData["formattedLevel"] ..
                        statsData["tier"] .. rank .. " §r§e" .. statsData["name"] .. " §r§l" .. statsData["guild"]
                    print(formattedName)
                    if statsData["banned"] == true then
                        print("§l§cBanned Until: §f" ..
                            tostring(os.date("%c", statsData["bannedUntil"])):gsub("  ", " ") ..
                            " §7(In " .. math.floor((statsData["bannedUntil"] - os.time()) / 86400) .. " days)")
                    end
                    if statsData["muted"] == true then
                        print("§l§cMuted Until: §f" ..
                            tostring(os.date("%c", statsData["mutedUntil"])):gsub("  ", " ") ..
                            " §7(In " .. math.floor((statsData["mutedUntil"] - os.time()) / 86400) .. " days)")
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

                    print("§l§dPlaytime: §f" ..
                        format_seconds(statsData["extraNested"]["online"]["time"]) ..
                        " §7(" .. math.floor(statsData["extraNested"]["online"]["time"] / 60) .. " hours)")
                    local fjyear, fjmonth, fjday, fjhour, fjmin, fjsec = statsData["firstJoin"]:match(
                        "(%d+)-(%d+)-(%d+) (%d+):(%d+):(%d+)")
                    local daysAgo = (os.time() - os.time { year = fjyear, month = fjmonth, day = fjday, hour = fjhour, min = fjmin, sec = fjsec }) //
                        86400
                    if daysAgo < 1 then
                        print("§l§3First Join: §f" .. statsData["firstJoin"] .. " §7(Today)§r")
                    else
                        print("§l§3First Join: §f" .. statsData["firstJoin"] .. " §7(" .. daysAgo .. " days ago)§r")
                    end

                    print("§6-----                 " ..
                        string.rep("  ", string.len(statsData["name"])) .. "              §6-----")
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
                print(NGToolsPrefix .. "§eA new update is available! §f(" .. serverVersion .. "§f > " .. version .. "§f)")
                print("Copied download link to clipboard.")
                setClipboard("https://onixclient.com/scripting/repo?search=ngtools")
                client.notification("A new update is available! (" .. serverVersion .. " > " .. version .. ")")
            else 
                client.notification("§aNGTools is up to date! ".. version)
            end
        end
    elseif identifier:find("gameStats") then
        local dataTable = {}
        dataTable = jsonToTable(data)
        local statsData = dataTable["extra"]
        if statsData ~= nil and dataTable["name"] ~= nil then
            if identifier == "gameStatsbedwars" then
                print("§6----- " .. NGToolsPrefix .. "§2§l" .. dataTable["name"] .. "\'s §r§cBedwars Stats " .. "§6-----")
                print("§l§5Kills: §f" .. statsData["bwKills"])
                print("§l§4Deaths: §f" .. statsData["bwDeaths"])
                print("§l§eFinal Kills: §f" .. statsData["bwFinalKills"])
                print("§l§aK/DR: §f" .. statsData["bwKills"] / statsData["bwDeaths"])
                print("§l§2Wins: §f" .. statsData["bwWins"])
                print("§l§cBeds Broken: §f" .. statsData["bwBedsBroken"])
                local bw_doublesTable = findGameKey(dataTable["winStreaks"], "bw_doubles")
                print("§l§dDoubles Streak: §f" .. bw_doublesTable["current"] .. " / " .. bw_doublesTable["best"])
                local bw_soloTable = findGameKey(dataTable["winStreaks"], "bw_solo")
                print("§l§dSolo Streak: §f" .. bw_soloTable["current"] .. " / " .. bw_soloTable["best"])
                local bw_squadsTable = findGameKey(dataTable["winStreaks"], "bw_squads")
                print("§l§dSquads Streak: §f" .. bw_squadsTable["current"] .. " / " .. bw_squadsTable["best"])
                local bw_1v1Table = findGameKey(dataTable["winStreaks"], "bw_1v1")
                print("§l§d1v1 Streak: §f" .. bw_1v1Table["current"] .. " / " .. bw_1v1Table["best"])
                local bw_2v2Table = findGameKey(dataTable["winStreaks"], "bw_2v2")
                print("§l§d2v2 Streak: §f" .. bw_2v2Table["current"] .. " / " .. bw_2v2Table["best"])
                print("§6-----                 " ..
                    string.rep("  ", string.len(dataTable["name"])) .. "                 §6-----")
            elseif identifier == "gameStatsskywars" then
                print("§6----- " .. NGToolsPrefix .. "§2§l" .. dataTable["name"] .. "\'s §r§6Skywars Stats " .. "§6-----")
                print("§l§5Kills: §f" .. statsData["swKills"])
                print("§l§4Deaths: §f" .. statsData["swDeaths"])
                print("§l§eK/DR: §f" .. statsData["swKills"] / statsData["swDeaths"])
                print("§l§2Wins: §f" .. statsData["swWins"])
                print("§l§cLosses: §f" .. statsData["swLosses"])
                print("§l§aW/LR: §f" .. statsData["swWins"] / statsData["swLosses"])
                local sw_doublesTable = findGameKey(dataTable["winStreaks"], "sw_doubles")
                print("§l§dDoubles Streak: §f" .. sw_doublesTable["current"] .. " / " .. sw_doublesTable["best"])
                local sw_soloTable = findGameKey(dataTable["winStreaks"], "sw_solo")
                print("§l§dSolo Streak: §f" .. sw_soloTable["current"] .. " / " .. sw_soloTable["best"])
                local sw_1v1Table = findGameKey(dataTable["winStreaks"], "sw_1v1")
                print("§l§d1v1 Streak: §f" .. sw_1v1Table["current"] .. " / " .. sw_1v1Table["best"])
                local sw_2v2Table = findGameKey(dataTable["winStreaks"], "sw_2v2")
                print("§l§d2v2 Streak: §f" .. sw_2v2Table["current"] .. " / " .. sw_2v2Table["best"])
                print("§6-----                 " ..
                    string.rep("  ", string.len(dataTable["name"])) .. "                 §6-----")
            elseif identifier == "gameStatsbridge" then
                print("§6----- " ..
                    NGToolsPrefix .. "§2§l" .. dataTable["name"] .. "\'s §r§1The Bridge Stats " .. "§6-----")
                print("§l§5Kills: §f" .. statsData["tbKills"])
                print("§l§4Deaths: §f" .. statsData["tbDeaths"])
                print("§l§eK/DR: §f" .. statsData["tbKills"] / statsData["tbDeaths"])
                print("§l§2Wins: §f" .. statsData["tbWins"])
                print("§l§cLosses: §f" .. statsData["tbLosses"])
                print("§l§aW/LR: §f" .. statsData["tbWins"] / statsData["tbLosses"])
                print("§l§3Goals: §f" .. statsData["tbGoals"])
                local tb_doublesTable = findGameKey(dataTable["winStreaks"], "tb_doubles")
                print("§l§dDoubles Streak: §f" .. tb_doublesTable["current"] .. " / " .. tb_doublesTable["best"])
                local tb_soloTable = findGameKey(dataTable["winStreaks"], "tb_solo")
                print("§l§dSolo Streak: §f" .. tb_soloTable["current"] .. " / " .. tb_soloTable["best"])
                print("§6-----                 " ..
                    string.rep("  ", string.len(dataTable["name"])) .. "                   §6-----")
            elseif identifier == "gameStatsfactions" then
                statsData = dataTable["factionData"]
                if statsData ~= nil then
                    print("§6----- " ..
                        NGToolsPrefix .. "§2§l" .. dataTable["name"] .. "\'s §r§dFactions Stats " .. "§6-----")
                    print("§l§5Kills: §f" .. statsData["kills"])
                    print("§l§aKill Streak: §f" .. statsData["streak"] .. " / " .. statsData["bestStreak"])
                    print("§l§cBounty: §f" .. statsData["bounty"])
                    print("§l§3Balance: §f" .. statsData["coins"])
                    if statsData["faction"] ~= 0 and statsData["faction"] ~= nil then
                        print("§l§6Faction: §o§n" .. statsData["faction"]["name"])
                    end
                    local fjyear, fjmonth, fjday, fjhour, fjmin, fjsec = statsData["registerDate"]:match(
                        "(%d+)-(%d+)-(%d+) (%d+):(%d+):(%d+)")
                    local daysAgo = (os.time() - os.time { year = fjyear, month = fjmonth, day = fjday, hour = fjhour, min = fjmin, sec = fjsec }) //
                        86400
                    if daysAgo < 1 then
                        print("§l§dRegistration Date: §f" .. statsData["registerDate"] .. " §7(Today)§r")
                    else
                        print("§l§dRegistration Date: §f" ..
                            statsData["registerDate"] .. " §7(" .. daysAgo .. " days ago)§r")
                    end
                    print("§6-----                 " ..
                        string.rep("  ", string.len(dataTable["name"])) .. "                 §6-----")
                else
                    print(NGToolsPrefix .. "Player has no factions statistics!")
                end
            elseif identifier == "gameStatssurvivalgames" then
                print("§6----- " ..
                    NGToolsPrefix .. "§2§l" .. dataTable["name"] .. "\'s §r§6Survival Games Stats " .. "§6-----")
                print("§l§5Kills: §f" .. statsData["sgKills"])
                print("§l§4Deaths: §f" .. statsData["sgDeaths"])
                print("§l§eK/DR: §f" .. statsData["sgKills"] / statsData["sgDeaths"])
                print("§l§2Wins: §f" .. statsData["sgWins"])
                local sg_soloTable = findGameKey(dataTable["winStreaks"], "sg_solo")
                print("§l§dSolo Streak: §f" .. sg_soloTable["current"] .. " / " .. sg_soloTable["best"])
                print("§6-----                 " ..
                    string.rep("  ", string.len(dataTable["name"])) .. "                   §6-----")
            elseif identifier == "gameStatsuhc" then
                print("§6----- " .. NGToolsPrefix .. "§2§l" .. dataTable["name"] .. "\'s §r§6UHC Stats " .. "§6-----")
                print("§l§5Kills: §f" .. statsData["uhcKills"])
                print("§l§4Deaths: §f" .. statsData["uhcDeaths"])
                print("§l§eK/DR: §f" .. statsData["uhcKills"] / statsData["uhcDeaths"])
                print("§l§2Wins: §f" .. statsData["uhcWins"])
                local sg_soloTable = findGameKey(dataTable["winStreaks"], "uhc_solo")
                print("§l§dSolo Streak: §f" .. sg_soloTable["current"] .. " / " .. sg_soloTable["best"])
                print("§6-----                 " ..
                    string.rep("  ", string.len(dataTable["name"])) .. "            §6-----")
            elseif identifier == "gameStatsduels" then
                print("§6----- " .. NGToolsPrefix .. "§2§l" .. dataTable["name"] .. "\'s §r§fDuels Stats " .. "§6-----")
                print("§l§5Kills: §f" .. statsData["duelsKills"])
                print("§l§4Deaths: §f" .. statsData["duelsDeaths"])
                print("§l§eK/DR: §f" .. statsData["duelsKills"] / statsData["duelsDeaths"])
                print("§l§2Wins: §f" .. statsData["duelsWins"])
                print("§l§cLosses: §f" .. statsData["duelsLosses"])
                print("§l§aW/LR: §f" .. statsData["duelsWins"] / statsData["duelsLosses"])
                local duels_doublesTable = findGameKey(dataTable["winStreaks"], "duels_doubles")
                print("§l§dDoubles Streak: §f" .. duels_doublesTable["current"] .. " / " .. duels_doublesTable["best"])
                local duels_soloTable = findGameKey(dataTable["winStreaks"], "duels_solo")
                print("§l§dSolo Streak: §f" .. duels_soloTable["current"] .. " / " .. duels_soloTable["best"])
                print("§6-----                 " ..
                    string.rep("  ", string.len(dataTable["name"])) .. "               §6-----")
            elseif identifier == "gameStatsmurdermystery" then
                print("§6----- " ..
                    NGToolsPrefix .. "§2§l" .. dataTable["name"] .. "\'s §r§eMurder Mystery Stats " .. "§6-----")
                print("§l§5Kills: §f" .. statsData["mmKills"])
                print("§l§4Deaths: §f" .. statsData["mmDeaths"])
                print("§l§eK/DR: §f" .. statsData["mmKills"] / statsData["mmDeaths"])
                print("§l§2Wins: §f" .. statsData["mmWins"])
                print("§l§cBow Kills: §f" .. statsData["mmBowKills"])
                print("§l§aKnife Kills: §f" .. statsData["mmKnifeKills"])
                print("§l§3Knife Throw Kills: §f" .. statsData["mmThrowKnifeKills"])
                local mm_clasicTable = findGameKey(dataTable["winStreaks"], "mm_classic")
                print("§l§dClassic Streak: §f" .. mm_clasicTable["current"] .. " / " .. mm_clasicTable["best"])
                local mm_infectionTable = findGameKey(dataTable["winStreaks"], "mm_infection")
                print("§l§dInfection Streak: §f" .. mm_infectionTable["current"] .. " / " .. mm_infectionTable["best"])
                print("§6-----                 " ..
                    string.rep("  ", string.len(dataTable["name"])) .. "                      §6-----")
            elseif identifier == "gameStatsconquests" then
                print("§6----- " ..
                    NGToolsPrefix .. "§2§l" .. dataTable["name"] .. "\'s §r§cConquests Stats " .. "§6-----")
                print("§l§5Kills: §f" .. statsData["cqKills"])
                print("§l§4Deaths: §f" .. statsData["cqDeaths"])
                print("§l§eK/DR: §f" .. statsData["cqKills"] / statsData["cqDeaths"])
                print("§l§2Wins: §f" .. statsData["cqWins"])
                --print("§l§cLosses: §f" ..statsData["tbLosses"])
                --print("§l§aW/LR: §f" .. statsData["tbWins"] / statsData["tbLosses"])
                print("§l§3Flags Captured: §f" .. statsData["cqFlagsCaptured"])
                print("§l§cFlags Returned: §f" .. statsData["cqFlagsReturned"])

                print("§6-----                 " ..
                    string.rep("  ", string.len(dataTable["name"])) .. "                   §6-----")
            elseif identifier == "gameStatsmommasays" then
                print("§6----- " ..
                    NGToolsPrefix .. "§2§l" .. dataTable["name"] .. "\'s §r§4Momma Says Stats " .. "§6-----")
                print("§l§5Successes: §f" .. statsData["msSuccesses"])
                print("§l§4Fails: §f" .. statsData["msFails"])
                print("§l§2Wins: §f" .. statsData["msWins"])

                print("§6-----                 " ..
                    string.rep("  ", string.len(dataTable["name"])) .. "                      §6-----")
            elseif identifier == "gameStatssoccer" then
                print("§6----- " .. NGToolsPrefix .. "§2§l" .. dataTable["name"] .. "\'s §r§4Soccer Stats " .. "§6-----")
                print("§l§aGoals: §f" .. statsData["scGoals"])
                print("§l§2Wins: §f" .. statsData["scWins"])

                print("§6-----                 " ..
                    string.rep("  ", string.len(dataTable["name"])) .. "                §6-----")
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
    elseif identifier == "punishments" then
        local dataTable = {}
        dataTable = jsonToTable(data)
        local punishmentData = dataTable["punishmentsNew"]
        if punishmentData ~= nil and dataTable["name"] ~= nil then
            if #punishmentData > 0 then
                print("§6----- " ..
                    NGToolsPrefix ..
                    "§2§l" .. dataTable["name"] .. "\'s §r§cPunishments §7(" .. #punishmentData .. ") §6-----")
                for x, dat in pairs(punishmentData) do
                    if x > 1 then
                        print("§6-----")
                    end
                    if dat["type"] == "MUTE" then
                        if dat["active"] == true then
                            print("§l§cMuted Until: §f" ..
                                tostring(os.date("%c", dat["validUntil"])):gsub("  ", " ") ..
                                " §7(In " .. math.floor((dat["validUntil"] - os.time()) / 86400) .. " days)")
                        else
                            print("§l§cMute §f- §7Expired")
                        end
                    else
                        if dat["active"] == true then
                            print("§l§cBanned Until: §f" ..
                                tostring(os.date("%c", dat["validUntil"])):gsub("  ", " ") ..
                                " §7(In " .. math.floor((dat["validUntil"] - os.time()) / 86400) .. " days)")
                        else
                            print("§l§cBan §f- §7Expired")
                        end
                    end
                    print("§e§lReason: §f" .. dat["reason"])
                    print("§l§3Duration: §f" ..
                        tostring(os.date("%c", dat["issuedAt"])):gsub("  ", " ") ..
                        " §f- " ..
                        tostring(os.date("%c", dat["validUntil"])):gsub("  ", " ") ..
                        " §7(" .. math.floor((dat["validUntil"] - dat["issuedAt"]) / 86400) .. " days)")
                    print("§2§lID: §f" .. dat["id"])
                end
                print("§6-----                 " ..
                    string.rep("  ", string.len(dataTable["name"]) + string.len(#punishmentData)) ..
                    "                §6-----")
            else
                print(NGToolsPrefix .. "Player has no punishments.")
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
    elseif identifier == "playerBio" then
        local dataTable = {}
        dataTable = jsonToTable(data)
        if dataTable["name"] ~= nil and dataTable["bio"] ~= nil then
            if dataTable["bio"] ~= " " and dataTable["bio"] ~= "" then
                print(NGToolsPrefix .. "§l§2" .. dataTable["name"] .. "'s §r§fBio: ")
                print(dataTable["bio"])
            else
                print(NGToolsPrefix .. "Player has no bio.")
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
            if indexedTable ~= nil then
                indexedTable = indexedTable[object:match("^%s*(.-)%s*$")]
            else
                if data:find("does not have any stats") then
                    indexedData = 0
                else
                    if data:find("Unknown Player") then
                        print(NGToolsPrefix .. "A player by this username does not exist on the server!")
                    else
                        if code == 0 then
                            print(NGToolsPrefix .. "Fetch Error: " .. data)
                        else
                            -- code 2 = spaces in url
                            print(NGToolsPrefix .. "Fetch Error: " .. "code " .. code)
                        end
                    end
                    indexedData = "err"
                end
            end
        end
        if indexedTable ~= nil and indexedData ~= "err" then
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
        if indexedData == nil then
            if data:find("does not have any stats") then
                indexedData = 0
            else
                if data:find("Unknown Player") then
                    print(NGToolsPrefix .. "A player by this username does not exist on the server!")
                else
                    if code == 0 then
                        print(NGToolsPrefix .. "Fetch Error: " .. data)
                    else
                        -- code 2 = spaces in url
                        print(NGToolsPrefix .. "Fetch Error: " .. "code " .. code)
                    end
                end
                indexedData = "err"
            end
        end
        print(BeforeMsg .. indexedData .. AfterMsg)
    end
end

function findRealName(Uname)
    client.execute("execute /w " .. Uname .. " .")
    handledWhisper = true
end

function fetchPlayerStats(Uname, index, BeforeMsg, AfterMsg)
    htmlName = Uname:gsub(" ", "%%20")
    network.get("https://api.ngmc.co/v1/players/" .. htmlName, index .. "||" .. BeforeMsg .. "||" .. AfterMsg)
end

function fetchServerStats(path, index, BeforeMsg, AfterMsg)
    network.get("https://api.ngmc.co/v1/servers/" .. path, index .. "||" .. BeforeMsg .. "||" .. AfterMsg)
end

function fetchKdr(Uname)
    name = autoCompleteName(Uname):gsub("\"", "")
    fetchPlayerStats(name, "kdr", NGToolsPrefix .. "§l§2" .. name .. " §eK/DR: §f", "§r")
end

function fetchBasicStats(Uname)
    print(NGToolsPrefix .. "Fetching...")
    name = autoCompleteName(Uname):gsub("\"", "")
    htmlName = name:gsub(" ", "%%20")
    network.get("https://api.ngmc.co/v1/players/" .. htmlName, "basicStats")
end

function fetchGameStats(Uname, mode)
    print(NGToolsPrefix .. "Fetching...")
    name = autoCompleteName(Uname):gsub("\"", "")
    htmlName = name:gsub(" ", "%%20")
    network.get("https://api.ngmc.co/v1/players/" .. htmlName .. "?withWinStreaks=true",
        "gameStats" .. string.lower(mode))
end

function fetchBasicInfo(Uname)
    print(NGToolsPrefix .. "Fetching...")
    name = autoCompleteName(Uname):gsub("\"", "")
    htmlName = name:gsub(" ", "%%20")
    network.get("https://api.ngmc.co/v1/players/" .. htmlName, "basicInfo")
end

function fetchPlayerBio(Uname)
    print(NGToolsPrefix .. "Fetching...")
    name = autoCompleteName(Uname):gsub("\"", "")
    htmlName = name:gsub(" ", "%%20")
    network.get("https://api.ngmc.co/v1/players/" .. htmlName, "playerBio")
end

function fetchPunishments(Uname)
    print(NGToolsPrefix .. "Fetching...")
    name = autoCompleteName(Uname):gsub("\"", "")
    htmlName = name:gsub(" ", "%%20")
    network.get("https://api.ngmc.co/v1/players/" .. htmlName, "punishments")
end

function autoCompleteName(Uname)
    for x, name in pairs(server.players()) do
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
    fetchServerStats("ping", "players online", NGToolsPrefix .. "§l§3Online Players: §f", "§r")
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
    print(
        "§b.ng§r §6gstats <username> <gamemode> §7 - Fetch player's stats for the specified gamemode. Uses current game if not specified.")
    print("§b.ng§r §6punishments <username>§7 - Fetch player's punishments")
    print("§b.ng§r §6info <username>§7 - Fetch player's account information")
    print("§b.ng§r §6bio <username>§7 - Fetch player's bio")
    print("§b.ng§r §6update §7 - Check for updates on github")
    print("§b.ng§r §6reply <message> §7 - Reply to the latest in-game direct message")
    print("§b.ng§r §6r <message> §7 - Reply to the latest in-game direct message")
    if registerAll == true then
        print("§b.ng §8is not required since all commands are registered!")
    end
    print("§6-----                            §6-----")
end

function replyMsg(message)
    client.execute("execute /w " .. replyIGN .. " " .. message)
end

function getLineCount(text)
    local _, count = string.gsub(text, "\n", "")
    return count + 1
end

function render()
    if locationGui == true and server.ip():find("nethergames") then
        locationTextToRender = "Node: " ..
            "[" .. proxy_region .. "] " .. node_id .. " (" .. node_gamemode .. ")\nProxy: " .. proxy_name
        local font = gui.font()
        sizeX = font.width(locationTextToRender) + paddingSetting.value * 2
        sizeY = font.height * getLineCount(locationTextToRender) * 1.2 + paddingSetting.value * 2

        gfx.color(bgColorSetting.value.r, bgColorSetting.value.g, bgColorSetting.value.b, bgColorSetting.value.a)
        gfx.rect(
            0, 0,
            font.width(locationTextToRender) + 0.2 + paddingSetting.value * 2,
            font.height * getLineCount(locationTextToRender) * 1.2 + paddingSetting.value * 2
        )

        gfx.color(textColorSetting.value.r, textColorSetting.value.g, textColorSetting.value.b, textColorSetting.value.a)
        gfx.text(paddingSetting.value, paddingSetting.value, locationTextToRender)
    end
end

-- Function to clean player names
local function cleanPlayerNames(players)
    local cleanedPlayers = {}
    for i, player in ipairs(players) do
        cleanedPlayers[i] = player:gsub("§.", "")
    end
    return cleanedPlayers
end

-- command handling functions

local function handleServerId()
    copyServerID()
end

local function handleKdr(playerNameKdr)
    local playerName = playerNameKdr or player.name():gsub("§.", "")
    fetchKdr(playerName)
end

local function handleMute(targetMute)
    if targetMute == nil or targetMute == "" then
        print("§cPlease specify a target player to mute!")
    else
        addMute(targetMute)
    end
end

local function handleUname(playNameUname)
    if playNameUname ~= nil then
        copyUname(playNameUname)
    else
        copyUname(player.name():gsub("§.", ""))
    end
end

local function handleOnline()
    fetchOnlinePlayers()
end

local function handleStats(playerNameStats)
    local playerName = playerNameStats or player.name():gsub("§.", "")
    fetchBasicStats(playerName)
end

local function handleGStats(playerNameGStats, gameModeGStats, currentLocation)
    local playerName = playerNameGStats or player.name():gsub("§.", "")
    local gameMode = gameModeGStats or currentLocation
    if gameMode == "lobby" then
        print("§cThis command doesn't work in the lobby! Specify a game mode or start playing.")
    else
        fetchGameStats(playerName, gameMode)
    end
end

local function handleInfo(playerNameInfo)
    local playerName = playerNameInfo or player.name():gsub("§.", "")
    fetchBasicInfo(playerName)
end

local function handleBio(playerNameBio)
    local playerName = playerNameBio or player.name():gsub("§.", "")
    fetchPlayerBio(playerName)
end

local function handleUpdate()
    updateCheck()
end

local function handleReply(messageReply)
    if messageReply == nil or messageReply == "" then
        print("§cPlease specify a message to reply with!")
    else
        replyMsg(messageReply)
    end
end

local function handleR(messageR)
    if messageR == nil or messageR == "" then
        print("§cPlease specify a message to reply with!")
    else
        replyMsg(messageR)
    end
end

local function handleHelp()
    printHelp()
end

local function handlePunishments(playerNamePunishments)
    if playerNamePunishments == nil then
        fetchPunishments(playerNamePunishments)
    else 
        fetchPunishments(player.name():gsub("§.", ""))
    end
    
end
--------------------------
--For registering Subcommands independently
-- Register all commands with intellisense
function registerAllCommands()
    if server.ip():find("nethergames") then
        registerCommand("serverid", function(arguments)
            handleServerId()
        end, function(intellisense)
            local overload = intellisense:addOverload()
        end, NGToolsPrefix .. "§7Copy the current ID of the server you're playing on to the clipboard")

        registerCommand("uname", function(arguments)
            local intellisenseHelper = MakeIntellisenseHelper(arguments)
            local parser = intellisenseHelper:addOverload()
            local playNameUname = parser:matchSoftEnum("playerName", "string", cleanPlayerNames(server.players()))
            handleUname(playNameUname)
        end, function(intellisense)
            local overload = intellisense:addOverload()
            overload:matchSoftEnum("playerName", "string", cleanPlayerNames(server.players()))
        end, NGToolsPrefix .. "§7Copy targeted player's username to the clipboard")

        registerCommand("mute", function(arguments)
            local intellisenseHelper = MakeIntellisenseHelper(arguments)
            local parser = intellisenseHelper:addOverload()
            local targetMute = parser:matchSoftEnum("playerName", "string", cleanPlayerNames(server.players()))
            handleMute(targetMute)
        end, function(intellisense)
            local overload = intellisense:addOverload()
            overload:matchSoftEnum("playerName", "string", cleanPlayerNames(server.players()))
        end, NGToolsPrefix .. "§7Add to the player mute list")

        registerCommand("online", function(arguments)
            handleOnline()
        end, function(intellisense)
            local overload = intellisense:addOverload()
        end, NGToolsPrefix .. "§7Shows online player count")

        registerCommand("kdr", function(arguments)
            local intellisenseHelper = MakeIntellisenseHelper(arguments)
            local parser = intellisenseHelper:addOverload()
            local playerNameKdr = parser:matchSoftEnum("playerName", "string", cleanPlayerNames(server.players()), true)
            handleKdr(playerNameKdr)
        end, function(intellisense)
            local overload = intellisense:addOverload()
            overload:matchSoftEnum("playerName", "string", cleanPlayerNames(server.players()), true)
        end, NGToolsPrefix .. "§7Fetch player's K/DR")

        registerCommand("stats", function(arguments)
            local intellisenseHelper = MakeIntellisenseHelper(arguments)
            local parser = intellisenseHelper:addOverload()
            local playerNameStats = parser:matchSoftEnum("playerName", "string", cleanPlayerNames(server.players()), true)
            handleStats(playerNameStats)
        end, function(intellisense)
            local overload = intellisense:addOverload()
            overload:matchSoftEnum("playerName", "string", cleanPlayerNames(server.players()), true)
        end, NGToolsPrefix .. "§7Fetch player's basic stats")

        registerCommand("gstats", function(arguments)
            local intellisenseHelper = MakeIntellisenseHelper(arguments)
            local parser = intellisenseHelper:addOverload()
            local playerNameGStats = parser:matchSoftEnum("playerName", "string", cleanPlayerNames(server.players()),
                true)
            local gameModeGStats = parser:matchEnum("gameMode", "string", validLocations, true)
            handleGStats(playerNameGStats, gameModeGStats, currentLocation)
        end, function(intellisense)
            local overload = intellisense:addOverload()
            overload:matchSoftEnum("playerName", "string", cleanPlayerNames(server.players()), true)
            overload:matchEnum("gameMode", "string", validLocations, true)
        end, NGToolsPrefix .. "§7Fetch player's stats for the specified gamemode. Uses current game if not specified.")

        registerCommand("punishments", function(arguments)
            local intellisenseHelper = MakeIntellisenseHelper(arguments)
            local parser = intellisenseHelper:addOverload()
            local playerNameInfo = parser:matchSoftEnum("playerName", "string", cleanPlayerNames(server.players()), true)
            handlePunishments(playerNameInfo)
        end, function(intellisense)
            local overload = intellisense:addOverload()
            overload:matchSoftEnum("playerName", "string", cleanPlayerNames(server.players()), true)
        end, NGToolsPrefix .. "§7Fetch player's punishments")

        registerCommand("info", function(arguments)
            local intellisenseHelper = MakeIntellisenseHelper(arguments)
            local parser = intellisenseHelper:addOverload()
            local playerNameInfo = parser:matchSoftEnum("playerName", "string", cleanPlayerNames(server.players()), true)
            handleInfo(playerNameInfo)
        end, function(intellisense)
            local overload = intellisense:addOverload()
            overload:matchSoftEnum("playerName", "string", cleanPlayerNames(server.players()), true)
        end, NGToolsPrefix .. "§7Fetch player's account information")

        registerCommand("bio", function(arguments)
            local intellisenseHelper = MakeIntellisenseHelper(arguments)
            local parser = intellisenseHelper:addOverload()
            local playerNameBio = parser:matchSoftEnum("playerName", "string", cleanPlayerNames(server.players()), true)
            handleBio(playerNameBio)
        end, function(intellisense)
            local overload = intellisense:addOverload()
            overload:matchSoftEnum("playerName", "string", cleanPlayerNames(server.players()), true)
        end, NGToolsPrefix .. "§7Fetch player's bio")

        registerCommand("update", function(arguments)
            handleUpdate()
        end, function(intellisense)
            local overload = intellisense:addOverload()
        end, NGToolsPrefix .. "§7Check for updates on github")

        registerCommand("reply", function(arguments)
            local intellisenseHelper = MakeIntellisenseHelper(arguments)
            local parser = intellisenseHelper:addOverload()
            local messageReply = parser:matchString("message")
            handleReply(messageReply)
        end, function(intellisense)
            local overload = intellisense:addOverload()
            overload:matchString("message")
        end, NGToolsPrefix .. "§7Reply to the latest in-game direct message")

        registerCommand("r", function(arguments)
            local intellisenseHelper = MakeIntellisenseHelper(arguments)
            local parser = intellisenseHelper:addOverload()
            local messageR = parser:matchString("message")
            handleR(messageR)
        end, function(intellisense)
            local overload = intellisense:addOverload()
            overload:matchString("message")
        end, NGToolsPrefix .. "§7Reply to the latest in-game direct message")
    end
end

--------------------------

function ngtools(intellisense, isExecuted)
    -- Define all overloads for subcommands
    local overloadServerId = intellisense:addOverload()
    local isServerId = overloadServerId:matchPath("serverid")

    local overloadKdr = intellisense:addOverload()
    local isKdr = overloadKdr:matchPath("kdr")
    local playerNameKdr = overloadKdr:matchSoftEnum("playerName", "string", cleanPlayerNames(server.players()), true) -- Optional player name

    local overloadMute = intellisense:addOverload()
    local isMute = overloadMute:matchPath("mute")
    local targetMute = overloadMute:matchSoftEnum("playerName", "string", cleanPlayerNames(server.players())) -- Optional player name

    local overloadUname = intellisense:addOverload()
    local isUname = overloadUname:matchPath("uname")
    local playNameUname = overloadUname:matchSoftEnum("playerName", "string", cleanPlayerNames(server.players())) -- Optional player name

    local overloadOnline = intellisense:addOverload()
    local isOnline = overloadOnline:matchPath("online")

    local overloadStats = intellisense:addOverload()
    local isStats = overloadStats:matchPath("stats")
    local playerNameStats = overloadStats:matchSoftEnum("playerName", "string", cleanPlayerNames(server.players()), true) -- Optional player name

    local overloadPunishments = intellisense:addOverload()
    local isPunishments = overloadStats:matchPath("punishments")
    local playerNamePunishments = overloadPunishments:matchSoftEnum("playerName", "string", cleanPlayerNames(server.players()), true) -- Optional player name

    local overloadGStats = intellisense:addOverload()
    local isGStats = overloadGStats:matchPath("gstats")
    local playerNameGStats = overloadGStats:matchSoftEnum("playerName", "string", cleanPlayerNames(server.players()),
        true)                                                                                   -- Optional player name
    local gameModeGStats = overloadGStats:matchEnum("gameMode", "string", validLocations, true) -- Optional game mode

    local overloadInfo = intellisense:addOverload()
    local isInfo = overloadInfo:matchPath("info")
    local playerNameInfo = overloadInfo:matchSoftEnum("playerName", "string", cleanPlayerNames(server.players()), true) -- Optional player name

    local overloadBio = intellisense:addOverload()
    local isBio = overloadBio:matchPath("bio")
    local playerNameBio = overloadBio:matchSoftEnum("playerName", "string", cleanPlayerNames(server.players()), true) -- Optional player name

    local overloadUpdate = intellisense:addOverload()
    local isUpdate = overloadUpdate:matchPath("update")

    local overloadReply = intellisense:addOverload()
    local isReply = overloadReply:matchPath("reply")
    local messageReply = overloadReply:matchString("message")

    local overloadReply = intellisense:addOverload()
    local isR = overloadReply:matchPath("r")
    local messageR = overloadReply:matchString("message")

    local overloadHelp = intellisense:addOverload()
    local isHelp = overloadHelp:matchPath("help")

    if isExecuted then
        if isServerId then
            handleServerId()
        elseif isKdr then
            handleKdr(playerNameKdr)
        elseif isMute then
            handleMute(targetMute)
        elseif isUname then
            handleUname(playNameUname)
        elseif isOnline then
            handleOnline()
        elseif isStats then
            handleStats(playerNameStats)
        elseif isGStats then
            handleGStats(playerNameGStats, gameModeGStats, currentLocation)
        elseif isInfo then
            handleInfo(playerNameInfo)
        elseif isBio then
            handleBio(playerNameBio)
        elseif isUpdate then
            handleUpdate()
        elseif isReply then
            handleReply(messageReply)
        elseif isR then
            handleR(messageR)
        elseif isHelp then
            handleHelp()
        elseif isPunishments then
            handlePunishments(playerNamePunishments)
        else
            print("§cUnknown subcommand! Type `§7.ngtools help§c` for help.")
        end
    end
end

registerCombinedCommand("ngtools", ngtools, NGToolsPrefix .. "Master Command")
registerCombinedCommand("ng", ngtools, NGToolsPrefix .. "Master Command")

function wrongServer()
    print(NGToolsPrefix .. "Error: You are not on the NetherGames!")
end
