name = "Totem Counter"
description = name

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
gapPath = "textures/items/golden_apple"

TextColor = { 255, 255, 255, 255 }
texts = client.settings.addNamelessFloat("Text Size", 0.1, 10, 0.3)


function update(deltaTime)

end

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
            if offhand == "totem_of_undying" then
                totemCount = totemCount + 1
            end
        end
    end
end
    if (itemLocation ~= "") then
        gui.font()
        gfx.texture(0, 0, 12, 12, totemPath)
        gfx.text(5, 6, totemCount, texts.value)
    end
end
