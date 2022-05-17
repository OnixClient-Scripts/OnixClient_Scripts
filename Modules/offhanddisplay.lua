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

atlasPath = "textures/gui/gui2.png"

function render(deltaTime)

    if (gui.mouseGrabbed() == false) then
        local inventory = player.inventory()
        local offhandItem = inventory.offhand()
        if (offhandItem ~= nil) then
            gfx.ctexture(gui.width() / 2 - 120, gui.height()  - 23.5, 11, 22, atlasPath, 0, 0, 0.04296874999, 0.08593749999)
            gfx.ctexture(gui.width() / 2 - 109, gui.height()  - 23.5, 11, 22, atlasPath, 0.66796875, 0, 0.04296874999, 0.08593749999)
            gfx.fimage(math.floor(255 * opacity))
            gfx.item(gui.width() / 2 - 117, gui.height()  - 20.5, offhandItem.location, 1)
            if (offhandItem.count ~= 1 and player.gamemode() == 0 or offhandItem ~= 1 and count_visible_in_gmc or offhandItem.count ~= 1 and player.gamemode() == 2) then
                gfx.color(255,255,255, math.floor(255 * opacity))
                if (offhandItem.count >= 10) then
                    gfx.text(gui.width() / 2 - 112.5, gui.height()  - 12, offhandItem.count, 1)
                else
                    gfx.text(gui.width() / 2 - 106.5, gui.height()  - 12, offhandItem.count, 1)
                end
            end
        
        end
        
    end
end
