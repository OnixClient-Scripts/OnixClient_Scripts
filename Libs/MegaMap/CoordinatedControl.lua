-- Coordinate Functions

function coordToChunkCoord(xCoord, zCoord)
    local xChunkCoord = xCoord // mapImageChunkSize
    local zChunkCoord = zCoord // mapImageChunkSize
    return xChunkCoord, zChunkCoord
end

function chunkCoordToCoord(xChunk, zChunk)
    return (xChunk * mapImageChunkSize) - 1, (zChunk * mapImageChunkSize) - 1
end
-- End: Constants

---Gets the mapPos for the player
---@return table mapPos
function getPlayerMapPos()
    local playerX, playerY, playerZ = player.position()
    local mapY = dimension.getMapHeight(playerX, playerZ)
    return { playerX, mapY, playerZ }
end