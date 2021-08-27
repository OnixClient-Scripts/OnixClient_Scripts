name = "Arrow Counter"
description = "gives the amout of arrow"

hide = false

positionX = 0
positionY = 480
sizeX = 30
sizeY = 10

Background_Color_R = 0
Background_Color_G = 0
Background_Color_B = 0
Background_Color_A = 0

Text_Color_R = 255
Text_Color_G = 255
Text_Color_B = 255
Text_Color_A = 255

bowOnly = false

bowId = 300
crossbowId = 565
arrowId = 301
texturePath = "textures/items/arrow"

function update(deltaTime)

end


function render(deltaTime)
    if(hide == false) then
        local inventory = player.inventory()
        local arrowCount = 0
        local selected = inventory.at(inventory.selected)
        local itemLocation = ""
        if (bowOnly == false or (selected ~= nil and (selected.id == bowId or selected.id == crossbowId))) then
            for i=1,inventory.size do
                local slot = inventory.at(i)
                if (slot ~= nil and slot.id == arrowId) then
                    arrowCount = arrowCount + slot.count
                    itemLocation = slot.location
                end
            end
            local offhand = inventory.offhand()
            if (offhand ~= nil and offhand.id == arrowId) then
                arrowCount = arrowCount + offhand.count
                itemLocation = offhand.location
            end

            if (itemLocation ~= "" or bowOnly == false) then
                local font = gui.font()
                local text = " Arrows: " .. arrowCount

                gfx.color(Background_Color_R,Background_Color_G,Background_Color_B,Background_Color_A)
                sizeX = 14 + font.width(text)
                gfx.rect(0, 0, sizeX, 10)

                gfx.color(Text_Color_R, Text_Color_G, Text_Color_B, Text_Color_A)
                gfx.text(12, 5 - (font.height / 2), text, 1)
                gfx.texture(0, 0, 10, 10, texturePath, Text_Color_A)
            end
        end
    end
end
