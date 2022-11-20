name = "Hive Autoqueue"
description = "Automatically Queue Hive Games.\nScript Version: v3.0"
--[[

Made by rosie w/ help from onix cuz he gamer (thx rice for letting me skid some code <3)

if you want to use .rq, you need the script, its called "HiveRequeue.lua" on the github.
alternatively you can just make a new command and put this as the code:

    command = "rq"
    help_message = "Requeues Hive Games"
    function execute(arguments)
    sendLocalData("00409ed7-72f4-4575-8028-c0abf7736a49", "e")
    end

bye🙂
]]
importLib("GFX2Colour")

team ="Unknown"
lastGamemode = ""
formattedGamemode = ""

Auto = "Fully Automatic (Recommended)"
Other = "Other Settings"

FullyAuto = true
ShowGamemode = false
inGame = false
oopsie = false
hub = false

client.settings.addAir(5)
client.settings.addInfo("Other")
client.settings.addBool("Show the gamemode on screen?", "ShowGamemode")
client.settings.addAir(5)

background = client.settings.addNamelessColor("Background Color", {0,0,0,127})

color = client.settings.addNamelessColor("Color", {255, 255, 255})

round = 1
client.settings.addInt("Rounded Corners", "round", 1, 10)

quality = 1
client.settings.addInt("Quality", "quality", 1, 10)

local formattedGamemodes = {
    DROP = "§5Block Drop",
    CTF = "§6Capture The Flag",
    BRIDGE = "§9The §5Bridge",
    GROUND = "§3Ground §2Wars",
    SG = "§3Survival Games",
    MURDER = "§fMurder Mystery",
    WARS = "§6Treasure Wars",
    SKY = "§9Skywars",
    BUILD = "§5Just Build",
    HIDE = "§9Hide And Seek",
    DR = "§cDeath Run",
    ARCADE = "§eArcade Hub",
    HUB = "§eHub"
}
formattedGamemodes["BRIDGE-DUOS"] = "§9The §5Bridge§8: Duos"
formattedGamemodes["SG-DUOS"] = "§3Survival Games§8: Duos"
formattedGamemodes["WARS-DUOS"] = "§6Treasure Wars§8: Duos"
formattedGamemodes["WARS-SQUADS"] = "§6Treasure Wars§8: Squads"
formattedGamemodes["WARS-MEGA"] = "§6Treasure Wars§8: Mega"
formattedGamemodes["SKY-DUOS"] = "§9Skywars§8: Duos"
formattedGamemodes["SKY-TRIOS"] = "§9Skywars§8: Trios"
formattedGamemodes["SKY-SQUADS"] = "§9Skywars§8: Squads"
formattedGamemodes["SKY-KITS"] = "§9Skywars §5Kits"
formattedGamemodes["SKY-KITS-DUOS"] = "§9Skywars §5Kits§8: Duos"
formattedGamemodes["SKY-MEGA"] = "§9Skywars §cMega"
formattedGamemodes["BUILD-DUOS"] = "§5Just Build§8: Duos"
formattedGamemodes["BUILDX"] = "§5Just Build§7: Extended"
formattedGamemodes["BUILDX-DUOS"] = "§5Just Build§7: Extended§8, Duos"

function update()
    if formattedGamemode == "" then
        ShowGamemode = false
    end
    local item = player.inventory().at(1)
    if item ~= nil and item.customName == "§r§bGame Selector§7 [Use]" then
        lastGamemode = "HUB"
        hub = true
    end
    if formattedGamemodes[lastGamemode] then
        formattedGamemode = formattedGamemodes[lastGamemode]
        if lastGamemode == "HUB" or lastGamemode == "ARCADE" then
            inGame = false
        else
            inGame = true
        end
    end
end

function onChat(message, username, type)
    -- fully automatic requeue :D
    if string.find(message, "§b§l» §r§a§lVoting has ended!") then
        client.execute("execute /connection")
        hub = false
        inGame = true
    end
    if string.find(message, player.name()) and string.find(message, " joined. §8") then
        client.execute("execute /connection")
        hub = false
        inGame = true
    end
    if string.find(message, "You are connected to server ") then
        lastGamemode = message
        lastGamemode = string.sub(message, 29)
        lastGamemode = string.match(lastGamemode, "[%a-]*")
    end

    -- hide the /connection message
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

    -- fully auto
    if string.find(message, "§rYou are on the ") then
        local teamcolor = message:sub(30, 30)
        if teamcolor == "e" then
            team = "Yellow"
        elseif teamcolor == "a" then
            team = "§aLime"
        elseif teamcolor == "c" then
            team = "§cRed"
        elseif teamcolor == "9" then
            team = "§9Blue"
        elseif teamcolor == "6" then
            team = "§6Gold"
        elseif teamcolor == "d" then
            team = "§dMagenta"
        elseif teamcolor == "b" then
            team = "§bAqua"
        elseif teamcolor == "7" then
            team = "§7Gray"
        elseif teamcolor == "5" then
            team = "§5Purple"
        elseif teamcolor == "2" then
            team = "§2Green"
        elseif teamcolor == "8" then
            team = "§8Dark Gray"
        elseif teamcolor == "3" then
            team = "§3Cyan"
        else
            team = "Unknown"
        end
    end
    if FullyAuto == true and string.find(message, team .. " Team §7has been §cELIMINATED§7!") then
        if string.find(message, player.name()) and string.find(message, " did an oopsie!") and lastGamemode == "SKY" then
            oopsie = true
            client.execute("execute /q " .. lastGamemode)
            ShowGamemode = false
            return
        else
            print("Unfortulately you lost.\n§r§8Queueing into a new game.")
            client.execute("execute /q " .. lastGamemode)
            ShowGamemode = false
            return
        end
    end
    if FullyAuto == true and string.find(message, team .. " was ELIMINATED!") then
        client.execute("execute /q " .. lastGamemode)
        print("Unfortulately you lost.\n§r§8Queueing into a new game.")
        ShowGamemode = false
        return
    end
    if FullyAuto == true and string.find(message, team .. " Team are the WINNERS!") then
        client.execute("execute /q " .. lastGamemode)
        print("Congratulations on winning! <3\n§r§8Queueing into a new game.")
        ShowGamemode = false
        return
    end
    if FullyAuto == true and string.find(message, team .. " Team is the WINNER!") then
        print("Congratulations on §6winning!\n§r§8Queueing into a new game.")
        client.execute("execute /q " .. lastGamemode)
        ShowGamemode = false
        return
    end
    if FullyAuto == true and string.find(message, "§a§l» §r§eYou finished in §f") then
        print("Wow, you did something.\n§r§8Queueing into a new game.")
        client.execute("execute /q " .. lastGamemode)
        ShowGamemode = false
        return
    end
    -- murder mystery
    if FullyAuto == true and string.find(message, "§c§l» §r§cYou died! §7§oYou will be taken to the Graveyard shortly...") then
        print("Dying is so bald!\n§r§8Queueing into a new game.")
        client.execute("execute /q " .. lastGamemode)
        ShowGamemode = false
        return
    end
    if FullyAuto == true and string.find(message, "§b§l» §r§aYou survived!") then
        print("Congratulations on surviving!\n§r§8Queueing into a new game.")
        client.execute("execute /q " .. lastGamemode)
        ShowGamemode = false
        return
    end
    -- all
    if FullyAuto == true and string.find(message, "§c§l» §r§c§lGame OVER!") then
        if string.find(lastGamemode, "BRIDGE") ~= nil then
            print("Your game has ended.\n§r§8Queueing into a new game.")
            client.execute("execute /hub")
            client.execute("execute /q " .. lastGamemode)
        else
            client.execute("execute /q " .. lastGamemode)
        end
    end
    -- block drop
    if FullyAuto == true and string.find(message, "§c§l» §r§cYou died! §7Stick around or play another round.") then
        print("F.\n§r§8Queueing into a new game.")
        client.execute("execute /q " .. lastGamemode)
        ShowGamemode = false
        return
    end
end
function render2(dt)
    local text = ""
    if ShowGamemode == true and hub == false then
        text = "Playing " .. formattedGamemode
    elseif hub == true and inGame == false then
        text = "In the " .. formattedGamemode
    else
        return
    end
    if ShowGamemode == true then
        local mesh = getGfx2Mesh(text)
        gfx2.color(background)
        gfx2.fillRoundRect(gui.width() - mesh.width - 8, 24 ,mesh.width + 3, mesh.height + 3, round)
        gfx2.color(color)
        mesh:render((gui.width() - mesh.width - 8) + ((mesh.width + 3) / 2 - mesh.width/2), 24 + (mesh.height + 3) / 2 - mesh.height / 2)
    end
end


function onLocalData(identifier, content)
    if identifier == "00409ed7-72f4-4575-8028-c0abf7736a49" then
        client.execute("execute /q " .. lastGamemode)
        ShowGamemode = false
    end
end
event.listen("LocalDataReceived", onLocalData)
event.listen("ChatMessageAdded", onChat)