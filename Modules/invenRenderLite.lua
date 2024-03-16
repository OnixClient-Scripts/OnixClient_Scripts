name = "Inventory Display Lite"
description = "Renders a custom inventory module!"

--[[
    without bloat, helix
]]

client.settings.addAir(8)
Lock = true
client.settings.addBool("Lock the position of the module?", "Lock")

client.settings.addAir(8)
bgColor = client.settings.addNamelessColor('Background Color?', { 0, 0, 0, 50 })

inventory = player.inventory()
invenRender = {}
slot = 0

positionX, positionY = gui.width() / 2 - 88, -13
sizeX, sizeY, scale = 176, 60, 1

function slotRender()
    local originX, originY = 8, 17
    local columnCurrent = math.floor(slot % 9)
    local rowCurrent = (math.floor(slot / 9))
    originY = rowCurrent * 18
    if columnCurrent == 0 then
        columnCurrent = 9
        originY = originY - 18
    end
    originX = originX + 18 * columnCurrent - 18
    originY = originY - 13
    gfx.item(originX, originY, slot - 1, scale, true)
end

function render(dt)
    scale = 1            --scale never changes
    if Lock == true then --Locks to the top center (if u resize a lot)
        positionX, positionY = gui.width() / 2 - 88, -4
    end
    gfx.color(bgColor.value.r, bgColor.value.g, bgColor.value.b, bgColor.value.a)
    gfx.roundRect(0, 0, sizeX, sizeY, 5, 10)

    if inventory ~= nil then
        for slotloop = 10, 36 do
            local item = inventory.at(slotloop)
            if item ~= nil then
                slot = slotloop
                slotRender()
            end
        end
    end
end

--yo waddup
