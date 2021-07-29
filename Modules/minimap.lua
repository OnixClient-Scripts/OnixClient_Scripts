name = "minimap"
description = "shows a map of blocks around you"

--[[
    Arrow Counter Module Script
	
	made by MCBE Craft
]]

positionX = 100
positionY = 100
size = 10

function update(deltaTime)

end


function render(deltaTime)
    local x,y,z = player.position()
    local lx,ly,lz = player.lookingPos()
    local sx = x - size
    local sy = y - math.floor(size/2)
    local sz = z - size
    local ex = sx + (2 * size)
    local ey = y + (size)
    local ez = sz + (2 * size)


    gfx.color(255,255,255, math.floor(255 / size * 2))
    for px=sx,ex do
        for pz=sz,ez do
            local highest = sy - 1
            for py=sy,ey do
                local block = dimension.getBlock(px,py,pz)
                if (block.id ~= 0) then
                    highest = py
                end
            end
            for i=sy,highest do
                gfx.rect(positionX + (4 * (px - x)), positionY + (4 * (pz - z)), 4, 4)
            end
        end
    end
    gfx.color(255,0,0)
    gfx.rect(positionX, positionY, 4, 4)
    gfx.rect(positionX + lx - x, positionY + lz - z, 4, 4)
end