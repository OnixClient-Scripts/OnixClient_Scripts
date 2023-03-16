name="Hive Autododge"
description="Automatically requeue to dodge sweats."

autododgeMainColor = client.settings.addNamelessTextbox("AutoDodge Main Colour", "c")
client.settings.addTitle("Please refer below for a list of colours.").scale = 1.2
client.settings.addInfo("0 Black, 1 Dark Blue, 2 Dark Green, 3 Dark Aqua, 4 Dark Red, 5 Dark Purple, 6 Gold, 7 Gray, 8 Dark Gray, 9 Blue, a Green, b Aqua, c Red, d Light Purple, e Yellow, f White").scale = 0.8
-- Settings
-- Max level to dodge
client.settings.addAir(3)
client.settings.addTitle("Level")
maxLevelBool = client.settings.addNamelessBool("Dodge by Level",true)
maxLevel = client.settings.addNamelessInt("Max Level",0,100,75)
client.settings.addAir(3)

-- Max prestige to dodge
client.settings.addTitle("Prestige")
maxPrestigeBool = client.settings.addNamelessBool("Dodge by Prestige",true)
maxPrestige = client.settings.addNamelessInt("Max Prestige",0,5,3)
client.settings.addAir(3)

-- Max KDR to dodge
client.settings.addTitle("KDR")
maxKDRBool = client.settings.addNamelessBool("Dodge by KDR",true)
maxKDR = client.settings.addNamelessInt("Max KDR",0,100,50)
client.settings.addAir(3)

-- Max winrate to dodge
client.settings.addTitle("Winrate")
maxWinrateBool = client.settings.addNamelessBool("Dodge by Winrate",true)
maxWinrate = client.settings.addNamelessInt("Max Winrate",0,100,50)
client.settings.addAir(3)

lastGamemode = "nil"
lastPlayer = "nil"
checkLobbyStats = false
checkedLobby = false
cancelQueue = false

function tablelen(tbl)
    local a = 0
    for k, v in pairs(tbl) do
        a = a + 1
    end
    return a
end

event.listen("TitleChanged", function(text, titleType)
	if titleType == "actionbar" then
		if text:find("§aStarting game in §c§l") then
			checkDodgeList()
			cancelQueue = false
			checkedLobby = false
			checkLobbyStats = true
		end
	end
end)

function onChat(message)
	if message:find("§b§l» §r§a§lVoting has ended!") then
		client.execute("execute /connection")
	end
	if message:find(player.name()) and message:find(" joined. §8") then
		client.execute("execute /connection")
	end
	if message:find(" joined. §8") then
		checkDodgeList()
	end
    if message:find("You are connected to server ") then
        lastGamemode = message:sub(29)
        lastGamemode = lastGamemode:match("[%a-]*")
		gamemode = lastGamemode:match("[%a]*"):lower()
    end

    -- hide the /connection message
    if message:find("You are connected to proxy ") then
        return true
    end
    if message:find("You are connected to server ") then
        return true
    end
    if message:find("§cYou're issuing commands too quickly, try again later.") then
        return true
    end
    if message:find("§cUnknown command. Sorry!") then
        return true
    end
end
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
	if #autododgeMainColor.value > 1 then
		autododgeMainColor.value = autododgeMainColor.value:sub(1, 1)
	end
	if checkLobbyStats == true and checkedLobby == false then
		local serverPlayers = server.players()
		local gamemode = lastGamemode:match("[%a]*"):lower()
		for i, currentSearchingPlayer in pairs(serverPlayers) do
			lastPlayer = currentSearchingPlayer
			usernameSearch = currentSearchingPlayer:gsub(" ", "%%20")
			if cancelQueue == false then
				if currentSearchingPlayer:find(player.name()) then
				else
					if gamemode ~= "party" then
						network.get("https://api.playhive.com/v0/game/all/" .. gamemode .. "/" .. usernameSearch,  "lobbyStats")
						checkedLobby = true
					end
				end
			else
				cancelQueue = false
				checkedLobby = false
			end
		end
	end
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
function onNetworkData(code,id, data)
	if cancelQueue == false then
		if code == 0 then
			result = jsonToTable(data)
			if type(result) ~= "table" then
 				return
			end
			if tablelen(result) == 0 then
				print("No results found.")
				return
			else
				if result["prestige"] ~= nil and maxPrestigeBool.value == true then
					prestige = result["prestige"]
					if prestige > maxPrestige.value then
						print("§4[§" .. autododgeMainColor.value .. "§lAutoDodge§r§4] §r§a" .. lastPlayer .. "§a has a prestige higher than §e" .. maxPrestige.value .. "§a!" .. "§a (" .. math.floor(prestige) .. ")")
						cancelQueue = true
						requeue(lastGamemode)
					end
				elseif maxLevelBool.value == true then
					level = calculateLevel(gamemode, result["xp"])
					if level > maxLevel.value then
						print("§4[§" .. autododgeMainColor.value .. "§lAutoDodge§r§4] §r§a" .. lastPlayer .. "§a has a level higher than §e" .. maxLevel.value .. "§a!" .. "§a (" .. math.floor(level) .. ")")
						cancelQueue = true
						requeue(lastGamemode)
					end
				elseif math.floor((result["victories"] / result["played"]) * 1000)/10 > maxWinrate.value and maxWinrateBool.value == true then -- If the player has a winrate
					print("§4[§" .. autododgeMainColor.value .. "§lAutoDodge§r§4] §r§a" .. lastPlayer .. "§a has a winrate higher than §e" .. maxWinrate.value .. "%§a!" .. "§a (" .. math.floor(math.floor((result["victories"] / result["played"]) * 1000)/10) .. "%)")
					cancelQueue = true
					requeue(lastGamemode)
				elseif result["deaths"] ~= nil and result["kills"] ~= nil then
					if math.floor((result["kills"] / result["deaths"]) * 1000) / 10 > maxKDR.value and maxKDRBool.value == true then
						print("§4[§" .. autododgeMainColor.value .. "§lAutoDodge§r§4] §r§a" .. lastPlayer .. "§a has a KDR higher than §e" .. maxKDR.value .. "%§a!" .. "§a (" .. math.floor(math.floor((result["kills"] / result["deaths"]) * 1000) / 10) .. "%)")
						cancelQueue = true
						requeue(lastGamemode)
					end
				end
			end
		end
	end
end
event.listen("ChatMessageAdded", onChat)

function requeue(game)
	print("§4[§" .. autododgeMainColor.value .. "§lAutoDodge§r§4] §r§a§r§" .. autododgeMainColor.value .. "Queuing into a new game of " .. formattedGamemodes[lastGamemode] .. "§r§" .. autododgeMainColor.value .. ".")
	client.execute("execute /q " .. game)
end

function string.startsWith(string, start)
	return string.sub(string, 1, string.len(start)) == start
end
function table.contains(table, element)
	for _, value in pairs(table) do
		if value == element then
			return true
		end
	end
	return false
end

dodgeList = {}
whitelist = {}

registerCommand("dodge", function(args)
	if args == (nil or "") then
		print("§4[§" .. autododgeMainColor.value .. "§lAutoDodge§r§4] §r§a§r§" .. autododgeMainColor.value .. "Please specify an argument.")
		return
	elseif args == "clear" then
		dodgeList = {}
		print("§4[§" .. autododgeMainColor.value .. "§lAutoDodge§r§4] §r§a§r§" .. autododgeMainColor.value .. "Cleared the dodge list.")
		return
	elseif args == "list" then
		print("§4[§" .. autododgeMainColor.value .. "§lAutoDodge§r§4] §r§a§r§" .. autododgeMainColor.value .. "Dodge list:")
		for i, v in pairs(dodgeList) do
			print("§4[§" .. autododgeMainColor.value .. "§lAutoDodge§r§4] §r§a§r§" .. autododgeMainColor.value .. "[§9" .. i .. "§" .. autododgeMainColor.value .. "] §e" .. v)
		end
		return
	elseif args == "help" then
		print("§4[§" .. autododgeMainColor.value .. "§lAutoDodge§r§4] §r§a§r§a§" .. autododgeMainColor.value .. "AutoDodge Help")
		print("§4[§" .. autododgeMainColor.value .. "§lAutoDodge§r§4] §r§a§r§a.dodge <player>§" .. autododgeMainColor.value .. " - Adds a player to the dodge list.")
		print("§4[§" .. autododgeMainColor.value .. "§lAutoDodge§r§4] §r§a§r§a.dodge list§" .. autododgeMainColor.value .. " - Lists all the player in the dodge list.")
		print("§4[§" .. autododgeMainColor.value .. "§lAutoDodge§r§4] §r§a§r§a.dodge clear§" .. autododgeMainColor.value .. " - Clears the dodge list.")
		return
	--need to remove from list
	elseif args == "remove" then
		print("§4[§" .. autododgeMainColor.value .. "§lAutoDodge§r§4] §r§a§r§" .. autododgeMainColor.value .. "Please specify a player to remove.")
		return
	elseif args:startsWith("remove ") then
		args = args:gsub("remove ", "")
		for i, v in pairs(dodgeList) do
			if v == args then
				table.remove(dodgeList, i)
				print("§4[§" .. autododgeMainColor.value .. "§lAutoDodge§r§4] §r§a§r§" .. autododgeMainColor.value .. "Removed §a" .. args .. "§r§" .. autododgeMainColor.value .. " from the dodge list.")
				saveConfig()
				return
			end
		end
		print("§4[§" .. autododgeMainColor.value .. "§lAutoDodge§r§4] §r§a§r§" .. autododgeMainColor.value .. "Player §a" .. args .. " not found in the dodge list.")
		return
	elseif args:startsWith("whitelist ") then
		local args = args:gsub("whitelist ","")
		print(args)
		if args == "clear" then
			whitelist = {}
			print("§4[§" .. autododgeMainColor.value .. "§lAutoDodge§r§4] §r§a§r§" .. autododgeMainColor.value .. "Cleared the whitelist.")
			saveConfig()
			return
		elseif args == "list" then
			print("§4[§" .. autododgeMainColor.value .. "§lAutoDodge§r§4] §r§a§r§" .. autododgeMainColor.value .. "Whitelist:")
			for i, v in pairs(whitelist) do
				print("§4[§" .. autododgeMainColor.value .. "§lAutoDodge§r§4] §r§a§r§" .. autododgeMainColor.value .. "" .. v)
			end
			return
		elseif args:startsWith("remove ") then
			args = args:gsub("remove ", "")
			for i, v in pairs(whitelist) do
				if v == args then
					table.remove(whitelist, i)
					print("§4[§" .. autododgeMainColor.value .. "§lAutoDodge§r§4] §r§a§r§" .. autododgeMainColor.value .. "Removed §a" .. args .. "§r§" .. autododgeMainColor.value .. " from the whitelist.")
					saveConfig()
					break
				end
			end
			print("§4[§" .. autododgeMainColor.value .. "§lAutoDodge§r§4] §r§a§r§" .. autododgeMainColor.value .. "Player §a" .. args .. " not found in the whitelist.")
			return
		elseif args~= (nil or "") then
			if args:find(player.name()) then
				print("§4[§" .. autododgeMainColor.value .. "§lAutoDodge§r§4] §r§a§r§" .. autododgeMainColor.value .. "You can't whitelist yourself!")
				return
			end
			if table.contains(whitelist, args) then
				print("§4[§" .. autododgeMainColor.value .. "§lAutoDodge§r§4] §r§a§r§" .. autododgeMainColor.value .. "Player already in the whitelist.")
				return
			else
				table.insert(whitelist, args)
				print("§4[§" .. autododgeMainColor.value .. "§lAutoDodge§r§4] §r§a§r§" .. autododgeMainColor.value .. "Added §a" .. args .. "§r§" .. autododgeMainColor.value .. " to the whitelist.")
				saveConfig()
				return
			end
		end
	elseif args ~= (nil or "") then
		if args:find(player.name()) then
			print("§4[§" .. autododgeMainColor.value .. "§lAutoDodge§r§4] §r§a§r§" .. autododgeMainColor.value .. "You can't dodge yourself!")
			return
		end
		if table.contains(dodgeList, args) then
			print("§4[§" .. autododgeMainColor.value .. "§lAutoDodge§r§4] §r§a§r§" .. autododgeMainColor.value .. "Player already in the dodge list.")
			return
		else
			table.insert(dodgeList, args)
			print("§4[§" .. autododgeMainColor.value .. "§lAutoDodge§r§4] §r§a§r§" .. autododgeMainColor.value .. "Added §a" .. args .. "§r§" .. autododgeMainColor.value .. " to the dodge list.")
			saveConfig()
			return
		end
	end
end)

function checkDodgeList()
	local playersConnected = server.players()
	for i, playersC in pairs(playersConnected) do
		for _, dodgeListPlayers in pairs(dodgeList) do
			if playersC:lower() == dodgeListPlayers:lower() then
				print("§4[§" .. autododgeMainColor.value .. "§lAutoDodge§r§4] §r§a§r§" .. autododgeMainColor.value .. "" .. playersC .. "§r§" .. autododgeMainColor.value .. " is in the dodge list. Requeuing...")
				requeue(lastGamemode)
			end
		end
	end
end

function checkWhitelist()
	local playersConnected = server.players()
	for i, playersC in pairs(playersConnected) do
		for _, whitelistPlayers in pairs(whitelist) do
			if playersC:lower() == whitelistPlayers:lower() then
				return true
			end
		end
	end
	return false
end

event.listen("ConfigurationSaved", function()
	local data = {}
	data.dodgeList = dodgeList
	return data
end)

event.listen("ConfigurationLoaded", function(data)
	dodgeList = data.dodgeList or {}
end)

function saveConfig()
	local config = client.getConfigManager(true)
	config:save(config:getActive())
end