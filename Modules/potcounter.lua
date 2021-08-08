name = "Pot Counter"
description = "gives the amout of healing pots"

--[[
    Pot Counter Module Script
	
	made by MCBE Craft
	improvement by Onix86
]]

positionX = 90
positionY = 10
size = 1

function update(deltaTime)
    
end


function render(deltaTime)
    local inventory = player.inventory()
    local potCount = 0
    for i=1,inventory.size do
        local slot = inventory.at(i)
        if (slot ~= nil and slot.id == 551) then
            potCount = potCount + slot.count
        end
    end
    local font = gui.font()
    local text = " Pot Count: " .. potCount

    gfx.color(0,0,0,120)
    gfx.rect(positionX, positionY, size*1.3*font.width(text), size*10)

    gfx.color(255, 255, 255)
    
    gfx.text(positionX+10, positionY + 2, text, size)
    gfx.texture(positionX, positionY, size*10, size*10, "textures/items/potion_bottle_splash_heal.png", 100)
end
