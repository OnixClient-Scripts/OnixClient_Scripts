name = "scope"
description = "adds a scope do bows and crossbows"

--[[
    Scope Module Script
	
	made by MCBE Craft
]]

--!!! NEEDS A "scope.png" FILE IN THE DATA FOLDER !!!
bowId = "bow"
crossbowId = "crossbow"
arrowId = 301

function render(deltaTime)
    local inventory = player.inventory()
    local selected = inventory.at(inventory.selected)
    if ((selected ~= nil and (selected.name == bowId or selected.name == crossbowId))) then
        gfx.image(0, 0, gui.width(), gui.height(), "scope.png")
    end
end
