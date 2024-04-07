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
    GRAV = "Gravity",
    GI = "Ghost Invasion",
    BED = "Bedwars",
}
formattedGamemodes["BRIDGE-DUOS"] = "The Bridge: Duos"
formattedGamemodes["SG-DUOS"] = "Survival Games: Duos"
formattedGamemodes["WARS-DUOS"] = "Treasure Wars: Duos"
formattedGamemodes["WARS-SQUADS"] = "Treasure Wars: Squads"
formattedGamemodes["WARS-MEGA"] = "Treasure Wars: Mega"
formattedGamemodes["BED-DUOS"] = "Bedwars: Duos"
formattedGamemodes["BED-TRIOS"] = "Bedwars: Trios"
formattedGamemodes["BED-SQUADS"] = "Bedwars: Squads"
formattedGamemodes["BED-MEGA"] = "Bedwars: Mega"
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

onInventoryChange = function()
    if server.ip():find("zeqa") then
        if player.inventory().at(8) ~= nil then
            if player.inventory().at(8).displayName:find("§gShop §fMenu§7") then
                hub = true
            end
        end
    end
end

lastInventoryState = {}
currentInventoryState = {}

function table.compare(table1, table2)
    if #table1 ~= #table2 then
        return false
    end
    for key, value in pairs(table1) do
        if table2[key] ~= value then
            return false
        end
    end
    for key, value in pairs(table2) do
        if table1[key] ~= value then
            return false
        end
    end
    return true
end

function checkInventoryChange()
    for i = 1, 36 do
        currentInventoryState[i] = player.inventory().at(i) ~= nil and player.inventory().at(i).count
    end

    if table.compare(currentInventoryState, lastInventoryState) == false then
        lastInventoryState = currentInventoryState
        onInventoryChange()
        currentInventoryState = {}
    end
end

function render3d()
    checkInventoryChange()
end

function postInit()
    for i = 1, 36 do
        currentInventoryState[i] = player.inventory().at(i) ~= nil and player.inventory().at(i).count
        lastInventoryState[i] = player.inventory().at(i) ~= nil and player.inventory().at(i).count
    end
end

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
    if (item3 ~= nil and item3.displayName == "§r§aYour SkyWars Locker§7 [Use]") then
        local file = io.open("RPC/RPCHelperGamemode.txt", "w")
        io.output(file)
        io.write("In Skywars Microhub")
        io.close(file)
    elseif (item3 ~= nil and item3.displayName == "§r§aYour BedWars Locker§7 [Use]") then
        local file = io.open("RPC/RPCHelperGamemode.txt", "w")
        io.output(file)
        io.write("In Bedwars Microhub")
        io.close(file)
    elseif (item ~= nil and item.customName == "§r§bGame Selector§7 [Use]") or (item2 ~= nil and item2.customName == "§r§7» §ePlayer §fSettings§7 «" and gameLobby == false) or (item3 ~= nil and item3.customName == "§r§7» §eRegion §fSelector§7 «") or hub == true then
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
            if server.ip():find("zeqa") and tostring(server.port()):find("19132") then
                io.write(formattedGamemode)
            else
                io.write("Playing " .. formattedGamemode)
            end
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

isQueuingFFA = false
function update()
    local username = player.name()
    if displayUsername.value == true then
        local file = io.open("RPC/RPCHelperUsername.txt", "w")
        io.output(file)
        if server.ip():find("zeqa") then
            local region = string.upper(server.ip():match("([^.]+)"))
            if server.port() == 19132 then
                formattedGamemode = "In The Lobby"
                io.write("As " .. username)
            else
                local serverNumber = tostring(server.port()):gsub("1000", "")
                region = region:gsub("ZEQA", "NA")
                io.write("As " .. username .. " (".. region .. serverNumber .. ")")
            end
        else
            io.write("As " .. username)
        end
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

event.listen("ChatMessageAdded", function(message, username, type)
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
    if string.find(message, "You are connected to server name ") then
        hub = false
        lastGamemode = message:sub(34):match("[%a-]*")
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
    if string.find(message, " joined. §8") then
        hub = false
        client.execute("execute /connection")
        gameLobby = true
    end
    --hide the /connection message
    if string.find(message, "You are connected to proxy ") then
        return true
    end
    if string.find(message, "You are connected to server name ") then
        return true
    end
    if message:find("You are connected to public IP ") then
        return true
    end
    if message:find("You are connected to internal IP ") then
        return true
    end
    if string.find(message, "§cYou're issuing commands too quickly, try again later.") then
        return true
    end
    if string.find(message, "§cUnknown command. Sorry!") then
        return true
    end
end)

ffaList = {
    ["nodebuff"] = "NoDebuff",
    ["sumo"] = "Sumo",
    ["combo"] = "Combo",
    ["fist"] = "Fist",
    ["knock"] = "Knock",
    ["oitc"] = "OITC",
    ["build"] = "Build",
    ["uch"] = "BuildUHC",
    ["res"] = "Resistance",
    ["archer"] = "Archer",
    ["killphrase"] = "Wrath"
}
trainingList = {"Block-In", "Clutch", "Reduce"}
botList = {"Easy Bot", "Medium Bot", "Hard Bot"}

function onNetworkData(code,id,data)
    local a,b,c = 1,2,3
end

globalModalRequestData = {}
ZeqaButtonSelected = -1

function stringtohex(utf8str)
    local str = utf8str:gsub(".", function(c)
        return string.format("%02X", string.byte(c))
    end)
    return str
end

function hextostring(hex)
    local str = hex:gsub("..", function(cc)
        return string.char(tonumber(cc, 16))
    end)
    return str
end
isTheCorrectModalFormThatIRequireAtThisMomentOfTime = false
event.listen("ModalRequested", function (ARG1, ARG2)
    --use these (autocomplete)
    ---@type ModalFormRequest
    local request = ARG1
    ---@type ModalFormReplyer
    local response = ARG2
    globalModalRequestData = {}
    if request.type == "form" then
        isTheCorrectModalFormThatIRequireAtThisMomentOfTime = request.form.title:find(hextostring("C2A76AEE8D85EE8D91EE8D84EE8D842020EE8D85EE8D8EEE8D912020EE8D80EE8D8BEE8D8B"))
        if isTheCorrectModalFormThatIRequireAtThisMomentOfTime then
            globalModalRequestData = request
        end
    end
end)

event.listen("UNDOCUMENTEDModalResponse", function(response)
    if globalModalRequestData ~= nil then
        ---@type ModalFormRequest
        local balls = globalModalRequestData
        if isTheCorrectModalFormThatIRequireAtThisMomentOfTime then
            for i, buttons in pairs(balls.form.buttons) do
                if response[1] == i-1 then
                    hub = false
                    inGame = true
                    isQueuingFFA = true
                    -- print(buttons.image.data)
                    local currentGamemode = ffaList[buttons.image.data:gsub("zeqa/textures/ui/gm/", ""):gsub("zeqa/textures/ui/more/", ""):gsub(".png", "")] or "Unknown"
                    currentGamemode = currentGamemode .. " FFA"
                    formattedGamemode = currentGamemode
                    lastGamemode = currentGamemode
                end
            end
        end
    end
end)