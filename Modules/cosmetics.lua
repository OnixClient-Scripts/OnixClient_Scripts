name = "Cosmetics"
description = "Crown and halo cosmetics for Onix Client"

cosmeticNum = 1
client.settings.addInt("Cosmetic:", "cosmeticNum", 1, 2)

-- "p" inputs are all a table of {x, y, z}
function noCullingTriangle(p1, p2, p3)
    gfx.triangle(p1[1], p1[2], p1[3], p2[1], p2[2], p2[3], p3[1], p3[2], p3[3])
    gfx.triangle(p3[1], p3[2], p3[3], p2[1], p2[2], p2[3], p1[1], p1[2], p1[3])
end

-- turns dimension of a prism into points
function getPrism3d(x, y, z, width, height, depth)
    local prismPoints = {}

    local hW = width / 2
    local hH = height / 2
    local hD = depth / 2

    table.insert(prismPoints, { x - hW, y - hH, z - hD })
    table.insert(prismPoints, { x + hW, y - hH, z - hD })
    table.insert(prismPoints, { x - hW, y + hH, z - hD })
    table.insert(prismPoints, { x + hW, y + hH, z - hD })
    table.insert(prismPoints, { x - hW, y - hH, z + hD })
    table.insert(prismPoints, { x + hW, y - hH, z + hD })
    table.insert(prismPoints, { x - hW, y + hH, z + hD })
    table.insert(prismPoints, { x + hW, y + hH, z + hD })

    return prismPoints
end

-- rotates a prism, given all it's points
function rotatePrism(prism, originX, originY, originZ, pitch, yaw)
    local output = {}
    for i = 1, #prism, 1 do
        local newPoint = rotatePoint(prism[i][1], prism[i][2], prism[i][3], originX, originY, originZ, pitch, yaw)
        table.insert(output, newPoint)
    end

    return output
end

-- rotates a point in 3d space
function rotatePoint(x, y, z, originX, originY, originZ, pitch, yaw)
    local newX, newY, newZ

    -- rotate along z axis
    x = x - originX
    y = y - originY

    newX = x * math.cos(pitch) - y * math.sin(pitch)
    newY = x * math.sin(pitch) + y * math.cos(pitch)

    x = newX + originX
    y = newY + originY

    -- rotate along y axis
    x = x - originX
    z = z - originZ

    newX = z * math.sin(yaw) + x * math.cos(yaw)
    newZ = z * math.cos(yaw) - x * math.sin(yaw)

    x = newX + originX
    z = newZ + originZ

    return { x, y, z }
end

-- renders an array of points for a prism using triangles
function renderPrism3d(prism)
    for i = 1, 8, 4 do
        -- 1, 2, 3 --- 5, 6, 7
        noCullingTriangle(prism[i], prism[i + 1], prism[i + 2])

        -- 2, 3, 4 --- 6, 7, 8
        noCullingTriangle(prism[i + 1], prism[i + 2], prism[i + 3])
    end

    for i = 1, 2, 1 do
        -- 1, 3, 5 --- 2, 4, 6
        noCullingTriangle(prism[i], prism[i + 2], prism[i + 4])

        -- 3, 5, 7 --- 4, 6, 8
        noCullingTriangle(prism[i + 2], prism[i + 4], prism[i + 6])
    end

    for i = 1, 4, 2 do
        -- 1, 2, 5 --- 3, 4, 7
        noCullingTriangle(prism[i], prism[i + 1], prism[i + 4])

        -- 2, 5, 6 --- 4, 7, 8
        noCullingTriangle(prism[i + 1], prism[i + 4], prism[i + 5])
    end
end

iterations = 0
function render3d()

    if player.perspective() == 0 then return end

    px, py, pz = player.pposition()
    pYaw, pPitch = player.rotation()

    if player.getFlag(1) then
        py = py - 0.25
    end

    local x, y, z, oX, oY, oZ, rPitch, rYaw, prism

    -- ----------------------------------------------------------------
    if cosmeticNum == 1 then
        x = px
        y = py + 0.5 + math.sin(iterations / 100) / 10
        z = pz

        oX = px
        oY = py - 0.2
        oZ = pz

        rPitch = math.rad(-pPitch)
        rYaw = math.rad(-pYaw - 90)

        gfx.color(255, 215, 0)

        prism = getPrism3d(x + 0.15, y, z, 0.05, 0.05, 0.25)
        prism = rotatePrism(prism, x, y, z, 0, iterations / 100)
        prism = rotatePrism(prism, oX, oY, oZ, rPitch, rYaw)
        renderPrism3d(prism)

        prism = getPrism3d(x - 0.15, y, z, 0.05, 0.05, 0.25)
        prism = rotatePrism(prism, x, y, z, 0, iterations / 100)
        prism = rotatePrism(prism, oX, oY, oZ, rPitch, rYaw)
        renderPrism3d(prism)

        prism = getPrism3d(x, y, z + 0.15, 0.25, 0.05, 0.05)
        prism = rotatePrism(prism, x, y, z, 0, iterations / 100)
        prism = rotatePrism(prism, oX, oY, oZ, rPitch, rYaw)
        renderPrism3d(prism)

        prism = getPrism3d(x, y, z - 0.15, 0.25, 0.05, 0.05)
        prism = rotatePrism(prism, x, y, z, 0, iterations / 100)
        prism = rotatePrism(prism, oX, oY, oZ, rPitch, rYaw)
        renderPrism3d(prism)
    end
    -- ----------------------------------------------------------------
    if cosmeticNum == 2 then
        x = px
        y = py + 0.15
        z = pz

        oX = px
        oY = py - 0.2
        oZ = pz

        rPitch = math.rad(-pPitch)
        rYaw = math.rad(-pYaw - 90)

        gfx.color(255, 215, 0)
        prism = getPrism3d(x, y, z, 0.55, 0.17, 0.55)
        prism = rotatePrism(prism, oX, oY, oZ, rPitch, rYaw)
        renderPrism3d(prism)

        for i = -1, 1, 2 do
            gfx.color(255, 215, 0)
            prism = getPrism3d(x + (0.27 * i), y + 0.08, z - 0.12, 0.05, 0.2, 0.15)
            prism = rotatePrism(prism, oX, oY, oZ, rPitch, rYaw)
            renderPrism3d(prism)

            prism = getPrism3d(x + (0.27 * i), y + 0.08, z + 0.12, 0.05, 0.2, 0.15)
            prism = rotatePrism(prism, oX, oY, oZ, rPitch, rYaw)
            renderPrism3d(prism)

            prism = getPrism3d(x - 0.12, y + 0.08, z + (0.27 * i), 0.15, 0.2, 0.05)
            prism = rotatePrism(prism, oX, oY, oZ, rPitch, rYaw)
            renderPrism3d(prism)

            prism = getPrism3d(x + 0.12, y + 0.08, z + (0.27 * i), 0.15, 0.2, 0.05)
            prism = rotatePrism(prism, oX, oY, oZ, rPitch, rYaw)
            renderPrism3d(prism)


            gfx.color(0, 255, 0)
            prism = getPrism3d(x + (0.27 * i), y + 0.08, z - 0.12, 0.07, 0.07, 0.07)
            prism = rotatePrism(prism, oX, oY, oZ, rPitch, rYaw)
            renderPrism3d(prism)

            gfx.color(0, 0, 255)
            prism = getPrism3d(x + (0.27 * i), y + 0.08, z + 0.12, 0.07, 0.07, 0.07)
            prism = rotatePrism(prism, oX, oY, oZ, rPitch, rYaw)
            renderPrism3d(prism)

            gfx.color(255, 0, 0)
            prism = getPrism3d(x + 0.12, y + 0.08, z + (0.27 * i), 0.07, 0.07, 0.07)
            prism = rotatePrism(prism, oX, oY, oZ, rPitch, rYaw)
            renderPrism3d(prism)

            gfx.color(255, 0, 255)
            prism = getPrism3d(x - 0.12, y + 0.08, z + (0.27 * i), 0.07, 0.07, 0.07)
            prism = rotatePrism(prism, oX, oY, oZ, rPitch, rYaw)
            renderPrism3d(prism)
        end
    end
    -- ----------------------------------------------------------------

    iterations = iterations + 1
end
