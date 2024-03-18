name = "Block Finder"
description = "Shows blocks in the world"

--[[
    by MCBE Craft
]]

fileLib2 = importLib("renderthreeD.lua")

local blockPos = {}

client.settings.addInfo("Instructions: use command .findBlock [block] and it will show you all of them within a radius")

client.settings.addAir(5)
backgroundColor = client.settings.addNamelessColor("Background color", { 0, 0, 0, 25 })

client.settings.addAir(5)
radius = 50
client.settings.addInt("Finding block radius", "radius", 5, 200)

registerCommand("findBlock", function(arguments)
    blockPos = {}
    if (arguments == "") then
        return
    end
    args = string.split(arguments, " ")
    if #args > 1 then
        if tonumber(args[2]) ~= nil then
            radius = tonumber(args[2])
        else
            return
        end
    end

    local x, y, z = player.position()
    local sx = x - radius
    local sy = y - radius
    local sz = z - radius
    local ex = sx + (2 * radius)
    local ey = 100
    local ez = sz + (2 * radius)

    local text = ""

    for px = sx, ex do
        for py = sy, ey do
            for pz = sz, ez do
                local block = dimension.getBlock(px, py, pz)
                if (string.match(block.name:lower(), args[1]:lower()) or block.id == tonumber(args[1]) and block.id ~= 0) then
                    text = text .. (block.name .. ": " .. px .. " " .. py .. " " .. pz .. "\n")
                    table.insert(blockPos, { px, py, pz })
                end
            end
        end
    end
    print(text)
end)

function render3d(dt)
    gfx.renderBehind(true)
    gfx.color(backgroundColor.value.r, backgroundColor.value.g, backgroundColor.value.b, backgroundColor.value.a)
    for i, value in ipairs(blockPos) do
        cube(value[1], value[2], value[3], 1)
    end
end
