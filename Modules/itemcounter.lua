name = "PvP Valuable Item Counter"
description = "gives the amount of iron ingot, gold ingot, diamond, and emerald"

--[[
    Item Counter Module Script

        made by MCBE Craft
        edited by Quoty0
]]

positionX = 5
positionY = 210
sizeX = 35
sizeY = 55

ironPath = "textures/items/iron_ingot"
goldPath = "textures/items/gold_ingot"
diamondPath = "textures/items/diamond"
emeraldPath = "textures/items/emerald"

TextColor = { 255, 255, 255, 255 }
BackColor = { 0, 0, 0, 128 }
client.settings.addColor("Text Color", "TextColor")
client.settings.addColor("Background Color", "BackColor")

function update(deltaTime)

end

function render(deltaTime)
    local inventory = player.inventory()
    local ironCount = 0
    local goldCount = 0
    local diamondCount = 0
    local emeraldCount = 0
    local ironId = "iron_ingot"
    local goldId = "gold_ingot"
    local diamondId = "diamond"
    local emeraldId = "emerald"

    local selected = inventory.at(inventory.selected)

    if ((selected ~= nil)) then
        for i = 1, inventory.size do
            local slot = inventory.at(i)
            if (slot ~= nil) then
                if (slot.name == ironId) then
                    ironCount = ironCount + slot.count
                    itemLocation = slot.location
                elseif (slot.name == goldId) then
                    goldCount = goldCount + slot.count
                    itemLocation = slot.location
                elseif (slot.name == diamondId) then
                    diamondCount = diamondCount + slot.count
                    itemLocation = slot.location
                elseif (slot.name == emeraldId) then
                    emeraldCount = emeraldCount + slot.count
                    itemLocation = slot.location
                end
            end
        end

        if (itemLocation ~= "") then
            local font = gui.font()

            gfx.color(BackColor.r, BackColor.g, BackColor.b, BackColor.a)
            gfx.rect(0, 0, 0, 10)

            gfx.color(TextColor.r, TextColor.g, TextColor.b, TextColor.a)
            gfx.text(14, 6 - (font.height / 2), ironCount, 1)
            gfx.texture(0, 0, 12, 12, ironPath)

            gfx.color(TextColor.r, TextColor.g, TextColor.b, TextColor.a)
            gfx.text(14, 20 - (font.height / 2), goldCount, 1)
            gfx.texture(0, 18 - (font.height / 2), 12, 12, goldPath)

            gfx.color(TextColor.r, TextColor.g, TextColor.b, TextColor.a)
            gfx.text(14, 34 - (font.height / 2), diamondCount, 1)
            gfx.texture(0, 32 - (font.height / 2), 12, 12, diamondPath)

            gfx.color(TextColor.r, TextColor.g, TextColor.b, TextColor.a)
            gfx.text(14, 48 - (font.height / 2), emeraldCount, 1)
            gfx.texture(0, 46 - (font.height / 2), 12, 12, emeraldPath)
        end
    end
end
