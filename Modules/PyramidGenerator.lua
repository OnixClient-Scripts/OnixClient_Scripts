name = "Pyramid Generator"
description = "Generates a pyramid."

function generatePyramidRelativeToPlayer(size, material)
    -- Get the player's current position
    local x, y, z = player.position()

    -- Calculate the coordinates of the pyramid's base
    local baseX = x - math.floor(size)
    local baseY = y
    local baseZ = z - math.floor(size)

    -- Loop over the pyramid's layers
    local start = 1
    local limit = math.floor(size / 2) * 2
    if size % 2 == 1 then -- odd-sized pyramid
        limit = limit + 1 -- add top layer
    end
    for i = start, limit, 2 do
        layerSize = size - i

        -- Fill the layer with the specified material
        local command = "execute fill ~" ..layerSize .." ~" .. i .. " ~" .. layerSize .. " ~" .. (-layerSize) .. " ~" .. i .. " ~" .. (-layerSize) .. " " .. material
        client.execute(command)
    end
    local start2 = 0
    local limit2 = math.floor(size / 2) * 2
    if size % 2 == 1 then -- odd-sized pyramid
        limit2 = limit2 + 1 -- add top layer
    end
    for i = start2, limit2, 2 do
        layerSize = size - i

        -- Fill the layer with the specified material
        local command = "execute fill ~" ..layerSize .." ~" .. i .. " ~" .. layerSize .. " ~" .. (-layerSize) .. " ~" .. i .. " ~" .. (-layerSize) .. " " .. material
        client.execute(command)
    end
end

registerCommand("pyramid", function(args)
    -- the material checker can include an _ in the name, so we need to match that too
    local size, material = args:match("(%-?%d+%.?%d*) ([%a_]+)")
    generatePyramidRelativeToPlayer(tonumber(size), material)
    -- teleport the player to the top of the pyramid
    client.execute("execute tp ~ ~" .. tonumber(size) + 1 .. " ~")
end)
