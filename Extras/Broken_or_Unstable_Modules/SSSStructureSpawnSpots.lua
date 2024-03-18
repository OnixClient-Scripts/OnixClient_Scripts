--[[
    Made by: Zeyrox1090/Zeuroux/Blueberry#5784
    Version: 1.0
    Description: Finds the area where mobs spawn in a structure
]]--
name = "Structure Spawn Spots"
description = "Finds the area where mobs spawn in a structure"

client.settings.addCategory("Global")
color = { 0, 255, 0, 255 }
client.settings.addColor("Spawn Pillar Color", "color")
size_height = client.settings.addNamelessInt("Spawn Pillar Height", 1, 30, 20)
renderBehind = client.settings.addNamelessBool("Render Behind", false)
client.settings.addAir(5)

client.settings.addCategory("Ocean Monument")
Om = client.settings.addNamelessKeybind("Set Ocean Monument Coords:", 77)
Ome = client.settings.addNamelessBool("Enabled", false)
omx, omy, omz = 1, 1, 1
client.settings.addAir(5)

client.settings.addCategory("Pillager Outpost")
Po = client.settings.addNamelessKeybind("Set Pillager Outpost Coords:", 79)
Poe = client.settings.addNamelessBool("Enabled", false)
pox, poy, poz = 1, 1, 1
client.settings.addAir(5)

client.settings.addCategory("Witch Hut")
Wh = client.settings.addNamelessKeybind("Set Witch Hut Coords:", 72)
Whe = client.settings.addNamelessBool("Enabled", false)
whx, why, whz = 1, 1, 1

function render3d()
    gfx.renderBehind(renderBehind.value)
    px, py, pz = player.position()
    if Whe.value then
        renderWitchSpawn()
    end
    if Poe.value then
        renderPillagerSpawn()
    end
    if Ome.value then
        renderGuardianSpawn()
    end
end

function renderPillagerSpawn()
    local sx = math.floor(pox / 16) * 16 + 8
    local sz = math.floor(poz / 16) * 16 + 8
    if math.floor(pox % 16) == 7 and math.floor(poz % 16) == 6 then
        cubexyz(sx + 0.05, poy, sz + 0.05, 0.9, 10, 0.9)
        cubexyz(sx + 8 + 0.05, poy, sz + 8 + 0.05, 0.9, 10, 0.9)
        cubexyz(sx + 8 + 0.05, poy, sz + 0.05, 0.9, 10, 0.9)
        cubexyz(sx + 0.05, poy, sz + 8 + 0.05, 0.9, 10, 0.9)
    elseif math.floor(pox % 16) == 9 and math.floor(poz % 16) == 10 then
        cubexyz(sx + 0.05, poy, sz + 0.05, 0.9, 10, 0.9)
    elseif math.floor(pox % 16) == 6 and math.floor(poz % 16) == 9 or math.floor(pox % 16) == 10 and math.floor(poz % 16) == 7 then
        cubexyz(sx + 0.05, poy, sz + 0.05, 0.9, 10, 0.9)
        cubexyz(sx + 8 + 0.05, poy, sz + 0.05, 0.9, 10, 0.9)
    end
end
function renderWitchSpawn()
    local cx = math.floor(whx / 16) * 16 + 3
    local cz = math.floor(whz / 16) * 16 + 4
    cubexyz(cx + 0.05, why - size_height.value / 2, cz + 0.05, 0.9, size_height.value, 0.9)
end
function renderGuardianSpawn()
    local cx = math.floor(omx / 16) * 16 + 8
    local cz = math.floor(omz / 16) * 16 + 8
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
    if down and not gui.mouseGrabbed() then
        if key == Om.value and Ome.value then
            omx, omy, omz = player.position()
            client.notification("Ocean Monument Coords Set\n".. "X:" .. omx .. " Y:" .. omy .. " Z:" .. omz)
        elseif key == Po.value and Poe.value then
            pox, poy, poz = player.selectedPos()
            client.notification("Pillager Outpost Coords Set\n".. "X:" .. pox .. " Y:" .. poy .. " Z:" .. poz)
        elseif key == Wh.value and Whe.value then
            whx, why, whz = player.position()
        end
    end
end)

function cubexyz(x, y, z, sx, sy, sz)
    gfx.color(color.r, color.g, color.b, color.a)
    local function isVisible(x1, y1, z1, x2, y2, z2, x3, y3, z3)
        -- Calculate the normal vector of the face
        local vx1, vy1, vz1 = x2 - x1, y2 - y1, z2 - z1
        local vx2, vy2, vz2 = x3 - x1, y3 - y1, z3 - z1
        local nx, ny, nz = vy1 * vz2 - vz1 * vy2, vz1 * vx2 - vx1 * vz2, vx1 * vy2 - vy1 * vx2
        -- Calculate the vector from the player to the face
        local px1, py1, pz1 = x1 - px, y1 - py - 2, z1 - pz
        -- Return true if the dot product of the two vectors is negative
        return nx * px1 + ny * py1 + nz * pz1 > 0
    end

    local x1, y1, z1 = x, y, z
    local x2, y2, z2 = x + sx, y, z
    local x3, y3, z3 = x + sx, y + sy, z
    local x4, y4, z4 = x, y + sy, z
    local x5, y5, z5 = x, y, z + sz
    local x6, y6, z6 = x + sx, y, z + sz
    local x7, y7, z7 = x + sx, y + sy, z + sz
    local x8, y8, z8 = x, y + sy, z + sz

    -- Only draw the faces that are visible from the player
    if isVisible(x1, y1, z1, x2, y2, z2, x3, y3, z3) then
        gfx.quad(x1, y1, z1, x2, y2, z2, x3, y3, z3, x4, y4, z4, true) -- front face
    end
    if isVisible(x2, y2, z2, x6, y6, z6, x7, y7, z7) then
        gfx.quad(x2, y2, z2, x6, y6, z6, x7, y7, z7, x3, y3, z3, true) -- right face
    end
    if isVisible(x6, y6, z6, x5, y5, z5, x8, y8, z8) then
        gfx.quad(x6, y6, z6, x5, y5, z5, x8, y8, z8, x7, y7, z7, true) -- back face
    end
    if isVisible(x5, y5, z5, x1, y1, z1, x4, y4, z4) then
        gfx.quad(x5, y5, z5, x1, y1, z1, x4, y4, z4, x8, y8, z8, true) -- left face
    end
    if isVisible(x4, y4, z4, x3, y3, z3, x7, y7, z7) then
        gfx.quad(x4, y4, z4, x3, y3, z3, x7, y7, z7, x8, y8, z8, true) -- top face
    end
    if isVisible(x5, y5, z5, x6, y6, z6, x2, y2, z2) then
        gfx.quad(x5, y5, z5, x6, y6, z6, x2, y2, z2, x1, y1, z1, true) -- bottom face
    end
end
