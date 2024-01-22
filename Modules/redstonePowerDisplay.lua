-- Made By O2Flash20 🙂
name = "Redstone Power Display"
description = "Shows you the power of nearby redstone."

textCol = client.settings.addNamelessColor("Text Color", { 255, 255, 255, 255 })
radius = client.settings.addNamelessInt("Radius", 0, 150, 16)

local redstones = {}
function update()
    redstones = dimension.findBlock("redstone_wire", nil, radius.value)
    for i = 1, #redstones, 1 do
        redstones[i][4] = dimension.getBlock(redstones[i][1], redstones[i][2], redstones[i][3]).data
    end
end

function render()
    gfx.color(textCol.value.r, textCol.value.g, textCol.value.b, textCol.value.a)
    for i = 1, #redstones, 1 do
        local x, y = gfx.worldToScreen(redstones[i][1] + 0.5, redstones[i][2], redstones[i][3] + 0.5)
        if x and y then
            gfx.text(x - 3.6, y - 6, redstones[i][4], 1.5)
        end
    end
end
