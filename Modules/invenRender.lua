name = "Inventory Display"
description = "Renders a custom inventory module!"

--made by: helix(has_no_hair)

client.settings.addAir(8)
Lock = false
client.settings.addBool("Lock the position of the module?", "Lock")

client.settings.addAir(8)
bgColor = {0, 0, 0, 50}
client.settings.addColor('Background Color?', 'bgColor')

client.settings.addAir(8)
column = 9
client.settings.addInt("Number of columns", 'column', 1, 36)

inventory = player.inventory()
invenRender = {}
slot = 0

positionX, positionY = gui.width() / 2 - 88, -13
sizeX, sizeY, scale = 176, 67, 1

function slotRender()
    local originX, originY = 5, 17 --starting pos
    local columnCurrent = math.floor(slot % column) --finds the remainder of the slot number / 9 
    local rowCurrent = (math.floor(slot / column)) --finds the floored version of slot / 9
    originY = rowCurrent * 18 --finds real row #
    if columnCurrent == 0 then
        columnCurrent = column --fixes there being no 9th slot
        originY = originY - 18 --fixes an issue where it would render one slot below
        sizeX = originX + 18 * columnCurrent + 4
    end
    originX = originX + 18 * columnCurrent - 18 --finds real coloumn #
    originY = originY -3 -- alignment error fix
    gfx.texture(originX, originY, 18, 18, 'textures/ui/item_cell.png')
    if slot == 36 then
        sizeY = originY + 20
    end
    gfx.item(originX + 0.99, originY + 0.95, slot - 1, scale, true) --final render
end

function render(dt)
    --scale = 1 --scale never changes
    if Lock == true then --Locks to the top center (if u resize a lot)
        positionX, positionY = gui.width() / 2 - (sizeX / 2), -13
    end

    gfx.color(0, 0, 0)
    gfx.rect(-3, 1, sizeX + 6, sizeY - 1)
    gfx.rect(-2, 0, sizeX + 4, sizeY + 1)
    gfx.rect(0, -2, sizeX, sizeY + 5)
    gfx.rect(-1, -1, sizeX + 2, sizeY + 3)


    gfx.color(198, 198, 198)
    gfx.rect(0, 1, sizeX, sizeY)

    gfx.color(255, 255, 255)
    gfx.rect(0, -1, sizeX, 2) --top highlight
    gfx.rect(-2, 1, 2, sizeY -1) --left highlight
    gfx.rect(-1, 0, 2, 2) --  left top corner
    gfx.rect(sizeX, 0, 1, 1)

    gfx.color(85, 85, 85)
    gfx.rect(0, sizeY, sizeX, 2) --bottom shadow
    gfx.rect(sizeX, 1, 2, sizeY - 1) --right shadow
    gfx.rect(sizeX -1 , sizeY -1 , 2, 2) -- right bottom corner
    gfx.rect(-1, sizeY, 1, 1) --left bottom corner
    gfx.text(5, 4, 'Inventory')
    gfx.text(sizeX - 7, 4, 'X')

    if inventory ~= nil then
        for slotloop = 10, 36 do --loops through inven slots, can be anything up to 36
            local item = inventory.at(slotloop)
            --[[if item ~= nil then --checks to see if slot has number
                slot = slotloop --global slot #
                slotRender() --renders current slot
            end]]
            slot = slotloop --global slot #
            slotRender() --renders current slot
        end
    end
end

--yo waddup