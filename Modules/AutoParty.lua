name = "AutoParty"
description = "Automatically accepts party invite from added players"

--[[
    Auto party accepter for The Hive and Cubecraft
    made by Quoty0
]]

commandUsage = "AutoParty command usage\n\n.addparty <player_name> - Add player to player list\n.removeparty <player_name> - Remove player from player list\n.listparty - Show player list"
client.settings.addInfo("commandUsage")

ImportedLib = importLib("fileUtility.lua")

players = {}

function countComma(str)
    local count = 0
    local index = 1
    while true do
        index = string.find(str, ",", index, true)
        if index == nil then
            break
        end
        count = count + 1
        index = index + 1
    end
    return count
end

function compressArray(array)
    local a = 1
    for i = 1, #array do
        if array[i] then
            array[a] = array[i]
            a = a + 1
        end
    end
    while array[a] do
        array[a] = nil
        a = a + 1
    end
end

local function isEmpty(arg)
  return arg == nil or arg == ''
end

function loadPlayerList()
    if fileExists("partyplayerlist.txt") == false then
        playerList = ""
        createFile("partyplayerlist.txt")
    else
        playerList = readWholeFile("partyplayerlist.txt")
        if playerList ~= "" then
            for i = 0, countComma(playerList) + 1 do
                players[i] = string.split(string.gsub(playerList, ", ", ","), ",")[i]
            end
        end
    end
end
loadPlayerList()

function savePlayerList()
    local file = io.open("partyplayerlist.txt", "w")

    if file then
        for i = 1, #players do
            if players[i] ~= nil then file:write(players[i]) end
            if i < #players then file:write(", ") end
        end
        file:close()
    else
        error("Unable to open file")
    end
    loadPlayerList()
end

function onChat(msg, user, type)
    local ip = server.ip()
    local msg = msg:gsub("§.","")
    local playerName = ""
    -- if ip == "geo.hivebedrock.network" or ip == "jp.hivebedrock.network" or ip == "sg.hivebedrock.network" or ip == "fr.hivebedrock.network" or ip == "ca.hivebedrock.network" then
    if string.find(ip, "hivebedrock.network") then
        if string.find(msg, " wants you to join their party!") and type == 2 then
		    playerName = string.gsub(msg, " wants you to join their party!", "")
			playerName = string.lower(playerName)
			for i = 1, #players do
                if playerName == string.lower(players[i]) then
                    client.execute("execute /party accept " .. playerName)
                    break
                end
			end
		end
    end
    if string.find(ip, "cubecraft.net") then
        if string.find(msg, "You have received a party invite from ") and type == 2 then
		    playerName = string.gsub(msg, "!", "")
			playerName = string.gsub(playerName, "You have received a party invite from ", "")
			playerName = string.lower(playerName)
			for i = 1 , #players do
                if playerName == string.lower(players[i]) then
                    client.execute("execute /party accept " .. playerName)
                    break
                end
			end
		end
    end
end
event.listen("ChatMessageAdded", onChat)

function addPlayer(arg)
    local isPlayerFound = false
    for i = 1, #players do
        if players[i] == arg then
            print("§aPlayer " .. arg .. " is already in player list")
            isPlayerFound = true
            break
        end
    end
    if isPlayerFound == false then
        table.insert(players, arg)
        print("§aPlayer " .. arg .. " is added to player list")
        savePlayerList()
    end
end

function removePlayer(arg)
    local isPlayerFound = false
    for i = 1, #players do
        if players[i] == arg then
            players[i] = nil
            print("§aPlayer " .. arg .. " is removed from the player list")
            isPlayerFound = true
            compressArray(players)
        end
    end
    if isPlayerFound == false then
        print("§aPlayer " .. arg .. " is not found in the player list")
    end
    savePlayerList()
end

registerCommand("addparty", function(arg)
    if isEmpty(arg) then
        print("§aInvalid player name")
        print("§aCommand usage: .addparty <player_name>")
	else
        addPlayer(arg)
    end
end)

registerCommand("removeparty", function(arg)
    if isEmpty(arg) then
        print("§aInvalid player name")
        print("§aCommand usage: .removeparty <player_name>")
    else
        removePlayer(arg)
    end
end)

registerCommand("listparty", function(arg)
    if isEmpty(playerList) then
        print("§aPlayer list is empty")
    else
        print("§aCurrent player list: " .. playerList)
    end
end)

registerCommand("clearparty", function(arg)
    if isEmpty(playerList) then
        print("§aPlayer list is already empty")
    else
        players = {}
        savePlayerList()
        print("§aPlayer list has been cleaned up!")
    end
end)
