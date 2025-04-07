name = "HiveWinstreakV2"
 description = "Winstreak counter for The Hive"
 
 --[[
     Winstreak Counter module by Quoty0
     Rework and rescript by Namenu
     A part of the script is from " Hive Auto Queue" Made by Rosie 
 ]]
 
 local font = gui.font()
 ImportedLib = importLib("fileUtility.lua")
 
 positionX = 558
 positionY = 316
 sizeX = 80
 sizeY = 15
 scale = 1
 
 local file = io.open("WinStreak.txt")
 
 if file then
     winstreak = "Gamemode Not Selected"
     gm = "Null"
     team = "Null"
     dead = "?"
 	file:close()
 else
 	local file = io.open("WinStreak.txt", "w")
 	file:write("0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0")
 	file:close()
     winstreak = 0
     gm = "Null"
     team = "Null"
     dead = "?"
 end
 xboxname = player.name()
 client.settings.addAir(10)
 textcolor = client.settings.addNamelessColor("Text Color", { 255, 255, 255, 255 })
 bgcolor = client.settings.addNamelessColor("Background Color", { 0, 0, 0, 128 })
 client.settings.addAir(10)
 xoffset = 0
 client.settings.addInt("Text X offset", "xoffset", -5, 5)
 yoffset = 0
 client.settings.addInt("Text Y offset", "yoffset", -5, 5)
 client.settings.addAir(30)
 cmdinfo =
 "Command List\nsetstreak <arg> - set your winstreak to <arg>\naddstreak add 1 to the current winstreak"
 client.settings.addInfo("cmdinfo")
 client.settings.addAir(10)
 addstreakinfo = "You can use .setstreak to set your streak number to the current gamemode you're in \nYou can use .addstreak to add 1 to you current winstreak\n(need to be in a game lobby else it will not work or edit the wrong one)"
 client.settings.addInfo("addstreakinfo")


function render(dt)
     text = "Winstreak: " .. tostring(winstreak)
     width = font.width(text) + 7 
     height = font.height + 7
     sizeX = width
     sizeY = height
     gfx.color(bgcolor.value.r, bgcolor.value.g, bgcolor.value.b, bgcolor.value.a)
     gfx.rect(0, 0, width, height)
     gfx.color(textcolor.value.r, textcolor.value.g, textcolor.value.b, textcolor.value.a)
     gfx.text(width / 2 - width / 2 + 4 + xoffset, 11 - height / 2 + yoffset, text, 1)
    end
function gmSelector(msg)
    local file = io.open("WinStreak.txt", "r")
    if file then

        local lineNumber = 0
        local newWinstreak = nil  
        for line in file:lines() do
            lineNumber = lineNumber + 1
            if string.match(msg, "Finding you a game of BED.*") and lineNumber == 1 then
                newWinstreak = tonumber(line)
                gm = "bed"
                NumberLine = 1
            elseif string.match(msg, "Finding you a game of SKY.*") and lineNumber == 2 then
                newWinstreak = tonumber(line)
                gm = "sky"
                NumberLine = 2
            elseif string.match(msg, "Finding you a game of Murder Mystery") and lineNumber == 3 then
                newWinstreak = tonumber(line)
                gm = "mm"
                NumberLine = 3
            elseif string.match(msg, "Finding you a game of Just Build.*") and lineNumber == 4 then
                newWinstreak = tonumber(line)
                gm = "jb"
                NumberLine = 4
            elseif string.match(msg, "Finding you a game of Capture The Flag.*") and lineNumber == 5 then
                newWinstreak = tonumber(line)
                gm = "ctf"
                NumberLine = 5
            elseif string.match(msg, "Finding you a game of Hide and Seek.*") and lineNumber == 6 then
                newWinstreak = tonumber(line)
                gm = "hs"
                NumberLine = 6
            elseif string.match(msg, "Finding you a game of DeathRun.*") and lineNumber == 7 then
                newWinstreak = tonumber(line)
                gm = "dr"
                NumberLine = 7
            elseif string.match(msg, "Finding you a game of Gravity.*") and lineNumber == 8 then
                newWinstreak = tonumber(line)
                gm = "gr"
                NumberLine = 8
            elseif string.match(msg, "Finding you a game of Block Party.*") and lineNumber == 9 then
                newWinstreak = tonumber(line)
                dead = "no"
                gm = "bp"
                NumberLine = 9
            elseif string.match(msg, "Finding you a game of Survival Game.*") and lineNumber == 10 then
                newWinstreak = tonumber(line)
                gm = "sg"
                NumberLine = 10
            elseif string.match(msg, "Finding you a game of The Bridge.*") and lineNumber == 11 then
                newWinstreak = tonumber(line)
                gm = "tb"
                NumberLine = 11
            elseif string.match(msg, "Finding you a game of Ground Wars.*") and lineNumber == 12 then
                newWinstreak = tonumber(line)
                gm = "gw"
                NumberLine = 12
            elseif string.match(msg, "Finding you a game of Block Drop.*") and lineNumber == 13 then
                newWinstreak = tonumber(line)
                gm = "bd"
                dead = "no"
                NumberLine = 13
            end
            
            if newWinstreak then
                winstreak = newWinstreak
                break
            end
        end
        file:close()
    end
end
function onChat(message, username, type)
    --Skywars
    if string.match(message, "§rYou are on the ") and type == 2 then
        teamcolor = message:sub(30, 30)
        if teamcolor == "e" then
            team = "Yellow"
        elseif teamcolor == "a" then
            team = "Lime"
        elseif teamcolor == "c" then
            team = "Red"
        elseif teamcolor == "9" then
            team = "Blue"
        elseif teamcolor == "6" then
            team = "Gold"
        elseif teamcolor == "d" then
            team = "Magenta"
        elseif teamcolor == "b" then
            team = "Aqua"
        elseif teamcolor == "7" then
            team = "Gray"
        elseif teamcolor == "5" then
            team = "Purple"
        elseif teamcolor == "2" then
            team = "Green"
        elseif teamcolor == "8" then
            team = "Dark Gray"
        elseif teamcolor == "3" then
            team = "Cyan"
        else
            team = "Unknown"
        end
    end
    if string.match(message, team .. " Team §7has been §cELIMINATED§7!") then

        if string.match(message, player.name()) then
            winstreak = 0
            updateWinstreakInFile(NumberLine, winstreak) 
            return
        end
    end
    if string.match(message, team .. " was ELIMINATED!") then
        winstreak = 0
        updateWinstreakInFile(NumberLine, winstreak) 
        return
    end

    if string.match(message, team .. " Team are the WINNERS!") then
        if string.match(message, player.name()) then
            winstreak = winstreak + 1
            updateWinstreakInFile(NumberLine, winstreak) 
            return
        end
    end
    if string.match(message, team .. " Team is the WINNER!") then
        return
    end

    -- Block Party
    if string.match(message, "§crock 'n' rolled into the void") or
       string.match(message, "§ctook the L!§8") or
       string.match(message, "§cain't stayin' alive") or
       string.match(message, "§cfell off the map") then
        if string.match(message, player.name()) then
            winstreak = 0
            updateWinstreakInFile(NumberLine, winstreak) 
            dead = "yes"
            return
        end
    end
    if string.match(message, "Game OVER!") and dead == "no" and gm == "bp" then
        winstreak = winstreak + 1
        updateWinstreakInFile(NumberLine, winstreak)
        return
    end

    -- Gravity
    if string.match(message, "§a§l» §r§eYou finished all maps and came in") then
        winstreak = winstreak + 1
        updateWinstreakInFile(NumberLine, winstreak) 
        return
    end
    if string.match(message, "Game OVER!") and gm == "gr" then
        winstreak = 0
        updateWinstreakInFile(NumberLine, winstreak)
        return
    end

    -- Block Drop
    if string.match(message, "§c§l» §r§cYou died! §7Stick around or play another round.") then
        winstreak = 0
        updateWinstreakInFile(NumberLine, winstreak)
        return
    end
    if string.match(message, "Game OVER!") and dead == "no" and gm == "bd" then
        winstreak = winstreak + 1
        updateWinstreakInFile(NumberLine, winstreak) 
        return
    end

    -- DeathRun
    if string.match(message, "You finished in") then
        winstreak = winstreak + 1
        updateWinstreakInFile(NumberLine, winstreak) 
        return
    end
    if string.match(message, "§c§l» §r§cYou died!") then
        print('§askill issue')
    end
    if string.match(message, "Game OVER!") and gm == "dr" then
        winstreak = 0
        updateWinstreakInFile(NumberLine, winstreak)
        print('§5Youre not very good at this arent you?')
        return 
    end

    -- Murder Mystery
    if string.match(message, "§c§l» §r§cYou died! §7§oYou will be taken to the Graveyard shortly...") then
        winstreak = 0
        updateWinstreakInFile(NumberLine, winstreak)  -- Update in the file
        return
    end
    if string.match(message, "§b§l» §r§aYou survived!") then
        winstreak = winstreak + 1
        updateWinstreakInFile(NumberLine, winstreak)  -- Update in the file
        return
    end
    if string.match(message, "Elimimate all players") then
        role = "Murder"
    end
    if string.match(message, "Try to survive.") then
        role = "Survivor"
    end
    if string.match(message, "Eliminate the murderer using your Zapper") then
        role = "Sheriff"
    end
    if string.match(message, "Murder won this round.") or string.match(message, "§cMurderer §7won this round.") and role == "Murder " then
        winstreak = winstreak + 1
        updateWinstreakInFile(NumberLine, winstreak)
        print("wow you're doing great")
        return
    end
end

function updateWinstreakInFile(lineNumber, newWinstreak)
    local file = io.open("WinStreak.txt", "r")
    if file then
        local lines = {}
        local lineCount = 0
        for line in file:lines() do
            lineCount = lineCount + 1
            if lineCount == lineNumber then
                table.insert(lines, tostring(newWinstreak))  
            else
                table.insert(lines, line)
            end
        end
        file:close()

        
        local file = io.open("WinStreak.txt", "w")
        for _, line in ipairs(lines) do
            file:write(line .. "\n")
        end
        file:close()
    end
end
 function onChatMessageAdded(msg)
     -- Call gmSelector
     gmSelector(msg)
 
     -- Call WS
     onChat(msg)
 end

 function setstreak(arg)

    if type(arg) == "number" then
        winstreak = arg  
        updateWinstreakInFile(NumberLine, winstreak)  
    else
        print("Error: Invalid argument. Please provide a valid number for the winstreak.")
    end
end
registerCommand("setstreak", function(arg)
    local streak = tonumber(arg)
    
    if streak then
        setstreak(streak)
        print("Winstreak changed to " .. streak)
    else
        if arg == nil or arg == "" then
            print("§cPlease provide a valid number for the winstreak!")
        else
            print("§c" .. arg .. " is not a valid number!")
        end
    end
end)
registerCommand("addstreak", function()

    winstreak = winstreak + 1  
    

    updateWinstreakInFile(NumberLine, winstreak)
    
    print("Winstreak modified. New winstreak: " .. winstreak)
end)
 event.listen("ChatMessageAdded", onChatMessageAdded)
 