function generateMapTile(xStart, xSize, zStart, zSize)
    local mapTileData = {}
    for i = 0, xSize do
        mapTileData[i] = {}
        for j = 0, zSize do
            local curX = xStart + i
            local curZ = zStart + j
            local curY = dimension.getMapHeight(curX, curZ)
            local mapPos = { curX, curY, curZ }
            local thisColor = getMapColor(mapPos)

            -- Check if any nil color data is received, this would break things badly
            if rgbNilError(r, g, b) then
                counter = 0
                return
            end
            mapTileData[i][j] = thisColor
        end
    end
    return mapTileData
end