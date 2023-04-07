--[[
    Made by: Zeyrox1090/Zeuroux/Blueberry#5784
    Version: 1.5
    Instructions: 
        1. Go to a ocean monument
        2. Go to the center of the monument(the one with the highest block)
        3. Press the keybind to set the center chunk coordinates
        4. The spawn pillars will be rendered
]]--

name = "Guardian Spawn Spots"
description = "Finds the area where guardians spawns in ocean monuments"

color = {0, 255, 0}
client.settings.addCategory("Center Chunk Coordinates")
px = client.settings.addNamelessTextbox("X:", "0")
pz = client.settings.addNamelessTextbox("Z:", "0")
keybind = client.settings.addNamelessKeybind("Set Center Chunk Coords:", 0x52)
client.settings.addColor("Spawn Pillar Color", "color")
function render3d()
    local cx = math.floor(px.value / 16) * 16 + 8
    local cz = math.floor(pz.value / 16) * 16 + 8
    local spacing = { 13.5, 16, 16, 16, 13 }
    for i = 1, 5 do
        for j = 1, 5 do
            local x = (j - 3) * spacing[j]
            local z = (i - 3) * spacing[i]
            cubexyz(cx + x + 0.05, 62, cz + z + 0.05, 0.9, -21, 0.9)
        end
    end
end

event.listen("KeyboardInput", function(key, down)
    if key == keybind.value and down and not gui.mouseGrabbed() then
        x, y, z = player.position()
        px.value = math.floor(x)
        pz.value = math.floor(z)
        client.notification("Center Chunk Coords Set\n" .. "x: " .. px.value .. " z: " .. pz.value)
    end
end)

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