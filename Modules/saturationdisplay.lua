name = "Saturation display"
description = "gives the amout of saturation"

--[[
    Saturation Display Module Script
	
	made by MCBE Craft
]]

positionX = 401
positionY = 285
imagePathFull = "hunger_full.png"
imagePathHalf = "hunger_half.png"
imagePathEmpty = "hunger_empty.png"

function update(deltaTime)

end


function render(deltaTime)
    local attributeList = player.attributes()
    local saturation = math.floor(attributeList.name("minecraft:player.saturation").value)
    for i = 0, 9 do
        if (saturation/2 > i) then
            if (i ~= (saturation - 1)/2) then
                gfx.image(positionX - (i * 8), positionY - 3, 9, 9, imagePathFull)
            else
                gfx.image(positionX - (i * 8), positionY - 3, 9, 9, imagePathHalf)
            end
        else
            gfx.image(positionX - (i * 8), positionY - 3, 9, 9, imagePathEmpty)
        end
    end
end
