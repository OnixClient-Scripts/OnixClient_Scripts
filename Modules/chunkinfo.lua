name = "Chunk Positions"
description = "Gives you the current chunk's chunk pos and your position inside of it"

positionX = 200
positionY = 150
sizeX = 60
sizeY = 10

--[[
    Chunk info Module Script
    
    made by Onix86
    thanks for ItzHugo for help
    and thanks to EianLee for the idea
]]

function render(deltaTime)

    local x,y,z = player.position()
    local chunk_x = math.floor(x / 16)
    local chunk_y = math.floor(y / 16)
    local chunk_z = math.floor(z / 16)

    x = x - (chunk_x * 16) + 1
    y = y - (chunk_y * 16) + 1
    z = z - (chunk_z * 16) + 1

    gfx.color(255, 255, 255)
    
    local text = "In Chunk: " .. math.floor(chunk_x) .. " " .. math.floor(chunk_y) .. " " .. math.floor(chunk_z) .. "   In Chunk Position: " .. math.floor(x) .. " " .. math.floor(y) .. " " .. math.floor(z)
    local font = gui.font()
    sizeX = font.width(text, 1)
    gfx.text(0, 5 - (font.height / 2), text)
end
