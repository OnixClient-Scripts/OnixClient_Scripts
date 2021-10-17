name = "guiscale"
description = "change guiscale"


--[[
    Guiscale Module Script
    
    made by MCBE Craft
]]

client.execute("guiscale 1")
scale = 1.0
currentscale = 1.0

client.settings.addFloat("Gui scale", "scale", 0.250, 20.0)

function update()
    if scale ~= currentscale then
        client.execute("guiscale " .. scale)
        currentscale = scale
    end
end

function render()
    
end
