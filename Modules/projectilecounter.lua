name = "Projectile Counter"
description = "gives the amout of Projectiles"

--[[
    Projectile Counter Module Script
	
	made by MCBE Craft
	edited by Prathpro17
    improved by Onix86
]]


positionX = 0
positionY = 490
sizeX = 30
sizeY = 10

TextColor = {255,255,255,255}
BackgroundColor = {0,0,0,128}

client.settings.addColor("Text Color", "TextColor")
client.settings.addColor("Background Color", "BackgroundColor")

snowballId = "snowball"
eggId = "egg"
textureSnowballPath = "textures/items/snowball"
textureEGGPath = "textures/items/egg"


function render(deltaTime)
    local inventory = player.inventory()
    local snowballCount = 0
    local eggCount = 0
    local selected = inventory.at(inventory.selected)
    local itemLocation = -1
    for i=1,inventory.size do
        local slot = inventory.at(i)
        if (slot ~= nil and slot.name == snowballId) then
            snowballCount = snowballCount + slot.count
            itemLocation = slot.location
        elseif (slot ~= nil and slot.name == eggId) then
            eggCount = eggCount + slot.count
            itemLocation = slot.location
        end
    end

    local offhand = inventory.offhand()
    if (offhand ~= nil and offhand.name == snowballId) then
        snowballCount = snowballCount + offhand.count
        itemLocation = offhand.location
    elseif (offhand ~= nil and offhand.name == eggId) then
        eggCount = eggCount + offhand.count
        itemLocation = offhand.location
    end

    if (itemLocation ~= -1) then
        local font = gui.font()
        local text = " Projectiles: " .. snowballCount + eggCount

        gfx.color(BackgroundColor.r,BackgroundColor.g,BackgroundColor.b,BackgroundColor.a)
        sizeX = 14 + font.width(text)
        gfx.rect(0, 0, sizeX, 10)

        gfx.color(TextColor.r,TextColor.g,TextColor.b,TextColor.a)
        gfx.text(12, 5 - (font.height / 2), text, 1)
        if snowballCount < eggCount then
            gfx.texture(0, 0, 10, 10, textureEGGPath)
        else
            gfx.texture(0, 0, 10, 10, textureSnowballPath)
        end
    end
end
