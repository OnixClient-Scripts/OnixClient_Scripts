name = "scope"
description = "adds a scope do bows and crossbows"

--[[
    Scope Module Script
	
	made by MCBE Craft

    !!! NEEDS A "scope.png" FILE IN THE DATA FOLDER !!!
]]


bowId = 300
crossbowId = 575

posX = 0
posY = 0
sizeImage = 50


sizeHeight = false
client.settings.addAir(5)
client.settings.addBool("Make the scope render across the width", "sizeHeight")


crossbows = true
client.settings.addAir(5)
client.settings.addBool("Adds the scope to crossbows too", "crossbows")




function update(deltaTime)
    local width = gui.width()
    local height = gui.height()
    if sizeHeight then
        sizeImage = width
        posX = 0
        posY = (height / 2) - (width / 2)
    else
        sizeImage = height
        posX = (width / 2) - (height / 2)
        posY = 0
    end
    
end

function render(deltaTime)
    local inventory = player.inventory()
    local selected = inventory.at(inventory.selected)
    if ((selected ~= nil and (selected.id == bowId or crossbows and selected.id == crossbowId))) then
        gfx.image(posX, posY, sizeImage, sizeImage, "scope.png")
    end
end
