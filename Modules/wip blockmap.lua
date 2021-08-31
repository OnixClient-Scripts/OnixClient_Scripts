name = "Blockmap"
description = "shows a map of blocks around you (some textures hasn't been setup yet)"

--[[
	Blockmap Module Script
	
	made by MCBE Craft
	helped by Onix86

    warning: causes massive fps drop because of all the textures it is drawing
    needs library translator.lua or almost all block textures will be missing
]]

ImportedLib = importLib("translator.lua")

isFirstUpdate = true
positionX = 500
positionY = 25
sizeX = 100
sizeY = 100
size = 10
PixelBlockRatio = 4
opacity = 3

--player and border color
r, g, b, a = 255, 0, 0, 255

function update(deltaTime)
	if (isFirstUpdate == true) then
		isFirstUpdate = false
	end
	
	sizeX = (size * PixelBlockRatio + PixelBlockRatio) * 2
	sizeY = sizeX

	x,y,z = player.position()
	lx,ly,lz = player.lookingPos()
	yaw, pitch = player.rotation()
	sx = x - size
	sy = y - math.floor(size/2)
	sz = z - size
	ex = sx + (2 * size)
	ey = y + (size)
	ez = sz + (2 * size)
	array = {}
	blockname = {}
	for i=sx,ex do
		array[i] = {}
		blockname[i] = {}
	end

	for px=sx,ex do
		for pz=sz,ez do
			local highest = sy - 1
			local name = "air"
			for py=sy,ey do
				local block = dimension.getBlock(px,ey - (py - sy),pz)
				if (block.id ~= 0 and block.id ~= 31 and block.id ~= 106 and block.id ~= 111 and block.id ~= 38 and block.id ~= 37 and block.id ~= 132 and block.id ~= 141 and block.id ~= 461 and block.id ~= 76 and block.id ~= 69 and string.find(block.name, "_button") == nil and block.id ~= 55 and block.id ~= 541 and block.id ~= 175) then
					highest = ey - (py - sy)
					name = translate(block.name, block.data)
					goto next_block
				end
			end
			::next_block::
			array[px][pz] = highest
			blockname[px][pz] = name
		end
	end

end


function render(deltaTime)
	if (isFirstUpdate == false) then --fix errors that happen on reloads
		for px=sx,ex do
			local cposx = (PixelBlockRatio * (px - x))
			for pz=sz,ez do
				local cposz = (PixelBlockRatio * (pz - z))
				if (blockname[px][pz] ~= "air") then
					gfx.texture(cposx + sizeX / 2 - PixelBlockRatio / 2, cposz + sizeY / 2 - PixelBlockRatio / 2, PixelBlockRatio, PixelBlockRatio, "textures/" .. blockname[px][pz], 1)
				end
			end
		end
		gfx.color(r, g, b, a)

		--player indicator
        	local a = math.cos(math.rad(yaw-120+90))
        	local b = math.sin(math.rad(yaw-120+90))
        	local c = math.cos(math.rad(yaw+120+90))
        	local d = math.sin(math.rad(yaw+120+90))
        	local e = math.cos(math.rad(yaw+90))
        	local f = math.sin(math.rad(yaw+90))

        	local halfSizeX = sizeX / 2
        	local halfSizeY = sizeY / 2
        	local triangleSize = 3
        	gfx.triangle(a * triangleSize + halfSizeX, b * triangleSize + halfSizeY, c * triangleSize + halfSizeX, d * triangleSize + halfSizeY, e * (triangleSize*1.5) + halfSizeX, f * (triangleSize*1.5) + halfSizeY)

		--border
		gfx.rect(0, 0, sizeX, 2)
		gfx.rect(0, 2, 2, sizeY - 2)
		gfx.rect(sizeX - 2, 2, 2, sizeY - 2)
		gfx.rect(2, sizeY - 2, sizeX - 4, 2)
	end
end
