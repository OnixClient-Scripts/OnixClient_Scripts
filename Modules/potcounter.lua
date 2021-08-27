name = "Pot Counter"
description = "gives the amount of healing pots"

healing = true
hide = false

positionX = 0
positionY = 470
sizeX = 30
if (healing == true) then
    sizeY = 20
else
    sizeY = 10
end

Background_Color_R = 0
Background_Color_G = 0
Background_Color_B = 0
Background_Color_A = 0

Text_Color_R = 255
Text_Color_G = 255
Text_Color_B = 255
Text_Color_A = 255

potionId = 551
effectId = 10
texturePath = "textures/items/potion_bottle_splash_heal"

function update(deltaTime)

end


function render(deltaTime)
    if(hide == false) then
        local inventory = player.inventory()
        local potCount = 0
        local potCountOne = 0
        local potCountTwo = 0
        for i=1,inventory.size do
            local slot = inventory.at(i)
            if (slot ~= nil and slot.id == potionId) then
                if (slot.data == 21) then
                    potCountOne = potCountOne + slot.count
                elseif (slot.data == 22) then
                    potCountTwo = potCountTwo + slot.count
                end
                itemLocation = slot.location
            end
        end

    local offhand = inventory.offhand()
    if (offhand ~= nil and offhand.id == potionId) then
        if (offhand.data == 21) then
            potCountOne = potCountOne + offhand.count
        elseif (offhand.data == 22) then
            potCountTwo = potCountTwo + offhand.count
        end
    end

    local font = gui.font()
    local text =" Pots: " .. potCountOne + potCountTwo .. " [" ..  4 * potCountOne + 8 * potCountTwo .. "]"

    gfx.color(Background_Color_R,Background_Color_G,Background_Color_B,Background_Color_A)
        sizeX = 14 + font.width(text)
        gfx.rect(0, 0, sizeX, sizeY)
        gfx.color(Text_Color_R, Text_Color_G, Text_Color_B, Text_Color_A)

    gfx.texture(0, 0, 10, 10, texturePath, Text_Color_A)
    gfx.text(12, 5 - (font.height / 2), text, 1)
end
end