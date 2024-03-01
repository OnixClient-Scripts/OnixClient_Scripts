name = "Mega Map For Big Goys Only"
description = "Extensive minimap script"

--[[
    made by jackhirsh
]]

-- Module Init
positionX = 35
positionY = 120
sizeX = 50
sizeY = 50

-- Settings
chunkRadiusSetting = client.settings.addNamelessInt("Chunk Radius", 1, 5, 1)

-- Imports
importLib("MegaMap/List.lua")
importLib("MegaMap/ColorLib.lua")
importLib("MegaMap/ChunkCache.lua")
importLib("MegaMap/CoordinatedControl.lua")
importLib("MegaMap/ChunkColors.lua")

-- Listener Handlers
function blockUpdateEventHandler(x, y, z, newBlock, oldBlock)
    if chunk_cache ~= nil then
        if dimension.getMapHeight(x, z) <= y then
            local xChunk, zChunk = coordToChunkCoord(x, z)
            ChunkCache.updateChunk(chunk_cache, xChunk, zChunk)
        end
    end
    return true
end

-- Listener Hooks
event.listen("BlockChanged", blockUpdateEventHandler)


-- Global Variables
mapImageChunkSize = 16
missingChunkTexture = {}
for i=0, mapImageChunkSize do
    missingChunkTexture[i] = {}
    for j=0, mapImageChunkSize do
        missingChunkTexture[i][j] = {r=255, g=255, b=255}
    end
end



function render(timeSinceUpdate)
    if chunk_cache == nil then chunk_cache = ChunkCache.new() end
end

-- Make the Drawing 0 indexed in top right?

function drawChunkImage(chunkX, chunkZ, image, gridSize)
    local posX = chunkX * ( sizeX / gridSize)
    local posY = chunkZ * ( sizeY / gridSize)
    if image ~= nil then
        gfx2.drawImage(posX, posY, sizeX, sizeY, image)
        return true
    end
    return false
end

function render2(timeSinceUpdate)

    local playerX, playerY, playerZ = player.position()
    local pChunkX, pChunkZ = coordToChunkCoord(playerX, playerZ)
    local chunk_image = ChunkCache.createChunkImage(chunk_cache, pChunkX, pChunkZ)
    local chunk_radius = chunkRadiusSetting.value

    for dx=-1 * chunk_radius, chunk_radius do
        for dz=-1 * chunk_radius, chunk_radius do
            local cur_image = ChunkCache.createChunkImage(chunk_cache, pChunkX + dx, pChunkZ + dz)
            drawChunkImage(dx + chunk_radius, dz + chunk_radius, cur_image, chunk_radius)
        end
    end

    if chunk_image ~= nil then
        gfx2.color(255, 255, 255)
        gfx2.text(0, 0,
        "(cx:" .. tostring(pChunkX) .. ", cz:" .. tostring(pChunkZ) .. ")" ,
        .25)
    end
end