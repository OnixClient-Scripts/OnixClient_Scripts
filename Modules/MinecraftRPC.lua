name = "Minecraft RPC"
description = "Rich Presence. Intelligently.\nClosing the launcher when using this is recommended."

--[[
made by rosie (credits: son, mitchell, onix)
requires MinecraftRPCHelper.exe (can be found on the repo)

exe source:
https://github.com/jqms/MinecraftRPC
]] --

function downloadExe()
    workingDir = "RoamingState/OnixClient/Scripts/Extras"
    network.fileget("MinecraftRPCHelper.exe","https://github.com/OnixClient-Scripts/OnixClient_Scripts/blob/master/Extras/MinecraftRPCHelper.exe?raw=true", "MinecraftRPCHelper")
    workingDir = "RoamingState/OnixClient/Scripts/Data"
end
downloadExe()

function openFolder() workingDir = "RoamingState/OnixClient/Scripts";fs.showFolder("Extras") workingDir = "RoamingState/OnixClient/Scripts/Data" end

importLib("DependentBoolean")

fs.mkdir("RPC")
io.open("RPC/RPCHelperUsername.txt", "w")
io.open("RPC/RPCHelperGamemode.txt", "w")

lastGamemode = ""
prefix = "Playing "
suffix = "lobby."
local result = {}
gameLobby = false
displaySettings = true
displayGamemode = true
displayUsername = true
displayLevel = true
hub = false

client.settings.addFunction("Open Exe Folder", "openFolder", "Open")
client.settings.addAir(2)
client.settings.addBool("RPC Settings", "displaySettings")
client.settings.addDependentBool("Display Gamemode?", "displayGamemode", "displaySettings")
client.settings.addDependentBool("Display Username?", "displayUsername", "displaySettings")
client.settings.addDependentBool("Display Level? (Hive Only)", "displayLevel", "displaySettings")

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
    REPLAY = "Replay"
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

globalLevel = 0
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
function calculateLevel(game, xp)
    local increment = GAME_XP[game][1] / 2
    local flattenLevel = GAME_XP[game][2]
    local level =
        (-increment + math.sqrt((increment^2) - 4 * increment * -xp)) /
        (2 * increment) +
        1
    if flattenLevel and level > flattenLevel then
        level =
            flattenLevel +
            (xp -
                (increment * ((flattenLevel - 1)^2) +
                    (flattenLevel - 1) * increment)) /
            ((flattenLevel - 1) * increment * 2);
    end
    return level
end
function onNetworkData(code, gamemode, data)
    if code == 0 then
        result = jsonToTable(data)
        if type(result) ~= "table" then
            return
        end
        if tablelen(result) == 0 then
            print("No results found.")
            return
        else
            globalLevel = math.floor(10*calculateLevel(globalGamemode, result["xp"]))/10
        end
    end
end

function tablelen(tbl)
    local a = 0
    for k, v in pairs(tbl) do
        a = a + 1
    end
    return a
end

function update(dt)
    client.settings.updateDependencies()
    local username = player.name()
    if displayUsername == true and displaySettings == true then
        local file = io.open("RPC/RPCHelperUsername.txt", "w")
        io.output(file)
        io.write("As " .. username)
        io.close(file)
    elseif displayUsername == false then
        local file = io.open("RPC/RPCHelperUsername.txt", "w")
        io.output(file)
        io.write("")
        io.close(file)
    end
    if formattedGamemode == nil then
        formattedGamemode = "Unknown"
    end
    local item = player.inventory().at(1)
    local item2 = player.inventory().at(9)
    if (item ~= nil and item.customName == "§r§bGame Selector§7 [Use]") or (item2 ~= nil and item2.customName == "§r§7» §ePlayer §fSettings§7 «" and gameLobby == false) or hub == true then
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
        if displayLevel == true then
            local file = io.open("RPC/RPCHelperGamemode.txt", "w")
            io.output(file)
            if globalLevel ~= 0 then
                io.write("Playing " .. formattedGamemode .. " (Lvl: " .. globalLevel .. ")")
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
        if displayLevel == true and globalLevel ~= (nil or 0) then
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
end
zeqaGamemodeUntamptered = ""
zeqaGamemode = ""
opponent = ""
function onChat(message, username, type)
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
	--cubecraft
	if message:find("is starting in §r§e§e§r§e§e5§r§e§e seconds") then
		hub = false
		local temp = message:gsub("§.", "")
		temp = temp:gsub(" is starting in 5 seconds.", "")
		prefix = temp
		formattedGamemode = prefix
		lastGamemode = prefix
	end
	--zeqa
    if string.find(message,"§eZEQA§8 » §r§7You have joined the queue for") then
        hub = false
        zeqaGamemode = string.gsub(message,"§eZEQA§8 » §r§7You have joined the queue for ","")
        zeqaGamemodeUntamptered = zeqaGamemode
        zeqaGamemode = string.gsub(zeqaGamemode,"§.","")
        formattedGamemode = zeqaGamemode
        lastGamemode = zeqaGamemode
        gameLobby = true
    end
    if string.find(message,"§eZEQA§8 » §r§7You have left the queue for") then
        gameLobby = false
        hub = true
    end
    if (string.find(message, "§eZEQA§8 » §r§7Found a ") and string.find(message, "match against")) then
        formattedGamemode = zeqaGamemode
        lastGamemode = zeqaGamemode
        gameLobby = false
    end

    --hive
    if string.find(message, "§b§l» §r§a§lVoting has ended!") then
        hub = false
        gameLobby = false
    end
    if string.find(message, "You are connected to server ") then
        hub = false
        lastGamemode = message
        lastGamemode = string.sub(message, 29)
        lastGamemode = string.match(lastGamemode, "[%a-]*")
        local gamemode = lastGamemode
        if string.find(gamemode, "-") then
            gamemode = string.sub(gamemode, 1, string.find(gamemode, "-") - 1)
        end
        globalGamemode = string.lower(gamemode)
        usernameSearch = string.gsub(player.name()," ", "%%20")
        if displayLevel == true then
            network.get("https://api.playhive.com/v0/game/all/" .. string.lower(gamemode) .. "/" .. usernameSearch,  gamemode)
        end
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