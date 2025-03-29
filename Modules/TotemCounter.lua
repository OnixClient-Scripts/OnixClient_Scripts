name = "Totem Counter"
description = "A simple TotemCounter script"

--[[
    Totem counter script
    made by austriaa_
    thanks to MCBE Craft for the resource counter
]]

positionX = 5
positionY = 210
sizeX = 12
sizeY = 12

totemPath = "textures/items/totem"

texts = client.settings.addNamelessFloat("Text Size", 0.1, 10, 0.50)
textc = client.settings.addNamelessColor("Text color", { 255, 255, 255, 255 })
bgc = client.settings.addNamelessColor("Background color", { 0, 0, 0, 127 })
function render()
    local inventory = player.inventory()
    local offhand = player.inventory().offhand()
    local totemCount = 0
    local totemId = "totem_of_undying"

    local selected = inventory.at(inventory.selected)
    for i = 1, inventory.size do
        local slot = inventory.at(i)
        if (slot ~= nil) then
            if (slot.name == totemId) then
                totemCount = totemCount + slot.count
                itemLocation = slot.location
        end
    end
end
    if (itemLocation ~= "") then
        gfx.color(bgc)
        gfx.rect(0, 0, 12, 12)
        gfx.color(textc)
        gfx.texture(0, 0, 12, 12, totemPath)
        gfx.text(5, 6, totemCount, texts.value)
    end
end