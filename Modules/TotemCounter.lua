name = "Totem Counter"
description = "Counts how many totems you have in your inventory."

--[[
    Totem counter script
    made by austriaa_
    thanks to MCBE Craft for the resource counter
    thanks to jqms for the offhand support and adding the other mode
]]

positionX = 5
positionY = 210
sizeX = 12
sizeY = 12

totemPath = "textures/items/totem"
client.settings.addTitle("Totem Counter Settings")
textc = client.settings.addNamelessColor("Text Color", { 255, 255, 255, 255 })
bgc = client.settings.addNamelessColor("Background Color", { 0, 0, 0, 127 })
insideforsomereason = client.settings.addNamelessBool("Text inside the totem image", false)
texts = client.settings.addNamelessFloat("Text Scale", 0.1, 2, 0.5)
color = client.settings.addNamelessBool("Color text according to count", false)

function render3d()
    texts.visible = insideforsomereason.value
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
            end
        end
    end
    if offhand and offhand.name == totemId then
        totemCount = totemCount + offhand.count
        itemLocation = offhand.location
    end
    if (itemLocation ~= "") then
        if insideforsomereason.value then
            gfx.color(bgc)
            gfx.rect(0, 0, 12, 12)
            gfx.color(textc)
            if color.value and totemCount <= 3 then
                gfx.color(255, 85, 85)
            elseif color.value and (totemCount == 4 or totemCount == 5) then
                gfx.color(255, 170, 0)
            elseif color.value and totemCount >= 6 then
                gfx.color(85, 255, 85)
            end
            gfx.texture(0, 0, 12, 12, totemPath)
            gfx.text(5, 6, tostring(totemCount), texts.value)
        else
            local txt = tostring(totemCount)
            local txtscale = 1.15
            local txtWidth = gui.font().width(txt, txtscale)
            gfx.color(bgc)
            gfx.rect(0, 0, 14 + txtWidth, 12.5)
            gfx.texture(0, 0, 12, 12, totemPath)
            gfx.color(textc)
            if color.value and totemCount <= 3 then
                gfx.color(255, 85, 85)
            elseif color.value and (totemCount == 4 or totemCount == 5) then
                gfx.color(255, 170, 0)
            elseif color.value and totemCount >= 6 then
                gfx.color(85, 255, 85)
            end

            gfx.text(12 + 2, 2, txt, txtscale)
        end
    end
    if insideforsomereason.value then
        sizeX = 12
        sizeY = 12
    else
        sizeX = 14 + gui.font().width(tostring(totemCount), 1.15)
        sizeY = 12.5
    end
end

