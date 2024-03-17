name = "Offhand slot display"
description = "shows the offhand item"

--[[
    Original module made by MCBE Craft
    Improvements by rice
]]

client.settings.addAir(5)
opacity = 0.75
client.settings.addFloat("Opacity", "opacity", 0, 1)

client.settings.addAir(5)
count_visible_in_gmc = false
client.settings.addBool("Item Count Visible in Creative Mode", "count_visible_in_gmc")

client.settings.addAir(5)
armorHud = false
client.settings.addBool("Add to Onix' Armor Hud module", "armorHud")

importLib("module.lua")

local atlasPath = "textures/gui/gui2"
local armorHudModule

function update(dt)
    armorHudModule = getModule("Armor HUD")
end

function render(deltaTime)
    local inventory = player.inventory()
    local offhandItem = inventory.offhand()
    if offhandItem and not gui.mouseGrabbed() then
        gfx.ctexture(gui.width() / 2 - 120, gui.height() - 23.5, 11, 22, atlasPath, 0, 0, 0.04296874999, 0.08593749999)
        gfx.ctexture(gui.width() / 2 - 109, gui.height() - 23.5, 11, 22, atlasPath, 0.66796875, 0, 0.04296874999,
            0.08593749999)
        gfx.fimage(math.floor(255 * opacity))
        gfx.item(gui.width() / 2 - 117, gui.height() - 20.5, offhandItem.location, 1)
        if offhandItem.maxDamage and offhandItem.durability > 0 and (count_visible_in_gmc or player.gamemode() ~= 1) then
            gfx.color(0, 0, 0, 255)
            gfx.rect(gui.width() / 2 - 115, gui.height() - 8, 13, 2)
            gfx.color(13, 64, 0, 255)
            gfx.rect(gui.width() / 2 - 115, gui.height() - 8, 12, 1)
            local percent = math.floor((offhandItem.maxDamage - offhandItem.durability) / offhandItem.maxDamage * 100)
            gfx.color(255 * (100 - percent) / 100, 255 * percent / 100, 0, 255)
            gfx.rect(gui.width() / 2 - 115, gui.height() - 8, math.floor(12 * (percent / 100)), 1)
        end
        if (offhandItem.count ~= 1 and player.gamemode() == 0 or offhandItem.count ~= 1 and count_visible_in_gmc or offhandItem.count ~= 1 and player.gamemode() == 2) then
            gfx.color(255, 255, 255, 255)
            if (offhandItem.count >= 10) then
                gfx.text(gui.width() / 2 - 112.5, gui.height() - 12, offhandItem.count .. "", 1)
            else
                gfx.text(gui.width() / 2 - 106.5, gui.height() - 12, offhandItem.count .. "", 1)
            end
        end
    end
    if armorHud and armorHudModule and offhandItem then
        if getSetting(armorHudModule, "horizontal").value then
            gfx.item(armorHudModule.pos["x"] + armorHudModule.size["x"] + 3, armorHudModule.pos["y"],
                offhandItem.location, 5)
            -- gfx.item(armorHudModule.pos["x"] + armorHudModule.size["x"] + 3, armorHudModule.pos["y"], offhandItem.location, getSetting(armorHudModule, "scale").value)
        else
            local text
            local c = getSetting(armorHudModule, "textColor").value
            gfx.color(c.r * 255, c.g * 255, c.b * 255, c.a * 255)
            if getSetting(armorHudModule, "showDurability").value then
                if getSetting(armorHudModule, "durabilityPercent").value then
                    if offhandItem.maxDamage and offhandItem.maxDamage ~= 0 then
                        local percent = math.floor((offhandItem.maxDamage - offhandItem.durability) /
                        offhandItem.maxDamage * 100)
                        text = percent .. "%"
                        if percent <= 50 then
                            gfx.color(255, (percent * 2) * 2.55, 0, c.a * 255)
                        else
                            gfx.color((((100 - percent) - 50) * 2) * 2.55, 255, 0, c.a * 255)
                        end
                    end
                elseif getSetting(armorHudModule, "showMaxDurability").value then
                    if offhandItem.maxDamage and offhandItem.maxDamage ~= 0 then
                        text = (offhandItem.maxDamage - offhandItem.durability) .. "/" .. offhandItem.maxDamage
                    else
                        text = offhandItem.count .. "/"
                        if offhandItem.maxStackCount then
                            text = text .. offhandItem.maxStackCount
                        else
                            text = text .. "64"
                        end
                    end
                else
                    if offhandItem.maxDamage then
                        text = (offhandItem.maxDamage - offhandItem.durability)
                    else
                        text = offhandItem.count
                    end
                end
            end
            if getSetting(armorHudModule, "rightText").value then
                gfx.item(armorHudModule.pos["x"],
                    armorHudModule.pos["y"] + armorHudModule.size["y"] +
                    getSetting(armorHudModule, "padding").value * getSetting(armorHudModule, "scale").value,
                    offhandItem.location, getSetting(armorHudModule, "scale").value)
                if text then
                    gfx.text(armorHudModule.pos["x"] + 18 * getSetting(armorHudModule, "scale").value,
                        armorHudModule.pos["y"] + armorHudModule.size["y"] +
                        (5 + getSetting(armorHudModule, "padding").value) * getSetting(armorHudModule, "scale").value,
                        text .. "", getSetting(armorHudModule, "scale").value)
                end
            else
                gfx.item(
                armorHudModule.pos["x"] + armorHudModule.size["x"] - 17 * getSetting(armorHudModule, "scale").value,
                    armorHudModule.pos["y"] + armorHudModule.size["y"] +
                    getSetting(armorHudModule, "padding").value * getSetting(armorHudModule, "scale").value,
                    offhandItem.location, getSetting(armorHudModule, "scale").value)
                if text then
                    gfx.text(
                    armorHudModule.pos["x"] + armorHudModule.size["x"] - 19 * getSetting(armorHudModule, "scale").value -
                    gui.font().width(text, getSetting(armorHudModule, "scale").value),
                        armorHudModule.pos["y"] + armorHudModule.size["y"] +
                        (5 + getSetting(armorHudModule, "padding").value) * getSetting(armorHudModule, "scale").value,
                        text .. "", getSetting(armorHudModule, "scale").value)
                end
            end
        end
    end
end
