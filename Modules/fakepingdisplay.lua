name = "Fake ping display"
description = "Show random number instead of ping"

--[[
    Fake ping display Module Script

    made by Quoty0
]]

positionX = 50
positionY = 25
sizeX = 40
sizeY = 10
scale = 1

min = 50
max = 80
TextColor = {255,255,255,255}
BackColor = {0,0,0,128}
client.settings.addInt("Minimum ping", "min", 0, 500)
client.settings.addInt("Maximum number", "max", 0, 500)
client.settings.addColor("Text Color", "TextColor")
client.settings.addColor("Background Color", "BackColor")

math.randomseed(os.time())
time = os.date("%S")
text = math.random(50, 70) .. " ms"



function render(deltaTime)
    if time ~= os.date("%S") then
        text = math.random(min, max) .. " ms"
        time = os.date("%S")
    end

    local font = gui.font()
    gfx.color(BackColor.r,BackColor.g,BackColor.b,BackColor.a)
    gfx.rect(0, 0, 40, 10)
    gfx.color(TextColor.r,TextColor.g,TextColor.b,TextColor.a)
    gfx.text(9, 2, text)
end 
