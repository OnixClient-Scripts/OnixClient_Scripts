name = "Better Hunger Bar"
description = "a script similar to appleskin mod in java"

fade_speed = client.settings.addNamelessFloat("Fade Speed", 0, 10, 3)
color = client.settings.addNamelessColor("Saturation Color", {255, 255, 0})
prioritize_cake = client.settings.addNamelessBool("Prioritize Cake", true)
Icons = "textures/gui/icons"
positionX = gui.width() / 2 + 82
positionY = gui.height() - 41

function render()
    if (player.gamemode() ~= 1) then
        local e_saturation, e_hunger = 0, 0
        local item = player.inventory().selectedItem()
        local o_saturation = player.attributes().name("minecraft:player.saturation").value
        local saturation = math.floor(o_saturation)
        local hunger = player.attributes().name("minecraft:player.hunger").value
        local isCake = dimension.getBlock(player.selectedPos()).name == "cake"
        if prioritize_cake.value and isCake then item = { name = "cake" } end
        if isCake and not item then item = { name = "cake" } end
        if food[item and item.name or ""] then
            e_saturation = math.floor(math.min(o_saturation + food[item.name].saturation, hunger + food[item.name].hunger))
            e_hunger = hunger + food[item.name].hunger
        end
        local a = math.floor(100 + (255-100) * (math.sin(os.clock() * fade_speed.value)))
        local hasHungerEffect = player.effects()["17"]
        for i = 0, 9 do
            c = color.value
            gfx.tcolor(255, 255, 255, 255)
            draw(positionX - (i * 8), positionY, 9, 9, Icons, hasHungerEffect and 133 or 16, 27, 9, 9)
            gfx.tcolor(c.r, c.g, c.b, 255)
            if (saturation / 2 > i) then
                bool = (i ~= (saturation - 1) / 2)
                draw(positionX - (i * 8) + (bool and 0 or 4), positionY, (bool and 9 or 5), 9, Icons, (bool and 43 or 47), 27, (bool and 9 or 5), 9)
            end
            gfx.tcolor(c.r, c.g, c.b, a)
            if (e_saturation / 2 > i) then
                bool = (i ~= (e_saturation - 1) / 2)
                draw(positionX - (i * 8) + (bool and 0 or 4), positionY, (bool and 9 or 5), 9, Icons, (bool and 43 or 47), 27, (bool and 9 or 5), 9)
            end
            gfx.tcolor(255, 255, 255, 255)
            if (hunger / 2 > i) then
                bool = (i ~= (hunger - 1) / 2)
                draw(positionX - (i * 8), positionY, 9, 9, Icons, (hasHungerEffect and (bool and 88 or 97) or (bool and 52 or 61)), 27, 9, 9)
            end
            gfx.tcolor(255, 255, 255, a)
            if (e_hunger / 2 > i) then
                bool = (i ~= (e_hunger - 1) / 2)
                draw(positionX - (i * 8), positionY, 9, 9, Icons, (hasHungerEffect and (bool and 88 or 97) or (bool and 52 or 61)), 27, 9, 9)
            end
        end
    end
end

function draw(x, y, width, height, filepath, u, v, sizeX, sizeY)
    gfx.ctexture(x, y, width, height, filepath, u / 256, v / 256, sizeX / 256, sizeY / 256)
end

food = { ["apple"] = { hunger = 4, saturation = 2.4 }, ["baked_potato"] = { hunger = 5, saturation = 6 }, ["beetroot"] = { hunger = 1, saturation = 1 }, ["beetroot_soup"] = { hunger = 6, saturation = 7.2 }, ["bread"] = { hunger = 5, saturation = 6 }, ["cake"] = { hunger = 2, saturation = 0.4 }, ["carrot"] = { hunger = 3, saturation = 3.6 }, ["chorus_fruit"] = { hunger = 4, saturation = 2.4 }, ["cooked_chicken"] = { hunger = 6, saturation = 7.2 }, ["cooked_cod"] = { hunger = 5, saturation = 6 }, ["cooked_mutton"] = { hunger = 6, saturation = 9.6 }, ["cooked_porkchop"] = { hunger = 8, saturation = 12.8 }, ["cooked_rabbit"] = { hunger = 5, saturation = 6 }, ["cooked_salmon"] = { hunger = 6, saturation = 9.6 }, ["cookie"] = { hunger = 2, saturation = 0.4 }, ["dried_kelp"] = { hunger = 1, saturation = 0.2 }, ["enchanted_golden_apple"] = { hunger = 4, saturation = 9.6 }, ["golden_apple"] = { hunger = 4, saturation = 9.6 }, ["glow_berries"] = { hunger = 2, saturation = 0.4 }, ["golden_carrot"] = { hunger = 6, saturation = 14.4 }, ["honey_bottle"] = { hunger = 6, saturation = 1.2 }, ["melon_slice"] = { hunger = 2, saturation = 1.2 }, ["mushroom_stew"] = { hunger = 6, saturation = 7.2 }, ["poisonous_potato"] = { hunger = 2, saturation = 1.2 }, ["potato"] = { hunger = 1, saturation = 0.6 }, ["pufferfish"] = { hunger = 1, saturation = 0.2 }, ["pumpkin_pie"] = { hunger = 8, saturation = 4.8 }, ["rabbit_stew"] = { hunger = 10, saturation = 12 }, ["beef"] = { hunger = 3, saturation = 1.8 }, ["chicken"] = { hunger = 2, saturation = 1.2 }, ["cod"] = { hunger = 2, saturation = 0.4 }, ["mutton"] = { hunger = 2, saturation = 1.2 }, ["porkchop"] = { hunger = 3, saturation = 1.8 }, ["rabbit"] = { hunger = 3, saturation = 1.8 }, ["salmon"] = { hunger = 2, saturation = 0.4 }, ["rotten_flesh"] = { hunger = 4, saturation = 0.8 }, ["spider_eye"] = { hunger = 2, saturation = 3.2 }, ["cooked_beef"] = { hunger = 8, saturation = 12.8}, ["suspicious_stew"] = { hunger = 6, saturation = 7.2 }, ["sweet_berries"] = { hunger = 2, saturation = 1.2 }, ["tropical_fish"] = { hunger = 1, saturation = 0.2 } }
