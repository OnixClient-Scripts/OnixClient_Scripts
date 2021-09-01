--library to translate minecraft block name to textures

wood = {"oak", "spruce", "birch", "jungle", "acacia", "big_oak"}
colors = {"white", "orange", "magenta", "light_blue", "yellow", "lime", "pink", "gray", "silver", "cyan", "purple", "blue", "brown", "green", "red", "black"}

function translate(block, id)
    
    if (block == "grass") then
        return "blocks/grass_carried"
    elseif (block == "water" or block == "flowing_water" or block == "seagrass") then
        return "blocks/water_placeholder"
    elseif (block == "leaves" or block == "leaves2") then
        return "blocks/leaves_oak_carried"
    elseif (block == "bed" or block == "wool" or block == "carpet") then
        return "blocks/wool_colored_" .. colors[id + 1]
    elseif (block == "stained_glass" or block == "stained_glass_pane") then
        return "blocks/glass_" .. colors[id + 1]
    elseif (block == "concrete") then
        return "blocks/concrete_" .. colors[id + 1]
    elseif (block == "concretePowder") then
        return "blocks/concrete_powder_" .. colors[id + 1]
    elseif (block == "stained_hardened_clay") then
        return "blocks/hardened_clay_stained_" .. colors[id + 1]
    elseif (block == "shulker_box") then
        return "blocks/shulker_top_" .. colors[id + 1]
    elseif (block == "undyed_shulker_box") then
        return "blocks/shulker_top_undyed"
    elseif (block == "glass_pane") then
        return "blocks/glass"
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
        return "blocks/planks_" .. wood[id + 1]
    elseif (block == "log") then
        return "blocks/log_" .. wood[id + 1] .. "_top"
    elseif (block == "grass_path") then
        return "blocks/grass_path_top"
    elseif (block == "fence_gate") then
        return "blocks/planks_oak"
    elseif (string.find(block, "_slab") ~= nil) then
        if (string.find(block, "wooden_") ~= nil) then
            return "blocks/planks_" .. wood[id + 1]
        else
            return "blocks/" .. string.gsub(block, "_stairs", "")
        end
    elseif (string.find(block, "mossy_cobblestone") ~= nil) then
        return "blocks/cobblestone_mossy"
    elseif (string.find(block, "_glazed_terracotta") ~= nil) then
        for i = 1, 16, 1 do
            if (string.find(block, colors[i]) ~= nil) then
                return "blocks/glazed_terracotta_" .. colors[i]
            end
        end
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
