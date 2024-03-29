name = "Saturation display"
description = "gives the amout of saturation"

positionX = 50
positionY = 50
atlasPath = "textures/gui/icons"
--imagePathFull = "hunger_full"
--imagePathHalf = "hunger_half"
--imagePathEmpty = "hunger_empty"

--[[
    Original module made by MCBE Craft

    Improvements by Onix86
]]--

function render(deltaTime)
    
    
    positionX = gui.width() / 2 + 80
    positionY = gui.height()  - 51
    local x,y,z = player.position()
    if (dimension.getBlock(x,y,z).name == "water") then
        positionY = positionY - 10
    end

    if (player.gamemode() ~= 1 and gui.mouseGrabbed() == false) then
        local attributeList = player.attributes()
        local saturation = math.floor(attributeList.name("minecraft:player.saturation").value)
        for i = 0, 9 do
            gfx.ctexture(positionX - (i * 8), positionY, 9, 9, atlasPath, 0.0625, 0.10546875, 0.03515625, 0.03515625)
            if (saturation/2 > i) then
                if (i ~= (saturation - 1)/2) then
                    gfx.ctexture(positionX - (i * 8), positionY, 9, 9, atlasPath, 0.203125, 0.10546875, 0.03515625, 0.03515625)
                else
                    gfx.ctexture(positionX - (i * 8), positionY, 9, 9, atlasPath, 0.23828125, 0.10546875, 0.03515625, 0.03515625)
                end
            --else
                --empty
            end
        end
        gfx.fimage()
    end
end
