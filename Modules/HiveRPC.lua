name = "Hive RPC"
description = "Rich presence for Hive gamemodes.\nClosing the launcher when using this is recommended."

--[[
made by rosie (son helped with c#)
requires HiveRPCHelper.exe (can be found on the repo)

!!may be innaccurate if youre in the hub due to how i get the current gamemode!!

c# source:
https://github.com/jqms/HiveRPCHelperSRC
]]--


importLib("DependentBoolean")

lastGamemode = ""
prefix = ""
suffix = "lobby."

lobby = false
displaySettings = false
displayGamemode = false
displayUsername = false

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
    DR="DR",
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

    if  lobby == false and formattedGamemode ~= "Hub" and lobby == false then
        prefix = "Playing "
    else
        prefix = "In the "
    end
    if  lobby == false and formattedGamemode ~= "Replay" and formattedGamemode ~= "Hub" then
        prefix = "Playing "
    else
        if  lobby == false and formattedGamemode == "Replay" then
            prefix = "In a "
        end
    end

    if formattedGamemode == nil then
        return
    elseif lobby == false and displayGamemode == true and displaySettings == true then
            file = io.open("HiveRPCHelperGamemode.txt", "w")
            io.output(file)
            io.write("" ..  prefix .. formattedGamemode)
            io.close(file)
        elseif displayGamemode == false then
            file = io.open("HiveRPCHelperGamemode.txt", "w")
            io.output(file)
            io.write("")
            io.close(file)
    end
    if formattedGamemode == nil then
        return
    elseif lobby == true then
        file = io.open("HiveRPCHelperGamemode.txt", "w")
        io.output(file)
        io.write("In a " .. formattedGamemode .. " lobby")
        io.close(file)
    end

    local username = player.name()
    if displayUsername == true and displaySettings == true then
        file1 = io.open("HiveRPCHelperUsername.txt", "w")
        io.output(file1)
        io.write("As " ..  username)
        io.close(file1)
    elseif displayUsername == false then
        file1 = io.open("HiveRPCHelperUsername.txt", "w")
        io.output(file1)
        io.write("")
        io.close(file1)
    end

end

function onChat(message, username, type)

    if string.find(message,"joined. §8") then
        lobby = true
        return
    elseif string.find(message, "§b§l» §r§a§lVoting has ended!") then
        lobby = false
        return
    end

    if string.find(message, "§b§l» §r§a§lVoting has ended!") or string.find(message," joined. §8") or string.find(message, "§a") then
        client.execute("execute /connection")
    end
    if string.find(message,"You are connected to server ") then
        lastGamemode = message
        lastGamemode = string.sub(message, 29)
        lastGamemode = string.match(lastGamemode,"[%a-]*")
    end
    if formattedGamemodes[lastGamemode] then
        formattedGamemode = formattedGamemodes[lastGamemode]
    end
    if string.find(message, "You are connected to proxy ") then
        return true
    end
    if string.find(message, "You are connected to server ") then
        return true
    end
end

event.listen("ChatMessageAdded", onChat)