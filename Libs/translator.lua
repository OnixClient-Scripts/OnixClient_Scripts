--library to translate minecraft block name to textures

wood = {"oak", "spruce", "birch", "jungle", "acacia", "big_oak"}
bark = {"log_oak_top", "log_spruce_top", "log_birch_top", "log_jungle_top", "log_acacia_top", "log_big_oak_top", "", "", "stripped_oak_log", "stripped_spruce_log", "stripped_birch_log", "stripped_jungle_log", "stripped_acacia_log", "stripped_dark_oak_log", "", ""}
colors = {"white", "orange", "magenta", "light_blue", "yellow", "lime", "pink", "gray", "silver", "cyan", "purple", "blue", "brown", "green", "red", "black"}
stonebrick = {"stone", "cobblestone", "stonebrick", "stonebrick_mossy", "stonebrick_cracked", "stonebrick_carved"}
slab1 = {"stone_slab_top", "sandstone_top", "planks_oak", "cobblestone", "brick", "stonebrick", "quartz_block_top", "nether_brick"}
slab2 = {"red_sandstone_top", "purpur_block", "prismarine_rough", "prismarine_dark", "prismarine_bricks", "cobblestone_mossy", "sandstone_top", "red_nether_brick"}
slab3 = {"end_bricks", "red_sandstone_top", "stone_andesite_smooth", "stone_andesite", "stone_diorite", "stone_diorite_smooth", "stone_granite", "stone_granite_smooth"}
slab4 = {"stonebrick_mossy", "quartz_block_top", "stone", "sandstone_top", "red_sandstone_top"}
walls = {"cobblestone", "cobblestone_mossy", "stone_granite", "stone_diorite", "stone_andesite", "sandstone_top", "brick", "stonebrick", "stonebrick_mossy", "nether_brick", "end_bricks", "prismarine_rough", "red_sandstone_top", "red_nether_brick", "", ""}
prismarine = {"prismarine_rough", "prismarine_dark", "prismarine_bricks"}
stone = {"stone", "stone_granite", "stone_granite_smooth", "stone_diorite", "stone_diorite_smooth", "stone_andesite", "stone_andesite_smooth"}
leaves1 = {"oak", "spruce", "birch", "jungle"}
leaves2 = {"acacia", "big_oak"}
coral = {"coral_blue", "coral_pink", "coral_purple", "coral_red", "coral_yellow", "", "", "", "coral_blue_dead", "coral_pink_dead", "coral_purple_dead", "coral_red_dead", "coral_yellow_dead", "", "", ""}
air = ", 0, 577, 31, 59, 75, 104, 105, 127, 244, 470, 462, 386, 677, 142, 493, 478, 479, 471, 486, 542, 32, 418, 419, 563, 574, 578, 591, 576, 39, 40, 483, 484, 414, 115, 51, 492, 523, 411, 463, 524, 667, 668, 669, 670, 671, 672, 673, 674, 675, 676, 678, 679, 680, 681, 682, 683, 464, 144, 140, 199, 594, 545, 6, 50, 106, 176, 177, 111, 38, 37, 132, 141, 208, 567, 131, 76, 69, 55, 541, 175, "
top = ", 92, 451, 61, 116, 474, 457, 198, 455, 527, 453, 84, 458, 449, 473, 151, 459, 526, 110, 490, 489, 488, 487, 58, 81, 216, 477, 420, 86, 494, "

function airblock(block, id)
    if string.find(block, "_sign") ~= nil or string.find(block, "_button") ~= nil or string.find(air, ", " .. id .. ", ") ~= nil then
        return "air"
    else
        return ""
    end
end

function translate(block, id, data)
    
    if string.find(top, ", " .. id .. ", ") ~= nil then
        return "blocks/" .. block .. "_top"
    elseif (block == "grass") then
        return "blocks/grass_carried"
    elseif (block == "water" or block == "flowing_water" or block == "seagrass" or block == "bubble_column" or block == "kelp") then
        return "blocks/water_placeholder"
    elseif (block == "lava" or block == "flowing_lava") then
        return "blocks/lava_placeholder"
    elseif (block == "leaves") then
        while (data > 3) do
            data = data - 4
        end
        if leaves1[data + 1] ~= nil then
            return "blocks/leaves_" .. leaves1[data + 1] .. "_carried"
        else
            return "air"
        end
    elseif (block == "leaves2") then
        while (data > 1) do
            data = data - 2
        end
        if leaves2[data + 1] ~= nil then
            return "blocks/leaves_" .. leaves2[data + 1] .. "_carried"
        else
            return "air"
        end
    elseif (block == "bed" or block == "wool" or block == "carpet") then
        while (data > 15) do
            data = data - 16
        end
        if colors[data + 1] ~= nil then
            return "blocks/wool_colored_" .. colors[data + 1]
        else
            return "air"
        end
    elseif (block == "stained_glass" or block == "stained_glass_pane") then
        while (data > 15) do
            data = data - 16
        end
        if colors[data + 1] ~= nil then
            return "blocks/glass_" .. colors[data + 1]
        else
            return "air"
        end
    elseif (block == "concrete") then
        while (data > 15) do
            data = data - 16
        end
        if colors[data + 1] ~= nil then
            return "blocks/concrete_" .. colors[data + 1]
        else
            return "air"
        end
    elseif (id == 237) then
        while (data > 15) do
            data = data - 16
        end
        if colors[data + 1] ~= nil then
            return "blocks/concrete_powder_" .. colors[data + 1]
        else
            return "air"
        end
    elseif (block == "stained_hardened_clay") then
        while (data > 15) do
            data = data - 16
        end
        if colors[data + 1] ~= nil then
            return "blocks/hardened_clay_stained_" .. colors[data + 1]
        else
            return "air"
        end
    elseif (block == "shulker_box") then
        while (data > 15) do
            data = data - 16
        end
        if colors[data + 1] ~= nil then
            return "blocks/shulker_top_" .. colors[data + 1]
        else
            return "air"
        end
    elseif (block == "undyed_shulker_box") then
        return "blocks/shulker_top_undyed"
    elseif (block == "glass_pane") then
        return "blocks/glass"
    elseif (id == 137 or  id == 189 or id == 188) then
        return "blocks/" .. block .. "_front_mipmap"
    elseif (id == 62) then
        return "blocks/furnace_top"
    elseif (id == 210 or id == 211) then
        return "blocks/build_" .. block
    elseif (block == "border_block") then
        return "blocks/border"
    elseif (block == "movingBlock" or block == "info_update" or block == "info_update2" or block == "invisibleBedrock" or block == "reserved6") then
        return "blocks/missing_tile"
    elseif (block == "jigsaw") then
        return "blocks/jigsaw_front"
    elseif (block == "bell") then
        return "blocks/bell_side"
    elseif (block == "conduit") then
        return "blocks/conduit_open"
    elseif (block == "end_portal_frame") then
        return "blocks/endframe_top"
    elseif (block == "rail") then
        return "blocks/rail_normal"
    elseif (block == "golden_rail") then
        return "blocks/rail_golden"
    elseif (block == "detector_rail") then
        return "blocks/rail_detector"
    elseif (block == "activator_rail") then
        return "blocks/rail_activator"
    elseif (block == "stonecutter_block") then
        return "blocks/stonecutter2_top"
    elseif (block == "sand" and data == 1) then
        return "blocks/red_sand"
    elseif (block == "azalea_leaves_flowered") then
        return "blocks/azalea_leaves_flowers"
    elseif (block == "honey_block") then
        return "blocks/honey_top"
    elseif (block == "melon_block") then
        return "blocks/melon_top"
    elseif (block == "carved_pumpkin") then
        return "blocks/pumpkin_face_off"
    elseif (block == "redstone_lamp" or block == "lit_redstone_lamp") then
        return "blocks/redstone_lamp_off"
    elseif (block == "seaLantern") then
        return "blocks/sea_lantern"
    elseif (block == "lit_pumpkin") then
        return "blocks/pumpkin_face_on"
    elseif (block == "honeycomb_block") then
        return "blocks/honeycomb"
    elseif block == "cauldron" then
        return "blocks/cauldron_side"
    elseif (block == "fletching_table") then
        return "blocks/fletcher_table_top"
    elseif (block == "anvil") then
        return "blocks/anvil_top_damaged_0"
    elseif (block == "grindstone") then
        return "blocks/grindstone_round"
    elseif (block == "quartz_ore") then
        return "blocks/quartz_ore"
    elseif (block == "podzol") then
        return "blocks/dirt_podzol_top"
    elseif (block == "piston") then
        return "blocks/piston_inner"
    elseif (block == "sticky_piston") then
        return "blocks/piston_inner"
    elseif (id == 472) then
        return "blocks/piston_top_normal"
    elseif (block == "hay_block") then
        return "blocks/hay_block_side"
    elseif (block == "packed_ice") then
        return "blocks/ice_packed"
    elseif (block == "snow_layer") then
        return "blocks/snow"
    elseif (block == "moss_carpet") then
        return "blocks/moss_block"
    elseif (block == "azalea") then
        return "blocks/azalea_leaves"
    elseif (block == "flowering_azalea") then
        return "blocks/azalea_leaves_flowers"
    elseif (block == "brown_mushroom_block") then
        return "blocks/mushroom_block_skin_brown"
    elseif (block == "red_mushroom_block") then
        return "blocks/mushroom_block_skin_red"
    elseif (block == "infested_deepslate") then
        return "blocks/deepslate/deepslate"
    elseif (block == "farmland") then
        return "blocks/farmland_wet"
    elseif (block == "smooth_stone") then
        return "blocks/stone_slab_top"
    elseif (block == "dried_kelp_block") then
        return "blocks/dried_kelp_top"
    elseif (block == "observer") then
        return "blocks/observer_front"
    elseif (block == "redstone_wire") then
        return "blocks/redstone"
    elseif (block == "brick_block") then
        return "blocks/brick"
    elseif (block == "prismarine") then
        while (data > 2) do
            data = data - 3
        end
        if prismarine[data + 1] ~= nil then
            return "blocks/" .. prismarine[data + 1]
        else
            return "air"
        end
    elseif (block == "tnt") then
        return "blocks/tnt_side"
    elseif (block == "dispenser") then
        return "blocks/dispenser_front_horizontal"
    elseif (block == "dropper") then
        return "blocks/dropper_front_horizontal"
    elseif (block == "hopper") then
        return "blocks/hopper_inside"
    elseif (block == "composter") then
        return "blocks/composter_side"
    elseif (block == "ender_chest") then
        return "blocks/ender_chest_front"
    elseif (block == "chest" or block == "trapped_chest") then
        return "blocks/chest_front"
    elseif (block == "crimson_stem" or block == "crimson_hyphae") then
        return "blocks/huge_fungus/crimson_log_top"
    elseif (block == "warped_stem" or block == "warped_hyphae") then
        return "blocks/huge_fungus/warped_stem_top"
    elseif (block == "stripped_crimson_stem" or block == "stripped_crimson_hyphae") then
        return "blocks/huge_fungus/stripped_crimson_stem_top"
    elseif (block == "stripped_warped_stem" or block == "stripped_warped_hyphae") then
        return "blocks/huge_fungus/stripped_warped_stem_top"
    elseif (block == "planks" or block == "fence") then
        while (data > 5) do
            data = data - 6
        end
        if wood[data + 1] ~= nil then
            return "blocks/planks_" .. wood[data + 1]
        else
            return "air"
        end
    elseif (block == "coral_block") then
        while (data > 15) do
            data = data - 16
        end
        if coral[data+1] ~= nil then
            return "blocks/" .. coral[data + 1]
        else
            return "air"
        end
    elseif (block == "log") then
        while (data > 3) do
            data = data - 4
        end
        if wood[data+1] ~= nil then
            return "blocks/log_" .. wood[data + 1] .. "_top"
        else
            return "air"
        end
    elseif (block == "log2") then
        while (data > 1) do
            data = data - 2
        end
        data = data + 4
        if wood[data+1] ~= nil then
            return "blocks/log_" .. wood[data + 1] .. "_top"
        else
            return "air"
        end
    elseif (block == "wood") then
        while (data > 15) do
            data = data - 16
        end
        if bark[data+1] ~= nil then
            return "blocks/" .. bark[data + 1]
        else
            return "air"
        end
    elseif (block == "stonebrick") then
        while (data > 3) do
            data = data - 4
        end
        if stonebrick[data + 3] ~= nil then
            return "blocks/" .. stonebrick[data + 3]
        else
            return "air"
        end
    elseif (block == "stone") then
        while (data > 6) do
            data = data - 7
        end
        if stone[data+1] ~= nil then
            return "blocks/" .. stone[data + 1]
        else
            return "air"
        end
    elseif (block == "cobblestone_wall") then
        while (data > 15) do
            data = data - 16
        end
        if walls[data+1] ~= nil then
            return "blocks/" .. walls[data + 1]
        else
            return "air"
        end
    elseif (string.find(block, "_wall") ~= nil) then
        block = string.gsub(block, "_wall", "")
        block = string.gsub(block, "blackstone_brick", "blackstone_bricks")
        if (string.find(block, "deepslate") ~= nil) then
            block = string.gsub(block, "brick", "bricks")
            block = string.gsub(block, "tile", "tiles")
            return "blocks/deepslate/" .. block
        else
            return "blocks/" .. block
        end
    elseif (block == "monster_egg") then
        while (data > 5) do
            data = data - 6
        end
        if stonebrick[data+1] ~= nil then
            return "blocks/" .. stonebrick[data + 1]
        else
            return "air"
        end
    elseif (block == "fence_gate") then
        return "blocks/planks_oak"
    elseif (block == "wooden_door") then
        return "blocks/planks_oak"
    elseif (string.find(block, "_slab") ~= nil) then
        if (string.find(block, "wooden_") ~= nil) then
            while (data > 5) do
                data = data - 6
            end
            if wood[data+1] ~= nil then
                return "blocks/planks_" .. wood[data + 1]
            else
                return "air"
            end
        else
            block = string.gsub(block, "_slab", "")
            block = string.gsub(block, "double_", "")
            block = string.gsub(block, "_double", "")
            block = string.gsub(block, "waxed_", "")
            block = string.gsub(block, "blackstone_brick", "blackstone_bricks")
            if (string.find(block, "deepslate") ~= nil) then
                block = string.gsub(block, "brick", "bricks")
                block = string.gsub(block, "tile", "tiles")
                return "blocks/deepslate/" .. block
            elseif block == "crimson" or block == "warped" then
                return "blocks/huge_fungus/" .. block .. "_planks"
            elseif block == "stone" then
                while (data > 7) do
                    data = data - 8
                end
                if slab1[data+1] ~= nil then
                    return "blocks/" .. slab1[data + 1]
                else
                    return "air"
                end
            elseif block == "stone2" then
                while (data > 7) do
                    data = data - 8
                end
                if slab2[data+1] ~= nil then
                    return "blocks/" .. slab2[data + 1]
                else
                    return "air"
                end
            elseif block == "stone3" then
                while (data > 7) do
                    data = data - 8
                end
                if slab3[data+1] ~= nil then
                    return "blocks/" .. slab3[data + 1]
                else
                    return "air"
                end
            elseif block == "stone4" then
                while (data > 7) do
                    data = data - 8
                end
                if slab4[data+1] ~= nil then
                    return "blocks/" .. slab4[data + 1]
                else
                    return "air"
                end
            else
                return "blocks/" .. block
            end
        end
    elseif (string.find(block, "mossy_cobblestone") ~= nil) then
        return "blocks/cobblestone_mossy"
    elseif (string.find(block, "_glazed_terracotta") ~= nil) then
        for i = 1, 16, 1 do
            if (string.find(block, colors[i]) ~= nil) then
                if colors[i] ~= nil then
                    return "blocks/glazed_terracotta_" .. colors[i]
                else
                    return "air"
                end
            end
        end
    elseif (string.find(block, "_repeater") ~= nil) then
        return "blocks/repeater_off"
    elseif (string.find(block, "sandstone") ~= nil) then
        if (string.find(block, "red") ~= nil) then
            return "blocks/red_sandstone_top"
        else
            return "blocks/sandstone_top"
        end
    elseif (string.find(block, "granite") ~= nil) then
        if (string.find(block, "polished") ~= nil) then
            return "blocks/stone_granite_smooth"
        else
            return "blocks/stone_granite"
        end
    elseif (string.find(block, "diorite") ~= nil) then
        if (string.find(block, "polished") ~= nil) then
            return "blocks/stone_diorite_smooth"
        else
            return "blocks/stone_diorite"
        end
    elseif (string.find(block, "andesite") ~= nil) then
        if (string.find(block, "polished") ~= nil) then
            return "blocks/stone_andesite_smooth"
        else
            return "blocks/stone_andesite"
        end
    elseif (string.find(block, "quartz") ~= nil) then
        return "blocks/quartz_block_top"
    elseif (string.find(block, "_comparator") ~= nil) then
        return "blocks/comparator_off"
    elseif (string.find(block, "_stairs") ~= nil) then
        if (string.find(block, "oak") ~= nil or string.find(block, "spruce") ~= nil or string.find(block, "birch") ~= nil or string.find(block, "jungle") ~= nil or string.find(block, "acacia") ~= nil) then
            block = string.gsub(block, "dark", "big")
            return "blocks/planks_" .. string.gsub(block, "_stairs", "")
        else
            block = string.gsub(block, "_stairs", "")
            if (id == 67) then
                return "blocks/cobblestone"
            elseif (id == 430) then
                return "blocks/stonebrick_mossy"
            elseif (id == 430) then
                return "blocks/stonebrick_mossy"
            elseif (id == 109) then
                return "blocks/stonebrick"
            elseif (id == 530) then
                return "blocks/polished_blackstone_bricks"
            elseif (id == 257) then
                return "blocks/prismarine_rough"
            elseif (string.find(block, "deepslate") ~= nil) then
                block = string.gsub(block, "brick", "bricks")
                block = string.gsub(block, "tile", "tiles")
                return "blocks/deepslate/" .. block
            elseif block == "crimson" or block == "warped" then
                return "blocks/huge_fungus/" .. block .. "_planks"
            else
                block = string.gsub(block, "normal_", "")
                block = string.gsub(block, "waxed_", "")
                block = string.gsub(block, "end_brick", "end_bricks")
                block = string.gsub(block, "purpur", "purpur_block")
                block = string.gsub(block, "dark_prismarine", "prismarine_dark")
                return "blocks/" .. block
            end
        end
    elseif (string.find(block, "_fence_gate") ~= nil) then
        if (string.find(block, "spruce") ~= nil or string.find(block, "birch") ~= nil or string.find(block, "jungle") ~= nil or string.find(block, "acacia") ~= nil or string.find(block, "dark_oak") ~= nil) then
            block = string.gsub(block, "dark", "big")
            return "blocks/planks_" .. string.gsub(block, "_fence_gate", "")
        else
            block = string.gsub(block, "_fence_gate", "")
            if block == "crimson" or block == "warped" then
                return "blocks/huge_fungus/" .. block .. "_planks"
            else
                return "blocks/" .. block
            end
        end
    elseif (string.find(block, "_door") ~= nil) then
        if (string.find(block, "spruce") ~= nil or string.find(block, "birch") ~= nil or string.find(block, "jungle") ~= nil or string.find(block, "acacia") ~= nil or string.find(block, "dark_oak") ~= nil) then
            block = string.gsub(block, "dark", "big")
            return "blocks/planks_" .. string.gsub(block, "_door", "")
        else
            block = string.gsub(block, "_door", "")
            block = string.gsub(block, "iron", "iron_block")
            if block == "crimson" or block == "warped" then
                return "blocks/huge_fungus/" .. block .. "_planks"
            else
                return "blocks/" .. block
            end
        end
    elseif (string.find(block, "_pressure_plate") ~= nil) then
        if (string.find(block, "spruce") ~= nil or string.find(block, "birch") ~= nil or string.find(block, "jungle") ~= nil or string.find(block, "acacia") ~= nil or string.find(block, "dark_oak") ~= nil) then
            block = string.gsub(block, "dark", "big")
            return "blocks/planks_" .. string.gsub(block, "_pressure_plate", "")
        else
            block = string.gsub(block, "_pressure_plate", "")
            block = string.gsub(block, "wooden", "planks_oak")
            block = string.gsub(block, "light_weighted", "gold_block")
            block = string.gsub(block, "heavy_weighted", "iron_block")
            if block == "crimson" or block == "warped" then
                return "blocks/huge_fungus/" .. block .. "_planks"
            else
                return "blocks/" .. block
            end
        end
    elseif (string.find(block, "_trapdoor") ~= nil) then
        if string.find(block, "crimson") or string.find(block, "warped") then
            return "blocks/huge_fungus/" .. block
        else
            return "blocks/" .. block
        end
    elseif (string.find(block, "deepslate") ~= nil) then
        if (string.find(block, "redstone_ore") ~= nil) then
            block = string.gsub(block, "lit_", "")
            return "blocks/deepslate/" .. block
        end
        return "blocks/deepslate/" .. block
    elseif ((string.find(block, "_copper") ~= nil)) then
        block = string.gsub(block, "waxed_", "")
        if block == "copper" then
            block = "copper_block"
        end
        return "blocks/" .. block
    elseif (string.find(block, "fence") ~= nil) then
        block = string.gsub(block, "_fence", "")
        block = string.gsub(block, "_gate", "")
        block = string.gsub(block, "dark", "big")
        if block == "crimson" or block == "warped" then
            return "blocks/huge_fungus/" .. block .. "_planks"
        else
            return "blocks/" .. block
        end
    elseif (string.find(block, "redstone_ore") ~= nil) then
        block = string.gsub(block, "lit_", "")
        return "blocks/" .. block
    else
        return "blocks/" .. block
    end

end
