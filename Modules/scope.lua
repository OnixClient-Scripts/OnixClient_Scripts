name = "scope"
description = "adds a scope do bows and crossbows"

--[[
    Scope Module Script
	
	made by MCBE Craft
]]

--!!! NEEDS A "scope.png" FILE IN THE DATA FOLDER !!!

posX = 5
posY = 210
scale = 500

bowId = 300
crossbowId = 575
arrowId = 301

function update(deltaTime)
    scale = gui.width()
    posX = gui.width() / 2 - scale / 2
    posY = gui.height() / 2 - scale / 2
end


function render(deltaTime)
    local inventory = player.inventory()
    local selected = inventory.at(inventory.selected)
    if ((selected ~= nil and (selected.id == bowId or selected.id == crossbowId))) then
        gfx.image(posX, posY, scale, scale, "scope.png")
        
    end
end
