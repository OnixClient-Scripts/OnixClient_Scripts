name = "Better Hunger"
description = "Hunger has never been so efficient and intuitive"

--[[
    betterHunger Module Script
	
	made by O2Flash20
]]

positionX = 500
positionY = 25
sizeX = 100
sizeY = 10

backgroundC = {51, 51, 51}
client.settings.addColor("Background Color", "backgroundC")

noSprintC = {100, 0, 0}
client.settings.addColor("No Sprint Color", "noSprintC")

hungerC = {200, 0, 0}
client.settings.addColor("Hunger Color", "hungerC")

hungerPreviewC = {0, 255, 0}
client.settings.addColor("Hunger Preview Color", "hungerPreviewC")

saturationC = {238, 230, 1}
client.settings.addColor("Saturation Color", "saturationC")

saturationPreviewC = {150, 255, 0}
client.settings.addColor("Saturation Preview Color", "saturationPreviewC")

canEatC = {0, 0, 0}
client.settings.addColor("Can Eat Color", "canEatC")

cantEatC = {255, 0, 0}
client.settings.addColor("Can't Eat Color", "cantEatC")

function render()
    att = player.attributes()
    exh = att.id(4).value
    sat = att.id(3).value
    hun = att.id(2).value

    heldThing = player.inventory().at(player.inventory().selected)
    if heldThing ~= nil then
        held = heldThing.name
    else
        held = "air"
    end
    
    heldIndex = 1
    for i = 0, #foods, 1 do
        if held ~= nil then
            if held == foods[i] then
                heldIndex = i
            end
        end
    end

    hunHeld = math.floor(hunger[heldIndex]+0.5)
    satHeld = math.floor(saturation[heldIndex]+0.5)

    if sat==0 then
        hunVal = hun*4 + (4-exh)
        satVal = sat*4
        slowVal = math.min(hunVal, 6*4)
    else
        hunVal = hun*4 + 4
        satVal = sat*4 + (4-exh) - 4
        slowVal = 6*4
    end

    if hunHeld + hun > 20 then
        hunHeld = 20-hun
    end
    if satHeld + sat > 20 then
        satHeld = 20-sat
    end

    hunVal = hunVal / (160/sizeX)
    satVal = satVal / (160/sizeX)
    slowVal = slowVal / (160/sizeX)
    hunHeldVal = hunHeld*4 / (160/sizeX)
    satHeldVal = satHeld*4 / (160/sizeX)

    q = 10
    r = 3
    -- Background
    gfx.color(backgroundC.r, backgroundC.g, backgroundC.b)
    gfx.roundRect(0, 0, sizeX, sizeY, r, q)
    -- Hunger
    gfx.color(hungerC.r, hungerC.g, hungerC.b)
    gfx.roundRect(0, 0, hunVal, 10, r, q)
    if sat > 0 or satHeld > 0 then gfx.rect(hunVal/2, 0, hunVal/2, 10) end
    -- Hunger preview
    gfx.color(hungerPreviewC.r, hungerPreviewC.g, hungerPreviewC.b)
    gfx.roundRect(hunVal, 0, hunHeldVal, 10, r, q)
    gfx.rect(hunVal, 0, hunHeldVal/2, 10)
    if sat > 0 or satHeld > 0 then gfx.rect(hunVal+hunHeldVal/2, 0, hunHeldVal/2, 10) end
    -- No sprint bar
    gfx.color(noSprintC.r, noSprintC.g, noSprintC.b)
    gfx.roundRect(0, 0, slowVal, 10, r, q)
    if hun > 6 then gfx.rect(slowVal/2, 0, slowVal/2, 10) end
    -- Saturation
    gfx.color(saturationC.r, saturationC.g, saturationC.b)
    gfx.roundRect(hunHeldVal+hunVal, 0, satVal, 10, r, q)
    gfx.rect(hunHeldVal+hunVal, 0, satVal/2, 10)
    if satHeld > 0 then gfx.rect(hunHeldVal+hunVal, 0, satVal, 10) end
    -- Saturation preview
    gfx.color(saturationPreviewC.r, saturationPreviewC.g, saturationPreviewC.b)
    gfx.roundRect(satVal+hunHeldVal+hunVal, 0, satHeldVal, 10, r, q)
    gfx.rect(satVal+hunHeldVal+hunVal, 0, satHeldVal/2, 10)
    -- middle bar
    if hun == 20 and held~="golden_apple" and held~="enchanted_golden_apple" then
        gfx.color(cantEatC.r, cantEatC.g, cantEatC.b)
        gfx.roundRect(sizeX/4, sizeY/4, sizeX/2, sizeY/2, r, q)
    else
        gfx.color(canEatC.r, canEatC.g, canEatC.b)
        gfx.roundRect(sizeX/4, sizeY/4, sizeX/2, sizeY/2, r, q)
    end
end

foods  =     {"none", "apple", "baked_potato", "beetroot", "beetroot_soup", "bread", "carrot", "chorus_fruit", "cooked_chicken", "cooked_cod", "cooked_mutton", "cooked_porkchop", "cooked_rabbit", "cooked_salmon", "cookie", "dried_kelp", "enchanted_golden_apple", "golden_apple", "glow_berries", "golden_carrot", "honey_bottle", "melon_slice", "mushroom_stew", "poisonous_potato", "potato", "pufferfish", "pumpkin_pie", "rabbit_stew", "raw_beef", "raw_chicken", "raw_cod", "raw_mutton", "raw_porkchop", "raw_rabbit", "raw_salmon", "rotten_flesh", "spider_eye", "cooked_beef", "suspicious_stew", "sweet_berries", "tropical_fish"}
hunger =     {0     , 4      , 5             , 1         , 6              , 5      , 3       , 4             , 6               , 5           , 6              , 4                , 5              , 6              , 2       , 1           , 4                       , 4             , 2             , 6              , 6             , 2            , 6              , 2                 , 1       , 1           , 8            , 10           , 3         , 2            , 2        , 2           , 3             , 3           , 2           , 4             , 2           , 8            , 6                , 2              , 1              }
saturation = {0     , 2      , 6             , 1         , 7              , 6      , 4       , 2             , 7               , 6           , 10             , 13               , 6              , 10             , 0       , 0           , 10                      , 10            , 0             , 7              , 1             , 1            , 7              , 1                 , 1       , 0.2         , 4.8          , 12           , 1.8       , 1.2          , 0.4      , 1.2         , 1.8           , 1.8         , 0.4         , 0.8           , 3.2         , 12.8         , 7.2              , 1.2            , 0.2            }
