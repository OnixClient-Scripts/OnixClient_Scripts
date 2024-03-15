name = "Minimap v3"
description = "Much quicker than Minimap v2, but not as pretty-looking."

sizeX = 100
sizeY = 100
positionX = 0
positionY = 100

radius = 50
client.settings.addInt("Radius", "radius", 0, 150)
checkLimit = 50
client.settings.addInt("Height", "checkLimit", 0, 100)

worldMap = {}
firstFrame = true
function render(deltaTime)
    px, py, pz = player.position() --GLOBAL
    drawColor = { 0, 0, 0 }

    if firstFrame then
        -- fill the full screen on the first time
        for i = -radius, radius, 1 do
            for j = -radius, radius, 1 do
                getBlock(px + i, pz + j)
            end
        end

        firstFrame = false
    end

    -- drawing the ui
    for i = -radius, radius, 1 do
        for j = -radius, radius, 1 do
            local blockPosX = px + i
            local blockPosZ = pz + j

            local worldMapEntry
            if worldMap[blockPosX] then worldMapEntry = worldMap[blockPosX][blockPosZ] end
            if (worldMapEntry) then
                if drawColor[1] == worldMapEntry[1] and drawColor[2] == worldMapEntry[2] and
                    drawColor[3] == worldMapEntry[3] then
                    -- color already right, do nothing
                else
                    gfx.color(worldMapEntry[1], worldMapEntry[2], worldMapEntry[3])
                    drawColor = { worldMapEntry[1], worldMapEntry[2], worldMapEntry[3] }
                end
            else
                if drawColor[1] == 51 and drawColor[2] == 51 and drawColor[3] == 51 then
                    -- color already right, do nothing
                else
                    gfx.color(51, 51, 51)
                    drawColor = { 51, 51, 51 }
                end
            end
            gfx.rect(
                (i + radius) * (sizeX / (radius * 2)), (j + radius) * (sizeY / (radius * 2)),
                (sizeX / (radius * 2)), (sizeY / (radius * 2))
            )
        end
    end
end

function update()
    if lastPos == nil then
        px, py, pz = player.position()
        lastPos = { px, pz }
    end

    -- when move
    if math.abs(px - lastPos[1]) < 40 and math.abs(pz - lastPos[2]) < 40 then
        if px > lastPos[1] then
            -- moved right, load right
            for i = 1, px - lastPos[1], 1 do
                for j = -radius, radius, 1 do
                    getBlock(px + radius - i, pz + j)
                end
            end
        end
        if px < lastPos[1] then
            -- moved left, load left
            for i = 1, lastPos[1] - px, 1 do
                for j = -radius, radius, 1 do
                    getBlock(px - radius + i, pz + j)
                end
            end
        end
        if pz > lastPos[2] then
            -- moved up, load up
            for i = 1, pz - lastPos[2], 1 do
                for j = -radius, radius, 1 do
                    getBlock(px + j, pz + radius - i)
                end
            end
        end
        if pz < lastPos[2] then
            -- moved down, load down
            for i = 1, lastPos[2] - pz, 1 do
                for j = -radius, radius, 1 do
                    getBlock(px + j, pz - radius + i)
                end
            end
        end
    else
    end

    lastPos = { px, pz } --GLOBAL
end

-- gets the block at the calculated y position and adds it to the worldMap table
function getBlock(x, z)
    local yLevel = py
    local i = 0

    function getIsEdge()
        return dimension.getBlock(x, yLevel, z).name ~= "air" and dimension.getBlock(x, yLevel + 1, z).name == "air"
    end

    while getIsEdge() == false do
        if i > checkLimit then break end

        if dimension.getBlock(x, yLevel, z).name == "air" then
            -- go down
            yLevel = yLevel - 1
        else
            -- go up
            yLevel = yLevel + 1
        end
        i = i + 1
    end

    if worldMap[x] then
        worldMap[x][z] = getColorTable(x, yLevel, z)
    else
        local zArray = {}
        zArray[z] = getColorTable(x, yLevel, z)
        worldMap[x] = zArray
    end
end

function getColorTable(x, y, z)
    local r, g, b = dimension.getMapColor(x, y, z)
    return { r, g, b }
end
