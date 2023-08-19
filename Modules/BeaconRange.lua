name = "Beacon Range"
description = "Shows the range of beacon"

color = { 250, 250, 250 }
renderBehind = client.settings.addNamelessBool("Render Behind", false)
client.settings.addColor("Color", "color")

layerDimensions = {
    { o = -20, s = 41 },
    { o = -30, s = 61 },
    { o = -40, s = 81 },
    { o = -50, s = 101 }
}

acceptable_blocks = {
    netherite_block = true,
    gold_block = true,
    iron_block = true,
    diamond_block = true,
    emerald_block = true
}

function render3d()
    gfx.renderBehind(renderBehind.value)
    gfx.color(color.r, color.g, color.b, color.a)
    ppx, ppy, ppz = player.pposition()
    beacons = dimension.findBlock('minecraft:beacon')
    for i = 1, #beacons do
        beacon = beacons[i]
        x, y, z = beacon[1], beacon[2], beacon[3]
        layers = getBeaconLayer(x, y, z)
        if layers == 0 then break end
        dim = layerDimensions[layers]
        square(x + dim.o, ppy - 2, z + dim.o, dim.s, 0.5, dim.s)
    end
end

function getBeaconLayer(x, y, z)
    for layer = 1, 4, 1 do
        for i = -layer, layer, 1 do
            for j = -layer, layer, 1 do
                if not acceptable_blocks[dimension.getBlock(x + i, y - layer, z + j).name] then
                    return layer - 1
                end
            end
        end
    end
    return 4
end

function square(x, y, z, sx, sy, sz)
    gfx.quad(x, y, z, x + sx, y, z, x + sx, y + sy, z, x, y + sy, z, true)
    gfx.quad(x, y, z + sz, x + sx, y, z + sz, x + sx, y + sy, z + sz, x, y + sy, z + sz, true)
    gfx.quad(x, y, z, x, y, z + sz, x, y + sy, z + sz, x, y + sy, z, true)
    gfx.quad(x + sx, y, z, x + sx, y, z + sz, x + sx, y + sy, z + sz, x + sx, y + sy, z, true)
end