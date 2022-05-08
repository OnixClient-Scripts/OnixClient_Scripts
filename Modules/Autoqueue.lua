name = "Autoqueue"
description = "Automatically Queue Hive Games"

--[[

Made by jqms w/ help from onix cuz he gamer

if you want to use .rq, you need the script, its called "HiveRequeue.lua" on the github.
alternatively you can just make a new command and put this as the code:

    command = "rq"
    help_message = "Requeues Hive Games"
    function execute(arguments)
    sendLocalData("00409ed7-72f4-4575-8028-c0abf7736a49", "e")
    end

bye🙂
]]--

lastMessage = ""

Auto = "Fully Automatic (Recommended)"
Skywars = "Skywars"
TreasureWars = "Treasure Wars"
OptionalText = [[The following options are optional! Fully automatic requeue 
handles selecting the gamemode for you!]]

FullyAuto = false

SkySolos = false
SkyDuos = false
SkyTrios = false
SkySquads = false
SkyKits = false
SkyKitsDuos = false

WarsSolos = false
WarsDuos = false
WarsTrios = false
WarsSquads = false

client.settings.addAir(5)

client.settings.addInfo("Auto")
client.settings.addBool("Fully Automatic Requeue", "FullyAuto")

client.settings.addAir(10)
client.settings.addInfo("OptionalText")
client.settings.addAir(2)

client.settings.addInfo("Skywars")
client.settings.addBool("Skywars Solos", "SkySolos")
client.settings.addBool("Skywars Duos", "SkyDuos")
client.settings.addBool("Skywars Trios", "SkyTrios")
client.settings.addBool("Skywars Squads", "SkySquads")
client.settings.addBool("Skywars Kits", "SkyKits")
client.settings.addBool("Skywars Kits Duos", "SkyKitsDuos")

client.settings.addAir(5)

client.settings.addInfo("TreasureWars")
client.settings.addBool("Treasure Wars Solos", "WarsSolos")
client.settings.addBool("Treasure Wars Duos", "WarsDuos")
client.settings.addBool("Treasure Wars Trios", "WarsTrios")
client.settings.addBool("Treasure Wars Squads", "WarsSquads")


function onChat(message, username, type)

--fully automatic requeue :D
    if FullyAuto == true and string.find(message, "§b§l» §r§a§lVoting has ended!") then
        client.execute("execute /connection")
    end
    if FullyAuto == true and string.find(message,"You are connected to server ") then
        lastMessage = message
        lastMessage = string.sub(message, 29)
        lastMessage = string.match(lastMessage,"[%a-]*")
    end

--hide the /connection message
    if FullyAuto == true and string.find(message, "You are connected to proxy ") or string.find(message, "You are connected to server ") then
        return true
    end

--fully auto
    --skywars
    if FullyAuto == true and string.find(message, "did an oopsie!") and string.find(message, player.name()) ~=nil then
        print("Falling into the void is §lembarrassing...\n§r§8Queueing into a new game.")
        client.execute("execute /q " .. lastMessage)
        return
    end
    if FullyAuto == true and string.find(message, "You were killed by") then
        print("You were §ckilled!\nQueuing into a new game.")
        client.execute("execute /q " .. lastMessage)
        return
    end
    if FullyAuto == true and string.find(message, "is the WINNER!") then
        print("Congratulations on §6winning!\n§r§8Queueing into a new game.")
        client.execute("execute /q " .. lastMessage)
        return
    end
    --treasure wars
    if FullyAuto == true and string.find(message, "§c§l» §r§7§lYou were eliminated") then
        print("They were §odefinitely cheating.\n§r§8Queueing into a new game. ")
        client.execute("execute /q " .. lastMessage)
        return
    end
    if FullyAuto == true and string.find(message, "are the WINNERS!") then
        print("Congratulations on §6winning!\n§r§8Queueing into a new game.")
        client.execute("execute /q " .. lastMessage)
        return
    end
    --murder mystery
    if FullyAuto == true and string.find(message, "§c§l» §r§cYou died! §7§oYou will be taken to the Graveyard shortly...") then
        print("Dying is so bald!\n§r§8Queueing into a new game.")
        client.execute("execute /q " .. lastMessage)
        return
    end
    if FullyAuto == true and string.find(message, "§b§l» §r§aYou survived!") then
        print("Congratulations on surviving!\n§r§8Queueing into a new game.")
        client.execute("execute /q " .. lastMessage)
        return
    end
    --all
    if FullyAuto == true and string.find(message, "§c§l» §r§c§lGame OVER!") then
        print("I don't know if you won or lost, so I'm just going to say well done!\n§r§8Queueing into a new game.")
        client.execute("execute /q " .. lastMessage)
        return
    end














--skywars
    -- solos
    if SkySolos == true and string.find(message, "You were killed by") then
        print("You were §ckilled!\nQueuing into a new game.")
        client.execute("execute /q sky")
    end
    if SkySolos == true and string.find(message, "is the WINNER!") then
        print("Congratulations on §6winning!\n§r§8Queueing into a new game.")
        client.execute("execute /q sky")
    end
    if SkySolos == true and string.find(message, "did an oopsie!") and string.find(message, player.name()) ~=nil then
        print("Falling into the void is §lembarrassing...\n§r§8Queueing into a new game.")
        client.execute("execute /q sky")
    end
-- duos
    if SkyDuos == true and string.find(message, "You were killed by") then
        print("You were §ckilled!\nQueuing into a new game.")
        client.execute("execute /q sky-duos")
    end
    if SkyDuos == true and string.find(message, "are the WINNERS!") then
        print("Congratulations on §6winning!\n§r§8Queueing into a new game.")
        client.execute("execute /q sky-duos")
    end
    if SkyDuos == true and string.find(message, "did an oopsie!") and string.find(message, player.name()) ~=nil then
        print("Falling into the void is §lembarrassing...\n§r§8Queueing into a new game.")
        client.execute("execute /q sky-duos")

    end
--trios
    if SkyTrios == true and string.find(message, "You were killed by") then
        print("You were §ckilled!\nQueuing into a new game.")
        client.execute("execute /q sky-trios")
    end
    if SkyTrios == true and string.find(message, "are the WINNERS!") then
        print("Congratulations on §6winning!\n§r§8Queueing into a new game.")
        client.execute("execute /q sky-trios")
    end
    if SkyTrios == true and string.find(message, "did an oopsie!") and string.find(message, player.name()) ~=nil then
        print("Falling into the void is §lembarrassing...\n§r§8Queueing into a new game.")
        client.execute("execute /q sky-trios")
    end
--squads
    if SkySquads == true and string.find(message, "You were killed by") then
        print("You were §ckilled!\nQueuing into a new game.")
        client.execute("execute /q sky-squads")
    end
    if SkySquads == true and string.find(message, "are the WINNERS!") then
        print("Congratulations on §6winning!\n§r§8Queueing into a new game.")
        client.execute("execute /q sky-squads")
    end
    if SkySquads == true and string.find(message, "did an oopsie!") and string.find(message, player.name()) ~=nil then
        print("Falling into the void is §lembarrassing...\n§r§8Queueing into a new game.")
        client.execute("execute /q sky-squads")
    end

--treasure wars
--solos
    if WarsSolos == true and string.find(message, "§c§l» §r§7§lYou were eliminated") then
        print("They were §odefinitely cheating.\n§r§8Queueing into a new game. ")
        client.execute("execute /q wars")
    end
    if WarsSolos == true and string.find(message, "are the WINNERS!") then
        print("Congratulations on §6winning!\n§r§8Queueing into a new game.")
        client.execute("execute /q wars")
    end
--duos
    if WarsDuos == true and string.find(message, "§c§l» §r§7§lYou were eliminated") then
        print("They were §odefinitely cheating.\n§r§8Queueing into a new game. ")
        client.execute("execute /q wars-duos")
    end
    if WarsDuos == true and string.find(message, "are the WINNERS!") then
        print("Congratulations on §6winning!\n§r§8Queueing into a new game.")
        client.execute("execute /q wars-duos")
    end
--trios
    if WarsTrios == true and string.find(message, "§c§l» §r§7§lYou were eliminated") then
        print("They were §odefinitely cheating.\n§r§8Queueing into a new game. ")
        client.execute("execute /q wars-trios")
    end
    if WarsTrios == true and string.find(message, "are the WINNERS!") then
        print("Congratulations on §6winning!\n§r§8Queueing into a new game.")
        client.execute("execute /q wars-trios")
    end
--squads
    if WarsSquads == true and string.find(message, "§c§l» §r§7§lYou were eliminated") then
        print("They were §odefinitely cheating.\n§r§8Queueing into a new game. ")
        client.execute("execute /q wars-squads")
    end
    if WarsSquads == true and string.find(message, "are the WINNERS!") then
        print("Congratulations on §6winning!\n§r§8Queueing into a new game.")
        client.execute("execute /q wars-squads")
    end
end
function onLocalData(identifier, content)
    if identifier == "00409ed7-72f4-4575-8028-c0abf7736a49" then 
        client.execute("execute /q " .. lastMessage)
    end
end
event.listen("LocalDataReceived", onLocalData)
event.listen("ChatMessageAdded", onChat)