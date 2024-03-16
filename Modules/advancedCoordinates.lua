--[[
    It was fun while it lasted, goodbye

    Made by Plextora#0033
]]
_G.switch = function(param, case_table)
    local case = case_table[param]
    if case then
        return case()
    end
    local def = case_table["default"]
    return def and def() or nil -- no I will not use tables for switch statements this is 100x times betters
end

name = "Advanced coordinates"
description = "Coordinates with some more information"

showDimension = true
showBiome = true
hideOnUnknown = false

client.settings.addBool("Display current biome?", "showBiome")
client.settings.addBool("Display current dimension?", "showDimension")
client.settings.addBool("Do not display biome if it is unknown", "hideOnUnknown")

positionX = 100
positionY = 100
sizeX = 70
sizeY = 50

function render(dt)
    local font = gui.font()
    local biome = dimension.getBiome(player.position())
    local currentBiome
    local biomeColorR
    local biomeColorB
    local biomeColorG
    local dimensionColorR
    local dimensionColorB
    local dimensionColorG

    switch(
        dimension.name(),
        {
            ["Overworld"] = function()
                dimensionColorR = "233"
                dimensionColorB = "200"
                dimensionColorG = "241"
            end,
            ["Nether"] = function()
                dimensionColorR = "206"
                dimensionColorB = "70"
                dimensionColorG = "70"
            end,
            ["TheEnd"] = function()
                dimensionColorR = "199"
                dimensionColorB = "172"
                dimensionColorG = "191"
            end
        }
    )

    if biome == nil then
        currentBiome = "???"
        biomeColorR = "255"
        biomeColorB = "0"
        biomeColorG = "0"
    end

    if biome ~= nil then -- fixes error spam ping me in onix discord if it breaks something
        if showBiome then
            switch(
                biome.name,
                {
                    ["plains"] = function()
                        currentBiome = "Plains"
                        biomeColorR = "94"
                        biomeColorB = "128"
                        biomeColorG = "47"
                    end,
                    ["river"] = function()
                        currentBiome = "River"
                        biomeColorR = "30"
                        biomeColorB = "87"
                        biomeColorG = "143"
                    end,
                    ["frozen_river"] = function()
                        currentBiome = "Frozen River"
                        biomeColorR = "68"
                        biomeColorB = "83"
                        biomeColorG = "97"
                    end,
                    ["frozen_ocean"] = function()
                        currentBiome = "Frozen Ocean"
                        biomeColorR = "124"
                        biomeColorB = "161"
                        biomeColorG = "216"
                    end,
                    ["cold_ocean"] = function()
                        currentBiome = "Cold Ocean"
                        biomeColorR = "5"
                        biomeColorB = "52"
                        biomeColorG = "121"
                    end,
                    ["forest"] = function()
                        currentBiome = "Forest"
                        biomeColorR = "32"
                        biomeColorB = "93"
                        biomeColorG = "47"
                    end,
                    ["desert"] = function()
                        currentBiome = "Desert"
                        biomeColorR = "237"
                        biomeColorB = "201"
                        biomeColorG = "175"
                    end,
                    ["basalt_deltas"] = function()
                        currentBiome = "Basalt Deltas"
                        biomeColorR = "63"
                        biomeColorB = "60"
                        biomeColorG = "63"
                    end,
                    ["crimson_forest"] = function()
                        currentBiome = "Crimson Forest"
                        biomeColorR = "160"
                        biomeColorB = "82"
                        biomeColorG = "82"
                    end,
                    ["taiga"] = function()
                        currentBiome = "Taiga"
                        biomeColorR = "137"
                        biomeColorB = "169"
                        biomeColorG = "131"
                    end,
                    ["cold_taiga"] = function()
                        currentBiome = "Cold Taiga"
                        biomeColorR = "114"
                        biomeColorB = "135"
                        biomeColorG = "110"
                    end,
                    ["beach"] = function()
                        currentBiome = "Beach"
                        biomeColorR = "255"
                        biomeColorB = "235"
                        biomeColorG = "165"
                    end,
                    ["cold_beach"] = function()
                        currentBiome = "Cold Beach"
                        biomeColorR = "169"
                        biomeColorB = "158"
                        biomeColorG = "120"
                    end,
                    ["jungle_hills"] = function()
                        currentBiome = "Jungle Hills"
                        biomeColorR = "109"
                        biomeColorB = "149"
                        biomeColorG = "109"
                    end,
                    ["jungle"] = function()
                        currentBiome = "Jungle"
                        biomeColorR = "150"
                        biomeColorB = "109"
                        biomeColorG = "84"
                    end
                }
            )

            if currentBiome == nil then
                if hideOnUnknown then
                    showBiome = false
                end
                if hideOnUnknown == false then
                    currentBiome = biome.name
                end
            end
        end
    end

    gfx.color(255, 255, 255)
    gfx.text(0, 0, string.format(" X: %s\n Y: %s\n Z: %s", player.position()))
    if showDimension then
        gfx.color(dimensionColorR, dimensionColorB, dimensionColorG)
        gfx.text(0, 0, string.format("\n\n\n Dimension: %s", dimension.name()))
    end
    if showBiome then
        gfx.color(biomeColorR, biomeColorB, biomeColorG)
        gfx.text(0, 0, string.format("\n\n\n\n Biome: %s", currentBiome))
    end
end
