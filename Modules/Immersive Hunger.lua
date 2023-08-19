name = "Immersive Hunger"
description = "Shows the hunger and saturation bar"

outline_color = client.settings.addNamelessEnum("Outline Color", 1, {{1, "Gold"},{2, "Blue"}})
preview_only_when_eating = client.settings.addNamelessBool("Preview Only When Eating", false)

positionX = 0
positionY = 0
sizeX = 81
sizeY = 9
alpha = 0
direction = 1
accumulator = 0
hunger_whole = gfx2.loadImage("\\ImmersiveHunger\\hunger_whole.png")
hunger_half = gfx2.loadImage("\\ImmersiveHunger\\hunger_half.png")
hungry_whole = gfx2.loadImage("\\ImmersiveHunger\\hungry_whole.png")
hungry_half = gfx2.loadImage("\\ImmersiveHunger\\hungry_half.png")
default_outline = gfx2.loadImage("\\ImmersiveHunger\\default_outline.png")
hungry_outline = gfx2.loadImage("\\ImmersiveHunger\\hungry_outline.png")
isHoldingRightClick = false
function render2(dt)
    if outline_color.value == 1 then
        outline_whole = gfx2.loadImage("\\ImmersiveHunger\\gold_outline_whole.png")
        outline_half = gfx2.loadImage("\\ImmersiveHunger\\gold_outline_half.png")
    else
        outline_whole = gfx2.loadImage("\\ImmersiveHunger\\blue_outline_whole.png")
        outline_half = gfx2.loadImage("\\ImmersiveHunger\\blue_outline_half.png")
    end
    update_status()
    for i = 10, 1, -1 do
        gfx2.drawImage(-9 + (i * 8), 0, 9, 9, default_outline)
        if hunger >= 2 then
            if player.effects()["17"] ~= nil then
                gfx2.drawImage(-9 + (i * 8), 0, 9, 9, hungry_whole)
            else
                gfx2.drawImage(-9 + (i * 8), 0, 9, 9, hunger_whole)
            end
            hunger = hunger - 2
        elseif hunger == 1 then
            if player.effects()["17"] ~= nil then
                gfx2.drawImage(-9 + (i * 8), 0, 9, 9, hungry_half)
            else
                gfx2.drawImage(-9 + (i * 8), 0, 9, 9, hunger_half)
            end
            hunger = hunger - 1
        end
        if saturation >= 2 then
            gfx2.drawImage(-9 + (i * 8), 0, 9, 9, outline_whole)
            saturation = saturation - 2
        elseif saturation == 1 then
            gfx2.drawImage(-9 + (i * 8), 0, 9, 9, outline_half)
            saturation = saturation - 1
        end
    end

    item_on_hand = player.inventory().at(player.inventory().selected)
    if item_on_hand ~= nil then item_on_hand = item_on_hand.name end
    
    accumulator = accumulator + dt
    if accumulator >= 1/6 then
        update_alpha()
    end
    update_status()

    if item_on_hand ~= nil and foods[item_on_hand] ~= nil then
        if preview_only_when_eating.value then
            if not player.getFlag(4) then
                return
            end
        end
        hunger_preview = hunger + foods[item_on_hand].hunger
        saturation_preview = saturation + foods[item_on_hand].saturation
        for i = 10, 1, -1 do
            if hunger_preview >= 2 then
                gfx2.drawImage(-9 + (i * 8), 0, 9, 9, hunger_whole, alpha)
                hunger_preview = hunger_preview - 2
            elseif hunger_preview == 1 then
                gfx2.drawImage(-9 + (i * 8), 0, 9, 9, hunger_half, alpha)
                hunger_preview = hunger_preview - 1
            end

            if saturation_preview >= 2 then
                gfx2.drawImage(-9 + (i * 8), 0, 9, 9, outline_whole, alpha)
                saturation_preview = saturation_preview - 2
            elseif saturation_preview == 1 then
                gfx2.drawImage(-9 + (i * 8), 0, 9, 9, outline_half, alpha)
                saturation_preview = saturation_preview - 1
            end

        end
    end
end

function update_alpha()
    if alpha >= 1 then
        direction = -1
    elseif alpha <= 0 then
        direction = 1
    end

    alpha = alpha + (0.02 * direction)
end

function update_status()
    hunger = player.attributes().id(1).value
    saturation = math.ceil(player.attributes().id(2).value)
end

foods = {
    ["apple"] = {
        hunger = 4,
        saturation = 2
    },
    ["baked_potato"] = {
        hunger = 5,
        saturation = 6
    },
    ["beetroot"] = {
        hunger = 1,
        saturation = 1.2
    },
    ["beetroot_soup"] = {
        hunger = 6,
        saturation = 7
    },
    ["bread"] = {
        hunger = 5,
        saturation = 6
    },
    ["carrot"] = {
        hunger = 3,
        saturation = 4
    },
    ["chorus_fruit"] = {
        hunger = 4,
        saturation = 2
    },
    ["cooked_chicken"] = {
        hunger = 6,
        saturation = 7
    },
    ["cooked_cod"] = {
        hunger = 5,
        saturation = 6
    },
    ["cooked_mutton"] = {
        hunger = 6,
        saturation = 10
    },
    ["cooked_porkchop"] = {
        hunger = 8,
        saturation = 12.8
    },
    ["cooked_rabbit"] = {
        hunger = 5,
        saturation = 6
    },
    ["cooked_salmon"] = {
        hunger = 6,
        saturation = 9.6
    },
    ["cookie"] = {
        hunger = 2,
        saturation = 0.4
    },
    ["dried_kelp"] = {
        hunger = 1,
        saturation = 0.2
    },
    ["enchanted_golden_apple"] = {
        hunger = 4,
        saturation = 9.6
    },
    ["golden_apple"] = {
        hunger = 4,
        saturation = 9.6
    },
    ["glow_berries"] = {
        hunger = 2,
        saturation = 1.2
    },
    ["golden_carrot"] = {
        hunger = 6,
        saturation = 14.4
    },
    ["honey_bottle"] = {
        hunger = 6,
        saturation = 1.2
    },
    ["melon_slice"] = {
        hunger = 2,
        saturation = 1.2
    },
    ["mushroom_stew"] = {
        hunger = 6,
        saturation = 7.2
    },
    ["poisonous_potato"] = {
        hunger = 2,
        saturation = 1.2
    },
    ["potato"] = {
        hunger = 1,
        saturation = 0.4
    },
    ["pufferfish"] = {
        hunger = 1,
        saturation = 0.2
    },
    ["pumpkin_pie"] = {
        hunger = 8,
        saturation = 4.8
    },
    ["rabbit_stew"] = {
        hunger = 10,
        saturation = 12
    },
    ["raw_beef"] = {
        hunger = 3,
        saturation = 1.8
    },
    ["raw_chicken"] = {
        hunger = 2,
        saturation = 1.2
    },
    ["raw_cod"] = {
        hunger = 2,
        saturation = 0.4
    },
    ["raw_mutton"] = {
        hunger = 2,
        saturation = 1.2
    },
    ["raw_porkchop"] = {
        hunger = 3,
        saturation = 1.8
    },
    ["raw_rabbit"] = {
        hunger = 3,
        saturation = 1.8
    },
    ["raw_salmon"] = {
        hunger = 2,
        saturation = 0.4
    },
    ["rotten_flesh"] = {
        hunger = 4,
        saturation = 0.8
    },
    ["spider_eye"] = {
        hunger = 2,
        saturation = 3.2
    },
    ["cooked_beef"] = {
        hunger = 8,
        saturation = 12.8
    },
    ["suspicious_stew"] = {
        hunger = 6,
        saturation = 7.2
    },
    ["sweet_berries"] = {
        hunger = 2,
        saturation = 1.2
    },
    ["tropical_fish"] = {
        hunger = 1,
        saturation = 0.2
    }
}