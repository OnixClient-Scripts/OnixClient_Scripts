name = "Minimap v2"
description = "A map of blocks around you. Slow but has a lot of features."

positionX = 500
positionY = 25
sizeX = 100
sizeY = 100

gridR = 25
gridSize = gridR * 2
checkLimit = 10
checkFrequency = 1
lightEnabled = false
client.settings.addInt("Map Radius", "gridR", 5, 50)
client.settings.addInt("Map Height", "checkLimit", 0, 50)
client.settings.addInt("Refresh Delay", "checkFrequency", 1, 50)
client.settings.addBool("Light Display", "lightEnabled")

log = ""

importLib("MinimapBlockTools.lua")

-- Arrays for the map
colourMap = {}
mapRects = {}

loops = 0
inWater = false
function update()
    UpdateMapTools()

    gridSize = gridR * 2

    -- Frame rate limiter
    loops = loops + 1
    if loops % checkFrequency == 0 then
        -- Empty arrays, get player position
        colourMap = {}
        mapRects = {}
        px, py, pz = player.position()

        -- Check if the player is in water
        if dimension.getBlock(px, py, pz).name == "water" then
            inWater = true
        else
            inWater = false
        end

        -- Moving the check downwards if the player is in the air
        downChecks = 0
        while dimension.getBlock(px, py, pz).name == "air" or invisWater(px, py, pz) and downChecks < checkLimit * 5 do
            downChecks = downChecks + 1
            py = py - 1
        end

        -- Finding all the blocks
        for j = 1, gridSize, 1 do
            for i = 1, gridSize, 1 do
                ySearch = py
                block = ""
                light = 0

                height = 0

                if dimension.getBlock(px + (i - gridSize / 2), ySearch, pz + (j - gridSize / 2)).name == "air" or
                    invisWater(px + (i - gridSize / 2), ySearch, pz + (j - gridSize / 2)) then
                    -- Check downwards
                    checks = 0
                    while dimension.getBlock(px + (i - gridSize / 2), ySearch, pz + (j - gridSize / 2)).name == "air" or
                        invisWater(px + (i - gridSize / 2), ySearch, pz + (j - gridSize / 2)) and checks < checkLimit do
                        checks = checks + 1

                        height = height - 1
                        ySearch = ySearch - 1
                    end
                    block = dimension.getBlock(px + (i - gridSize / 2), ySearch, pz + (j - gridSize / 2)).name

                    -- Get light
                    if lightEnabled then
                        bLight, sLight = dimension.getBrightness(px + (i - gridSize / 2), ySearch + 1,
                            pz + (j - gridSize / 2))
                        sLight = sLight * (math.abs(dimension.time() - 0.5) * 2)

                        if bLight > sLight then
                            light = bLight
                        else
                            light = sLight
                        end
                    end
                else
                    -- Check upwards
                    checks = 0
                    while dimension.getBlock(px + (i - gridSize / 2), ySearch, pz + (j - gridSize / 2)).name ~= "air" and
                        invisWater(px + (i - gridSize / 2), ySearch, pz + (j - gridSize / 2)) == false and
                        checks < checkLimit do
                        checks = checks + 1

                        height = height + 1
                        ySearch = ySearch + 1
                    end
                    block = dimension.getBlock(px + (i - gridSize / 2), ySearch - 1, pz + (j - gridSize / 2)).name
                    blockdata = dimension.getBlock(px + (i - gridSize / 2), ySearch - 1, pz + (j - gridSize / 2)).data

                    -- Get light
                    if lightEnabled then
                        bLight, sLight = dimension.getBrightness(px + (i - gridSize / 2), ySearch,
                            pz + (j - gridSize / 2))
                        sLight = sLight * (math.abs(dimension.time() - 0.5) * 2)

                        if bLight > sLight then
                            light = bLight
                        else
                            light = sLight
                        end
                    end
                end

                -- lava glow lichen tuff
                if block == "tuff" or block == "glow_lichen" or block == "lava" or block == "deepslate" or
                    block == "tallgrass" or block == "torch" or block == "wheat" or block == "grass" or block == "kelp"
                    or block == "grass_path" or block == "sand" or block == "gravel" or block == "seagrass" or
                    block == "red_flower" or block == "water" or block == "flowing_water" or block == "leaves2" or
                    block == "leaves" then
                    r, g, b = getRBG(block)
                else
                    color = getMapColorName(block, blockdata)
                    r = color[1]
                    g = color[2]
                    b = color[3]
                end
                -- r, g, b = getRBG(block)

                -- Darkening the squares depending on light levels
                if lightEnabled then
                    lDarkening = map(light, 0, 15, 0.3, 1)
                    r = r * lDarkening
                    g = g * lDarkening
                    b = b * lDarkening
                end

                -- Lighten the layer above the player
                if height > -1 then
                    r = r * 1.2
                    g = g * 1.2
                    b = b * 1.2
                end

                -- Darken layers with depth
                if height < -1 and block ~= "air" then
                    darkening = map(math.abs(height), 0, checkLimit, 1, 0)
                    r = r * darkening
                    g = g * darkening
                    b = b * darkening
                end


                table.insert(colourMap, { r, g, b })
            end
        end

        -- Turning "colorMap" into a list of horizontal rectangles for better fps
        i = 0
        rectLength = 0
        rectStart = { 0, 0 }
        while i < #colourMap - 1 do
            i = i + 1

            -- If the next color is the same as this one, add it
            if colourMap[i][1] == colourMap[i + 1][1] and colourMap[i][2] == colourMap[i + 1][2] and
                colourMap[i][3] == colourMap[i + 1][3] and i % gridSize ~= 0 and i ~= gridSize * gridSize - 1 then
                if rectLength == 0 then
                    rectStart = { i % gridSize, math.floor(i / gridSize) }
                end
                rectLength = rectLength + 1

                -- If not, end the rect
            else
                if rectLength == 0 then
                    table.insert(mapRects, { { i % sizeX, math.floor(i / sizeX) }, 1, colourMap[i] })
                else
                    table.insert(mapRects, { rectStart, rectLength, colourMap[i] })
                    rectLength = 1
                    rectStart = { i % gridSize, math.floor(i / gridSize) }
                end
            end
        end
    end
end

function render()
    -- Drawing the rects
    for i = 1, #mapRects, 1 do
        gfx.color(mapRects[i][3][1], mapRects[i][3][2], mapRects[i][3][3])

        gfx.rect((mapRects[i][1][1]) * (sizeX / gridSize), (mapRects[i][1][2]) * (sizeX / gridSize),
            (sizeX / gridSize) * mapRects[i][2], sizeX / gridSize)
    end
    -- There's a problem with rendering the blocks at the ends so i just hardcoded it :P
    if #colourMap > 0 then
        gfx.color(colourMap[1][1], colourMap[1][2], colourMap[1][3])
        gfx.rect(0, 0, sizeX / gridSize, sizeX / gridSize)
        gfx.color(colourMap[2][1], colourMap[2][2], colourMap[2][3])
        gfx.rect(sizeX / gridSize, 0, sizeX / gridSize, sizeX / gridSize)
        gfx.color(colourMap[3][1], colourMap[3][2], colourMap[3][3])
        gfx.rect(sizeX / gridSize * 2, 0, sizeX / gridSize, sizeX / gridSize)
        gfx.color(colourMap[#colourMap][1], colourMap[#colourMap][2], colourMap[#colourMap][3])
        gfx.rect(sizeX - 1 * (sizeX / gridSize), sizeX - 1 * (sizeX / gridSize), sizeX / gridSize, sizeX / gridSize)
    end
    -----------------------------------------------------------------------------------------

    -- A square on the player
    gfx.color(255, 0, 255)
    gfx.rect(((gridSize / 2) * sizeX / gridSize) - sizeX / gridSize, (gridSize / 2) * sizeX / gridSize - sizeX / gridSize
    , sizeX / gridSize, sizeX / gridSize)

    -- Direction line
    yaw, pitch = player.rotation()
    gfx.color(255, 0, 0)
    x1, y1, x2, y2, x3, y3, x4, y4 = directionLine(math.rad(yaw + 90), 13,
        ((gridSize / 2) * sizeX / gridSize) - sizeX / gridSize / 2,
        (gridSize / 2) * sizeX / gridSize - sizeX / gridSize / 2)
    gfx.triangle(x1, y1, x2, y2, x3, y3)
    gfx.triangle(x4, y4, x3, y3, x2, y2)

    directionTriangle(math.rad(yaw + 90), 13, ((gridSize / 2) * sizeX / gridSize) - sizeX / gridSize / 2,
        (gridSize / 2) * sizeX / gridSize - sizeX / gridSize / 2)

    -- "log" for debugging
    gfx.color(255, 255, 255)
    gfx.text(5, 5, log, 3)
end

-- Color values
function getRBG(name)
    if name == "grass" or name == "slime" then
        return 127, 178, 56
    elseif name == "sand" or name == "birch_trapdoor" or name == "birch_door" or name == "birch_fence_gate" or
        name == "birch_pressure_plate" or name == "sandstone" or name == "glowstone" or name == "end_stone" or
        name == "end_bricks" or name == "end_brick_stairs" or name == "bone_block" or name == "scaffolding" then
        return 247, 233, 163
    elseif name == "cobweb" or name == "bed" or name == "wool" then
        return 199, 199, 199
    elseif name == "lava" or name == "fire" or name == "flowing_lava" or name == "redstone_block" then
        return 255, 0, 0
    elseif name == "ice" or name == "blue_ice" or name == "packed_ice" then
        return 160, 160, 255
    elseif name == "iron_block" or name == "iron_bars" or name == "iron_trapdoor" or name == "iron_door" or
        name == "anvil" or name == "grindstone" or name == "lodestone" or name == "lantern" then
        return 167, 167, 167

        -- missing a bunch
    elseif name == "sapling" or name == "seagrass" or name == "kelp" or name == "red_flower" or name == "double_plant" or
        name == "reeds" or name == "wheat" or name == "tallgrass" or name == "leaves" or name == "azalea_leaves" or
        name == "big_dripleaf" or name == "small_dripleaf_block" or name == "leaves2" then
        return 0, 124, 0
    elseif name == "snow" or name == "snow_layer" or name == "powder_snow" then
        return 255, 255, 255
    elseif name == "clay" or name == "monster_egg" then
        return 164, 168, 184
    elseif name == "dirt" or name == "dirt_with_roots" or name == "grass_path" or name == "farmland" or name == "jukebox" then
        return 151, 109, 77
    elseif name == "water" or name == "flowing_water" then
        return 64, 64, 255
    elseif name == "stone" or name == "normal_stone_stairs" or name == "stone_slab4" or name == "stone_slab3" or
        name == "gravel" then
        return 112, 112, 112
    elseif name == "air" then
        return 121, 166, 255
    elseif name == "deepslate" then
        return 100, 100, 100
    elseif name == "glow_lichen" then
        return 127, 167, 150
    elseif name == "tuff" then
        return 87, 92, 92

        -- not used
    elseif name == "player" then
        return 255, 0, 255
    else
        -- all blocks that i havent mentioned
        return 51, 51, 51
    end
end

-- Giving the quad points for the direction line
function directionLine(a, l, x0, y0)
    widthDiv = 20

    x01 = x0 + l * math.cos(a)
    y01 = y0 + l * math.sin(a)

    a1 = a + math.rad(90)

    x1 = x01 + (l / widthDiv) * math.cos(a1)
    y1 = y01 + (l / widthDiv) * math.sin(a1)

    x2 = x0 + (l / widthDiv) * math.cos(a1)
    y2 = y0 + (l / widthDiv) * math.sin(a1)

    a2 = a - math.rad(90)

    x3 = x01 + (l / widthDiv) * math.cos(a2)
    y3 = y01 + (l / widthDiv) * math.sin(a2)

    x4 = x0 + (l / widthDiv) * math.cos(a2)
    y4 = y0 + (l / widthDiv) * math.sin(a2)

    return x2, y2, x1, y1, x4, y4, x3, y3
end

-- different options for pointer
function directionTriangle(a, l, x0, y0)
    x2, y2, x1, y1, x4, y4, x3, y3 = directionLine(a, l, x0, y0)

    x5 = x1 + (l / 5) * math.cos(a + 90)
    y5 = y1 + (l / 5) * math.sin(a + 90)

    x6 = x3 + (l / 5) * math.cos(a - 90)
    y6 = y3 + (l / 5) * math.sin(a - 90)

    x7 = x01 + (l / 3) * math.cos(a)
    y7 = y01 + (l / 3) * math.sin(a)

    gfx.color(255, 0, 0)
    gfx.triangle(x6, y6, x5, y5, x7, y7)
end

-- A useful math function
function map(value, min1, max1, min2, max2)
    return (value - min1) * ((max2 - min2) / (max1 - min1)) + min2
end

-- Returns true if the block of water selected should be invisible
function invisWater(x, y, z)
    if inWater and dimension.getBlock(x, y, z).name == "water" then
        return true
    else
        return false
    end
end
