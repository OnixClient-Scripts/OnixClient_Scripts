name = "Hive Chat Debloater"
description = "Adds small aesthetic tweaks to §eThe Hive§r's chat (debloats).\n§o§l§0Release v1.2\n§rMade by Jams\n\nExtra: .block command. (Requires Blocker.lua & Blockernt.lua)"

--[[
    Hive Chat Debloater Script

    Made by Jams
    Helped a lot by Mr. Onix
]]--
blocked = {}

RemoveUnlocks = false
RemoveHiddenMessage = false
RemoveTips = false
RemoveGameOver = false
RemoveTeamers = false
RemoveVoting = false
RemoveEliminated = false
RemoveLoginStreak = false

function Debloat()
    RemoveUnlocks = true
    RemoveHiddenMessage = true
    RemoveTips = true
    RemoveGameOver = true
    RemoveTeamers = true
    RemoveVoting = true
    RemoveEliminated = true
    RemoveLoginStreak = true
    client.settings.send()
end
function Bloat()
    RemoveUnlocks = false
    RemoveHiddenMessage = false
    RemoveTips = false
    RemoveGameOver = false
    RemoveTeamers = false
    RemoveVoting = false
    RemoveEliminated = false
    RemoveLoginStreak = false
    client.settings.send()
end


client.settings.addAir(10)
client.settings.addFunction("Enable All", "Debloat", "Debloat")
client.settings.addFunction("Disable All", "Bloat", "Bloat")
client.settings.addAir(10)

client.settings.addBool("Remove login streak message.", "RemoveLoginStreak")
noLoginStreak = "Removes:\n§8§l[§a§lLR§8§l] §rYou're now on a (day) day login streak. XP boost: +(XP boost)%"
client.settings.addInfo("noLoginStreak")
client.settings.addAir(10)

client.settings.addBool("Remove \"You have unused unlocks\" message.", "RemoveUnlocks")
noUnlocks = "Removes:\n§a§l» §rYou have unused unlocks in your Locker!"
client.settings.addInfo("noUnlocks")
client.settings.addAir(10)

client.settings.addBool("Remove \"You have been hidden\" message.", "RemoveHiddenMessage")
noHiddenMessage = "Removes:\n§b§l» §r§7You have been hidden. §8[Hidden Zone]\n§b§l» §r§7You are now visible."
client.settings.addInfo("noHiddenMessage")
client.settings.addAir(10)

client.settings.addBool("Remove \"No teaming!\" message.", "RemoveTeamers")
noTeaming = "Removes:\n§c§l» §r§c§lNo teaming! §r§6Teamers will be banned."
client.settings.addInfo("noTeaming")
client.settings.addAir(10)

client.settings.addBool("Remove \"Voting has ended\" message.", "RemoveVoting")
noVoting = "Removes:\n§b§l» §r§a§lVoting has ended!"
client.settings.addInfo("noVoting")
client.settings.addAir(10)

client.settings.addBool("Remove \"Gameover\" message.", "RemoveGameOver")
noGameover = "Removes:\n§c§l» §r§c§lGame OVER!"
client.settings.addInfo("noGameover")
client.settings.addAir(10)

client.settings.addBool("Remove Eliminated text", "RemoveEliminated")
wasEliminated = "Removes:\n§7(Colour)§r was ELIMINATED!"
client.settings.addInfo("wasEliminated")
client.settings.addAir(10)

client.settings.addBool("Remove Tips", "RemoveTips")
serverMessages = "Removes the following server messages:\n\n§6[§e!§6] §r§7Didn't get your store purchase? §3Try §a/fixpurchase§r,\n§6[§e!§6] §r§aJoin our forums : §3Go to §bforum.playhive.com§r,\n§6[§e!§6] §r§9Need help? §3Go to §asupport.playhive.com§r,\n§6[§e!§6] §r§9Join our Discord : run §d/discord§r,\n§6[§e!§6] §r§aFollow our Twitter : §b@theHiveMC§r."
client.settings.addInfo("serverMessages")


local initlog = io.open("Chatlog.txt", 'w')
io.close(initlog)

function onChat(message, username, type)
    if RemoveUnlocks == true and message == "§a§l» §rYou have unused unlocks in your Locker!" then
    return true
    end
    
    if RemoveHiddenMessage == true and message == "§b§l» §r§7You have been hidden. §8[Hidden Zone]" then
    return true
    end

    if RemoveHiddenMessage == true and message ==  "§b§l» §r§7You are now visible." then
    return true
    end

    if RemoveTips == true and message == "§6[§e!§6] §r§9Join our Discord : run §d/discord" then
    return true
    end
    
    if RemoveTips == true and message == "§6[§e!§6] §r§7Didn't get your store purchase? §3Try §a/fixpurchase" then
    return true
    end

    if RemoveTips == true and message == "§6[§e!§6] §r§aFollow our Twitter : §b@theHiveMC" then
    return true
    end

    if RemoveTips == true and message == "§6[§e!§6] §r§aJoin our forums : §3Go to §bforum.playhive.com" then
    return true
    end

    if RemoveTips == true and message == "§6[§e!§6] §r§9Need help? §3Go to §asupport.playhive.com" then
    return true
    end

    if RemoveGameOver == true and message == "§c§l» §r§c§lGame OVER!" then
    return true
    end

    if RemoveTeamers == true and message == "§c§l» §r§c§lNo teaming! §r§6Teamers will be banned." then
    return true
    end
    
    if RemoveVoting == true and message == "§b§l» §r§a§lVoting has ended!" then
    return true
    end

    if RemoveEliminated == true and string.find(message, "was ELIMINATED!") ~= nil then
    return true
    end

    if RemoveLoginStreak == true and string.find(message, "day loginstreak. XP boost: +") ~= nil then
    return true
    end

    local lowerMessage = string.lower(message)
    for k,BlockedText in pairs(blocked) do
        if string.find(lowerMessage, BlockedText) ~= nil then
            return true
        end
    end
    
    local file = io.open("Chatlog.txt", 'a')
    file:write(message .. "\n")
    io.close(file)
    
end

function saveBlockedList()
    local file = io.open("BlockedList.txt", 'w')
    
    for _,text in pairs(blocked) do
      file:write(text .. "\n")
    end
  
    io.close(file)
  end
  
  function loadBlockedlist()
    local file = io.open("BlockedList.txt", 'r')
    blocked = {}
    if file == nil then return end
  
    local filelines = file:lines()
    for line in filelines do
      if line ~= "" then
        table.insert(blocked, line)
      end
    end
  
    io.close(file)
  end

function onLocalData(identifier, content)
    if identifier == "57f718bd-79e0-4212-9c6d-f6b9c091946f" then 
        print("Added word \"§7" .. content .. "§r\" to the block list.")
        table.insert(blocked,content)
        saveBlockedList()
    elseif identifier == "7772437c-671c-4682-8728-238bc46efd7a" then
        local nbl = {}
        local found = false
        for _, text in pairs(blocked) do
            if content ~= string.lower(text) then
                table.insert(nbl, text)
            else 
                found = true
            end
        end
        blocked = nbl
        saveBlockedList()

        if found == true then
            print("Removed word \"§7" .. content .. "§r\" from the block list.")
        else
            print("The word \"§7" .. content .. "§r\" was not on the block list.")
        end
    end

end
loadBlockedlist()
event.listen("ChatMessageAdded", onChat)
event.listen("LocalDataReceived", onLocalData)
