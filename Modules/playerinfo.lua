name = "PlayerInfo"
description = "Show player information"

positionX = 20
positionY = 80
sizeX = 100
sizeY = 50
scale = 1


--[[
    Player Info Module Script
    
    made by Quoty0
    thanks for Onix86 for help
    
    Background size is not done yet
    use module size 1 or make it transparent
]]


function update(deltaTime)
    
end

function render(deltaTime)
	if (true == true) then 
	--for countingCount=1,1000 do
	local name = player.name()
	local gamemode = player.gamemode()
	local gamemode_string
	local player_x,player_y,player_z = player.position()
	local block_x,block_y,block_z = player.selectedPos()
	local biome = dimension.getBiome(player_x,player_y,player_z)
	local biomeName = "No biome"
	local block = dimension.getBlock(block_x,block_y,block_z)
	local blockId = block.id
	local blockData = block.data
	local blockName = block.name
	local attribs = player.attributes()
	local health = attribs.id(7).value
	local food = attribs.id(2).value
	local saturation = attribs.id(3).value
    local font = gui.font()
	
	if gamemode == 0 then
		gamemode_string = "Survival"
	elseif gamemode == 1 then
		gamemode_string = "Creative"
	elseif gamemode == 2 then
		gamemode_string = "Adventure"
	elseif gamemode == 5 then
		gamemode_string = "Default"
	else
		gamemode_string = "Unknown"
	end
	if (biome ~= nil) then biomeName = biome.name end
	
	
	gfx.color(0,0,0,120)
    gfx.rect(0, 0, 100, 50)

    gfx.color(255, 255, 255)
    gfx.text(1, 3, " X: " .. player_x, 0.7)
	
    gfx.text(1, 11, " Y: " .. player_y, 0.7)

    gfx.text(1, 19, " Z: " .. player_z, 0.7)

    gfx.text(26, 3, " Player: " .. name, 0.7)

    gfx.text(26, 11, " Gamemode: " .. gamemode_string, 0.7)
	
    gfx.text(26, 19, " Biome: " .. biomeName, 0.7)
	
    gfx.text(26, 28, " Facing Block: " .. blockName, 0.7)
	
    gfx.text(26, 35, " Facing Block ID: " .. blockId, 0.7)
	
    gfx.text(26, 42, " Facing Block Data: " .. blockData, 0.7)


	gfx.text(1, 26, " H: " .. health, 0.7)
	
    gfx.text(1, 34, " F: " .. food, 0.7)

    gfx.text(1, 42, " S: " .. saturation, 0.7)
end
end
