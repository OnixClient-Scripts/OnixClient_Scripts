ChunkCache = {}

function ChunkCache.new()
    return {colorData={}, imgData ={}}
end

function ChunkCache.updateChunk(cache, xChunk, zChunk)
    local xStart, zStart = chunkCoordToCoord(xChunk, zChunk)
    local update_result = generateMapTile(xStart, mapImageChunkSize, zStart, mapImageChunkSize)
    if cache.colorData[xChunk] == nil then cache.colorData[xChunk] = {} end
    if cache.colorData[xChunk][zChunk] == nil then cache.colorData[xChunk][zChunk] = {} end
    cache.colorData[xChunk][zChunk] = update_result
    return update_result
end

function ChunkCache.readChunk(cache, xChunk, zChunk)
    -- First do checks to make sure the chunk is cached, return missingChunkTexture otherwise
    if cache.colorData[xChunk] == nil then return false end
    result = cache.colorData[xChunk][zChunk]
    if result == nil then return false end

    return result
end

function ChunkCache.getChunkColoring(cache, xChunk, zChunk)
    local read_result = ChunkCache.readChunk(cache, xChunk, zChunk)
    if read_result ~= nil and read_result then
        return read_result
    else
        return ChunkCache.updateChunk(cache, xChunk, zChunk)
    end
end

function ChunkCache.getChunkImage(cache, xChunk, zChunk)
    if cache.imgData[xChunk] == nil then cache.imgData[xChunk] = {} end
    if cache.imgData[xChunk][zChunk] == nil then
        cache.imgData[xChunk][zChunk] = ChunkCache.createChunkImage(cache, xChunk, zChunk)
        return cache.imgData[xChunk][zChunk]
    else
        return cache.imgData[xChunk][zChunk]
    end
end

function ChunkCache.createChunkImage(cache, xChunk, zChunk)
    local chunk_coloring = ChunkCache.getChunkColoring(cache, xChunk, zChunk)
    if chunk_coloring ~= nil then
        local result_image = gfx2.createImage(mapImageChunkSize, mapImageChunkSize)
        if result_image ~= nil then
            for i=0, mapImageChunkSize do
                for j=0, mapImageChunkSize do
                    local pixelData = chunk_coloring[i][j]
                    if pixelData ~= nil and pixelData.r ~= nil and pixelData.g ~= nil and pixelData.b ~= nil then
                        result_image.setPixel(result_image, i, j, pixelData.r, pixelData.g, pixelData.b)
                    end
                    end
                end
            end
        return result_image
    end
end
