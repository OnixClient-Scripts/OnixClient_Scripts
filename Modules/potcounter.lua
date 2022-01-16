name = "Potion Counter"
description = "Gives the amout of healing pots"

--[[
    Pot Counter Module Script
	
	made by MCBE Craft
	improvement by Onix86
]]

healing = true

positionX = 90
positionY = 10
sizeX = 30
sizeY = 20

TextColor = {255,255,255,255}
BackgroundColor = {0,0,0,128}

client.settings.addBool("Show Healing Hearts", "healing")
client.settings.addColor("Text Color", "TextColor")
client.settings.addColor("Background Color", "BackgroundColor")

potionId = "splash_potion"
effectId = 10
texturePath = "textures/items/potion_bottle_splash_heal"

function update(deltaTime)

end


function render(deltaTime)
    if (healing == true) then
        sizeY = 20
    else
        sizeY = 10
    end

    local inventory = player.inventory()
    local potCount = 0
    local potCountOne = 0
    local potCountTwo = 0
    for i=1,inventory.size do
        local slot = inventory.at(i)
        if (slot ~= nil and slot.name == potionId) then
            if (slot.data == 21) then
                potCountOne = potCountOne + slot.count
            elseif (slot.data == 22) then
                potCountTwo = potCountTwo + slot.count
            end
            itemLocation = slot.location
        end
    end

    local offhand = inventory.offhand()
    if (offhand ~= nil and offhand.name == potionId) then
        if (offhand.data == 21) then
            potCountOne = potCountOne + offhand.count
        elseif (offhand.data == 22) then
            potCountTwo = potCountTwo + offhand.count
        end
    end
    
    local font = gui.font()
    local text = " Pot Count: " .. potCountOne + potCountTwo
    local textTwo = " Total Regen: " .. 4 * potCountOne + 8 * potCountTwo

    gfx.color(BackgroundColor.r,BackgroundColor.g,BackgroundColor.b,BackgroundColor.a)
    if (healing == true) then
        sizeX = 14 + font.width(textTwo)
        gfx.rect(0, 0, sizeX, sizeY)
        gfx.color(TextColor.r,TextColor.g,TextColor.b,TextColor.a)
        gfx.text(12, 15 - (font.height / 2), textTwo, 1)
        gfx.effect(0, 10, 10, 10, effectId, TextColor.a)
    else
        sizeX = 14 + font.width(text)
        gfx.rect(0, 0, sizeX, sizeY)
        gfx.color(TextColor.r,TextColor.g,TextColor.b,TextColor.a)
    end    
    gfx.texture(0, 0, 10, 10, texturePath, TextColor.a)
    gfx.text(12, 5 - (font.height / 2), text, 1)
end
