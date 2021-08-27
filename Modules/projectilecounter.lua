name = "Projectile Counter"
description = "gives the amout of Projectiles"

hide = false

positionX = 0
positionY = 490
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

hide = false

snowballId = 372
eggId = 388
texturePath = "textures/items/snowball"

function update(deltaTime)

end


function render(deltaTime)
    if(hide == false) then
        local inventory = player.inventory()
        local snowballCount = 0
        local eggCount = 0
        local selected = inventory.at(inventory.selected)
        local itemLocation = ""
        if (hide == false) then
            for i=1,inventory.size do
                local slot = inventory.at(i)
                if (slot ~= nil and slot.id == snowballId) then
                    snowballCount = snowballCount + slot.count
                    itemLocation = slot.location
                else if (slot ~= nil and slot.id == eggId) then
                    eggCount = eggCount + slot.count
                    itemLocation = slot.location
                end
                end
            end
        end

    local offhand = inventory.offhand()
    if (offhand ~= nil and offhand.id == snowballId) then
        snowballCount = snowballCount + offhand.count
        itemLocation = offhand.location
    else if (offhand ~= nil and offhand.id == eggId) then
        eggCount = eggCount + offhand.count
        itemLocation = offhand.location
    end
    end

    if (itemLocation ~= "" or hide == false) then
        local font = gui.font()
        local text = " Projectiles: " .. snowballCount + eggCount

        gfx.color(Background_Color_R,Background_Color_G,Background_Color_B,Background_Color_A)
        sizeX = 14 + font.width(text)
        gfx.rect(0, 0, sizeX, 10)

        gfx.color(Text_Color_R, Text_Color_G, Text_Color_B, Text_Color_A)
        gfx.text(12, 5 - (font.height / 2), text, 1)
        gfx.texture(0, 0, 10, 10, texturePath, Text_Color_A)
    end
end
end