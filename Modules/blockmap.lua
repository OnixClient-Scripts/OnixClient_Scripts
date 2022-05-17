name = "Blockmap"
description = "shows a map of the blocks around you"

--[[
	Blockmap Module Script
	
	made by MCBE Craft
	helped by Onix86

    warning: causes massive fps drop because of all the textures it is drawing
    needs library translator.lua or almost all block textures will be missing
]]

ImportedLib = importLib("translator.lua")
ImportedLib2 = importLib("fileUtility.lua")

client.settings.addAir(5)
textColor = {254, 254, 254, 254}
client.settings.addColor("Text color", "textColor")

isFirstUpdate = true
positionX = 500
positionY = 25
sizeX = 100
sizeY = 100
size = 10
PixelBlockRatio = 4
opacity = 3

function update(deltaTime)
	if not ImportedLib or not ImportedLib2 then
		print("BLOCK MAP IS MISSING LIBRARIES")
	end
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
				if (airblock(block.name, block.id) ~= "air") then
					highest = ey - (py - sy)
						name = translate(block.name, block.id, block.data)
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
		local tempblockname = {}
		for i=sx,ex do
			tempblockname[i] = {}
			for j=sz,ez do
				tempblockname[i][j] = blockname[i][j]
			end
		end
		for idkx = sx, ex do
			for idkz = sz, ez do
				if (tempblockname[idkx][idkz] ~= "air" and tempblockname[idkx][idkz] ~= nil) then
					local currentblock = tempblockname[idkx][idkz]
					for idktoox = sx, ex do
						local cposx = (PixelBlockRatio * (idktoox - x))
						for idktooz = sz, ez do
							local cposz = (PixelBlockRatio * (idktooz - z))
							if tempblockname[idktoox][idktooz] == currentblock then
								tempblockname[idktoox][idktooz] = "air"
								gfx.ctexture(cposx + sizeX / 2 - PixelBlockRatio / 2, cposz + sizeY / 2 - PixelBlockRatio / 2, PixelBlockRatio, PixelBlockRatio, "textures/" .. currentblock, 0, 0, 1, 1)
							end
						end
					end
					gfx.fimage()
				end
			end
		end
		gfx.color(textColor.r, textColor.g, textColor.b, textColor.a)

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
