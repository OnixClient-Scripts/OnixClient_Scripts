name="Chroma Controller"
description="centralized chroma control module"

--[[
    By MCBE Craft
    HOW TO USE: this module is the base of chroma, make sure it is always enabled
    TO IMPLEMENT CHROMA INTO YOUR SCRIPTS: make sure you have `chroma.lua` and `charPixel.lua` and `module.lua` libraries, `importLib("chroma.lua")`
    You can then use the chromaText(x pos, y pos, text, opacity) and chromaTextList(x offset, y offset, table containing {x=x pos, y=y pos, text=text}, opacity) functions
    Check samples in `testChroma.lua` module
]]

hue_shift_speed = 5
client.settings.addFloat("Hue Shift Speed", "hue_shift_speed", 0.2, 35)

rainbow_speed = 300
client.settings.addFloat("Rainbow Update Speed", "rainbow_speed", 1, 500)

hue = 0
client.settings.addFloat("Current hue value", "hue", 0, 360)

pastel = false
client.settings.addBool("Use pastel Colors", "pastel")

pastelIntensity = 135
client.settings.addInt("Pastel intensity", "pastelIntensity", 0, 255)


function render(dt)
    hue = hue + dt * rainbow_speed
    if hue > 360 then hue = 0 end
    if hue < 0 then hue = 360 end
    client.settings.send()
end

