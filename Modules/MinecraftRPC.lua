name = "Minecraft RPC"
description = "Rich Presence. Intelligently.\nClosing the launcher when using this is recommended."

--[[
made by rosie (credits: son, mitchell, onix)
requires HiveRPCHelper.exe (can be found on the repo)

exe source:
https://github.com/jqms/MinecraftRPC
]]--

local appID
importLib("DependentBoolean")

fs.mkdir("RPC")
_ = io.open("RPC/RPCHelperUsername.txt","w")
_ = io.open("RPC/RPCHelperGamemode.txt","w")

lastGamemode = ""
prefix = "Playing "
suffix = "lobby."

hiveLobby = false
displaySettings = true
displayGamemode = true
displayUsername = true

client.settings.addBool("RPC Settings","displaySettings")
client.settings.addDependentBool("Display Gamemode?","displayGamemode","displaySettings")
client.settings.addDependentBool("Display Username?","displayUsername","displaySettings")

local formattedGamemodes = {
    DROP="Block Drop",
    CTF="Capture The Flag",
    BRIDGE="The Bridge",
    GROUND="Ground Wars",
    SG="Survival Games",
    MURDER="Murder Mystery",
    WARS="Treasure Wars",
    SKY="Skywars",
    BUILD="Just Build",
    HIDE="Hide And Seek",
    DR="Death Run",
    ARCADE="Arcade Hub",
    HUB="Hub",
    REPLAY="Replay"
}
formattedGamemodes["BRIDGE-DUOS"]="The Bridge: Duos" 
formattedGamemodes["SG-DUOS"]="Survival Games: Duos"
formattedGamemodes["WARS-DUOS"]="Treasure Wars: Duos"
formattedGamemodes["WARS-SQUADS"]="Treasure Wars: Squads"
formattedGamemodes["WARS-MEGA"]="Treasure Wars: Mega"
formattedGamemodes["SKY-DUOS"]="Skywars: Duos"
formattedGamemodes["SKY-TRIOS"]="Skywars: Trios"
formattedGamemodes["SKY-SQUADS"]="Skywars: Squads"
formattedGamemodes["SKY-KITS"]="Skywars Kits"
formattedGamemodes["SKY-KITS-DUOS"]="Skywars Kits: Duos"
formattedGamemodes["SKY-MEGA"]="Skywars Mega"
formattedGamemodes["BUILD-DUOS"]="Just Build: Duos"
formattedGamemodes["BUILDX"]="§5Just Build: Extended"
formattedGamemodes["BUILDX-DUOS"]="Just Build: Extended, Duos"

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
    if item ~= nil and item.customName == "§r§bGame Selector§7 [Use]" then
        local file = io.open("RPC/RPCHelperGamemode.txt", "w")
        io.output(file)
        io.write("In the Hub")
        io.close(file)
    elseif item2 ~= nil and item2.name == "cubecraft:skyblock_settings" then
        local file = io.open("RPC/RPCHelperGamemode.txt", "w")
        io.output(file)
        io.write("Playing Skyblock")
        io.close(file)
    elseif lastGamemode ~= nil and hiveLobby == false then
        local file = io.open("RPC/RPCHelperGamemode.txt", "w")
        io.output(file)
        io.write("Playing " .. formattedGamemode)
        io.close(file)
    elseif lastGamemode ~= nil and hiveLobby == true then
        local file = io.open("RPC/RPCHelperGamemode.txt", "w")
        io.output(file)
        io.write("Queuing " .. formattedGamemode)
        io.close(file)
    else
        return
    end
end

function onChat(message, username, type)
    if string.find(message, "§aWelcome to Galaxite") then
        prefix = "Playing Galaxite"
        local file = io.open("RPC/RPCHelperGamemode.txt", "w")
        io.output(file)
        io.write(prefix)
        io.close(file)
    end

--hive 
    if string.find(message," joined. §8") and string.find(message, player.name()) then
        client.execute("execute /connection")
        hiveLobby = true
    end
    if string.find(message, "§b§l» §r§a§lVoting has ended!") then
        hiveLobby = false
    end
    if string.find(message,"You are connected to server ") then
        lastGamemode = message
        lastGamemode = string.sub(message, 29)
        lastGamemode = string.match(lastGamemode,"[%a-]*")
    end
    if formattedGamemodes[lastGamemode] then
        formattedGamemode = formattedGamemodes[lastGamemode]
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