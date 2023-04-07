--[[
    Made by Zeyrox1090/Zeuroux/Blueberry#5784
    Version: 1.5
        Instructions:
        1. Go and mess with this
    ]]--
name = "Circle Tool"
description = "Helps you build circles in minecraft"

color = { 0, 255, 255 }
client.settings.addCategory("Circle settings")
px = client.settings.addNamelessTextbox("X:", "0")
py = client.settings.addNamelessTextbox("Y:", "0")
pz = client.settings.addNamelessTextbox("Z:", "0")
r = client.settings.addNamelessInt("Radius:", 1, 200, 10)
vd = client.settings.addNamelessInt("View Distance:", 10, 100, 20)
t = client.settings.addNamelessInt("Thickness:", 1, 20, 1)
client.settings.addColor("Block Color", "color")
hollow = client.settings.addNamelessBool("Hollow", false);
vertical = client.settings.addNamelessBool("Vertical", false);
rotate = client.settings.addNamelessBool("Rotate", false);
keybind = client.settings.addNamelessKeybind("Set Center Chunk Coords:", 0x4F)

function render3d()
    px_, py_, pz_ = player.position()
    drawPixelCircle(tonumber(px.value), tonumber(py.value), tonumber(pz.value), r.value, t.value)
    t.max = r.value;
end

function drawPixelCircle(xc, yc, zc, radius, thickness)
    local x_min, x_max = xc - radius, xc + radius
    local y_min, y_max = yc - radius, yc + radius
    local z_min, z_max = zc - radius, zc + radius
    local r2 = radius * radius
    local t2 = (radius - thickness) * (radius - thickness)
    local hollow_val = hollow.value and thickness > 0
    if vertical.value and rotate.value then
        for x = x_min, x_max do
            for y = y_min, y_max do
                if (x - xc)^2 + (y - yc)^2 <= r2 then
                    if not hollow_val or (x - xc)^2 + (y - yc)^2 >= t2 then
                        if math.sqrt((x - px_)^2 + (y - py_)^2 + (zc - pz_)^2) <= vd.value then
                            cubexyz(x, y, zc, 1, 1, 1)
                        end
                    end
                end
            end
        end
    elseif vertical.value and not rotate.value then
        for z = z_min, z_max do
            for y = y_min, y_max do
                if (y - yc)^2 + (z - zc)^2 <= r2 then
                    if not hollow_val or (y - yc)^2 + (z - zc)^2 >= t2 then
                        if math.sqrt((xc - px_)^2 + (y - py_)^2 + (z - pz_)^2) <= vd.value then
                            cubexyz(xc, y, z, 1, 1, 1)
                        end
                    end
                end
            end
        end
    else
        for x = x_min, x_max do
            for z = z_min, z_max do
                if (x - xc)^2 + (z - zc)^2 <= r2 then
                    if not hollow_val or (x - xc)^2 + (z - zc)^2 >= t2 then
                        if math.sqrt((x - px_)^2 + (yc - py_)^2 + (z - pz_)^2) <= vd.value then
                            cubexyz(x, yc, z, 1, 1, 1)
                        end
                    end
                end
            end
        end
    end
end

function cubexyz(x, y, z, sx, sy, sz)
    gfx.color(color.r, color.g, color.b)
    local cx, cy, cz = x + sx/2, y + sy/2, z + sz/2
    local vx, vy, vz = cx - px_, cy - py_ -2, cz - pz_
    local dot_x1 = vx * -1
    local dot_x2 = vx
    local dot_y1 = vy * -1
    local dot_y2 = vy
    local dot_z1 = vz * -1
    local dot_z2 = vz
    if dot_x1 < 0 then
        gfx.quad(x, y, z, x, y, z + sz, x, y + sy, z + sz, x, y + sy, z, true)
    end
    if dot_x2 < 0 then
        gfx.quad(x + sx, y, z, x + sx, y + sy, z, x + sx, y + sy, z + sz, x + sx, y, z + sz, true)
    end
    if dot_y1 < 0 then
        gfx.quad(x, y, z, x + sx, y, z, x + sx, y, z + sz, x, y, z + sz, true)
    end
    if dot_y2 < 0 then
        gfx.quad(x, y + sy, z, x, y + sy, z + sz, x + sx, y + sy, z + sz, x + sx, y + sy, z, true)
    end
    if dot_z1 < 0 then
        gfx.quad(x, y, z, x + sx, y, z, x + sx, y + sy, z, x, y + sy, z, true)
    end
    if dot_z2 < 0 then
        gfx.quad(x, y, z + sz, x + sx, y, z + sz, x + sx, y + sy, z + sz, x, y + sy, z + sz, true)
    end
end

event.listen("KeyboardInput", function(key, state)
    if keybind.value == key and state and not gui.mouseGrabbed() then
        x, y, z = player.position()
        px.value = x
        py.value = y
        pz.value = z
    end
end)