name = "Explosive Crops"
description = "Has a random chance of crops exploding when you break them."

function explode(x,y,z)
    client.execute("execute /summon ender_crystal " .. x .. " " .. y .. " " .. z .. " ~ ~ minecraft:crystal_explode")
end

local plants = {
    "wheat",
    "carrots",
    "potatoes",
    "beetroot",
    "melon_block",
    "pumpkin_stem",
    "melon_stem",
    "pumpkin",
    "torchflower",
    "pitcher_crop"
}

event.listen("MouseInput", function(button, down)
    if button == 1 and down then
        if player.facingBlock() then
            local blockPosX, blockPosY, blockPosZ = player.selectedPos()
            local block = dimension.getBlock(blockPosX, blockPosY, blockPosZ)
            for i,v in pairs(plants) do
                if block.name == v then
                    if math.random(1, 5) == 1 then
                        explode(blockPosX, blockPosY+1, blockPosZ)
                    end
                end
            end
        end
    end
end)