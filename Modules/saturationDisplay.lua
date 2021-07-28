name = "Saturation display"
description = "gives the amout of saturation"

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
    gfx.color(255, 0, 0, 0)
    for i = 0, 9 do
        gfx.image((positionX) - (i * 8), positionY - 3, 9, 9, imagePathEmpty)
    end
    for i=0,(saturation - 1)/2 do
        if (i ~= (saturation - 1)/2) then
            gfx.image(positionX - (i * 8), positionY - 3, 9, 9, imagePathFull)
        else
            gfx.image(positionX - (i * 8), positionY - 3, 9, 9, imagePathHalf)
        end
    end
end
