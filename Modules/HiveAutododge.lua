name = "Hive Autododge"
description = "Automatically requeues your game based on specified parameters."

importLib("HiveHelper")

lastGamemode = ""
---@type Setting[]
playerList = {}

client.settings.addCategory("Level")
levelBool = client.settings.addNamelessBool("Dodge Level", false)
levelDodge = client.settings.addNamelessInt("Level Dodge", 1, 100, 75)
client.settings.addAir(5)

client.settings.addCategory("Prestige")
prestigeBool = client.settings.addNamelessBool("Dodge Prestige", false)
prestigeDodge = client.settings.addNamelessInt("Prestige Dodge", 0, 5, 3)
client.settings.addAir(5)

client.settings.addCategory("Player")

function reloadSettings()
    local texts = {}
    for _, text in pairs(playerList) do
        table.insert(texts, {text=text.text.value})
        text.title.parent.removeSetting(text.title)
        text.text.parent.removeSetting(text.text)
        text.erase.parent.removeSetting(text.erase)
        text.padding.parent.removeSetting(text.padding)
    end
    playerList = {}
    for _, text in pairs(texts) do
        AddPlayer(text.text, text.key)
    end
end

function AddPlayer(text)
    if text == nil then text = "" end
    local index = #playerList + 1
    _G["PlayerFunctionRemoval" .. index] = function()
        local settingToGetRidof = playerList[index]
        table.remove(playerList, index)
        settingToGetRidof.title.parent.removeSetting(settingToGetRidof.title)
        settingToGetRidof.text.parent.removeSetting(settingToGetRidof.text)
        settingToGetRidof.erase.parent.removeSetting(settingToGetRidof.erase)
        settingToGetRidof.padding.parent.removeSetting(settingToGetRidof.padding)
        reloadSettings()
    end

    table.insert(playerList,{
        padding = client.settings.addAir(0),
        title = client.settings.addTitle("Player " .. index),
        text=client.settings.addNamelessTextbox("", text, 512),
        erase = client.settings.addFunction("Remove", "PlayerFunctionRemoval" .. index, "Remove")
    })
end
function AddPlayerEntry()
    AddPlayer()
end
client.settings.addFunction("Add Player To Block", "AddPlayerEntry", "Add")

event.listen("ConfigurationSaved", function()
    local data = {}
    local texts = {}
    for _, text in pairs(playerList) do
        table.insert(texts, {text=text.text.value})
    end
    data.texts = texts
    return data
end)

event.listen("ConfigurationLoaded", function(data)
    if data.texts == nil then return end
    for _, text in pairs(data.texts) do
        AddPlayer(text.text)
    end
end)

alreadyRequeuing = false
delayNextRequeue = false

event.listen("TitleChanged", function(text, titleType)
	if titleType == "actionbar" then
		if text:find("§aStarting game in §") then
			if text:match("§aStarting game in §.§.(%d+)") then
				local match = text:match("§aStarting game in §.§.(%d+)")
				if tonumber(match) <= 10 then
					if delayNextRequeue then
						requeue(lastGamemode, "§eAttempting to requeue again!", true)
						delayNextRequeue = false
					end
				end
				if tonumber(match) <= 5 then
					delayNextRequeue = false
					getPlayerStats()
				end
			end
			checkDodgeList()
		end
	end
end)

playersChecked = {}

event.listen("ChatMessageAdded", function(message, username, type, xuid)
	if message:find("§cYou are already connected to this server!") then
		print("§r§eInitiating requeue delay.")
		delayNextRequeue = true
		return true
	end
	if string.find(message, "§b§l» §r§a§lVoting has ended!") then
		client.execute("execute /connection")
		checkDodgeList()
		getPlayerStats()
	end
	if string.find(message, " joined. §8") then
		if message:find(player.name()) then
			playersChecked = {}
			alreadyRequeuing = false
			client.execute("execute /connection")
		end
		checkDodgeList()
		if levelBool.value == false and prestigeBool.value == false then
			return
		else
			getPlayerStats()
		end
	end
	if string.find(message, "You are connected to server ") then
		lastGamemode = message:sub(29):match("[%a-]*"):lower()
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
end)

function update()
    local language = client.language()
    if not language:find("en") then
        client.notification("This script only supports English.")
        client.execute("toggle off script" .. name)
	end
    local item = player.inventory().at(1)
    if item ~= nil and item.customName == "§r§bGame Selector§7 [Use]" then
        lastGamemode = "HUB"
    end

	if levelBool.value == false then
		levelDodge.visible = false
	else
		levelDodge.visible = true
	end
	if prestigeBool.value == false then
		prestigeDodge.visible = false
	else
		prestigeDodge.visible = true
	end
end

function requeue(game, message, sendRequeue)
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

function touchHiveAPI(username,gamemode)
	if alreadyRequeuing then return end
	for i, player in pairs(playersChecked) do
		if player == username then return end
	end
	username = string.gsub(username, " ", "%%20")
	network.get("https://api.playhive.com/v0/game/all/" .. gamemode .. "/" .. username,  gamemode)
end

function tablelen(tbl)
    local a = 0
    for k, v in pairs(tbl) do
        a = a + 1
    end
    return a
end

function onNetworkData(code, id, data)
	if code == 0 then
		result = jsonToTable(data)
		if type(result) ~= "table" then return end
		if tablelen(result) == 0 then return else
			if result["prestige"] ~= nil and prestigeBool.value then
				if result["prestige"] >= prestigeDodge.value then
					if alreadyRequeuing then return end
					requeue(lastGamemode, "§r§cA user is too high prestige.", true)
					alreadyRequeuing = true
				end
			elseif result["xp"] ~= nil and levelBool.value then
				local level = calculateLevel(lastGamemode, result["xp"])
				if level >= levelDodge.value then
					if alreadyRequeuing then return end
					requeue(lastGamemode, "§r§cA user is too high level.", true)
					alreadyRequeuing = true
				end
			end
		end
	end
end

function checkDodgeList()
	local serverList = server.players()
	for i, __Player in pairs(playerList) do
		local _player = __Player.text.value
		for _, username in pairs(serverList) do
			if username == _player and username ~= player.name() then
				requeue(lastGamemode, "§r§c" .. _player .. "§r§b is in your game.", true)
			end
		end
	end
end

function getPlayerStats()
	if delayNextRequeue then return end
	local serverList = server.players()
	for i, serverPlayer in pairs(serverList) do
		if serverPlayer ~= player.name() then
			if lastGamemode ~= "HUB" or lastGamemode ~= "ARCADE" then
				touchHiveAPI(serverPlayer, lastGamemode)
				table.insert(playersChecked, serverPlayer)
			end
		end
	end
end