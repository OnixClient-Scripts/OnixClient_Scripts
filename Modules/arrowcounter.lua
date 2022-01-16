name = "Arrow Counter"
description = "gives the amout of arrow"

--[[
    Arrow Counter Module Script
	
	made by MCBE Craft
	improvements by Onix86
    improvements by Onix86 (again)
]]

positionX = 5
positionY = 210
sizeX = 30
sizeY = 10

Background_Color = {0,0,0,128}
Text_Color = {255, 255, 255, 255}
bowOnly = true 

client.settings.addBool("Bow & Crossbow Only", "bowOnly")
client.settings.addColor("Text Color", "Text_Color")
client.settings.addColor("Background Color", "Background_Color")


bowId = "bow"
crossbowId = "crossbow"
arrowId = "arrow"
texturePath = "textures/items/arrow"


function render(deltaTime)
    local inventory = player.inventory()
    local arrowCount = 0
    local selected = inventory.at(inventory.selected)
    local itemLocation = ""
    if (bowOnly == false or (selected ~= nil and (selected.name == bowId or selected.name == crossbowId))) then
        for i=1,inventory.size do
            local slot = inventory.at(i)
            if (slot ~= nil and string.match(slot.name, arrowId) ~= nil) then
                arrowCount = arrowCount + slot.count
                itemLocation = slot.location
            end
        end
        local offhand = inventory.offhand()
        if (offhand ~= nil and string.match(offhand.name, arrowId) ~= nil) then
            arrowCount = arrowCount + offhand.count
            itemLocation = offhand.location
        end
        
        if (itemLocation ~= "" or bowOnly == false) then
            local font = gui.font()
            local text = " Arrow Count: " .. arrowCount

            gfx.color(Background_Color.r,Background_Color.g,Background_Color.b,Background_Color.a)
            sizeX = 14 + font.width(text)
            gfx.rect(0, 0, sizeX, 10)

            gfx.color(Text_Color.r, Text_Color.g, Text_Color.b, Text_Color.a)
            gfx.text(12, 5 - (font.height / 2), text, 1)
            gfx.texture(0, 0, 10, 10, texturePath, Text_Color.a)
        end
        
    end
end
