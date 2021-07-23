name = "PlayerInfo"
description = "Show player info"

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

    local module_x = 0
    local module_y = 0
    local module_size = 1

    local name = player.name()
    local gamemode = player.gamemode()
    local gamemode_string
    local player_x,player_y,player_z = player.position()
    local block_x,block_y,block_z = player.selectedPos()
    local biome = dimension.getBiome(player_x,player_y,player_z)
    local biomeName = "Unknown"
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
    
    if (biome ~= nil) then
        biomeName = biome.name
    end
    
    
    gfx.color(0,0,0,0)
    gfx.rect(module_x, module_y, module_size*150, module_size*63)

    
    gfx.color(255, 255, 255)
    gfx.text(module_x - 1, module_y + module_size*1, " X: " .. player_x, module_size)
    
    gfx.text(module_x - 1, module_y + module_size*10, " Y: " .. player_y, module_size)

    gfx.text(module_x - 1, module_y + module_size*19, " Z: " .. player_z, module_size)
    
    gfx.text(module_x - 1, module_y + module_size*34, " H: " .. health, module_size)
    
    gfx.text(module_x - 1, module_y + module_size*43, " F: " .. food, module_size)

    gfx.text(module_x - 1, module_y + module_size*52, " S: " .. saturation, module_size)
    

    gfx.text(module_x + module_size*40, module_y + module_size*1, " Player: " .. name, module_size)

    gfx.text(module_x + module_size*40, module_y + module_size*10, " Gamemode: " .. gamemode_string, module_size)
    
    gfx.text(module_x + module_size*40, module_y + module_size*19, " Biome: " .. biomeName, module_size)
    
    gfx.text(module_x + module_size*40, module_y + module_size*34, " Facing Block: " .. blockName, module_size)
    
    gfx.text(module_x + module_size*40, module_y + module_size*43, " Facing Block ID: " .. blockId, module_size)
    
    gfx.text(module_x + module_size*40, module_y + module_size*52, " Facing Block Data: " .. blockData, module_size)
end
