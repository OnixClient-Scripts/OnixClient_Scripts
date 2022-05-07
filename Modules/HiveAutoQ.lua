name = "HiveAutoQ"
description = "Semi-Auto Queuing for The Hive server!!"

--[[
    Hive Auto Qing
    
    Made by Helix
    Shoutouts to Onix for making such a versatile client
    (& to all the people i stole code from)
]]--

NTK = "Be sure to not activate more than one boolean at a time"
NTK2 ="TreasureWars isnt exactly finished yet"
NTK3 = "Please let me know of any bugs if you come across them !!"

SW_Title = "SkyWars"
SW_Solo = false
SW_Duos = false
SW_Trios = false
SW_Sqauds = false
SW_Mega = false --ew lmao

TW_Title = "TreasureWars"
TW_Solos = false
TW_Duos = false
TW_Trios = false
TW_Squads = false
TW_Mega = false --ew lmao

SG_Title = "Survival Games"
SG_Solos = false
SG_Duos = false

Ewww= "Just Build"
JB_Solo = false
JB_Duos = false
JB_Solos_dt = false
JB_Duos_dt = false

TheActullyFunGames_Title = "Miscellaneous" --BLOAT, BLOAT TITLE bloat bloat bloat
MM = false
Hide_Seek = false
DR = false

--I will add seasonall eventually maybe

-- v this is all the gui stuff v --
client.settings.addInfo("NTK")

client.settings.addAir(12)

client.settings.addInfo("SW_Title")
client.settings.addBool("Solos", "SW_Solo")
client.settings.addBool("Duos", "SW_Duos")
client.settings.addBool("Trios", "SW_Trios")
client.settings.addBool("Sqauds", "SW_Sqauds")
client.settings.addBool("Mega", "SW_Mega")

client.settings.addAir(10)

client.settings.addInfo("TW_Title")
client.settings.addInfo("NTK2")
client.settings.addBool("Solo", "TW_Solos")
client.settings.addBool("Duos", "TW_Duos")
client.settings.addBool("Trios", "TW_Trios")
client.settings.addBool("Squads", "TW_Squads")
client.settings.addBool("Mega", "TW_Mega")

client.settings.addAir(10)

client.settings.addInfo("Ewww")
client.settings.addBool("Solo", "JB_Solo")
client.settings.addBool("Double Time Solo", "JB_Solos_dt")
client.settings.addBool("Duos", "JB_Duos")
client.settings.addBool("Double Time Duos", "JB_Duos_dt")

client.settings.addAir(10)

client.settings.addInfo("TheActullyFunGames_Title")
client.settings.addBool("Murder Mystery", "MM")

client.settings.addBool("Hide & Seek", "Hide_Seek")

client.settings.addBool("Deathrun", "DR")

client.settings.addAir(10)

client.settings.addInfo("NTK3")


-- v The actual code that does stuff v --
function onChat(message, username, type)
    message = string.lower(message)
    gameover = "§c§l» §r§c§lgame over!"


    --/\/\/\/\  Sky Wars /\/\/\/\--
    if SW_Solo == true and string.match(message, gameover) then
        client.execute("execute /q sky")
    end

    if SW_Duos == true and string.match(message, gameover) then
        client.execute("execute /q sky-duos")
    end

    if SW_Trios == true and string.match(message, gameover) then
        client.execute("execute /q sky-trios")
    end

    if SW_Mega == true and string.match(message, gameover) then
        client.execute("execute /q sky-mega")
    end


    --/\/\/\/\  Treasure Wars  /\/\/\/\--
    if TW_Solos == true and string.match(message, gameover) then 
        client.execute("execute /q wars")
    end

    if TW_Duos == true and string.match(message, gameover) then
        client.execute("execute /q wars-duos")
    end

    if TW_Trios == true and string.match(message, gameover) then
        client.execute("execute /q wars-trios")
    end

    if TW_Squads == true and string.match(message, gameover) then
        client.execute("execute /q wars-squads")
    end

    if TW_Mega == true and string.match(message, gameover) then
        client.execute("execute /q wars-mega")
    end


    --/\/\/\/\  Survival Games  /\/\/\/\--
    if SG_Solos == true and string.match(message, gameover) then
        client.execute("execute /q sg")
    end

    if SG_Duos == true and string.match(message, gameover) then
        client.execute("execute /q sg-duos")
    end


    --/\/\/\/\  Just Build (ew)  /\/\/\/\--
    if JB_Solo == true and string.match(message, gameover) then
        client.execute("execute /q build")
    end

    if JB_Duos == true and string.match(message, gameover) then
        client.execute("execute /q build-duos")
    end

    if JB_Solos_dt == true and string.match(message, gameover) then
        client.execute("execute /q buildX")
    end

    if JB_Duos == true and string.match(message, gameover) then
        client.execute("execute /q build-duosX")
    end


    --/\/\/\/\  Mic.  /\/\/\/\--
    if Hide_Seek == true and string.match(message, gameover) then
        client.execute("execute /q hide")
    end

    if MM == true and string.match(message, gameover) then
        client.execute("execute /q murder")
    end

    if MM == true and string.match(message, "§c§l» §r§cyou died! §7§oyou will be taken to the graveyard shortly...") then
        client.execute("execute /q murder")
    end
    --This one is if you get killed by murd^ (idk if its possible to be in one 'if' statement)

    if DR == true and string.match(message, gameover) then
        client.execute("execute /q dr")
    end
end
event.listen("ChatMessageAdded", onChat)

--[[                                   *@@.           
                                  O@@#            
                                 *@@#.O           
                                 @@@ °@@@°        
                                 @@@    O@@o   ** 
                       .*oO#@@@@ @@@ *Ooo#@@@@@@@*
                   .O@@@@@@@@#@@ O@@°o@@@@@#Oo.   
                 *@@@@*  .#@@*   o@@o             
               .@@@#@@O     o@@@ *@@o             
              °@@@   °@@@o    °# @@@.             
              @@@ O.    O@@#.   #@@O              
             .@@@ @@@o    .#@@O@@@*               
             °@@@   o@@O.  *@@@@o                 
   .*oO@@@@@# @@@ @@@@@@@@@@@o.                   
*@@@@@@@OoOOo @@@ #@@#Oo*°                        
 oo. .#@@*    @@@                                 
        o@@@. @@@                                 
          .#°O@@*                                 
            #@@#        Helix (omg bloat)                          
           .@@o                                   
]]