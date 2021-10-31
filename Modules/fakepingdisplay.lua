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
client.settings.addInt("Minimum ping", "min", 0, 500)
client.settings.addInt("Maximum number", "max", 0, 500)

math.randomseed(os.time())
time = os.date("%S")
text = math.random(50, 70) .. " ms"

function update(deltaTime)

end


function render(deltaTime)
    if time ~= os.date("%S") then
        text = math.random(min, max) .. " ms"
        time = os.date("%S")
    end

    local font = gui.font()
    gfx.color(0, 0, 0, 180)
    gfx.rect(0, 0, 40, 10)
    gfx.color(255, 255, 255, 255)
    gfx.text(9, 2, text)
end 
