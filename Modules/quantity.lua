name = "Held Item Counter"
description = "Gives the amount of the selected item you have in your inventory"

--[[
    Quantity Module Script
	
	made by MCBE Craft
]]

positionX = 75
positionY = 300
sizeX = 30
sizeY = 16

client.settings.addAir(5)
backgroundColor = client.settings.addNamelessColor("Text color", { 0, 0, 0, 127 })

client.settings.addAir(5)
textColor = client.settings.addNamelessColor("Text color", { 254, 254, 254, 254 })


function render(deltaTime)
    if not gui.mouseGrabbed() then
        local inventory = player.inventory()
        local selectedPos = inventory.selected
        local selected = inventory.at(selectedPos)
        if (selected ~= nil) then
            local amount = selected.count
            for i = 1, inventory.size do
                local slot = inventory.at(i)
                if (slot ~= nil and slot.id == selected.id and slot.location ~= selected.location) then
                    amount = amount + slot.count
                end
            end

            local offhand = inventory.offhand()
            if (offhand ~= nil and offhand.id == selected.id) then
                amount = amount + offhand.count
            end

            if (selected.count ~= amount) then
                local font = gui.font()
                local text = selected.name .. ": " .. amount
                sizeX = font.width(text) + 17
                gfx.color(backgroundColor.value.r, backgroundColor.value.g, backgroundColor.value.b, backgroundColor.value.a)
                gfx.rect(0, 0, sizeX, sizeY)
                gfx.color(textColor.value.r, textColor.value.g, textColor.value.b, textColor.value.a)
                gfx.item(0, 0, selected.location, 1)
                gfx.text(17, 4, text)
            end
        end
    end
end
