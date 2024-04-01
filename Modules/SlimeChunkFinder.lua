name = "Slime Chunk Finder"
description = "Why not?"

color = client.settings.addNamelessColor("Chunk Color", { 0, 255, 0 })
client.settings.addCategory("Minimap Mode")
minimapmode = client.settings.addNamelessBool("Minimap Mode", true)
minimapchunksize = client.settings.addNamelessInt("Minimap Chunk Size", 2, 16, 4)
playerarrowsize = client.settings.addNamelessFloat("Arrow Size", 0, 20, 1)
client.settings.addCategory("3d Mode")
_3dmode = client.settings.addNamelessBool("3D Mode", false)
rd = client.settings.addNamelessInt("Render Distance", 1, 69, 8)
lines = client.settings.addNamelessFloat("Line Spacing", 0.069, 16, 4)
renderbehind = client.settings.addNamelessBool("Render Behind", false)

ct = {}
notct = {}
cx, cz = 0, 0
sizeX, sizeY = 50, 50
positionX, positionY = 0, 0
function setContains(set, table)
    for i = 1, #set do
        if set[i][1] == table[1] and set[i][2] == table[2] then
            return true
        end
    end
end
function update()
    if #ct + #notct > 1000 then ct, notct = {}, {} end
    px, _, pz = player.pposition()
    cx, cz = math.floor(px / 16), math.floor(pz / 16)
    offset = minimapmode.value and math.floor(24 / minimapchunksize.value) or rd.value
    for i = cx - offset, cx + offset do
        for j = cz - offset, cz + offset do
            chunk = {i, j}
            if not setContains(ct, chunk) and not setContains(notct, chunk) then
                if slime(chunk) then
                    table.insert(ct, chunk)
                else
                    table.insert(notct, chunk)
                end
            end
        end
    end
end
function render3d()
    px, _, pz = player.pposition()
    if not _3dmode.value then return end
    gfx.renderBehind(renderbehind.value)
    for i = 1, #ct do
        x, z = ct[i][1] * 16, ct[i][2] * 16
        if math.abs(x - px) < rd.value * 16 and math.abs(z - pz) < rd.value * 16 then
            gfx.color(color.value.r * 255, color.value.g * 255, color.value.b * 255)
            chunk_border(x, -64, z, 16, 256, 16)
        end
    end
end
function render2(dt)
    px, _, pz = player.pposition()
    if not minimapmode.value then return end
    theme = gui.theme()
    size = minimapchunksize.value
    gfx2.color(theme.windowBackground)
    gfx2.fillRect(0, 0, sizeX, sizeY)
    gfx2.color(theme.outline)
    gfx2.drawRect(0, 0, sizeX, sizeY, .5)
    for i = 1, #ct do
        x, z = ct[i][1] * 16, ct[i][2] * 16
        Offset = 16 / size
        gfx2.pushClipArea(.5, .5, sizeX - 1, sizeY - 1)
        gfx2.color(color.value.r * 255, color.value.g * 255, color.value.b * 255)
        gfx2.fillRect(sizeX / 2 + x / Offset - px / Offset, sizeY / 2 + z / Offset - pz / Offset, size, size)
        gfx2.popClipArea()
    end
    for i = -15, 15 do
        for j = -15, 15 do
            x, z = (cx + i) * 16, (cz + j) * 16
            Offset = 16 / size
            gfx2.pushClipArea(.5, .5, sizeX - 1, sizeY - 1)
            gfx2.color(125, 125, 125)
            gfx2.drawRect(sizeX / 2 + x / Offset - px / Offset, sizeY / 2 + z / Offset - pz / Offset, size, size, .1)
            gfx2.popClipArea()
        end
    end
    gfx2.color(255, 0, 0)
    e = sizeX / 2
    gfx2.pushTransformation({3, player.rotation(), e, e})
    size_ = playerarrowsize.value
    gfx2.fillTriangle(e, e + size_, e - size_, e - size_, e + size_, e - size_)
end
function chunk_border(x, y, z, sex, sy, sz)
    line = lines.value
    for i = 0, sex, line do
        gfx.line(x + i, y, z + sz, x + i, y + sy, z + sz)
        gfx.line(x + i, y, z, x + i, y + sy, z)
        gfx.line(x + sex, y, z + i, x + sex, y + sy, z + i)
        gfx.line(x, y, z + i, x, y + sy, z + i)
    end
    for i = 0, sy, line do
        gfx.line(x, y + i, z, x, y + i, z + sz)
        gfx.line(x + sex, y + i, z, x + sex, y + i, z + sz)
        gfx.line(x, y + i, z, x + sex, y + i, z)
        gfx.line(x, y + i, z + sz, x + sex, y + i, z + sz)
    end
end

function slime(m)
    m = toSigned32Bit(math.imul(m[1], 0x1f1f1f1f) ~ m[2])
    function f(x, y) return math.imul(x ~ unsignedRightShift(x, 30), 0x6c078965) + y end
    a = toSigned32Bit(m & 0x80000000) | toSigned32Bit(f(m, 1) & 0x7fffffff)
    m = toSigned32Bit(f(m, 1))
    for i = 2, 397 do m = toSigned32Bit(f(m, i)) end
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
function math.imul(x, y)
    function ToInt32(x) return x & 0xffffffff end
    result = ToInt32(ToInt32(x) * ToInt32(y))
    if result >= 0x80000000 then result = result - 0x100000000 end
    return result
end
