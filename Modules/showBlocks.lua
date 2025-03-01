name = "Block Finder"
description = "Shows blocks in the world"

--[[
    by MCBE Craft + jqms (i converted it to findBlock)
]]

fileLib2 = importLib("renderthreeD.lua")

local blockPos = {}

client.settings.addInfo("Instructions: use command .findBlock [block] and it will show you all of them within a radius")

client.settings.addAir(5)
backgroundColor = client.settings.addNamelessColor("Background color", { 0, 0, 0, 25 })

client.settings.addAir(5)
radius = 50
client.settings.addInt("Finding block radius", "radius", 5, 200)

blockPos = {}
---@diagnostic disable-next-line: missing-parameter
registerCommand("findBlock", function(arguments)
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

    local text = ""

    local worldBlocks = dimension.findBlock(arguments, 0, radius or 50)
    for i, block in ipairs(worldBlocks) do
        text = text .. (arguments .. ": " .. block[1] .. " " .. block[2] .. " " .. block[3] .. "\n")
        table.insert(blockPos, { block[1], block[2], block[3] })
    end
end)

function render3d(dt)
    gfx.renderBehind(true)
    gfx.color(backgroundColor.value.r, backgroundColor.value.g, backgroundColor.value.b, backgroundColor.value.a)
    for i, value in ipairs(blockPos) do
        cube(value[1], value[2], value[3], 1)
    end
end
