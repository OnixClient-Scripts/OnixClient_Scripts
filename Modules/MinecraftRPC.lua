name = "Minecraft RPC"
description = "Rich Presence. Intelligently.\nClosing the launcher when using this is recommended."

--[[
made by rosie (credits: son, onix)
requires MinecraftRPCHelper.exe (can be found on the repo)

exe source:
https://github.com/jqms/MinecraftRPC
]] --

function downloadRPC()
    client.notification("Downloading latest exe...")
    workingDir = "RoamingState/OnixClient/Scripts/"
	fs.mkdir("Extras")
	workingDir = "RoamingState/OnixClient/Scripts/Extras"
    network.fileget("MinecraftRPCHelper.exe","https://raw.githubusercontent.com/OnixClient-Scripts/OnixClient_Scripts/master/Extras/MinecraftRPCHelper.exe", "MinecraftRPCHelper")
	workingDir = "RoamingState/OnixClient/Scripts/Data"
end

function openFolder()
	workingDir = "RoamingState/OnixClient/Scripts/Extras"
	setClipboard("%localappdata%/Packages/Microsoft.MinecraftUWP_8wekyb3d8bbwe/RoamingState/OnixClient/Scripts/Extras/MinecraftRPCHelper.exe")
	client.notification("Press Windows Key + R and paste to open the exe.")
	workingDir = "RoamingState/OnixClient/Scripts/Data"
end

fs.mkdir("RPC")
io.open("RPC/RPCHelperUsername.txt", "w"):close()
io.open("RPC/RPCHelperGamemode.txt", "w"):close()

lastGamemode = ""
prefix = "Playing "
suffix = "lobby."
local result = {}
gameLobby = false
hub = false

client.settings.addCategory("RPC Settings")
displayGamemode = client.settings.addNamelessBool("Display Gamemode?", true)
displayUsername = client.settings.addNamelessBool("Display Username?", true)
client.settings.addAir(5)

client.settings.addCategory("Zeqa Settings")
displayRankStatus = client.settings.addNamelessBool("Display Rank Status?", true)
displayOpponent = client.settings.addNamelessBool("Display Opponent?", true)
client.settings.addAir(5)

client.settings.addCategory("Hive Settings")
displayLevel = client.settings.addNamelessBool("Display Level? (Hive Only)", true)
client.settings.addAir(5)

client.settings.addCategory("Miscellaneous Settings")
client.settings.addFunction("Open Exe", "openFolder", "Open")
client.settings.addAir(2)
client.settings.addFunction("Download Latest Exe", "downloadRPC", "Download")
client.settings.addInfo("Make sure to close the exe before attempting to update it.")




displayPercentage = {}
-- client.settings.addNamelessBool("Display Percentage? (Hive Only)", true)

local formattedGamemodes = {
    DROP = "Block Drop",
    CTF = "Capture The Flag",
    BRIDGE = "The Bridge",
    GROUND = "Ground Wars",
    SG = "Survival Games",
    MURDER = "Murder Mystery",
    WARS = "Treasure Wars",
    SKY = "Skywars",
    BUILD = "Just Build",
    HIDE = "Hide And Seek",
    DR = "Death Run",
    ARCADE = "Arcade Hub",
    HUB = "Hub",
    REPLAY = "Replay",
    PARTY = "Block Party",
    GRAV = "Gravity"
}
formattedGamemodes["BRIDGE-DUOS"] = "The Bridge: Duos"
formattedGamemodes["SG-DUOS"] = "Survival Games: Duos"
formattedGamemodes["WARS-DUOS"] = "Treasure Wars: Duos"
formattedGamemodes["WARS-SQUADS"] = "Treasure Wars: Squads"
formattedGamemodes["WARS-MEGA"] = "Treasure Wars: Mega"
formattedGamemodes["SKY-DUOS"] = "Skywars: Duos"
formattedGamemodes["SKY-TRIOS"] = "Skywars: Trios"
formattedGamemodes["SKY-SQUADS"] = "Skywars: Squads"
formattedGamemodes["SKY-KITS"] = "Skywars Kits"
formattedGamemodes["SKY-KITS-DUOS"] = "Skywars Kits: Duos"
formattedGamemodes["SKY-MEGA"] = "Skywars Mega"
formattedGamemodes["BUILD-DUOS"] = "Just Build: Duos"
formattedGamemodes["BUILDX"] = "Just Build: Extended"
formattedGamemodes["BUILDX-DUOS"] = "Just Build: Extended, Duos"

globalLevel = ""
globalGamemode = ""

local GAME_XP = {
    wars={150,52},
    dr={200,42},
    hide={100},
    murder={100, 82},
    sg={150},
    sky={150, 52},
    build={100},
    ground={150},
    drop={150, 22},
    ctf={150}
}

function tablelen(tbl)
    local a = 0
    for k, v in pairs(tbl) do
        a = a + 1
    end
    return a
end

function updateButOutsideOfItSoICanAddTheAFKThingBecauseImLazy()
    if formattedGamemode == nil then
        formattedGamemode = "Unknown"
    end
    local item = player.inventory().at(1)
    local item2 = player.inventory().at(9)
    local item3 = player.inventory().at(5)
    if (item ~= nil and item.customName == "§r§bGame Selector§7 [Use]") or (item2 ~= nil and item2.customName == "§r§7» §ePlayer §fSettings§7 «" and gameLobby == false) or (item3 ~= nil and item3.customName == "§r§7» §eRegion §fSelector§7 «")or hub == true then
        local file = io.open("RPC/RPCHelperGamemode.txt", "w")
        io.output(file)
        io.write("In the Hub")
        io.close(file)
    elseif item2 ~= nil and item2.name == "cubecraft:skyblock_settings" then
        globalLevel = 0
        local file = io.open("RPC/RPCHelperGamemode.txt", "w")
        io.output(file)
        io.write("In The Hub")
        io.close(file)
    elseif lastGamemode ~= nil and gameLobby == false then
        if server.ip():find("hive") and displayLevel.value then
            local file = io.open("RPC/RPCHelperGamemode.txt", "w")
            io.output(file)
            if globalLevel ~= 0 then
                    io.write("Playing " .. formattedGamemode .. " (Lvl: " .. globalLevel .. ")")
                -- elseif globalLevel:find("%") then
                --     print(globalLevel)
                --     io.write("Playing " .. formattedGamemode .. " (" .. globalLevel .. "%")
            else
                io.write("Playing " .. formattedGamemode)
            end
            io.close(file)
        else
            local file = io.open("RPC/RPCHelperGamemode.txt", "w")
            io.output(file)
            io.write("Playing " .. formattedGamemode)
            io.close(file)
        end
    elseif lastGamemode ~= nil and gameLobby == true then
        if server.ip():find("hive") and displayLevel.value and (globalLevel ~= nil or globalLevel ~= 0) then
            local file = io.open("RPC/RPCHelperGamemode.txt", "w")
            io.output(file)
			io.write("Queuing " .. formattedGamemode.. " (Lvl: " .. globalLevel .. ")")
            io.close(file)
        else
            local file = io.open("RPC/RPCHelperGamemode.txt", "w")
            io.output(file)
            io.write("Queuing " .. formattedGamemode)
            io.close(file)
        end
    else
        return
    end
    if server.ip():find("hive") then
        if displayLevel.value == true then
            displayPercentage.value = false
            local xp = player.attributes().name("minecraft:player.level")
            globalLevel = math.floor(xp.value)
        elseif displayPercentage.value == true then
            displayLevel.value = false
            local xp = player.attributes().name("minecraft:player.experience").value

            local percentage = math.floor(xp * 100)
            globalLevel = percentage .. "%"
        end
    end
end

lastKeyboardInput = os.clock()

event.listen("KeyboardInput", function(key, down)
    lastKeyboardInput = os.clock()
end)

function update()
    local username = player.name()
    if displayUsername.value == true then
        local file = io.open("RPC/RPCHelperUsername.txt", "w")
        io.output(file)
        io.write("As " .. username)
        io.close(file)
    elseif displayUsername.value == false then
        local file = io.open("RPC/RPCHelperUsername.txt", "w")
        io.output(file)
        io.write("")
        io.close(file)
    end
    if lastKeyboardInput + 600 < os.clock() then
        local file = io.open("RPC/RPCHelperGamemode.txt", "w")
        io.output(file)
        io.write("Currently AFK")
        io.close(file)
    else
        updateButOutsideOfItSoICanAddTheAFKThingBecauseImLazy()
    end
end

opponent = ""

function onChat(message, username, type)
    if server.ip():find("galaxite") then
        if string.find(message, "§aWelcome to Galaxite") then
            hub = true
            local file = io.open("RPC/RPCHelperGamemode.txt", "w")
            io.output(file)
            io.write(prefix)
            io.close(file)
        end
        if message:find(" §6Joining ") then
            hub = false
            local galaxiteTeam = ""
            local temp = message:sub(16)
            if temp:find("Solo") then
                galaxiteTeam = "Solos"
                temp = temp:gsub(" Solo", "")
            elseif temp:find("Double") then
                galaxiteTeam = "Doubles"
                temp = temp:gsub(" Double", "")
            elseif temp:find("Quad") then
                galaxiteTeam = "Quads"
                temp = temp:gsub(" Quad", "")
            end
            if galaxiteTeam == "" then
                prefix = temp
            else
                prefix = temp .. " (" .. galaxiteTeam .. ")"
            end
            formattedGamemode = prefix
            lastGamemode = prefix
        end
    end
    if server.ip():find("cubecraft") then
        --cubecraft
        if message:find("is starting in §r§e§e§r§e§e5§r§e§e seconds") then
            hub = false
            local temp = message:gsub("§.", "")
            temp = temp:gsub(" is starting in 5 seconds.", "")
            prefix = temp
            formattedGamemode = prefix
            lastGamemode = prefix
        end
    end
    if server.ip():find("zeqa") then
        --zeqa
        if player.inventory().at(8).displayName:find("§gShop §fMenu§7") then
            hub = true
        end
        if string.find(message,"ZEQA§. » §r§7You have joined the queue for") then
            hub = false
            formattedGamemode = message:match("ZEQA§. » §r§7You have joined the queue for (.*)"):gsub("§.", "")
            if displayRankStatus.value == false then
                formattedGamemode = formattedGamemode:gsub("Ranked ", ""):gsub("Unranked ", "")
            end
            lastGamemode = formattedGamemode
            gameLobby = true
        end
        if string.find(message,"ZEQA§. » §r§7You have left the queue for") then
            gameLobby = false
            hub = true
        end
        if message:match("ZEQA§. » §r§7Found a §f(.-)§7 match against §c.-") then
            gamemode = message:match("ZEQA§. » §r§7Found a §f(.-)§7 match against §c.-")
            opponent = message:gsub("ZEQA§. » §r§7Found a §f.-§7 match against §c", ""):gsub("§.", "")
            if gamemode then
                if displayRankStatus.value == false then
                    gamemode = gamemode:gsub("Ranked ", ""):gsub("Unranked ", "")
                end
                if displayOpponent.value == true then
                    gamemode = gamemode .. " against " .. opponent
                end
                formattedGamemode = gamemode
                lastGamemode = gamemode
                gameLobby = false
            end
        end
    end

    --hive
    if string.find(message, "§b§l» §r§a§lVoting has ended!") then
        hub = false
        gameLobby = false
    end
    if string.find(message, "You are connected to server ") then
        hub = false
        lastGamemode = message:sub(29):match("[%a-]*")
        local gamemode = lastGamemode
        if string.find(gamemode, "-") then
            gamemode = string.sub(gamemode, 1, string.find(gamemode, "-") - 1)
        end
        globalGamemode = string.lower(gamemode)
        usernameSearch = string.gsub(player.name()," ", "%%20")
    end
    if formattedGamemodes[lastGamemode] then
        formattedGamemode = formattedGamemodes[lastGamemode]
    end

    if string.find(message, " joined. §8") and string.find(message, player.name()) then
        hub = false
        client.execute("execute /connection")
        gameLobby = true
    end
    --hide the /connection message
    if string.find(message, "You are connected to proxy ") then
        return true
    end
    if string.find(message, "You are connected to server ") then
        return true
    end
    if string.find(message, "§cYou're issuing commands too quickly, try again later.") then
        return true
    end
    if string.find(message, "§cUnknown command. Sorry!") then
        return true
    end
end
event.listen("ChatMessageAdded", onChat)

function onNetworkData(code,id,data)
    local a,b,c = 1,2,3
end