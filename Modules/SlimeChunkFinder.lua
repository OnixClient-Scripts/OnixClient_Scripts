name = "Slime Chunk Finder"
description = "Why not?"
color = client.settings.addNamelessColor("Chunk Color", { 0, 255, 0 })
minimapmode = client.settings.addNamelessBool("Minimap Mode", false)
minimapchunksize = client.settings.addNamelessInt("Minimap Chunk Size", 2, 16, 4)

client.settings.addCategory("3d Mode")

rd = client.settings.addNamelessInt("Render Distance", 1, 69, 8)
lines = client.settings.addNamelessFloat("Line Spacing", 0.069, 16, 4)
renderbehind = client.settings.addNamelessBool("Render Behind", false)

ct = {}
notct = {}

sizeX = 50
sizeY = 50
positionX = 0
positionY = 0

function update(dt)
    px, py, pz = player.position()
    cx = math.floor(px / 16)
    cz = math.floor(pz / 16)
    if minimapmode.value then
        offset = math.floor(24 / minimapchunksize.value)
    else
        offset = rd.value
    end
    for i = cx - offset, cx + offset do
        for j = cz - offset, cz + offset do
            if not setContains(ct, { i, j }) and not setContains(notct, { i, j }) then
                if slime({ i, j }) then
                    table.insert(ct, { i, j })
                else
                    table.insert(notct, { i, j })
                end
            end
        end
    end
end

function setContains(set, table)
    for i = 1, #set do
        if set[i][1] == table[1] and set[i][2] == table[2] then
            return true
        end
    end
end

function render3d()
    if minimapmode.value then return end
    px, py, pz = player.position()
    gfx.renderBehind(renderbehind.value)
    for i = 1, #ct do
        x = ct[i][1] * 16
        z = ct[i][2] * 16
        if math.abs(x - px) < rd.value * 16 and math.abs(z - pz) < rd.value * 16 then
            gfx.color(color.value.r * 255, color.value.g * 255, color.value.b * 255)
            chunk_border(x, -64, z, 16, 256, 16)
        end
    end
end



function render2()
    theme = gui.theme()
    size = minimapchunksize.value
    offsetZ = 16 / size
    offsetX = 16 / size
    if not minimapmode.value then return end
    px, py, pz = player.position()
    yaw, pitch = player.rotation()
    gfx2.color(theme.windowBackground)
    gfx2.fillRect(0, 0, sizeX, sizeY)
    gfx2.color(theme.outline)
    gfx2.drawRect(0, 0, sizeX, sizeY, .5)
    for i = 1, #ct do
        x = ct[i][1] * 16
        z = ct[i][2] * 16
        gfx2.color(color.value.r * 255, color.value.g * 255, color.value.b * 255)

        gfx2.pushClipArea(.5, .5, sizeX - 1, sizeY - 1)
        gfx2.fillRect(sizeX / 2 + x / offsetX - px / offsetX, sizeY / 2 + z / offsetZ - pz / offsetZ, size, size)
        gfx2.color(255, 0, 0)
        x = sizeX / 2
        y = sizeY / 2
        drawTriangle(x, y, 2, -2, yaw)
    end
end

function drawTriangle(x, y, sx, sy, rotation)
    function rotatePoint(x, y, angleDegrees)
        local angleRadians = math.rad(angleDegrees)
        local cosTheta = math.cos(angleRadians)
        local sinTheta = math.sin(angleRadians)
        local newX = x * cosTheta - y * sinTheta
        local newY = x * sinTheta + y * cosTheta
        return newX, newY
    end

    local p1x, p1y = 0, -sy / 2
    local p2x, p2y = sx / 2, sy / 2
    local p3x, p3y = -sx / 2, sy / 2
    p1x, p1y = rotatePoint(p1x, p1y, rotation)
    p2x, p2y = rotatePoint(p2x, p2y, rotation)
    p3x, p3y = rotatePoint(p3x, p3y, rotation)
    p1x, p1y = p1x + x, p1y + y
    p2x, p2y = p2x + x, p2y + y
    p3x, p3y = p3x + x, p3y + y
    gfx2.fillTriangle(p1x, p1y, p2x, p2y, p3x, p3y)
end

function slime(m)
    m = toSigned32Bit(imul(m[1], 0x1f1f1f1f) ~ m[2])
    function f(x, y)
        return imul(x ~ unsignedRightShift(x, 30), 0x6c078965) + y
    end

    a = toSigned32Bit(m & 0x80000000) | toSigned32Bit(f(m, 1) & 0x7fffffff);
    m = toSigned32Bit(f(m, 1))
    for i = 2, 397 do
        m = toSigned32Bit(f(m, i))
    end
    t = { 0, 0x9908b0df }
    m = toSigned32Bit(m ~ unsignedRightShift(a, 1) ~ t[(a & 1) + 1])
    m = toSigned32Bit(m ~ unsignedRightShift(m, 11))
    m = toSigned32Bit(m ~ m << 7 & 0x9d2c5680)
    m = toSigned32Bit(m ~ m << 15 & 0xefc60000)
    m = toSigned32Bit(m ~ unsignedRightShift(m, 18))
    return ((unsignedRightShift(m, 0) % 10) == 0)
end

function unsignedRightShift(value, shift) return math.floor((value % 2 ^ 32) / (2 ^ shift)) end

function toSigned32Bit(unsignedValue) return (unsignedValue % 0x100000000 + 0x80000000) % 0x100000000 - 0x80000000 end

function ToInt32(x) return x & 0xffffffff end

function imul(x, y)
    result = (ToInt32(x) * ToInt32(y)) & 0xffffffff
    if result >= 0x80000000 then result = result - 0x100000000 end
    return result
end

function chunk_border(x, y, z, sex, sy, sz)
    for i = 0, sex, lines.value do
        gfx.line(x + i, y, z + sz, x + i, y + sy, z + sz)
        gfx.line(x + i, y, z, x + i, y + sy, z)
        gfx.line(x + sex, y, z + i, x + sex, y + sy, z + i)
        gfx.line(x, y, z + i, x, y + sy, z + i)
    end
    for i = 0, sy, lines.value do
        gfx.line(x, y + i, z, x, y + i, z + sz)
        gfx.line(x + sex, y + i, z, x + sex, y + i, z + sz)
        gfx.line(x, y + i, z, x + sex, y + i, z)
        gfx.line(x, y + i, z + sz, x + sex, y + i, z + sz)
    end
end
