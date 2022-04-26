name = "Motion blur"
description = "Blur your motion! \nMade by hmmm#9008"
isVisual = true
isvisibleingui = true

Oppacity = 255
client.settings.addInt("Blur oppacity", "Oppacity", 0, 255)

local lastRot

function render(deltaTime)
    if (player.rotation() ~= lastRot) then
        BlurScreen()
    end

    lastRot = player.rotation()
end

function BlurScreen()
    gfx.color(0, 0, 0, Oppacity)
    gfx.drawRect(0, 0, 1000, 1000, 1000)
    gfx.color(255, 255, 255)
    gfx.text(150, 100, "Blur", 20)
end