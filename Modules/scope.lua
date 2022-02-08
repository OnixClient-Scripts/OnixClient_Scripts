name = "scope"
description = "adds a scope do bows and crossbows"

--[[
    Scope Module Script
	
	made by MCBE Craft

    !!! NEEDS A "scope.png" FILE IN THE DATA FOLDER !!!
]]


bowId = 300
crossbowId = 575

positionX = 0
positionY = 0
sizeImage = 50
sizeX = 0
sizeY = 0


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
        positionX = 0
        positionY = (height / 2) - (width / 2)
    else
        sizeImage = height
        positionX = (width / 2) - (height / 2)
        positionY = 0
    end
    
end

function render(deltaTime)
    local inventory = player.inventory()
    local selected = inventory.at(inventory.selected)
    if ((selected ~= nil and (selected.id == bowId or crossbows and selected.id == crossbowId))) then
        gfx.image(0, 0, sizeImage, sizeImage, "scope.png")
    end
end
