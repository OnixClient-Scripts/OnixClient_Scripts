name = "Hive Autoqueue"
description = "Automatically Queue Hive Games. Includes .rq command.\nScript Version: v3.6"

-- Made by rosie w/ help from onix cuz he gamer (thx quoty for letting me skid some code <3)

importLib("gfx2Colors")

team = "Unknown"
lastGamemode = ""
formattedGamemode = ""

Auto = "Fully Automatic (Recommended)"
Other = "Other Settings"

inGame = false
hub = false
inCS = false

client.settings.addCategory("Settings")
keybindButton = client.settings.addNamelessKeybind("Requeue Key", 0)
requeueIfCS = client.settings.addNamelessBool("Requeue If CS", false)
client.settings.addAir(5)

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
	PARTY = "§dBlock §9Party",
    GRAV = "§uGravity"
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
    local language = client.language()
    if not language:find("en") then
        client.notification("This script only supports English.")
        client.execute("toggle off script" .. name)
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
    -- local scoreboard = server.scoreboard()
    -- local sidebar = scoreboard.getDisplayObjective("sidebar")
    -- if sidebar then
    --     local scores = sidebar.scores
    --     for i, v in pairs(scores) do
    --         if v.name:find(" §7Custom") then
    --             inCS = true
    --         else
    --             inCS = false
    --         end
    --     end
    -- end
end

function onChat(message, username, type)
    -- fully automatic requeue :D
    if string.find(message, "§b§l» §r§a§lVoting has ended!") then
        client.execute("execute /connection")
        hub = false
        inGame = true
    end
    if string.find(message, " joined. §8") then
        if string.find(message, player.name()) then
            client.execute("execute /connection")
            hub = false
            inGame = true
        end
    end
    if string.find(message, "You are connected to server name ") then
        lastGamemode = message:sub(34):match("[%a-]*")
    end

    -- hide the /connection message
    if string.find(message, "You are connected to proxy ") then
        return true
    end
    if string.find(message, "You are connected to server ") then
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

    -- fully auto
    if string.find(message, "§rYou are on the ") then
        local teamcolor = message:sub(30, 30)
        if teamcolor == "e" then
            team = "§eYellow"
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
    local function gamemodeQueues()
        if string.find(message, team .. " Team §7has been §cELIMINATED§7!") then
            if string.find(message, player.name()) and string.find(message, " did an oopsie!") and lastGamemode == "SKY" then
                requeue(lastGamemode, "You did an oopsie??", true)
                return
            else
                requeue(lastGamemode,"Unfortulately you lost.", true)
                return
            end
        end
        if string.find(message, team .. " was ELIMINATED!") then
            requeue(lastGamemode, "Unfortulately you lost.", true)
            return
        end
        if string.find(message, team .. " Team are the WINNERS!") then
            requeue(lastGamemode, "Congratulations on winning! <3", true)
            return
        end
        if string.find(message, team .. " Team is the WINNER!") then
            requeue(lastGamemode, "Congratulations on winning! <3", true)
            return
        end
        if string.find(message, "§a§l» §r§eYou finished in §f") then
            requeue(lastGamemode, "Wow, you did something.", true)
            return
        end
        -- murder mystery
        if string.find(message, "§c§l» §r§cYou died! §7§oYou will be taken to the Graveyard shortly...") then
            requeue(lastGamemode, "Dying is so bald!", true)
            return
        end
        if string.find(message, "§b§l» §r§aYou survived!") then
            requeue(lastGamemode, "Congratulations on surviving!", true)
            return
        end

        -- block party
        if message:find("§crock 'n' rolled into the void") then
            if message:find(player.name()) then
                requeue(lastGamemode, player.name() .. " gave you up. " .. player.name() .. " let you down.", true)
                return
            end
        end

        if message:find("§ctook the L!§8") then
            if message:find(player.name()) then
                requeue(lastGamemode, "The 12th letter of the alphabet is yours.", true)
                return
            end
        end

        if message:find("§cain't stayin' alive") then
            if message:find(player.name()) then
                requeue(lastGamemode, "Ah, ha, ha, ha not staying alive. Not staying alive!", true)
                return
            end
        end

        if message:find("§chas two left feet") then
            if message:find(player.name()) then
                requeue(lastGamemode, "How can you dance?", true)
                return
            end
        end

        if message:find("§cfell off the map") then
            if message:find(player.name()) then
                requeue(lastGamemode, "L ratio.", true)
                return
            end
        end
        -- gravity
        if message:find("§a§l» §r§eYou finished all maps and came in") then
            requeue(lastGamemode, "Congratulations on finishing all maps!", true)
            return
        end
        -- all
        if string.find(message, "§c§l» §r§c§lGame OVER!") then
            if lastGamemode:find("BRIDGE") ~= nil then
                if lastGamemode:find("DUOS") then
                    print("Your game has ended.\n§r§8Queueing into a new game.")
                    requeue(lastGamemode, "Your game has ended.", true)
                else
                    client.execute("execute /hub")
                    requeue(lastGamemode, "Your game has ended.", true)
                end
            else
                requeue(lastGamemode)
            end
        end
        -- block drop
        if string.find(message, "§c§l» §r§cYou died! §7Stick around or play another round.") then
            requeue(lastGamemode, "F.", true)
            return
        end
    end
    if inCS then
        if requeueIfCS.value then
            gamemodeQueues()
        end
    else
        gamemodeQueues()
    end
end

event.listen("KeyboardInput", function(key, down)
	if key == keybindButton.value and down and gui.mouseGrabbed() == false then
		requeue(lastGamemode)
	end
end)

function requeue(game, message, sendRequeue)
    if server.ip():find("zeqa") then return end
    if message ~= nil then
        print(message)
    end
    if sendRequeue == nil then
        sendRequeue = false
    end
    if sendRequeue == true then
        print("§r§8Queueing into a new game.")
    end
	client.execute("execute /q " .. game)
end

registerCommand("rq", function(args)
	if args == "" then
		client.execute("execute /q " .. lastGamemode)
		print("§c§l» §r§cQueuing into a new game of " .. formattedGamemodes[lastGamemode] .. "§r§c.")
	end
end)

event.listen("ChatMessageAdded", onChat)