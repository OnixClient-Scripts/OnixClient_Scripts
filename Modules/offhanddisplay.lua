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

local atlasPath = "textures/gui/gui2.png"
local armorHudModule

function update(dt)
    for k, v in pairs(client.modules()) do
        if v.name == "Armor HUD" and not v.isScript then
            armorHudModule = v
        end
    end
end

function getSett(mod, set)
    for k, v in pairs(mod.settings) do
        if v.name == set then
            return v
        end
    end
end

function render(deltaTime)
    local inventory = player.inventory()
    local offhandItem = inventory.offhand()
    if (offhandItem ~= nil) then
        gfx.ctexture(gui.width() / 2 - 120, gui.height()  - 23.5, 11, 22, atlasPath, 0, 0, 0.04296874999, 0.08593749999)
        gfx.ctexture(gui.width() / 2 - 109, gui.height()  - 23.5, 11, 22, atlasPath, 0.66796875, 0, 0.04296874999, 0.08593749999)
        gfx.fimage(math.floor(255 * opacity))
        gfx.item(gui.width() / 2 - 117, gui.height()  - 20.5, offhandItem.location, 1)
        if (offhandItem.count ~= 1 and player.gamemode() == 0 or offhandItem.count ~= 1 and count_visible_in_gmc or offhandItem.count ~= 1 and player.gamemode() == 2) then
            gfx.color(255,255,255, 255)
            if (offhandItem.count >= 10) then
                gfx.text(gui.width() / 2 - 112.5, gui.height()  - 12, offhandItem.count, 1)
            else
                gfx.text(gui.width() / 2 - 106.5, gui.height()  - 12, offhandItem.count, 1)
            end
        end
        if armorHud and armorHudModule then
            if getSett(armorHudModule, "Horizontally Aligned").value then
                gfx.item(armorHudModule.pos["x"] + armorHudModule.size["x"] + 3, armorHudModule.pos["y"], offhandItem.location, 1)
            else
                local text
                if getSett(armorHudModule, "Show Item Durability").value then
                    if getSett(armorHudModule, "Show Durability in %").value then
                        text = nil
                    elseif getSett(armorHudModule, "Show Durability/TotalDurability").value then
                        text = offhandItem.count .. "/"
                        if offhandItem.maxStackCount then
                            text = text .. offhandItem.maxStackCount
                        else
                            text = text .. "64"
                        end
                    else
                        text = offhandItem.count
                    end
                end
                if getSett(armorHudModule, "Text on the Right Side").value then
                    gfx.item(armorHudModule.pos["x"], armorHudModule.pos["y"] + armorHudModule.size["y"] + 5, offhandItem.location, 1)
                    local c = getSett(armorHudModule, "Text Color").value
                    gfx.color(c.r * 255, c.g * 255, c.b * 255, c.a * 255)
                    if text then
                        gfx.text(armorHudModule.pos["x"] + 18, armorHudModule.pos["y"] + armorHudModule.size["y"] + 10, text)
                    end
                else
                    gfx.item(armorHudModule.pos["x"] + armorHudModule.size["x"] - 17, armorHudModule.pos["y"] + armorHudModule.size["y"] + 5, offhandItem.location, 1)
                    local c = getSett(armorHudModule, "Text Color").value
                    gfx.color(c.r * 255, c.g * 255, c.b * 255, c.a * 255)
                    if text then
                        gfx.text(armorHudModule.pos["x"] + armorHudModule.size["x"] - 19 - gui.font().width(text) , armorHudModule.pos["y"] + armorHudModule.size["y"] + 10, text)
                    end
                end
            end
        end
    end
end
