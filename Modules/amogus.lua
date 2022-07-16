--[[
    quite a sussy file

    Made by Plextora#0033 in like 5 mins
]]

name = "amogus"
description = "a lil amogus fren on your screen!"

susText = true

client.settings.addAir("5")
client.settings.addBool("Add text \"Sus\" next to the sussy boi?", "susText")

positionX = 100
positionY = 100
sizeX = 15
sizeY = 15

function render(dt)
    local font = gui.font()
    gfx.color(255, 0, 0)
    if susText then
        gfx.text(0, 0, "ඞ sus")
    end
    if susText == false then
        gfx.text(0, 0, "ඞ")
    end
end
