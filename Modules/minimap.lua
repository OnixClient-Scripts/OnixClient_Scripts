name = "minimap"
description = "shows a map of blocks around you"

--[[
    Minimap Module Script
    
    made by MCBE Craft
]]

positionX = 575
positionY = 50
size = 10
opacity = 3

function update(deltaTime)
    x,y,z = player.position()
    lx,ly,lz = player.lookingPos()
    sx = x - size
    sy = y - math.floor(size/2)
    sz = z - size
    ex = sx + (2 * size)
    ey = y + (size)
    ez = sz + (2 * size)
    array = {}
    for i=sx,ex do
        array[i] = {}
    end

    for px=sx,ex do
        for pz=sz,ez do
            local highest = sy - 1
            for py=sy,ey do
                local block = dimension.getBlock(px,ey - (py - sy),pz)
                if (block.id ~= 0) then
                    highest = ey - (py - sy)
                    goto next_block
                end
            end
            ::next_block::
            array[px][pz] = highest
        end
    end

end


function render(deltaTime)
    gfx.color(255,255,255, math.floor(255 / size * opacity))
    for px=sx,ex do
        for pz=sz,ez do
            for i=sy,array[px][pz]do
                gfx.rect(positionX + (4 * (px - x)), positionY + (4 * (pz - z)), 4, 4)
            end
        end
    end
    gfx.color(255,0,0)
    gfx.rect(positionX, positionY, 4, 4)
    gfx.rect(positionX + lx - x, positionY + lz - z, 4, 4)
end
