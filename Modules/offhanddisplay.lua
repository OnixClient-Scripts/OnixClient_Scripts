name = "Offhand slot display"
description = "shows the offhand item"

positionX = 200
positionY = 310
sizeX = 22
sizeY = 22

path = "textures/ui/hotbar_0"
opacity = 0.75

--[[
    Original module made by MCBE Craft
]]--

function update(deltaTime)

end


function render(deltaTime)

    if (gui.mouseGrabbed() == false) then
        local inventory = player.inventory()
        local offhandItem = inventory.offhand()
        if (offhandItem ~= nil) then
            gfx.texture(0, 0, sizeX, sizeY, path, opacity)
            gfx.item(3, 3, offhandItem.location, 1)
            if (offhandItem.count ~= 0 and player.gamemode() ~= 1) then
                gfx.color(255,255,255, math.floor(255 * opacity))
                if (offhandItem.count >= 10) then
                    gfx.text(8, 11, offhandItem.count, 1)
                else
                    gfx.text(14, 11, offhandItem.count, 1)
                end
            end
        
        end
        
    end
end
