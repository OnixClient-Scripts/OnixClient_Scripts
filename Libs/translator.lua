--library to translate minecraft block name to textures

wood = {"oak", "spruce", "birch", "jungle", "acacia", "big_oak"}

function translate(block, id)
    
    if (block == "grass") then
        return "blocks/grass_carried"
    elseif (block == "water" or block == "flowing_water" or block == "seagrass") then
        return "blocks/water_placeholder"
    elseif (block == "leaves" or block == "leaves2") then
        return "blocks/leaves_oak_carried"
    elseif (block == "bed" or block == "wool") then
        return "blocks/wool_colored_white"
    elseif (block == "crafting_table") then
        return "blocks/crafting_table_top"
    elseif (block == "cactus") then
        return "blocks/cactus_top"
    elseif (block == "piston") then
        return "blocks/piston_top_normal"
    elseif (block == "sticky_piston") then
        return "blocks/piston_top_sticky"
    elseif (block == "hay_block") then
        return "blocks/hay_block_side"
    elseif (block == "farmland") then
        return "blocks/farmland_wet"
    elseif (block == "observer") then
        return "blocks/observer_front"
    elseif (block == "redstone_wire") then
        return "blocks/redstone"
    elseif (block == "target") then
        return "blocks/target_top"
    elseif (block == "tnt") then
        return "blocks/tnt_side"
    elseif (block == "dispenser") then
        return "blocks/dispenser_front_horizontal"
    elseif (block == "dropper") then
        return "blocks/dropper_front_horizontal"
    elseif (block == "hopper") then
        return "blocks/hopper_inside"
    elseif (block == "composter") then
        return "blocks/composter_bottom"
    elseif (block == "chest" or block == "trapped_chest") then
        return "blocks/chest_front"
    elseif (block == "planks" or block == "fence") then
        while (id > 5) do
            id = id - 6
        end
        return "blocks/planks_" .. wood[id + 1]
    elseif (block == "log") then
        while (id > 5) do
            id = id - 6
        end
        return "blocks/log_" .. wood[id + 1] .. "_top"
    elseif (block == "grass_path") then
        return "blocks/grass_path_top"
    elseif (block == "fence_gate") then
        return "blocks/planks_oak"
    elseif (string.find(block, "_slab") ~= nil) then
        if (string.find(block, "wooden_") ~= nil) then
            while (id > 5) do
                id = id - 6
            end
            return "blocks/planks_" .. wood[id + 1]
        else
            return "blocks/" .. string.gsub(block, "_stairs", "")
        end
    elseif (string.find(block, "mossy_cobblestone") ~= nil) then
        return "blocks/cobblestone_mossy"
    elseif (string.find(block, "_repeater") ~= nil) then
        return "blocks/repeater_off"
    elseif (string.find(block, "_comparator") ~= nil) then
        return "blocks/comparator_off"
    elseif (string.find(block, "_stairs") ~= nil) then
        if (string.find(block, "oak") ~= nil or string.find(block, "spruce") ~= nil or string.find(block, "birch") ~= nil or string.find(block, "jungle") ~= nil or string.find(block, "acacia") ~= nil) then
            return "blocks/planks_" .. string.gsub(block, "_stairs", "")
        else
            return "blocks/" .. string.gsub(block, "_stairs", "")
        end
    elseif (string.find(block, "_fence_gate") ~= nil) then
        if (string.find(block, "spruce") ~= nil or string.find(block, "birch") ~= nil or string.find(block, "jungle") ~= nil or string.find(block, "acacia") ~= nil) then
            return "blocks/planks_" .. string.gsub(block, "_fence_gate", "")
        else
            return "blocks/" .. string.gsub(block, "_fence_gate", "")
        end
    else
        return "blocks/" .. block
    end

end