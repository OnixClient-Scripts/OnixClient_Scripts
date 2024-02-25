name="Map Labeler"
description="Labels Maps in game with their names"

--[[
    made by jackhirsh
]]

positionX = 35
positionY = 120
sizeX = 10
sizeY = 10
textColorSetting = client.settings.addNamelessColor("Text Color", {0, 0, 0})
backgroundColorSetting = client.settings.addNamelessColor("Background Color", {255, 255, 255, 128})

function render(timeSinceUpdate)
    inventory = player.inventory()
    offHandItem = inventory.offhand()
    offHandName = offHandItem.name
end

function render2(timeSinceUpdate)
    if (offHandName == "filled_map") then
        local maxTextWidth = gfx2.textSize(offHandItem.displayName)
        gfx2.color(backgroundColorSetting)
        sizeX = maxTextWidth * 1.2
        gfx2.fillRoundRect(0, 0, sizeX, sizeY, 2)
        gfx2.color(textColorSetting)
        gfx2.text(sizeX/10, 1, offHandItem.displayName)
    end
end
