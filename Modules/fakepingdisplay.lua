name = "Fake ping display"
description = "Show random number instead of ping"

--[[
    Fake ping display Module Script

    made by Quoty0
]]

positionX = 50
positionY = 25
sizeX = 50
sizeY = 15
scale = 1

min = 50
max = 80
textColorR = 255
textColorG = 255
textColorB = 255
textColorA = 255
bgColorR = 0
bgColorG = 0
bgColorB = 0
bgColorA = 128
client.settings.addInt("Minimum ping", "min", 0, 500)
client.settings.addInt("Maximum number", "max", 0, 500)
client.settings.addAir(5)
client.settings.addInt("Text Color R", "textColorR", 0, 255)
client.settings.addInt("Text Color G", "textColorG", 0, 255)
client.settings.addInt("Text Color B", "textColorB", 0, 255)
client.settings.addInt("Text Color A", "textColorA", 0, 255)
client.settings.addAir(5)
client.settings.addInt("Background Color R", "bgColorR", 0, 255)
client.settings.addInt("Background Color G", "bgColorG", 0, 255)
client.settings.addInt("Background Color B", "bgColorB", 0, 255)
client.settings.addInt("Background Color A", "bgColorA", 0, 255)

math.randomseed(os.time())
time = os.date("%S")
text = math.random(50, 70) .. " ms"



function render(dt)
    local font = gui.font()

    if time ~= os.date("%S") then
        text = math.random(min, max) .. " ms"
        time = os.date("%S")
    end

    local font = gui.font()
    textWidth = font.width(text, 1)
    gfx.color(bgColorR,bgColorG,bgColorB,bgColorA)
    gfx.rect(0, 0, 50, 15)
    gfx.color(textColorR,textColorG,textColorB,textColorA)
    gfx.text(25-textWidth/2, 3.5, text, 1)
end 
