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

positionX = 100
positionY = 24
sizeX = 0
sizeY = 0

loadedLib = true
importLib("gfx2Colors")

team = "Unknown"
lastGamemode = ""
formattedGamemode = ""

Auto = "Fully Automatic (Recommended)"
Other = "Other Settings"

FullyAuto = true
inGame = false
oopsie = false
hub = false

client.settings.addCategory("Settings")
keybindButton = client.settings.addNamelessKeybind("Requeue Key", 0)
client.settings.addAir(5)
client.settings.addCategory("Display Settings")
ShowGamemode = client.settings.addNamelessBool("Show the gamemode on screen?", false)
client.settings.addAir(2)

outline = client.settings.addNamelessBool("Outline", true)
outlineWidth = client.settings.addNamelessFloat("Outline Width", 0.1, 5, 0.65)
outlineColor = client.settings.addNamelessColor("Outline Color", {255,255,255,255})
client.settings.addAir(2)
color = client.settings.addNamelessColor("Color", {255, 255, 255})
background = client.settings.addNamelessColor("Background Color", {0,0,0,127})
client.settings.addAir(2)
round = client.settings.addNamelessInt("Rounded Corners",  1, 10 , 2)

quality = 1

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
    HUB = "§eHub",
	PARTY = "§dBlock §9Party"
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
	if ShowGamemode.value == false then
		outline.visible = false
		outlineWidth.visible = false
		outlineColor.visible = false
		color.visible = false
		background.visible = false
		round.visible = false
	else
		outline.visible = true
		outlineWidth.visible = true
		outlineColor.visible = true
		color.visible = true
		background.visible = true
		round.visible = true
	end
    local language = client.language()
    if not language:find("en") then
        client.notification("This script only supports English.")
        client.execute("toggle off script" .. name)
	end
    if formattedGamemode == "" then
        ShowGamemode.value = false
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
            ShowGamemode.value = false
            return
        else
            print("Unfortulately you lost.\n§r§8Queueing into a new game.")
            client.execute("execute /q " .. lastGamemode)
            ShowGamemode.value = false
            return
        end
    end
    if FullyAuto == true and string.find(message, team .. " was ELIMINATED!") then
        client.execute("execute /q " .. lastGamemode)
        print("Unfortulately you lost.\n§r§8Queueing into a new game.")
        ShowGamemode.value = false
        return
    end
    if FullyAuto == true and string.find(message, team .. " Team are the WINNERS!") then
        client.execute("execute /q " .. lastGamemode)
        print("Congratulations on winning! <3\n§r§8Queueing into a new game.")
        ShowGamemode.value = false
        return
    end
    if FullyAuto == true and string.find(message, team .. " Team is the WINNER!") then
        print("Congratulations on §6winning!\n§r§8Queueing into a new game.")
        client.execute("execute /q " .. lastGamemode)
        ShowGamemode.value = false
        return
    end
    if FullyAuto == true and string.find(message, "§a§l» §r§eYou finished in §f") then
        print("Wow, you did something.\n§r§8Queueing into a new game.")
        client.execute("execute /q " .. lastGamemode)
        ShowGamemode.value = false
        return
    end
    -- murder mystery
    if FullyAuto == true and string.find(message, "§c§l» §r§cYou died! §7§oYou will be taken to the Graveyard shortly...") then
        print("Dying is so bald!\n§r§8Queueing into a new game.")
        client.execute("execute /q " .. lastGamemode)
        ShowGamemode.value = false
        return
    end
    if FullyAuto == true and string.find(message, "§b§l» §r§aYou survived!") then
        print("Congratulations on surviving!\n§r§8Queueing into a new game.")
        client.execute("execute /q " .. lastGamemode)
        ShowGamemode.value = false
        return
    end
	-- block party
	if FullyAuto == true and message:find(player.name()) and message:find("§crock 'n' rolled into the void") then
		print(player.name() .. " gave you up. " .. player.name() .. " let you down.\n§r§8Queueing into a new game.")
        client.execute("execute /q " .. lastGamemode)
        ShowGamemode.value = false
        return
	end
	if FullyAuto == true and message:find(player.name()) and message:find("§ctook the L!§8") then
		print("The 12th letter of the alphabet is yours.\n§r§8Queueing into a new game.")
		client.execute("execute /q " .. lastGamemode)
		ShowGamemode.value = false
		return
	end
	if FullyAuto == true and message:find(player.name()) and message:find("§cain't stayin' alive") then
		print("Ah, ha, ha, ha not staying alive. Not staying alive!\n§r§8Queueing into a new game.")
		client.execute("execute /q " .. lastGamemode)
		ShowGamemode.value = false
		return
	end
	if FullyAuto == true and message:find(player.name()) and message:find("§chas two left feet") then
		print("How can you dance?\n§r§8Queueing into a new game.")
		client.execute("execute /q " .. lastGamemode)
		ShowGamemode.value = false
		return
	end
	if FullyAuto == true and message:find(player.name()) and message:find("§cfell off the map") then
		print("L ratio.\n§r§8Queueing into a new game.")
		client.execute("execute /q " .. lastGamemode)
		ShowGamemode.value = false
		return
	end
    -- all
    if FullyAuto == true and string.find(message, "§c§l» §r§c§lGame OVER!") then
        if lastGamemode:find("BRIDGE") ~= nil then
			if lastGamemode:find("DUOS") then
				print("Your game has ended.\n§r§8Queueing into a new game.")
				client.execute("execute /q " .. lastGamemode)
			else
				print("Your game has ended.\n§r§8Queueing into a new game.")
				client.execute("execute /hub")
				client.execute("execute /q " .. lastGamemode)
			end
        else
            client.execute("execute /q " .. lastGamemode)
        end
    end
    -- block drop
    if FullyAuto == true and string.find(message, "§c§l» §r§cYou died! §7Stick around or play another round.") then
        print("F.\n§r§8Queueing into a new game.")
        client.execute("execute /q " .. lastGamemode)
        ShowGamemode.value = false
        return
    end
end
function render2(dt)
    local text = ""
    if ShowGamemode.value == true and hub == false then
        text = "Playing " .. formattedGamemode
    elseif hub == true and inGame == false then
        text = "In the " .. formattedGamemode
    else
        return
    end --gui.width() - mesh.width - 8
    if ShowGamemode.value == true then
		if loadedLib then
			local mesh = getGfx2Mesh(text)
			gfx2.color(background)
			gfx2.fillRoundRect(0, 0 ,mesh.width + 3, mesh.height + 3, round.value)
            if outline.value then
                gfx2.color(outlineColor)
                gfx2.drawRoundRect(0, 0 ,mesh.width + 3, mesh.height + 3, round.value, outlineWidth.value)
            end
			gfx2.color(color)
			mesh:render(1.5, 1.5)
            sizeX = mesh.width + 3
            sizeY = mesh.height + 3
		end
	end
end

event.listen("KeyboardInput", function(key, down)
	if key == keybindButton.value and down and gui.mouseGrabbed() == false then
		requeue(lastGamemode)
	end
end)

function requeue(game)
	client.execute("execute /q " .. game)
end

registerCommand("rq", function(args)
	if args == "" then
		client.execute("execute /q " .. lastGamemode)
		print("§c§l» §r§cQueuing into a new game of " .. formattedGamemodes[lastGamemode] .. "§r§c.")
	end
end)

event.listen("ChatMessageAdded", onChat)