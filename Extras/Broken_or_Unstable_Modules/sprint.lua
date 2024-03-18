name = "Toggle Sprint Indicator"
description = "customizable toggle sprint"

--[[
    made by MCBE Craft
]]
importLib("module.lua")
importLib("chroma.lua")


word = "Baldness"
not_toggled_text = "[" .. word .. ": (Disabled)]"
toggled_text = "[" .. word .. ": (Enabled)]"

positionX = 100
positionY = 100
sizeX = 100
sizeY = 100
local toggleSprintMod

function update(deltaTime)
    local font = gui.font()
    sizeX = font.width(not_toggled_text) + 2
    sizeY = font.wrap + 1
    toggleSprintMod = getModule("Toggle Sprint/Sneak", false)
end


function render(deltaTime)
    local text
    if toggleSprintMod.enabled and getSetting(toggleSprintMod, "alwaysSprint").value or getSetting(toggleSprintMod, "ToggleSprint").value then
        text = toggled_text
    else
        text = not_toggled_text
    end
    chromaControlerMod = getModule("Chroma Controller", true)
    chromaText(1, 1, text)
end