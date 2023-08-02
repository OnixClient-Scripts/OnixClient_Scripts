name = "HiveAutoParty"
description = "Automatically accepts party invite from added players"

--[[
    The Hive auto party accepter
    made by Quoty0
]]

commandUsage = "HiveAutoParty command usage\n\n.addparty <player_name> - Add player to player list\n.removeparty <player_name> - Remove player from player list\n.listparty - Show player list"
client.settings.addInfo("commandUsage")

ImportedLib = importLib("fileUtility.lua")

function loadPlayerList()
    if fileExists("partyplayerlist.txt") == false then
        playerList = ""
        createFile("partyplayerlist.txt")
    else
        playerList = readWholeFile("partyplayerlist.txt")
    end
end
loadPlayerList()

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

local function isEmpty(arg)
  return arg == nil or arg == ''
end

function onChat(msg, user, type)
    local ip = server.ip()
    local playerName = ""
    if ip == "geo.hivebedrock.network" or ip == "jp.hivebedrock.network" or ip == "sg.hivebedrock.network" or ip == "fr.hivebedrock.network" or ip == "ca.hivebedrock.network" then
        if string.find(msg, " wants you to join their party!") and type == 2 then
		    playerName = string.gsub(msg, "§b wants you to join their party!", "")
			playerName = string.gsub(playerName, "§b§a", "")
			playerName = string.lower(playerName)
			if string.find(string.lower(playerList), playerName) then
                client.execute("execute /party accept " .. playerName)
			end
		end
    end
end
event.listen("ChatMessageAdded", onChat)

function addPlayer(arg)
    file = io.open("partyplayerlist.txt", 'a+')
	if isEmpty(playerList) then
	    file:write(arg)
    else
        file:write(", " .. arg)
    end
    io.close(file)
    loadPlayerList()
	print("§aPlayer " .. arg .. " is added to player list")
end

function removePlayer(arg)
    if isEmpty(playerList) then
	    print("§aPlayer list is empty")
	else
        file = io.open("partyplayerlist.txt", 'w')
    	if string.find(playerList, ", " .. arg) then
            playerList = string.gsub(playerList, ", " .. arg, "")
			print("§aPlayer " .. arg .. " is removed from player list")
		elseif string.find(playerList, arg .. ", ") then
            playerList = string.gsub(playerList, arg .. ", ", "")
			print("§aPlayer " .. arg .. " is removed from player list")
		elseif string.find(playerList, arg) then
		    playerList = string.gsub(playerList, arg, "")
			print("§aPlayer " .. arg .. " is removed from player list")
		else
		    print("§aPlayer " .. arg .. " is not in player list")
		end
		file:write(playerList)
		io.close(file)
	end
end

registerCommand("addparty", function(arg)
    if isEmpty(arg) then
        print("§aInvalid player name")
        print("§aCommand usage: .addparty <player_name>")
	elseif string.find(playerList, arg) then
		print("§aThe player is already in player list")
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
