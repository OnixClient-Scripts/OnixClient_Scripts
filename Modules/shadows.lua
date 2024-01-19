-- Made By O2Flash20 🙂
name = "Shadows"
description = "Real Time Shadows?!??!"

importLib("scripting-repo")

blocksGrid = {}

qualitySetting = client.settings.addNamelessEnum("Quality Setting:", 1,
    { { 1, "Performance" }, { 2, "Balanced" }, { 3, "High" }, { 4, "Cinematic" } }
)
shadowStrength = client.settings.addNamelessInt("Shadow Strength", 0, 255, 100)

info =
"For cinematic mode, go to a spot what you want to take a screen shot of and wait for it to load in all the shadows (don't move, that \nwon't be fun)."
client.settings.addInfo(info)

-- always set it to performance mode to start
radius = 7
continuousUpdateRadius = 3
continuousUpdateDelay = 5
resolution = 2
sunTimesToCheck = 2
timeBetweenQuadUpdates = 0.5 --(seconds)
blocksCheckedPerFrame = 10
blockQueueMax = 3000

raycastOffset = radius * 1e-3

function postInit()
    if not fs.exist("shadowTiles.png") then
        scriptingRepo.downloadDataFile("shadowTiles.png")
    end
end

function setQuality()
    blocksGrid = {}
    if qualitySetting.value == 1 then --PERFORMANCE
        radius = 7
        continuousUpdateRadius = 3
        continuousUpdateDelay = 5
        resolution = 2
        sunTimesToCheck = 2
        timeBetweenQuadUpdates = 0.5
        blocksCheckedPerFrame = 10
        blockQueueMax = 3000
    elseif qualitySetting.value == 2 then --BALANCED
        radius = 10
        continuousUpdateRadius = 3
        continuousUpdateDelay = 2
        resolution = 2
        sunTimesToCheck = 4
        timeBetweenQuadUpdates = 0.5
        blocksCheckedPerFrame = 30
        blockQueueMax = 30000
    elseif qualitySetting.value == 3 then --HIGH
        radius = 20
        continuousUpdateRadius = 3
        continuousUpdateDelay = 7
        resolution = 2
        sunTimesToCheck = 6
        timeBetweenQuadUpdates = 1
        blocksCheckedPerFrame = 100
        blockQueueMax = 80000
    elseif qualitySetting.value == 4 then --CINEMATIC
        radius = 50
        continuousUpdateRadius = 2
        continuousUpdateDelay = 50
        resolution = 2
        sunTimesToCheck = 5
        timeBetweenQuadUpdates = 1
        blocksCheckedPerFrame = 200
        blockQueueMax = 50000000000
    end

    raycastOffset = radius * 1e-3
    hasDoneInitialScan = false
end

blockCheckQueue = {}
hasDoneInitialScan = false
i = 0
lastQualitySetting = 0
function update()
    if qualitySetting.value ~= lastQualitySetting then
        setQuality()
        lastQualitySetting = qualitySetting.value
    end

    if dimension.time() > 0.25 and dimension.time() < 0.75 then return end

    px, py, pz = player.position()

    if not hasDoneInitialScan then --for when the player first loads in
        hasDoneInitialScan = true

        for x = -radius, radius do
            for y = -radius, radius do
                for z = -radius, radius do
                    table.insert(blockCheckQueue, { x + px, y + py, z + pz })
                end
            end
        end
    end

    if lastX then
        -- moved +x
        if lastX < px and px - lastX < 20 then
            for x = lastX + radius + 1, px + radius, 1 do
                for y = -radius + py, radius + py, 1 do
                    for z = -radius + pz, radius + pz, 1 do
                        table.insert(blockCheckQueue, { x, y, z })
                    end
                end
            end
        end
        -- moved -x
        if lastX > px and lastX - px < 20 then
            for x = lastX - radius - 1, px - radius, -1 do
                for y = -radius + py, radius + py, 1 do
                    for z = -radius + pz, radius + pz, 1 do
                        table.insert(blockCheckQueue, { x, y, z })
                    end
                end
            end
        end

        -- moved +y
        if lastY < py and py - lastY < 20 then
            for y = lastY + radius + 1, py + radius, 1 do
                for x = -radius + px, radius + px, 1 do
                    for z = -radius + pz, radius + pz, 1 do
                        table.insert(blockCheckQueue, { x, y, z })
                    end
                end
            end
        end
        -- moved -y
        if lastY > py and lastY - py < 20 then
            for y = lastY - radius - 1, py - radius, -1 do
                for x = -radius + px, radius + px, 1 do
                    for z = -radius + pz, radius + pz, 1 do
                        table.insert(blockCheckQueue, { x, y, z })
                    end
                end
            end
        end

        -- moved +z
        if lastZ < pz and pz - lastZ < 20 then
            for z = lastZ + radius + 1, pz + radius, 1 do
                for x = -radius + px, radius + px, 1 do
                    for y = -radius + py, radius + py, 1 do
                        table.insert(blockCheckQueue, { x, y, z })
                    end
                end
            end
        end
        -- moved -z
        if lastZ > pz and lastZ - pz < 20 then
            for z = lastZ - radius - 1, pz - radius, -1 do
                for x = -radius + px, radius + px, 1 do
                    for y = -radius + py, radius + py, 1 do
                        table.insert(blockCheckQueue, { x, y, z })
                    end
                end
            end
        end
    end

    lastX, lastY, lastZ = px, py, pz

    -- always update a small radius around the player in case a block changed
    i = (i + 1) % continuousUpdateDelay
    if i == 0 then
        for x = px - continuousUpdateRadius, px + continuousUpdateRadius, 1 do
            for y = py - continuousUpdateRadius, py + continuousUpdateRadius, 1 do
                for z = pz - continuousUpdateRadius, pz + continuousUpdateRadius, 1 do
                    table.insert(blockCheckQueue, { x, y, z, true })
                end
            end
        end
    end
end

t = 0
quadsToRender = {}
function render3d(dt)
    if radius == nil then return end --in case this runs before the settings are defined

    if dimension.time() > 0.25 and dimension.time() < 0.75 then return end

    if #blockCheckQueue > blockQueueMax then
        local newQueue = {}
        for i = #blockCheckQueue - blockQueueMax / 2, blockQueueMax / 2 do
            table.insert(newQueue, blockCheckQueue[i])
        end
        blockCheckQueue = newQueue
    end

    if #blockCheckQueue > 0 then
        local blocksChecked = 0
        while blocksChecked < blocksCheckedPerFrame and #blockCheckQueue > 0 do
            local wasChecked = checkBlockFromQueue() --this also actually does the check, but returns "if work was done"
            if wasChecked then
                blocksChecked = blocksChecked + 1
            else
                blocksChecked = blocksChecked + 0.005 --if it wasnt a block that had quads, do them way faster
            end
        end
    end

    if not px or not py or not pz then return end
    -- update the quads to render list every so often
    t = t + dt
    if t >= timeBetweenQuadUpdates then
        t = 0
        quadsToRender = getQuadsNeaby()
    end

    gfx.tcolor(255, 255, 255, shadowStrength.value)
    gfx.tquadbatch(
        quadsToRender, "shadowTiles", false
    )
end

allQuads = {}
function checkBlockFromQueue()
    -- *Starts from the end
    local bx = blockCheckQueue[#blockCheckQueue][1]
    local by = blockCheckQueue[#blockCheckQueue][2]
    local bz = blockCheckQueue[#blockCheckQueue][3]

    --if true, it will update the block even if it's already in the grid. this is for the continuous check to overwrite existing information
    local ignoreCheckConditions = blockCheckQueue[#blockCheckQueue][4]

    if not ignoreCheckConditions and blocksGrid[bx] ~= nil and blocksGrid[bx][by] ~= nil and blocksGrid[bx][by][bz] ~= nil then --if this block has already been done, skip it
        table.remove(blockCheckQueue)
        return false
    end

    if isTransparent(bx, by, bz) then
        addToGrid(bx, by, bz, false)
        table.remove(blockCheckQueue)
        return false
    end

    -- now I know this is a block I have to check all the sides of
    -- check all the blocks around to see which are transparent
    local yPosBlock = isTransparent(bx, by + 1, bz)
    local yNegBlock = isTransparent(bx, by - 1, bz)
    local xPosBlock = isTransparent(bx + 1, by, bz)
    local xNegBlock = isTransparent(bx - 1, by, bz)
    local zPosBlock = isTransparent(bx, by, bz + 1)
    local zNegBlock = isTransparent(bx, by, bz - 1)

    thisBlockQuads = {} -- this table will contain a few time indices, and within them, all the quads that belong to this block that should be drawn at this time
    -- later, this will be added to the grid
    -- then, it will go through all these grid entries and put all the quads for the time it wants into one long table

    -- the block is new and is solid, so see which of its faces are exposed
    if xPosBlock then
        local faceSampleInfo = {} --a 2d table, each element is a point that was sampled and contains {time: isInShadowAtThatTime}

        local numQuadsInShadow = {}
        for i = 1, sunTimesToCheck, 1 do
            numQuadsInShadow[i] = 0 --fill it with 0 to avoid errors later on
        end

        for i = 0, resolution, 1 do
            faceSampleInfo[i] = {}
            for j = 0, resolution, 1 do
                local sampleX = i / resolution
                local sampleY = j / resolution

                local sample = whenIsPointInShadow(bx + 1 + raycastOffset, sampleX + by, sampleY + bz, 1)
                for k = 1, #sample, 1 do --for each time, count up how many of the sample points are in shadow
                    if sample[k] then
                        numQuadsInShadow[k] = numQuadsInShadow[k] + 1
                    end
                end

                faceSampleInfo[i][j] = sample
            end
        end

        -- now, make quads with faceSampleInfo
        for k = 1, sunTimesToCheck, 1 do
            if thisBlockQuads[k] == nil then
                thisBlockQuads[k] = {}
            end

            if numQuadsInShadow[k] == 0 then
                -- there's no shadow
            elseif numQuadsInShadow[k] == (resolution + 1) * (resolution + 1) then --it's all shadow, so only render one quad for the whole face
                local rightEdgeOffset = 0
                local leftEdgeOffset = 0
                if zNegBlock then
                    leftEdgeOffset = -raycastOffset
                end
                if zPosBlock then
                    rightEdgeOffset = raycastOffset
                end
                local topEdgeOffset = 0
                local bottomEdgeOffset = 0
                if yNegBlock then
                    bottomEdgeOffset = -raycastOffset
                end
                if yPosBlock then
                    topEdgeOffset = raycastOffset
                end

                table.insert(thisBlockQuads[k], {
                    bx + 1 + raycastOffset, by + 1 + topEdgeOffset, bz + 1 + rightEdgeOffset,
                    0, 0.5,
                    bx + 1 + raycastOffset, by + bottomEdgeOffset, bz + 1 + rightEdgeOffset,
                    0, 0.5,
                    bx + 1 + raycastOffset, by + bottomEdgeOffset, bz + leftEdgeOffset,
                    0, 0.5,
                    bx + 1 + raycastOffset, by + 1 + topEdgeOffset, bz + leftEdgeOffset,
                    0, 0.5,
                })
            else
                -- it's gonna require many different quads
                for i = 0, resolution - 1, 1 do
                    for j = 0, resolution - 1, 1 do
                        local topLeftIsShadow = faceSampleInfo[i][j + 1][k]
                        local topRightIsShadow = faceSampleInfo[i + 1][j + 1][k]
                        local bottomLeftIsShadow = faceSampleInfo[i][j][k]
                        local bottomRightIsShadow = faceSampleInfo[i + 1][j][k]

                        local uvs = uvCoordsFromCornerShadows(
                            topLeftIsShadow, topRightIsShadow, bottomLeftIsShadow, bottomRightIsShadow
                        )

                        local rightEdgeOffset = 0
                        local leftEdgeOffset = 0
                        if j == 0 and zNegBlock then
                            leftEdgeOffset = -raycastOffset
                        end
                        if j == resolution - 1 and zPosBlock then
                            rightEdgeOffset = raycastOffset
                        end
                        local topEdgeOffset = 0
                        local bottomEdgeOffset = 0
                        if i == 0 and yNegBlock then
                            bottomEdgeOffset = -raycastOffset
                        end
                        if i == resolution - 1 and yPosBlock then
                            topEdgeOffset = raycastOffset
                        end

                        table.insert(thisBlockQuads[k], {
                            bx + 1 + raycastOffset,
                            i / resolution + by + bottomEdgeOffset,
                            j / resolution + bz + leftEdgeOffset,
                            uvs["bl"][1], uvs["bl"][2],
                            bx + 1 + raycastOffset,
                            (i + 1) / resolution + by + topEdgeOffset,
                            j / resolution + bz + leftEdgeOffset,
                            uvs["br"][1], uvs["br"][2],
                            bx + 1 + raycastOffset,
                            (i + 1) / resolution + by + topEdgeOffset,
                            (j + 1) / resolution + bz + rightEdgeOffset,
                            uvs["tr"][1], uvs["tr"][2],
                            bx + 1 + raycastOffset,
                            i / resolution + by + bottomEdgeOffset,
                            (j + 1) / resolution + bz + rightEdgeOffset,
                            uvs["tl"][1], uvs["tl"][2]
                        })
                    end
                end
            end
        end
    end
    if xNegBlock then
        local faceSampleInfo = {} --a 2d table, each element is a point that was sampled and contains {time: isInShadowAtThatTime}

        local numQuadsInShadow = {}
        for i = 1, sunTimesToCheck, 1 do
            numQuadsInShadow[i] = 0 --fill it with 0 to avoid errors later on
        end

        for i = 0, resolution, 1 do
            faceSampleInfo[i] = {}
            for j = 0, resolution, 1 do
                local sampleX = i / resolution
                local sampleY = j / resolution

                local sample = whenIsPointInShadow(bx - raycastOffset, sampleX + by, sampleY + bz, 2)
                for k = 1, #sample, 1 do --for each time, count up how many of the sample points are in shadow
                    if sample[k] then
                        numQuadsInShadow[k] = numQuadsInShadow[k] + 1
                    end
                end

                faceSampleInfo[i][j] = sample
            end
        end

        -- now, make quads with faceSampleInfo
        for k = 1, sunTimesToCheck, 1 do
            if thisBlockQuads[k] == nil then
                thisBlockQuads[k] = {}
            end

            if numQuadsInShadow[k] == 0 then
                --there's no shadow
            elseif numQuadsInShadow[k] == (resolution + 1) * (resolution + 1) then --it's all shadow, so only render one quad for the whole face
                local rightEdgeOffset = 0
                local leftEdgeOffset = 0
                if zNegBlock then
                    leftEdgeOffset = -raycastOffset
                end
                if zPosBlock then
                    rightEdgeOffset = raycastOffset
                end
                local topEdgeOffset = 0
                local bottomEdgeOffset = 0
                if yNegBlock then
                    bottomEdgeOffset = -raycastOffset
                end
                if yPosBlock then
                    topEdgeOffset = raycastOffset
                end

                table.insert(thisBlockQuads[k], {
                    bx - raycastOffset, by + bottomEdgeOffset, bz + 1 + rightEdgeOffset,
                    0, 0.5,
                    bx - raycastOffset, by + 1 + topEdgeOffset, bz + 1 + rightEdgeOffset,
                    0, 0.5,
                    bx - raycastOffset, by + 1 + topEdgeOffset, bz + leftEdgeOffset,
                    0, 0.5,
                    bx - raycastOffset, by + bottomEdgeOffset, bz + leftEdgeOffset,
                    0, 0.5,
                })
            else
                -- it's gonna require many different quads
                for i = 0, resolution - 1, 1 do
                    for j = 0, resolution - 1, 1 do
                        local topLeftIsShadow = faceSampleInfo[i][j + 1][k]
                        local topRightIsShadow = faceSampleInfo[i + 1][j + 1][k]
                        local bottomLeftIsShadow = faceSampleInfo[i][j][k]
                        local bottomRightIsShadow = faceSampleInfo[i + 1][j][k]

                        local uvs = uvCoordsFromCornerShadows(
                            topLeftIsShadow, topRightIsShadow, bottomLeftIsShadow, bottomRightIsShadow
                        )

                        local rightEdgeOffset = 0
                        local leftEdgeOffset = 0
                        if j == 0 and zNegBlock then
                            leftEdgeOffset = -raycastOffset
                        end
                        if j == resolution - 1 and zPosBlock then
                            rightEdgeOffset = raycastOffset
                        end
                        local topEdgeOffset = 0
                        local bottomEdgeOffset = 0
                        if i == 0 and yNegBlock then
                            bottomEdgeOffset = -raycastOffset
                        end
                        if i == resolution - 1 and yPosBlock then
                            topEdgeOffset = raycastOffset
                        end

                        table.insert(thisBlockQuads[k], {
                            bx - raycastOffset,
                            i / resolution + by + bottomEdgeOffset,
                            (j + 1) / resolution + bz + rightEdgeOffset,
                            uvs["tl"][1], uvs["tl"][2],
                            bx - raycastOffset,
                            (i + 1) / resolution + by + topEdgeOffset,
                            (j + 1) / resolution + bz + rightEdgeOffset,
                            uvs["tr"][1], uvs["tr"][2],
                            bx - raycastOffset,
                            (i + 1) / resolution + by + topEdgeOffset,
                            j / resolution + bz + leftEdgeOffset,
                            uvs["br"][1], uvs["br"][2],
                            bx - raycastOffset,
                            i / resolution + by + bottomEdgeOffset,
                            j / resolution + bz + leftEdgeOffset,
                            uvs["bl"][1], uvs["bl"][2],
                        })
                    end
                end
            end
        end
    end
    if yPosBlock then             --****----------- Good one
        local faceSampleInfo = {} --a 2d table, each element is a point that was sampled and contains {time: isInShadowAtThatTime}

        local numQuadsInShadow = {}
        for i = 1, sunTimesToCheck, 1 do
            numQuadsInShadow[i] = 0 --fill it with 0 to avoid errors later on
        end

        -- get all the samples of where the shadows will fall
        for i = 0, resolution, 1 do
            faceSampleInfo[i] = {}
            for j = 0, resolution, 1 do
                local sampleX = i / resolution
                local sampleY = j / resolution

                local sample = whenIsPointInShadow(sampleX + bx, by + 1 + raycastOffset, sampleY + bz, 3)
                for k = 1, #sample, 1 do --for each time, count up how many of the sample points are in shadow
                    if sample[k] then
                        numQuadsInShadow[k] = numQuadsInShadow[k] + 1
                    end
                end

                faceSampleInfo[i][j] = sample
            end
        end

        -- Now, make quads with faceSampleInfo
        for k = 1, sunTimesToCheck, 1 do
            if thisBlockQuads[k] == nil then
                thisBlockQuads[k] = {}
            end

            if numQuadsInShadow[k] == 0 then
                -- do nothing (no shadow here)
            elseif numQuadsInShadow[k] == (resolution + 1) * (resolution + 1) then --it's all shadow, so only render one quad for the whole face
                local rightEdgeOffset = 0
                local leftEdgeOffset = 0
                if xNegBlock then
                    leftEdgeOffset = -raycastOffset
                end
                if xPosBlock then
                    rightEdgeOffset = raycastOffset
                end
                local topEdgeOffset = 0
                local bottomEdgeOffset = 0
                if zNegBlock then
                    bottomEdgeOffset = -raycastOffset
                end
                if zPosBlock then
                    topEdgeOffset = raycastOffset
                end

                table.insert(thisBlockQuads[k], {
                    bx + leftEdgeOffset, by + 1 + raycastOffset, bz + 1 + topEdgeOffset,
                    0, 0.5,
                    bx + 1 + rightEdgeOffset, by + 1 + raycastOffset, bz + 1 + topEdgeOffset,
                    0, 0.5,
                    bx + 1 + rightEdgeOffset, by + 1 + raycastOffset, bz + bottomEdgeOffset,
                    0, 0.5,
                    bx + leftEdgeOffset, by + 1 + raycastOffset, bz + bottomEdgeOffset,
                    0, 0.5
                })
            else
                -- it's gonna require many different quads
                for i = 0, resolution - 1, 1 do
                    for j = 0, resolution - 1, 1 do
                        local topLeftIsShadow = faceSampleInfo[i][j + 1][k]
                        local topRightIsShadow = faceSampleInfo[i + 1][j + 1][k]
                        local bottomLeftIsShadow = faceSampleInfo[i][j][k]
                        local bottomRightIsShadow = faceSampleInfo[i + 1][j][k]

                        local uvs = uvCoordsFromCornerShadows(
                            topLeftIsShadow, topRightIsShadow, bottomLeftIsShadow, bottomRightIsShadow
                        )

                        local rightEdgeOffset = 0
                        local leftEdgeOffset = 0
                        if i == 0 and xNegBlock then
                            leftEdgeOffset = -raycastOffset
                        end
                        if i == resolution - 1 and xPosBlock then
                            rightEdgeOffset = raycastOffset
                        end

                        local topEgdeOffset = 0
                        local bottomEdgeOffset = 0
                        if j == 0 and zNegBlock then
                            bottomEdgeOffset = -raycastOffset
                        end
                        if j == resolution - 1 and zPosBlock then
                            topEgdeOffset = raycastOffset
                        end

                        table.insert(thisBlockQuads[k], {
                            i / resolution + bx + leftEdgeOffset,
                            by + 1 + raycastOffset,
                            (j + 1) / resolution + bz + topEgdeOffset,
                            uvs["tl"][1], uvs["tl"][2],
                            (i + 1) / resolution + bx + rightEdgeOffset,
                            by + 1 + raycastOffset,
                            (j + 1) / resolution + bz + topEgdeOffset,
                            uvs["tr"][1], uvs["tr"][2],
                            (i + 1) / resolution + bx + rightEdgeOffset,
                            by + 1 + raycastOffset,
                            j / resolution + bz + bottomEdgeOffset,
                            uvs["br"][1], uvs["br"][2],
                            i / resolution + bx + leftEdgeOffset,
                            by + 1 + raycastOffset,
                            j / resolution + bz + bottomEdgeOffset,
                            uvs["bl"][1], uvs["bl"][2],
                        })
                    end
                end
            end
        end
    end
    if yNegBlock then --*this can only be in shadow
        for k = 1, sunTimesToCheck, 1 do
            if thisBlockQuads[k] == nil then
                thisBlockQuads[k] = {}
            end
            local rightEdgeOffset = 0
            local leftEdgeOffset = 0
            if xNegBlock then
                leftEdgeOffset = -raycastOffset
            end
            if xPosBlock then
                rightEdgeOffset = raycastOffset
            end
            local topEdgeOffset = 0
            local bottomEdgeOffset = 0
            if zNegBlock then
                bottomEdgeOffset = -raycastOffset
            end
            if zPosBlock then
                topEdgeOffset = raycastOffset
            end
            table.insert(thisBlockQuads[k], {
                bx + 1 + rightEdgeOffset, by - raycastOffset, bz + 1 + topEdgeOffset,
                0, 0.5,
                bx + leftEdgeOffset, by - raycastOffset, bz + 1 + topEdgeOffset,
                0, 0.5,
                bx + leftEdgeOffset, by - raycastOffset, bz + bottomEdgeOffset,
                0, 0.5,
                bx + 1 + rightEdgeOffset, by - raycastOffset, bz + bottomEdgeOffset,
                0, 0.5,
            })
        end
    end
    if zPosBlock then
        local faceSampleInfo = {} --a 2d table, each element is a point that was sampled and contains {time: isInShadowAtThatTime}

        local numQuadsInShadow = {}
        for i = 1, sunTimesToCheck, 1 do
            numQuadsInShadow[i] = 0 --fill it with 0 to avoid errors later on
        end

        for i = 0, resolution, 1 do
            faceSampleInfo[i] = {}
            for j = 0, resolution, 1 do
                local sampleX = i / resolution
                local sampleY = j / resolution

                local sample = whenIsPointInShadow(sampleX + bx, sampleY + by, bz + raycastOffset + 1, 5)
                for k = 1, #sample, 1 do --for each time, count up how many of the sample points are in shadow
                    if sample[k] then
                        numQuadsInShadow[k] = numQuadsInShadow[k] + 1
                    end
                end

                faceSampleInfo[i][j] = sample
            end
        end

        -- now, make quads with faceSampleInfo
        for k = 1, sunTimesToCheck, 1 do
            if thisBlockQuads[k] == nil then
                thisBlockQuads[k] = {}
            end

            if numQuadsInShadow[k] == 0 then
                -- there's no shadow
            elseif numQuadsInShadow[k] == (resolution + 1) * (resolution + 1) then --it's all shadow, so only render one quad for the whole face
                local rightEdgeOffset = 0
                local leftEdgeOffset = 0
                if xNegBlock then
                    leftEdgeOffset = -raycastOffset
                end
                if xPosBlock then
                    rightEdgeOffset = raycastOffset
                end
                local topEdgeOffset = 0
                local bottomEdgeOffset = 0
                if yNegBlock then
                    bottomEdgeOffset = -raycastOffset
                end
                if yPosBlock then
                    topEdgeOffset = raycastOffset
                end

                table.insert(thisBlockQuads[k], {
                    bx + leftEdgeOffset, by + bottomEdgeOffset, bz + 1 + raycastOffset,
                    0, 0.5,
                    bx + 1 + rightEdgeOffset, by + bottomEdgeOffset, bz + 1 + raycastOffset,
                    0, 0.5,
                    bx + 1 + rightEdgeOffset, by + 1 + topEdgeOffset, bz + 1 + raycastOffset,
                    0, 0.5,
                    bx + leftEdgeOffset, by + 1 + topEdgeOffset, bz + 1 + raycastOffset,
                    0, 0.5,
                })
            else
                for i = 0, resolution - 1, 1 do
                    for j = 0, resolution - 1, 1 do
                        local topLeftIsShadow = faceSampleInfo[i][j + 1][k]
                        local topRightIsShadow = faceSampleInfo[i + 1][j + 1][k]
                        local bottomLeftIsShadow = faceSampleInfo[i][j][k]
                        local bottomRightIsShadow = faceSampleInfo[i + 1][j][k]

                        local uvs = uvCoordsFromCornerShadows(
                            topLeftIsShadow, topRightIsShadow, bottomLeftIsShadow, bottomRightIsShadow
                        )

                        local rightEdgeOffset = 0
                        local leftEdgeOffset = 0
                        if i == 0 and xNegBlock then
                            leftEdgeOffset = -raycastOffset
                        end
                        if i == resolution - 1 and xPosBlock then
                            rightEdgeOffset = raycastOffset
                        end
                        local topEdgeOffset = 0
                        local bottomEdgeOffset = 0
                        if j == 0 and yNegBlock then
                            bottomEdgeOffset = -raycastOffset
                        end
                        if j == resolution - 1 and yPosBlock then
                            topEdgeOffset = raycastOffset
                        end

                        table.insert(thisBlockQuads[k], {
                            i / resolution + bx + leftEdgeOffset,
                            j / resolution + by + bottomEdgeOffset,
                            bz + 1 + raycastOffset,
                            uvs["bl"][1], uvs["bl"][2],
                            (i + 1) / resolution + bx + rightEdgeOffset,
                            j / resolution + by + bottomEdgeOffset,
                            bz + 1 + raycastOffset,
                            uvs["br"][1], uvs["br"][2],
                            (i + 1) / resolution + bx + rightEdgeOffset,
                            (j + 1) / resolution + by + topEdgeOffset,
                            bz + 1 + raycastOffset,
                            uvs["tr"][1], uvs["tr"][2],
                            i / resolution + bx + leftEdgeOffset,
                            (j + 1) / resolution + by + topEdgeOffset,
                            bz + 1 + raycastOffset,
                            uvs["tl"][1], uvs["tl"][2],
                        })
                    end
                end
            end
        end
    end
    if zNegBlock then
        local faceSampleInfo = {} --a 2d table, each element is a point that was sampled and contains {time: isInShadowAtThatTime}

        local numQuadsInShadow = {}
        for i = 1, sunTimesToCheck, 1 do
            numQuadsInShadow[i] = 0 --fill it with 0 to avoid errors later on
        end

        for i = 0, resolution, 1 do
            faceSampleInfo[i] = {}
            for j = 0, resolution, 1 do
                local sampleX = i / resolution
                local sampleY = j / resolution

                local sample = whenIsPointInShadow(sampleX + bx, sampleY + by, bz - raycastOffset, 6)
                for k = 1, #sample, 1 do --for each time, count up how many of the sample points are in shadow
                    if sample[k] then
                        numQuadsInShadow[k] = numQuadsInShadow[k] + 1
                    end
                end

                faceSampleInfo[i][j] = sample
            end
        end

        -- now, make quads with faceSampleInfo
        for k = 1, sunTimesToCheck, 1 do
            if thisBlockQuads[k] == nil then
                thisBlockQuads[k] = {}
            end

            if numQuadsInShadow[k] == 0 then
                -- there's no shadow
            elseif numQuadsInShadow[k] == (resolution + 1) * (resolution + 1) then --it's all shadow, so only render one quad for the whole face
                local rightEdgeOffset = 0
                local leftEdgeOffset = 0
                if xNegBlock then
                    leftEdgeOffset = -raycastOffset
                end
                if xPosBlock then
                    rightEdgeOffset = raycastOffset
                end
                local topEdgeOffset = 0
                local bottomEdgeOffset = 0
                if yNegBlock then
                    bottomEdgeOffset = -raycastOffset
                end
                if yPosBlock then
                    topEdgeOffset = raycastOffset
                end

                table.insert(thisBlockQuads[k], {
                    bx + 1 + rightEdgeOffset, by + bottomEdgeOffset, bz - raycastOffset,
                    0, 0.5,
                    bx + leftEdgeOffset, by + bottomEdgeOffset, bz - raycastOffset,
                    0, 0.5,
                    bx + leftEdgeOffset, by + 1 + topEdgeOffset, bz - raycastOffset,
                    0, 0.5,
                    bx + 1 + rightEdgeOffset, by + 1 + topEdgeOffset, bz - raycastOffset,
                    0, 0.5,
                })
            else
                for i = 0, resolution - 1, 1 do
                    for j = 0, resolution - 1, 1 do
                        local topLeftIsShadow = faceSampleInfo[i][j + 1][k]
                        local topRightIsShadow = faceSampleInfo[i + 1][j + 1][k]
                        local bottomLeftIsShadow = faceSampleInfo[i][j][k]
                        local bottomRightIsShadow = faceSampleInfo[i + 1][j][k]

                        local uvs = uvCoordsFromCornerShadows(
                            topLeftIsShadow, topRightIsShadow, bottomLeftIsShadow, bottomRightIsShadow
                        )

                        local rightEdgeOffset = 0
                        local leftEdgeOffset = 0
                        if i == 0 and xNegBlock then
                            leftEdgeOffset = -raycastOffset
                        end
                        if i == resolution - 1 and xPosBlock then
                            rightEdgeOffset = raycastOffset
                        end
                        local topEdgeOffset = 0
                        local bottomEdgeOffset = 0
                        if j == 0 and yNegBlock then
                            bottomEdgeOffset = -raycastOffset
                        end
                        if j == resolution - 1 and yPosBlock then
                            topEdgeOffset = raycastOffset
                        end

                        table.insert(thisBlockQuads[k], {
                            i / resolution + bx + leftEdgeOffset,
                            (j + 1) / resolution + by + topEdgeOffset,
                            bz - raycastOffset,
                            uvs["tl"][1], uvs["tl"][2],
                            (i + 1) / resolution + bx + rightEdgeOffset,
                            (j + 1) / resolution + by + topEdgeOffset,
                            bz - raycastOffset,
                            uvs["tr"][1], uvs["tr"][2],
                            (i + 1) / resolution + bx + rightEdgeOffset,
                            j / resolution + by + bottomEdgeOffset,
                            bz - raycastOffset,
                            uvs["br"][1], uvs["br"][2],
                            i / resolution + bx + leftEdgeOffset,
                            j / resolution + by + bottomEdgeOffset,
                            bz - raycastOffset,
                            uvs["bl"][1], uvs["bl"][2],
                        })
                    end
                end
            end
        end
    end

    addToGrid(bx, by, bz, thisBlockQuads)
    table.remove(blockCheckQueue)
    return true
end

--[[
    directions:
    +x: 1
    -x: 2
    +y: 3
    -y: 4
    +z: 5
    -z: 6
]]
function whenIsPointInShadow(x, y, z, direction)
    local times = {}
    for i = 1, sunTimesToCheck, 1 do
        local thisSunTime = ((i - 0.5) / (2 * sunTimesToCheck) + 0.75) % 1
        local thisSunAngle = -2 * math.pi * thisSunTime
        local thisSunDirX = math.sin(thisSunAngle)
        local thisSunDirY = math.cos(thisSunAngle)

        if (direction == 1 and thisSunDirX < 0) or (direction == 2 and thisSunDirX > 0) or direction == 4 then
            table.insert(times, true) --these must be in shadow, no need to check
        else
            -- if the x, y, or z coordinate is on an edge, you'll need to check twice, once on each side of the edge
            local numXToCheck = 1
            if x == math.floor(x) then numXToCheck = 2 end
            local numYToCheck = 1
            if y == math.floor(y) then numYToCheck = 2 end
            local numZToCheck = 1
            if z == math.floor(z) then numZToCheck = 2 end

            local isInShadow = false
            for j = 1, numXToCheck, 1 do
                for k = 1, numYToCheck, 1 do
                    for l = 1, numZToCheck, 1 do
                        local xSamplePos = 0.1 * ((2 * numXToCheck - 2) * j - (3 * numXToCheck - 3)) + x
                        local ySamplePos = 0.1 * ((2 * numYToCheck - 2) * k - (3 * numYToCheck - 3)) + y
                        local zSamplePos = 0.1 * ((2 * numZToCheck - 2) * l - (3 * numZToCheck - 3)) + z
                        if dimension.raycast(
                                xSamplePos, ySamplePos, zSamplePos,
                                xSamplePos + thisSunDirX * 100, ySamplePos + thisSunDirY * 100, zSamplePos
                            ).isBlock == true then
                            isInShadow = true
                            goto skipCheck
                        end
                    end
                end
            end
            ::skipCheck::

            table.insert(times, isInShadow)
        end
    end
    return times
end

function uvCoordsFromCornerShadows(tl, tr, bl, br)
    local uvs = {}

    -- two next to eachother in shadow
    if tl and tr and (not bl) and (not br) then
        uvs["tl"] = { 0, 0.5 }
        uvs["tr"] = { 0.5, 0.5 }
        uvs["bl"] = { 0, 0 }
        uvs["br"] = { 0.5, 0 }
    elseif bl and br and (not tl) and (not tr) then
        uvs["tl"] = { 0, 0 }
        uvs["tr"] = { 0.5, 0 }
        uvs["bl"] = { 0, 0.5 }
        uvs["br"] = { 0.5, 0.5 }
    elseif tl and bl and (not tr) and (not br) then
        uvs["tl"] = { 0, 0.5 }
        uvs["tr"] = { 0, 0 }
        uvs["bl"] = { 0.5, 0.5 }
        uvs["br"] = { 0.5, 0 }
    elseif tr and br and (not tl) and (not bl) then
        uvs["tl"] = { 0, 0 }
        uvs["tr"] = { 0, 0.5 }
        uvs["bl"] = { 0.5, 0 }
        uvs["br"] = { 0.5, 0.5 }

        -- Only one in light
    elseif tr and tl and bl and (not br) then
        uvs["tl"] = { 0, 0.5 }
        uvs["tr"] = { 0.5, 0.5 }
        uvs["bl"] = { 0, 1 }
        uvs["br"] = { 0.5, 1 }
    elseif tr and tl and br and (not bl) then
        uvs["tl"] = { 0.5, 0.5 }
        uvs["tr"] = { 0, 0.5 }
        uvs["bl"] = { 0.5, 1 }
        uvs["br"] = { 0, 1 }
    elseif tr and br and bl and (not tl) then
        uvs["tl"] = { 0.5, 1 }
        uvs["tr"] = { 0, 1 }
        uvs["bl"] = { 0.5, 0.5 }
        uvs["br"] = { 0, 0.5 }
    elseif br and tl and bl and (not tr) then
        uvs["tl"] = { 0, 1 }
        uvs["tr"] = { 0.5, 1 }
        uvs["bl"] = { 0, 0.5 }
        uvs["br"] = { 0.5, 0.5 }

        -- only one in shadow
    elseif (not tr) and (not tl) and (not bl) and br then
        uvs["tl"] = { 1, 1 }
        uvs["tr"] = { 0.5, 1 }
        uvs["bl"] = { 1, 0.5 }
        uvs["br"] = { 0.5, 0.5 }
    elseif (not tr) and (not tl) and (not br) and bl then
        uvs["tl"] = { 0.5, 1 }
        uvs["tr"] = { 1, 1 }
        uvs["bl"] = { 0.5, 0.5 }
        uvs["br"] = { 1, 0.5 }
    elseif (not tr) and (not br) and (not bl) and tl then
        uvs["tl"] = { 0.5, 0.5 }
        uvs["tr"] = { 1, 0.5 }
        uvs["bl"] = { 0.5, 1 }
        uvs["br"] = { 1, 1 }
    elseif (not br) and (not tl) and (not bl) and tr then
        uvs["tl"] = { 1, 0.5 }
        uvs["tr"] = { 0.5, 0.5 }
        uvs["bl"] = { 1, 1 }
        uvs["br"] = { 0.5, 1 }

        -- two opposites in shadow
    elseif bl and tr and (not tl) and (not br) then
        uvs["tl"] = { 0.5, 0 }
        uvs["tr"] = { 1, 0 }
        uvs["bl"] = { 0.5, 0.5 }
        uvs["br"] = { 1, 0.5 }
    elseif tl and br and (not bl) and (not tr) then
        uvs["tl"] = { 1, 0 }
        uvs["tr"] = { 0.5, 0 }
        uvs["bl"] = { 1, 0.5 }
        uvs["br"] = { 0.5, 0.5 }

        -- not in shadow at all
    elseif (not tr) and (not tl) and (not br) and (not bl) then
        uvs["tl"] = { 0, 0 }
        uvs["tr"] = { 0, 0 }
        uvs["bl"] = { 0, 0 }
        uvs["br"] = { 0, 0 }

        -- all in shadow
    else
        uvs["tl"] = { 0, 0.5 }
        uvs["tr"] = { 0, 0.5 }
        uvs["bl"] = { 0, 0.5 }
        uvs["br"] = { 0, 0.5 }
    end

    return uvs
end

function getQuadsNeaby()
    -- getting the closest time sample to the current time:
    local lowestSampleDist = 10000000 --random big number
    local lowestSampleIndex = -1      --random number < 0
    local thisTime = dimension.time()
    for i = 1, sunTimesToCheck do
        local thisSampleTime = ((i - 0.5) / (2 * sunTimesToCheck) + 0.75) % 1
        local timeDiff = math.abs(thisTime - thisSampleTime) --the difference between this sample's time and the actual time
        if (timeDiff < lowestSampleDist) then
            lowestSampleDist = timeDiff
            lowestSampleIndex = i
        end
    end

    local quads = {}
    for x = -radius + px, radius + px, 1 do
        for y = -radius + py, radius + py, 1 do
            for z = -radius + pz, radius + pz, 1 do
                if blocksGrid[x] and blocksGrid[x][y] and blocksGrid[x][y][z] and blocksGrid[x][y][z][lowestSampleIndex] then
                    for i = 1, #blocksGrid[x][y][z][lowestSampleIndex], 1 do
                        table.insert(quads, blocksGrid[x][y][z][lowestSampleIndex][i])
                    end
                end
            end
        end
    end

    return quads
end

--[[
    in the block grid:
        nil: not yet checked
        false: is air
        a table: the shadow quads at times
]]
function addToGrid(x, y, z, content)
    if blocksGrid[x] == nil then blocksGrid[x] = {} end
    if blocksGrid[x][y] == nil then blocksGrid[x][y] = {} end
    blocksGrid[x][y][z] = content
end

function isTransparent(x, y, z)
    local transparentTable = { 0, 87, 131, 51, 140, 240, 200, 92, 111, 76, 72, 409, 406, 408, 405, 407, 66281, 66202, 66329, 11, 78, 66305, 66053, 66054, 70, 147, 148, 66086, 143, 399, 396, 398, 395, 397, 66278, 66321, 66302, 83, 77, 66051, 66052, 66087, 208, 66103, 151, 94, 150, 154, 66077, 66081, 464, 461, 412, 452, 120, 66, 27, 28, 126, 117, 449, 411, 66059, 450, 66342, 55, 393, 130, 146, 54, 217, 416, 66338, 6, 66358, 59, 104, 244, 105, 462, 145, 66126, 66129, 66128, 66022, 66078, 66113, 199, 66130, 66060, 463, 66219, 66218, 66217, 66216, 66215, 66214, 66213, 66212, 66211, 66210, 66209, 66208, 66207, 66206, 66205, 66204, 66203, 857, 853, 861, 26, 862, 854, 860, 864, 856, 855, 852, 865, 863, 866, 858, 859, 171, 66269, 66183, 66179, 66175, 66171, 66240, 66158, 66157, 66156, 66155, 66154, 66153, 66075, 66084, 66073, 66056, 66055, 182, 421, 44, 417, 66315, 66304, 66330, 66280, 158, 420, 903, 899, 907, 908, 900, 906, 910, 902, 898, 901, 911, 909, 32, 912, 904, 905, 160, 101, 66038, 66037, 167, 66311, 66334, 66287, 402, 400, 403, 401, 404, 96, 66036, 66035, 71, 66308, 66322, 66284, 197, 196, 195, 194, 193, 64, 66271, 66184, 66176, 66180, 66172, 66239, 66151, 66150, 66149, 66148, 66147, 66146, 66145, 66066, 66083, 66067, 66046, 66045, 259, 258, 257, 203, 440, 156, 433, 439, 114, 108, 429, 426, 428, 425, 427, 424, 431, 180, 432, 128, 430, 109, 66314, 66303, 66332, 66279, 164, 163, 136, 135, 134, 53, 434, 67, 435, 66050, 66049, 66307, 66324, 66283, 186, 187, 185, 184, 183, 107, 66048, 66047, 113, 66306, 66323, 66282, 832, 830, 833, 831, 834, 85, 66272, 66185, 66177, 66181, 66173, 66069, 66088, 66068, 139, 65, 142, 177, -257, -256, -515, -532, -491, -577, -575, -578, -576, -579, 50, 523, 385, 20, 241, 242, 243, 245, 246, 247, 248, 249, 250, 251, 252, 253, 254, 255, 79, 212, 213, 470, 165, 9, 8, 415, 102, 31, 175, 37, 38, 39, 40, 41, 42, 43, 45, 46, 106, 418, 127, 188, 189, 190, 191, 192, 410, 666 }
    local id = dimension.getBlock(x, y, z).id

    for i = 1, #transparentTable do
        if id == transparentTable[i] then
            return true
        end
    end

    return false
end
