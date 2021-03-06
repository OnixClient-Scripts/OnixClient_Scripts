name = "Minimap"
description = "shows a map of blocks around you"

--[[
    Minimap Module Script
    
    made by MCBE Craft
	improvements by Onix86
]]

isFirstUpdate = true
positionX = 500
positionY = 25
sizeX = 100
sizeY = 100
size = 10
PixelBlockRatio = 4
opacity = 3

function update(deltaTime)
	if (isFirstUpdate == true) then
		positionX = gui.width() - ((PixelBlockRatio * size) + 75)
		isFirstUpdate = false
	end
	
	sizeX = (size * PixelBlockRatio + PixelBlockRatio) * 2
	sizeY = sizeX

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
	if (isFirstUpdate == false) then --fix errors that happen on reloads
	    gfx.color(255,255,255, math.floor(255 / size * opacity))
	    for px=sx,ex do
			local cposx = (PixelBlockRatio * (px - x))
	        for pz=sz,ez do
				local cposz = (PixelBlockRatio * (pz - z))
	            for i=sy,array[px][pz]do
	                gfx.rect(cposx + sizeX / 2 - PixelBlockRatio / 2, cposz + sizeY / 2 - PixelBlockRatio / 2, PixelBlockRatio, PixelBlockRatio)
	            end
	        end
	    end
	    gfx.color(255,0,0)
	    gfx.rect(sizeX / 2 - PixelBlockRatio / 2, sizeY / 2 - PixelBlockRatio / 2, PixelBlockRatio, PixelBlockRatio)
	    gfx.rect(lx - x + sizeX / 2 - PixelBlockRatio / 2, lz - z + sizeY / 2 - PixelBlockRatio / 2, PixelBlockRatio, PixelBlockRatio)
	end
end
