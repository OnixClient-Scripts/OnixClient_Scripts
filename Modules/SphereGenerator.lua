name = "Sphere Generator"
description = "Generates a sphere."

function generateSphere(radius, material)
    local x,y,z = player.position()
    local sx = x - radius
    local sy = y - radius
    local sz = z - radius
    local ex = x + radius
    local ey = y + radius
    local ez = z + radius

    for px=sx,ex do
        for py=sy,ey do
            for pz=sz,ez do
                if math.sqrt((px-x)^2 + (py-y)^2 + (pz-z)^2) <= radius then
                    client.execute("execute /setblock " .. px .. " " .. py .. " " .. pz .. " " .. material)
                end
            end
        end
    end
end

registerCommand("sphere", function(args)
    local radius, material = args:match("(%-?%d+%.?%d*) ([%a_]+)")
    generateSphere(tonumber(radius), material)
    -- teleport the player to the top of the sphere
    client.execute("execute tp ~ ~" .. tonumber(radius) + 1 .. " ~")
end)