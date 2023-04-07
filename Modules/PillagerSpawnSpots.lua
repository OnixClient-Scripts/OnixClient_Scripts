--[[
    Made by Zeyrox1090/Zeuroux/Blueberry#5784
    Version: 1.0
    Instructions:
        1. Go to an outpost look at the chest on the top floor then press the keybind(R by default)
]]--

name = "Pillager Spawn Spots"
description = "Finds the area where pillagers spawns in pillager outposts"

color = { 0, 255, 0 }
client.settings.addCategory("Outpost Coordinates")
cx = client.settings.addNamelessTextbox("X:", "0")
cz = client.settings.addNamelessTextbox("Z:", "0")
cy = client.settings.addNamelessTextbox("Y:", "0")
keybind = client.settings.addNamelessKeybind("Set Outpost Coords:", 0x52)
client.settings.addColor("Spawn Pillar Color", "color")

function render3d()
    local sx = math.floor(cx.value / 16) * 16 + 8
    local sz = math.floor(cz.value / 16) * 16 + 8
    if math.floor(cx.value % 16) == 7 and math.floor(cz.value % 16) == 6 then
        cubexyz(sx + 0.05, cy.value, sz + 0.05, 0.9, 10, 0.9)
        cubexyz(sx + 8 + 0.05, cy.value, sz + 8 + 0.05, 0.9, 10, 0.9)
        cubexyz(sx + 8 + 0.05, cy.value, sz + 0.05, 0.9, 10, 0.9)
        cubexyz(sx + 0.05, cy.value, sz + 8 + 0.05, 0.9, 10, 0.9)
    elseif math.floor(cx.value % 16) == 9 and math.floor(cz.value % 16) == 10 then
        cubexyz(sx + 0.05, cy.value, sz + 0.05, 0.9, 10, 0.9)
    elseif math.floor(cx.value % 16) == 6 and math.floor(cz.value % 16) == 9 or math.floor(cx.value % 16) == 10 and math.floor(cz.value % 16) == 7 then
        cubexyz(sx + 0.05, cy.value, sz + 0.05, 0.9, 10, 0.9)
        cubexyz(sx + 8 + 0.05, cy.value, sz + 0.05, 0.9, 10, 0.9)
    end
end

event.listen("KeyboardInput", function(key, down)
    if key == keybind.value and down and not gui.mouseGrabbed() then
        x, y, z = player.selectedPos()
        cx.value = math.floor(x)
        cz.value = math.floor(z)
        cy.value = math.floor(y - 8)
        client.notification("Outpost Outpost Coords Set\n" .. "x: " .. cx.value .. " z: " .. cz.value)
    end
end)
function cubexyz(x, y, z, sx, sy, sz)
    px_, py_, pz_ = player.position()
    gfx.color(color.r, color.g, color.b)
    local cx, cy, cz = x + sx / 2, y + sy / 2, z + sz / 2
    local vx, vy, vz = cx - px_, cy - py_ - 2, cz - pz_
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
