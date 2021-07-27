name = "Arrow Counter"
description = "gives the amout of arrow"

--[[
    Arrow Counter Module Script
	
	made by MCBE Craft
	improvement by Onix86
]]

positionX = 90
positionY = 20
size = 1
imagePath = "arrow.png"
bowOnly = true   --crossbows too, will be invisible if you don't hold one

bowId = 300
crossbowId = 575

function update(deltaTime)
    
end


function render(deltaTime)
    local inventory = player.inventory()
    local arrowCount = 0
    local selected = inventory.at(inventory.selected)
    if (bowOnly == false or (selected ~= nil and (selected.id == bowId or selected.id == crossbowId))) then
        for i=1,inventory.size do
            local slot = inventory.at(i)
            if (slot ~= nil and slot.id == 301) then
                arrowCount = arrowCount + slot.count
            end
        end
	if (inventory.offhand() ~= nil and inventory.offhand().id == 301) then
            arrowCount = arrowCount + inventory.offhand().count
        end
    
        local font = gui.font()
        local text = " Arrow Count: " .. arrowCount

        gfx.color(0,0,0,120)
        gfx.rect(positionX, positionY, size*1.2*font.width(text), size*10)

        gfx.color(255, 255, 255)
        
        gfx.text(positionX+10, positionY + 2, text, size)
        gfx.image(positionX, positionY, size*10, size*10, imagePath)
    end
end
