name = "Mining mod"
description = "Usefull infos and stats for mining"

positionX = 500
positionY = 25
sizeX = 100
sizeY = 50

pickaxePath = "textures/items/diamond_pickaxe"


--[[
    Original module made by MCBE Craft
]]--

function update(deltaTime)
    
end


function render(deltaTime)
    local inventory = player.inventory()
    local durability = 0
    local ores = {"iron", "gold", "copper", "redstone", "lapis", "emerald", "quartz", "diamond", "netherite"}
    local amountOre = {0, 0, 0, 0, 0, 0, 0, 0, 0}
    local amountRessource = {0, 0, 0, 0, 0, 0, 0, 0, 0}
    local pathOre = {"", "", "", "", "", "", "", "", ""}
    local pathRessource = {"", "", "", "", "", "", "", "", ""}
    for i=1,inventory.size do
        local slot = inventory.at(i)
        if (slot ~= nil) then
            if (slot.id == 297 or slot.id == 318 or slot.id == 604) then
                durability = durability + slot.maxData - slot.data
            elseif (string.find(slot.name, "_ore") ~= nil or slot.name == "ancient_debris") then
                for a=1,9 do
                    local ore = ores[a]
                    if (string.find(slot.name, ore) or slot.name == "ancient_debris" and ore == "netherite") then
                        amountOre[a] = amountOre[a] + slot.count
                        pathOre[a] = slot.location
                    end
                end
            else
                for a=1,9 do
                    local ore = ores[a]
                    if (slot.name == ore or slot.name == ore .. "_ingot" and slot.name ~= "netherite_ingot" or slot.name == "raw_" .. ore or slot.name == ore .. "_lazuli" or slot.name == ore .. "_scrap") then
                        amountRessource[a] = amountRessource[a] + slot.count
                        pathRessource[a] = slot.location
                    end
                end
            end
        end
    end

    local text = "total durability: " .. durability

    local font = gui.font()
    sizeX = font.width(text) + 13

    gfx.texture(1, 1, 10, 10, pickaxePath)
    gfx.text(12, 1, text)

    local b = 1
    for a=1,9 do
        if (amountOre[a] > 0) then
            gfx.item(positionX + 1, positionY + b * 10 + 1, pathOre[a], 0.625)
            gfx.text(12, b * 10 + 1, ores[a] .. ": " .. amountOre[a])
            b = b + 1
        end
    end
    for a=1,9 do
        if (amountRessource[a] > 0) then
            gfx.item(positionX + 1, positionY + b * 10 + 1, pathRessource[a], 0.625)
            gfx.text(12, b * 10 + 1, ores[a] .. ": " .. amountRessource[a])
            b = b + 1
        end
    end
    sizeY = b * 10 + 2
end
