name="Booster Timer"
description = "Shows how long you have left on your boost. The command is .boosterinfo"

positionX = 0
positionY = 0
sizeX = 150
sizeY = 10

showTime = false
client.settings.addBool("Display Time Remaining On HUD", "showTime")
textColour = client.settings.addNamelessColor("Text Colour", {255,255,255,100})

timeLeft = 0
boosterEnded = false
boosterStarted = 0
booster = false

function render2(dt)
    gfx2.color(textColour)
    if showTime == true and boosterStarted ~= 0 then
        gfx2.text(1,1, "You have " .. timeLeft .. " minutes remaining on your booster.")
    end
end
function update()
    if booster == true then
        boosterStarted = os.time()
        booster = false
    end
    if (os.time() == (boosterStarted + 3660)) and boosterEnded == false then
        boosterEnded = true
        print("§6[§e!§6] §aYour booster has ended.")
    end
    if boosterStarted ~= 0 then
        timeLeft = math.floor((3660 - (os.time() - boosterStarted))/60)
    end
end
function boosterFunc()
    print("§c§l»§r §a§oYou have §r§2" .. timeLeft .. " minutes §r§a§oremaining on your booster.")
end
registerCommand("boosterinfo", boosterFunc)

event.listen("ChatMessageAdded", function(message, username, type, xuid)
    if string.find(message, "§3Booster Activated! §fIt expires in 60 minutes.") then
        booster = true
    end
end)