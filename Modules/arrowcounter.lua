name = "Arrow Counter"
description = "gives the amout of arrow"

--[[
    Arrow Counter Module Script
	
	made by MCBE Craft
]]

positionX = 5
positionY = 210
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
    local itemLocation = ""
    if (bowOnly == false or (selected ~= nil and (selected.id == bowId or selected.id == crossbowId))) then
        for i=1,inventory.size do
            local slot = inventory.at(i)
            if (slot ~= nil and slot.id == 301) then
                arrowCount = arrowCount + slot.count
                itemLocation = slot.location
            end
        end
        if (inventory.offhand() ~= nil and inventory.offhand().id == 301) then
            arrowCount = arrowCount + inventory.offhand().count
            itemLocation = inventory.offhand().location
        end
        if (itemLocation ~= "") then
            local font = gui.font()
            local text = " Arrow Count: " .. arrowCount

            gfx.color(0,0,0,0)
            gfx.rect(positionX, positionY, 12 + font.width(text), 10)

            gfx.color(255, 0, 0)

            gfx.text(positionX + 17, positionY + 3, text, 1)
            gfx.item(positionX, positionY - 3, itemLocation)
        end
        
    end
end
