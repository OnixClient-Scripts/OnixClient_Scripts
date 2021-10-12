name = "screendarker"
description = "Make screen darker (make a black dimm on your screen)"

--[[
    ScreenDarker Module Script

    made by hugo
]]

darkStrength = 120

client.settings.addInt("Strength", "darkStrength", 1, 255)


function render(deltaTime)
    gfx.color(0,0,0,darkStrength)
    gfx.rect(0, 0, 1000, 1000)

end
