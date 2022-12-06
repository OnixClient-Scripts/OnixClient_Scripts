name = "Hive Statistic Checker"
description = "Allows you to check the statistics of people in-game."

--[[
    by rosie
    thnx onix for being epic and making the brain of the script lol
]]

importLib("hiveGamemodes")
importLib("DependentBoolean")

statMode = ""
fullStats = false

client.settings.addAir(2.5)
checkStatsOnJoin = client.settings.addNamelessBool("Display Stats On User Joined", true)

client.settings.addAir(5)
client.settings.addBool("Stat Display Type","fullStats")
function update()
    if fullStats == true then
        statMode = "Displaying Full Stats"
    else
        statMode = "Displaying Compact Stats"
    end
end
function epochToDate(epoch)
    local date = os.date("*t", epoch)
    return date.day .. "/" .. date.month .. "/" .. date.year
end
client.settings.addDependentInfo("statMode","fullStats")

ign = ""
local lastResult = {}
local result = {}
formattedGamemode = getListGamemodes()

local ip = server.ip()

function tablelen(tbl)
    local a = 0
    for k, v in pairs(tbl) do
        a = a + 1
    end
    return a
end

local GAME_XP = {
    wars={150,52},
    dr={200},
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

function getLevelColor(level)
    if level <= 9 then
        return "§7"
    elseif level <= 19 then
        return "§6"
    elseif level <= 24 then
        return "§e"
    elseif level <= 29 then
        return "§b"
    elseif level <= 49 then
        return "§d"
    elseif level <= 79 then
        return "§a"
    elseif level <= 99 then
        return "§c"
    elseif level <= 100 then
        return "§9"
    end
    return "Massive fat error contact xJqms"
end
function getPrestigeColor(prestige)
    if prestige == 1 then
        return "§7"
    elseif prestige == 2 then
        return "§6"
    elseif prestige == 3 then
        return "§e"
    elseif prestige == 4 then
        return "§b"
    elseif prestige == 5 then
        return "§d"
    end
    return "Massive fat error contact xJqms"
end
-- prestige 1 = 
-- prestige 2 = 
-- prestige 3 = 
-- prestige 4 = 
-- prestige 5 = 
function getPrestigeType(prestige)
	if prestige == 1 then
		return ""
	elseif prestige == 2 then
		return ""
	elseif prestige == 3 then
		return ""
	elseif prestige == 4 then
		return ""
	elseif prestige == 5 then
		return ""
	end
	return ""
end
function printLevel(level)
    if level <= 9 then
        print("§7Level: §e" .. level)
    elseif level <= 19 then
        print("§6Level: §e" .. level)
    elseif level <= 24 then
        print("§eLevel: §e" .. level)
    elseif level <= 29 then
        print("§bLevel: §e" .. level)
    elseif level <= 49 then
        print("§dLevel: §e" .. level)
    elseif level <= 79 then
        print("§aLevel: §e" .. level)
    elseif level <= 99 then
        print("§cLevel: §e" .. level)
    elseif level <= 100 then
        print("§9Level: §e" .. level)
    end
end

autoPlayerSearch = false
function onNetworkData(code, netGamemode, data)
    if code == 0 then
        result = jsonToTable(data)
        if type(result) ~= "table" then
            print("Error...")
            return
        end
        if tablelen(result) == 0 then
            print("No results found.")
            return
        elseif fullStats == true and autoPlayerSearch == false then
            print("§b§l------------------------------------§r\n§eHive Statistics Checker\n§cUser: §r" .. username .. "\n§aGamemode: §r" .. formattedGamemode[string.upper(gamemode)] .. "\n§b§l------------------------------------§r")
            if netGamemode == "wars" then
                local level = math.floor(10*(calculateLevel(netGamemode, result["xp"])))/10
                printLevel(level)
                print("§2Experience: §e" .. result["xp"])
                print("§8Games Played: §e" .. result["played"])
                print("§6Victories: §e" .. result["victories"])
                print("§8Losses: §e" .. result["played"] - result["victories"])
                print("§1Winrate: §e" .. math.floor((result["victories"] / result["played"]) * 1000)/10 .. "%")
                print("§4Lossrate: §e" .. 100-math.floor((result["victories"] / result["played"]) * 1000)/10 .. "%")
                print("§3Final Kills: §e" .. result["final_kills"])
                print("§5Kills: §e" .. result["kills"])
                print("§4Deaths: §e" .. result["deaths"])
                print("§6Treasures Destroyed: §e" .. result["treasure_destroyed"])
                print("§eK§cD§eR: §e" .. math.floor((result["kills"] / result["deaths"])*100)/100)
                print("§3Prestige: §e" .. result["prestige"])
                print("§bFirst Played: §e" .. epochToDate(result["first_played"]))
            elseif netGamemode == "sky" then
                local level = math.floor(10*(calculateLevel(netGamemode, result["xp"])))/10
                printLevel(level)
                print("§2Experience: §e" .. result["xp"])
                print("§8Games Played: §e" .. result["played"])
                print("§6Victories: §e" .. result["victories"])
                print("§8Losses: §e" .. result["played"] - result["victories"])
                print("§1Winrate: §e" .. math.floor((result["victories"] / result["played"]) * 1000)/10 .. "%")
                print("§4Lossrate: §e" .. 100-math.floor((result["victories"] / result["played"]) * 1000)/10 .. "%")
                print("§5Kills: §e" .. result["kills"])
                print("§dMystery Chests Destroyed: §e" .. result["mystery_chests_destroyed"])
                print("§9Ores Mined: §e" .. result["ores_mined"])
                print("§dSpells Used: §e" .. result["spells_used"])
                print("§bFirst Played: §e" .. epochToDate(result["first_played"]))
            elseif netGamemode == "ctf" then
                local level = math.floor(10*(calculateLevel(netGamemode, result["xp"])))/10
                printLevel(level)
                print("§2Experience: §e" .. result["xp"])
                print("§8Games Played: §e" .. result["played"])
                print("§6Victories: §e" .. result["victories"])
                print("§8Losses: §e" .. result["played"] - result["victories"])
                print("§1Winrate: §e" .. math.floor((result["victories"] / result["played"]) * 1000)/10 .. "%")
                print("§4Lossrate: §e" .. 100-math.floor((result["victories"] / result["played"]) * 1000)/10 .. "%")
                print("§5Kills: §e" .. result["kills"])
                print("§4Deaths: §e" .. result["deaths"])
                print("§eK§cD§eR: §e" .. math.floor((result["kills"] / result["deaths"])*100)/100)
                print("§bFlags Captured: §e" .. result["flags_captured"])
                print("§cFlags Returned: §e" .. result["flags_returned"])
                print("§2Assists: §e" .. result["assists"])
                print("§bFirst Played: §e" .. epochToDate(result["first_played"]))
            elseif netGamemode == "sg" then
                local level = math.floor(10*(calculateLevel(netGamemode, result["xp"])))/10
                printLevel(level)
                print("§2Experience: §e" .. result["xp"])
                print("§8Games Played: §e" .. result["played"])
                print("§6Victories: §e" .. result["victories"])
                print("§8Losses: §e" .. result["played"] - result["victories"])
                print("§1Winrate: §e" .. math.floor((result["victories"] / result["played"]) * 1000)/10 .. "%")
                print("§4Lossrate: §e" .. 100-math.floor((result["victories"] / result["played"]) * 1000)/10 .. "%")
                print("§5Kills: §e" .. result["kills"])
                print("§7Crates: §e" .. result["crates"])
                print("§8Deathmatches: §e" .. result["deathmatches"])
                print("§cCows: §e" .. result["cows"])
                print("§bFirst Played: §e" .. epochToDate(result["first_played"]))
            elseif netGamemode == "dr" then
                local level = math.floor(10*(calculateLevel(netGamemode, result["xp"])))/10
                printLevel(level)
                print("§2Experience: §e" .. result["xp"])
                print("§8Games Played: §e" .. result["played"])
                print("§6Victories: §e" .. result["victories"])
                print("§8Losses: §e" .. result["played"] - result["victories"])
                print("§1Winrate: §e" .. math.floor((result["victories"] / result["played"]) * 1000)/10 .. "%")
                print("§4Lossrate: §e" .. 100-math.floor((result["victories"] / result["played"]) * 1000)/10 .. "%")
                print("§5Kills: §e" .. result["kills"])
                print("§4Deaths: §e" .. result["deaths"])
                print("§0C§rh§0e§rc§0k§rp§0o§ri§0n§rt§0s§r: §e" .. result["checkpoints"])
                print("§bT§dr§ra§dp§bs §aActivated: §e" .. result["activated"])
                print("§bFirst Played: §e" .. epochToDate(result["first_played"]))
            elseif netGamemode == "hide" then
                local level = math.floor(10*(calculateLevel(netGamemode, result["xp"])))/10
                printLevel(level)
                print("§2Experience: §e" .. result["xp"])
                print("§8Games Played: §e" .. result["played"])
                print("§6Victories: §e" .. result["victories"])
                print("§8Losses: §e" .. result["played"] - result["victories"])
                print("§1Winrate: §e" .. math.floor((result["victories"] / result["played"]) * 1000)/10 .. "%")
                print("§4Lossrate: §e" .. 100-math.floor((result["victories"] / result["played"]) * 1000)/10 .. "%")
                print("§4Deaths: §e" .. result["deaths"])
                print("§1Hider Kills: §e" .. result["hider_kills"])
                print("§4Seeker Kills: §e" .. result["seeker_kills"])
                print("§bFirst Played: §e" .. epochToDate(result["first_played"]))
            elseif netGamemode == "murder" then
                local level = math.floor(10*(calculateLevel(netGamemode, result["xp"])))/10
                printLevel(level)
                print("§2Experience: §e" .. result["xp"])
                print("§8Games Played: §e" .. result["played"])
                print("§6Victories: §e" .. result["victories"])
                print("§8Losses: §e" .. result["played"] - result["victories"])
                print("§1Winrate: §e" .. math.floor((result["victories"] / result["played"]) * 1000)/10 .. "%")
                print("§4Lossrate: §e" .. 100-math.floor((result["victories"] / result["played"]) * 1000)/10 .. "%")
                print("§4Deaths: §e" .. result["deaths"])
                print("§6Coins: §e" .. result["coins"])
                print("§6Avg Coins/game: §e: " .. math.floor(10*(result["coins"]/result["played"]))/10)
                print("§bFirst Played: §e" .. epochToDate(result["first_played"]))
            elseif netGamemode == "drop" then
                local level = math.floor(10*(calculateLevel(netGamemode, result["xp"])))/10
                printLevel(level)
                print("§2Experience: §e" .. result["xp"])
                print("§8Games Played: §e" .. result["played"])
                print("§6Victories: §e" .. result["victories"])
                print("§8Losses: §e" .. result["played"] - result["victories"])
                print("§1Winrate: §e" .. math.floor((result["victories"] / result["played"]) * 1000)/10 .. "%")
                print("§4Lossrate: §e" .. 100-math.floor((result["victories"] / result["played"]) * 1000)/10 .. "%")
                print("§4Deaths: §e" .. result["deaths"])
                print("§Blocks Destroyed: §e" .. result["blocks_destroyed"])
                print("§bPowerups Collected: §e" .. result["powerups_collected"])
                print("§aVaults Used: §e" .. result["vaults_used"])
                print("§bFirst Played: §e" .. epochToDate(result["first_played"]))
            elseif netGamemode == "ground" then
                local level = math.floor(10*(calculateLevel(netGamemode, result["xp"])))/10
                printLevel(level)
                print("§2Experience: §e" .. result["xp"])
                print("§8Games Played: §e" .. result["played"])
                print("§6Victories: §e" .. result["victories"])
                print("§8Losses: §e" .. result["played"] - result["victories"])
                print("§1Winrate: §e" .. math.floor((result["victories"] / result["played"]) * 1000)/10 .. "%")
                print("§4Lossrate: §e" .. 100-math.floor((result["victories"] / result["played"]) * 1000)/10 .. "%")
                print("§4Deaths: §e" .. result["deaths"])
                print("§3Blocks Destroyed: §e" .. result["blocks_destroyed"])
                print("§dProjectiles Fired: §e" .. result["projectiles_fired"])
                print("§bFirst Played: §e" .. epochToDate(result["first_played"]))
            elseif netGamemode == "build" then
                local level = math.floor(10*(calculateLevel(netGamemode, result["xp"])))/10
                printLevel(level)
                print("§2Experience: §e" .. result["xp"])
                print("§8Games Played: §e" .. result["played"])
                print("§6Victories: §e" .. result["victories"])
                print("§8Losses: §e" .. result["played"] - result["victories"])
                print("§1Winrate: §e" .. math.floor((result["victories"] / result["played"]) * 1000)/10 .. "%")
                print("§4Lossrate: §e" .. 100-math.floor((result["victories"] / result["played"]) * 1000)/10 .. "%")
                print("§2Loved Builds: §e" .. result["rating_love_received"])
                print("§aGood Builds: §e" .. result["rating_good_received"])
                print("§eOkay Builds: §e" .. result["rating_okay_received"])
                print("§cMeh Builds: §e" .. result["rating_meh_received"])
                print("§bFirst Played: §e" .. epochToDate(result["first_played"]))
            end
        elseif fullStats == false and autoPlayerSearch == false then
            if result["prestige"] ~= nil then
                prestige =	getPrestigeType(result["prestige"]) .. " "
            else
                prestige = ""
            end
			if netGamemode ~= "overallStats" then
				if monthlyBool == false then
					local level = math.floor(10*(calculateLevel(netGamemode, result["xp"])))/10
					print("§8" .. username .. "§f, Lvl: " .. prestige .. getLevelColor(level) .. level ..  "§f, W: §e" .. result["victories"] .. "§f, W/L: §7".. math.floor((result["victories"] / result["played"]) * 1000)/10 .. "%§f, " .. "GM: §a" .. formattedGamemode[string.upper(gamemode)] .. "§f, FP: §e" .. epochToDate(result["first_played"]))
				else
					goto monthlyThings
				end
			else
				overallLevel = math.floor(10*(calculateLevel(gamemode1, result["xp"])))/10
				overallPrestige = getPrestigeType(result["prestige"]) .. " "
			end
			::monthlyThings::
			if monthlyBool == true and netGamemode ~= "overallStats" then
				print("§3(Monthly) " .. "§8" .. username .. "§f, Lvl: " .. overallPrestige .. getLevelColor(overallLevel) .. overallLevel ..  "§f, W: §e" .. result["victories"] .. "§f, W/L: §7".. math.floor((result["victories"] / result["played"]) * 1000)/10 .. "%§f, GM: §a" .. formattedGamemode[string.upper(gamemode)])
			end

        -- elseif autoPlayerSearch == true then
--             print("§a§l» §r§7" .. searchingUser .. " joined" .. "§f, Lvl: " .. "§f, W: §e" .. result["victories"] .. "§f, W/L: §7".. math.floor((result["victories"] / result["played"]) * 1000)/10 .. "%§f")
        else
            if tablelen(result) == 0 then
                print("No results found.")
            else
                for k,v in pairs (result) do
                    print(k .. ": " .. v)
                end
            end
        end
        if fullStats == true then print("§b§l------------------------------------§r") end
    end
end
usernameSearch = " "
registerCommand("stats", function (arguments)
    if arguments == "" then
        print("§b§l------------------------------------§r\n§eUsage:\n§cUsername§r, §aGamemode \n§r§b§l------------------------------------§r")
    elseif string.find(arguments, ", ") then
        gamemode = string.sub(arguments, string.find(arguments, ", ") + 2)
        username = tostring(string.sub(arguments, 1, string.find(arguments, ", ") - 1))
		-- i need to add a monthly parameter check here and set monthlyBool to true if it is
		if string.find(gamemode, "monthly") then
			monthlyBool = true
			gamemode = string.sub(gamemode, 1, string.find(gamemode, "monthly") - 2)
		else
			monthlyBool = false
		end
        if string.find(gamemode, "-") then
            gamemode = string.sub(gamemode, 1, string.find(gamemode, "-") - 1)
        end
        usernameSearch = string.gsub(username, " ", "%%20")
        if formattedGamemode[string.upper(username)] then
            --dude switched gamemode and username L
            local temp = username
            username = gamemode
            gamemode = temp
        elseif not formattedGamemode[string.upper(gamemode)] then
            print("§b§l------------------------------------§r\n§eUnknown gamemode:§r\n\"" .. gamemode .. "\"\n§r§b§l------------------------------------§r")
            return
        end
        if fullStats == true then print("§b§l------------------------------------§r\n§eGetting §a".. formattedGamemode[string.upper(gamemode)] .. "§r§e statistics for§r§c " .. username .. "§r\n§r§b§l------------------------------------§r") end
        if monthlyBool == false then
			monthlySearch = false
			network.get("https://api.playhive.com/v0/game/all/" .. gamemode .. "/" .. usernameSearch,  gamemode)
		else
			network.get("https://api.playhive.com/v0/game/all/" .. gamemode .. "/" .. usernameSearch,  "overallStats")
			gamemode1 = gamemode
			network.get("https://api.playhive.com/v0/game/monthly/player/" .. gamemode .. "/" .. usernameSearch,  gamemode)
		end
    end
end)

function postInit()
    client.execute("lua autoreload")
    client.execute("toggle on script " .. name)
end
-- function onChat(message,username,type)
--     if checkStatsOnJoin.value == true then
--         if string.find(message,"joined. §8") then
--             if string.find(message, player.name()) then
--                 client.execute("execute /connection")
--                 return
--             else
--                 globalMessage = message
--                 autoPlayerSearch = true
--                 checkUsername = string.gsub(message, " joined. §8%[.....","");checkUsername = string.gsub(checkUsername, "]","")
--                 checkUsername = string.gsub(checkUsername, "§a§l.. §r§7","")
--                 searchingUser = string.gsub(checkUsername, " ", "%%20")
--                 network.get("https://api.playhive.com/v0/game/all/" .. lastGamemode .. "/" .. searchingUser, "gamemode")
--                 local file = io.open("Temp.txt", "a")
--                 io.output(file)
--                 io.write("https://api.playhive.com/v0/game/all/" .. lastGamemode .. "/" .. searchingUser .. "\n" .. message .. "\n" .. searchingUser .. "\n")
--                 io.close(file)
--                 return true
--             end
--         end
--     end
--     if string.find(message, "You are connected to proxy ") then
--         return true
--     end
--     if string.find(message, "You are connected to server ") then
--         lastGamemode = message
--         lastGamemode = string.sub(message, 29)
--         lastGamemode = string.match(lastGamemode, "[%a-]*")
--         if string.find(lastGamemode, "-") then
--             lastGamemode = string.sub(lastGamemode, 1, string.find(lastGamemode, "-") - 1)
--         end
--         lastGamemode = string.lower(lastGamemode)
--         return true
--     end
--     if string.find(message, "§cYou're issuing commands too quickly, try again later.") then
--         return true
--     end
--     if string.find(message, "§cUnknown command. Sorry!") then
--         return true
--     end
--     if string.find(message, "§b§l» §r§a§lVoting has ended!") then
--         autoPlayerSearch = false
--     end
-- end
-- event.listen("ChatMessageAdded", onChat)