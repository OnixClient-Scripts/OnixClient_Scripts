function render(deltaTime)

    local x,y,z = player.position()
    local chunk_x = math.floor(x / 16)
    local chunk_y = math.floor(y / 16)
    local chunk_z = math.floor(z / 16)

    x = x - (chunk_x * 16)
    y = y - (chunk_y * 16)
    z = z - (chunk_z * 16)

    gfx.color(255, 255, 255)
    gfx.text(200, 150, "chunk: " .. chunk_x .. " " .. chunk_y .. " " .. chunk_z .. "   chunkpos: " .. x .. " " .. y .. " " .. z)
end
