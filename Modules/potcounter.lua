name = "Pot Counter"
description = "gives the amout of healing pots"

--[[
    Pot Counter Module Script
	
	made by MCBE Craft
	improvement by Onix86
]]
positionX = 90
positionY = 10
sizeX = 30
sizeY = 10

Background_Color_R = 0
Background_Color_G = 0
Background_Color_B = 0
Background_Color_A = 127

Text_Color_R = 255
Text_Color_G = 0
Text_Color_B = 0
Text_Color_A = 255

potionId = 561
texturePath = "textures/items/potion_bottle_splash_heal"

function update(deltaTime)

end


function render(deltaTime)
    local inventory = player.inventory()
    local potCount = 0
    for i=1,inventory.size do
        local slot = inventory.at(i)
        if (slot ~= nil and slot.id == potionId) then
            potCount = potCount + slot.count
            itemLocation = slot.location
         end
    end

    local offhand = inventory.offhand()
    if (offhand ~= nil and offhand.id == potionId) then
        potCount = potCount + offhand.count
    end
        
    local font = gui.font()
    local text = " Pot Count: " .. potCount

    gfx.color(Background_Color_R,Background_Color_G,Background_Color_B,Background_Color_A)
    sizeX = 14 + font.width(text)
    gfx.rect(0, 0, sizeX, 10)

    gfx.color(Text_Color_R, Text_Color_G, Text_Color_B, Text_Color_A)
    gfx.text(12, 5 - (font.height / 2), text, 1)
    gfx.texture(0, 0, 10, 10, texturePath, Text_Color_A)
end
