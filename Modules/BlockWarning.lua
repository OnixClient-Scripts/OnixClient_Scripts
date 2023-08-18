name = "Block Warning"
description = "Displays a warning when you are low on blocks"

positionX = 50
positionY = 50
sizeX = 24
sizeY = 24

client.settings.addTitle("Warning Settings")
client.settings.addAir(5)
client.settings.addInfo("The warning will be triggered when you have the specified amount of blocks left")
warning = client.settings.addNamelessInt("Blocks Left:", 1, 64, 10)

function render(dt)
    local inventory = player.inventory()
    local slot = inventory.selected
    local item = inventory.at(slot)
    
    if item ~= nil then
        local count = item.count
        local itemtype = item.name
        
        if string.find(itemtype, "wool") then
            if count <= warning.value then
                gfx.color(255, 18, 18)
                gfx.text(0, 0, "⚠", 3)
            end
        end
    end
end
