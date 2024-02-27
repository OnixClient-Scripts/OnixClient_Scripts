---gets the grassColor as a table
---@param mapPos any Position to fetch grassColor
---@return table ColorTable a getColorTable Response
function getGrassColor(mapPos)
    local biomeColorData = getBiomeColors(mapPos)
    return getColorTableFromSetting(biomeColorData.grassColor)
end

---Gets the waterColor as a table
---@param mapPos any Position to fetch waterColor
---@return table ColorTable a getColorTable Response
function getWaterColor(mapPos)
    local biomeColorData = getBiomeColors(mapPos)
    return getColorTableFromSetting(getColorTable(biomeColorData.waterColor))
end

function getMapColor(mapPos)
    return getColorTable(dimension.getMapColor(unp(mapPos)))
end

function getBiomeColors(mapPos)
    biomeData = dimension.getBiomeColor(unp(mapPos))
    return { grassColor = biomeData.grass, waterColor = biomeData.water }
end

function getColorTable(r, g, b, a)
    return { r=r, g=g, b=b, a=a}
end

function getColorTableFromSetting(colSet)
    return getColorTable(colSet.r, colSet.g, colSet.b, colSet.a)
end

---This gets the color for a given mapPos factoring in BiomeColoration
---@param mapPos table
function getPositionColor(mapPos)
    local blockAt = dimension.getBlock(unp(mapPos))
    if blockAt.name == "grass" then
        return getGrassColor(mapPos)
    end
    if string.match(blockAt.name, "water") then
        return getWaterColor(mapPos)
    end
    return getMapColor(mapPos)
end

function rgbNilError(r, g, b)
    if r == nil or g == nil or b == nil then
        client.notification(
            "Received a nil color value" ..
            "\nr:" ..
            tostring(r) ..
            "\ng:" ..
            tostring(g) ..
            "\nb:" ..
            tostring(b)
        )
        return true
    else
        return false
    end
end

function unp(aTable)
    return table.unpack(aTable)
end

