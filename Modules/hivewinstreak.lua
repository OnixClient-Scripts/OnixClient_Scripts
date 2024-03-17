name = "Hive Winstreak Counter"
description = "Winstreak counter for The Hive (Only Skywars, Treasure wars)"

--[[
    Winstreak Counter module (for The Hive Skywars, Treasure wars)
    made by Quoty0
]]

positionX = 558
positionY = 316
sizeX = 80
sizeY = 15
scale = 1

local font = gui.font()
ImportedLib = importLib("fileUtility.lua")

if fileExists("hivewinstreak.txt") == false then
    winstreak = 0
    writeFile("hivewinstreak.txt", "0")
else
    winstreak = readWholeFile("hivewinstreak.txt")
end

function setstreak(arg)
    winstreak = arg
    file = io.open("hivewinstreak.txt", 'w')
    file:write(arg)
    io.close(file)
end

hidetext = false
client.settings.addBool("Hide 'Winstreak: ' text", "hidetext")
showmsg = false
client.settings.addBool("Show message when winstreak is changed", "showmsg")
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
"Command List\n============================\n.resetstreak - reset your winstreak to 0\n.addstreak - add 1 winstreak\n.setstreak <arg> - set your winstreak to <arg>"
client.settings.addInfo("cmdinfo")
client.settings.addAir(10)
addstreakinfo = "You can use §b.addstreak§r, §b.resetstreak§r command for other games"
client.settings.addInfo("addstreakinfo")

team = "Unknown"

function onChat(msg, user, type)
    local ip = server.ip()
    if ip == "geo.hivebedrock.network" or ip == "jp.hivebedrock.network" or ip == "sg.hivebedrock.network" or ip == "fr.hivebedrock.network" or ip == "ca.hivebedrock.network" then
        if string.find(msg, "§rYou are on the ") and type == 2 then
            teamcolor = msg:sub(30, 30)
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
        if (string.find(msg, team .. " Team §7has been §cELIMINATED§7!") or string.find(msg, team .. " was ELIMINATED!")) and type == 2 then
            setstreak(0)
            if showmsg == true then
                print("§l§" ..
                    teamcolor .. "» §r§" .. teamcolor .. "You §ghave been eliminated! Your killstreak has been reset.")
            end
        end
        if string.find(msg, team .. " Team are the WINNERS!") and type == 2 then
            setstreak(winstreak + 1)
            if showmsg == true then
                print("§l§" ..
                    teamcolor ..
                    "» §r§" ..
                    teamcolor .. "You §gare the winner! Your killstreak is §" .. teamcolor .. winstreak .. " §gnow!")
            end
        end
    end
end

event.listen("ChatMessageAdded", onChat)

function render(dt)
    if hidetext == true then
        text = tostring(winstreak)
    else
        text = "Winstreak: " .. tostring(winstreak)
    end
    width = font.width(text) + 7
    height = font.height + 7
    sizeX = width
    sizeY = height
    gfx.color(bgcolor.value.r, bgcolor.value.g, bgcolor.value.b, bgcolor.value.a)
    gfx.rect(0, 0, width, height)
    gfx.color(textcolor.value.r, textcolor.value.g, textcolor.value.b, textcolor.value.a)
    gfx.text(width / 2 - width / 2 + 4 + xoffset, 11 - height / 2 + yoffset, text, 1)
end

registerCommand("resetstreak", function()
    setstreak(0)
    print("Winstreak has been reset")
end)

registerCommand("addstreak", function()
    setstreak(winstreak + 1)
    print("Winstreak added")
end)

registerCommand("setstreak", function(arg)
    if tonumber(arg) then
        setstreak(arg)
        print("Winstreak changed to " .. arg)
    else
        print(arg .. " is not number!")
    end
end)
