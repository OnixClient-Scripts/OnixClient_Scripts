name = "Armor Display"
description = "Displays armor items beside the hotbar"

showDurability = client.settings.addNamelessBool("Show Durability", true)
showSlot = client.settings.addNamelessBool("Show Slot Icon", true)

function getHotbarBounds()

    local screenSafeArea = gui.screenSafe()

    local scaledWidth = gui.width()
    local scaledHeight = gui.height()

    local hotbarBaseWidth = 183
    local hotbarBaseHeight = 24

    local hotbarScaledX = (scaledWidth - hotbarBaseWidth) / 2

    local safeAreaScale = (1 - screenSafeArea)
    local scaledSafeAreaOffsetY = scaledHeight * safeAreaScale
    local hotbarScaledY = scaledHeight - hotbarBaseHeight - (scaledSafeAreaOffsetY * 0.5)

    local hotbarX = hotbarScaledX
    local hotbarY = hotbarScaledY - (18)
    local hotbarWidth = hotbarBaseWidth
    local hotbarHeight = (hotbarBaseHeight - 1) + (18)
    return hotbarX, hotbarY, hotbarWidth, hotbarHeight

end


function getHotbarPosition()

    screenWidth = gui.width()
    screenHeight = gui.height()

    local hx, hy, hw, hh = getHotbarBounds()
    local hotbarCenterX = screenWidth / 2
    local hotbarY = (hy + hh) - 22


    return hotbarCenterX, hotbarY
end
function slot(x, y, item, isLeft, isRight)
    if isLeft == nil then isLeft = false end
    if isRight == nil then isRight = false end
    local hotbarX, hotbarY = getHotbarPosition()
    local slotX, slotY = hotbarX + x, hotbarY - y
    if showSlot.value then
        gfx.texture(slotX, slotY, 20, 22,"textures/ui/hotbar_1")
        if isLeft then gfx.texture(slotX - 1, slotY, 1, 22, "textures/ui/hotbar_end_cap") end
        if isRight then gfx.texture(slotX + 20, slotY, 1, 22, "textures/ui/hotbar_end_cap") end
    end
    local itemX, itemY = slotX + 1.8, slotY + 3
    if item then gfx.item(itemX, itemY, item.location, 1, showDurability.value) end
end



function render(dt)
    local armor = player.inventory().armor()
    if not armor then return end

    slot(-133, 0.6, armor.helmet, true)

    slot(-113, 0.6, armor.chestplate, false, true)

    slot(93, 0.6, armor.leggings, true)

    slot(113, 0.6, armor.boots, false, true)
end