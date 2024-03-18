name = "Sphere Generator"
description = "Generates a sphere."

blockCount = 0

client.settings.addInfo(
    "Instructions: use the command .sphere [radius] [block] OR .hsphere [radius] [thickness] [block]"
)

function generateSphere(radius, material)
    local x, y, z = player.position()
    local sx = x - radius
    local sy = y - radius
    local sz = z - radius
    local ex = x + radius
    local ey = y + radius
    local ez = z + radius

    for px = sx, ex do
        for py = sy, ey do
            for pz = sz, ez do
                if math.sqrt((px - x) ^ 2 + (py - y) ^ 2 + (pz - z) ^ 2) <= radius then
                    client.execute("execute /setblock " .. px .. " " .. py .. " " .. pz .. " " .. material)
                    blockCount = blockCount + 1
                end
            end
        end
    end
end

function generateHollowSphere(radius, thickness, material)
    local x, y, z = player.position()
    local sx = x - radius
    local sy = y - radius
    local sz = z - radius
    local ex = x + radius
    local ey = y + radius
    local ez = z + radius

    for px = sx, ex do
        for py = sy, ey do
            for pz = sz, ez do
                local distance = math.sqrt((px - x) ^ 2 + (py - y) ^ 2 + (pz - z) ^ 2)
                if distance <= radius and distance >= radius - thickness then
                    client.execute("execute /setblock " .. px .. " " .. py .. " " .. pz .. " " .. material)
                    blockCount = blockCount + 1
                end
            end
        end
    end
end

registerCommand("sphere", function(args)
    blockCount = 0
    local radius, material = args:match("(%-?%d+%.?%d*) (.+)")
    generateSphere(tonumber(radius), material)
    -- teleport the player to the top of the sphere
    client.execute("execute tp ~ ~" .. tonumber(radius) + 1 .. " ~")
    print("Placed " .. blockCount .. " blocks.")
end)

registerCommand("hsphere", function(args)
    blockCount = 0
    local radius, thickness, material = args:match("(%-?%d+%.?%d*) (%-?%d+%.?%d*) (.+)")
    generateHollowSphere(tonumber(radius), tonumber(thickness), material)
    -- teleport the player to the top of the sphere
    client.execute("execute tp ~ ~" .. tonumber(radius) + 1 .. " ~")
    print("Placed " .. blockCount .. " blocks.")
end)
