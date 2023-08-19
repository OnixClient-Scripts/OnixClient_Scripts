--[[
    IMPORT THE LOOPER LIBRARY BEFORE USING THIS SCRIPT
    Made by Zeuroux
    LOL 69 Lines
]]--
name = "Slime Chunk"
description = "Shows the slime chunks"

importLib("looper.lua")
slime_chunks = {}
color = client.settings.addNamelessColor("Color", {0, 1, 0})
rd = client.settings.addNamelessInt("Render Distance",1, 69, 8)
lines = client.settings.addNamelessFloat("Line Spacing", 0.069, 16, 4)

function render3d()
    gfx.color(color.value.r * 255, color.value.g * 255, color.value.b * 255, color.value.a)
    for i = 1, #slime_chunks do
        local chunk = slime_chunks[i]
        if math.abs(chunk[1] - math.floor(x / 16)) < rd.value and math.abs(chunk[2] - math.floor(z / 16)) < rd.value then
            chunk_border(chunk[1] * 16, -64, chunk[2] * 16, 16, 350, 16)
        end
    end
end

function update_slime()
    x, y, z = player.position()
    pending = {}
    for i = rd.value, -rd.value, -1 do
        for j = rd.value, -rd.value, -1 do
            local chunk = { (math.floor(x / 16) + i), (math.floor(z / 16) + j) }
            table.insert(pending, chunk)
        end
    end
    network.get("https://api.zeuroux.me/slime?table=" .. tableToString(pending), "slime_chunks")
end

function onNetworkData(code, identifier, data)
    if identifier == "slime_chunks" and code == 0 then
        slime_chunks = jsonToTable(data).slime_chunks
    end
end

function tableToString(tbl)
    local result = "["
    for i, v in ipairs(tbl) do
        result = result .. "[" .. table.concat(v, ",") .. "]"
        if i < #tbl then
            result = result .. ","
        end
    end
    result = result .. "]"
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
looper:new(update_slime, 4000, -1)