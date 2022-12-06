name = "Among UI"
description = "gives you a sus UI"

--made by helix(has_no_hair)
--might add things like hunger and xp in the future idk 

centerMogus = client.settings.addNamelessBool("Lock the sus bar to center?", false)

function getMogus()
    workingDir = "RoamingState/OnixClient/Scripts/Data"
    fs.mkdir("AmongUI")
    workingDir = "RoamingState/OnixClient/Scripts/Data/AmongUI"
    for i = 1, 3 do
        network.fileget("amongus"..i..".png","https://github.com/OnixClient-Scripts/OnixClient_Scripts/blob/master//Data/AmongusHealth/amongus"..i..".png?raw=true", "amongus"..i)
    end
end

getMogus()

function onNetworkData(code, id, data) end

positionX, positionY = 224, 293
sizeX, sizeY = 30, 10

workingDir = "RoamingState/OnixClient/Scripts/Data/AmongUI"
function render(dt)
    local attributes = player.attributes()
    local health = attributes.id(7).value
    gfx.image(-4, 0, 10, 10, "amongus1.png")
    for i = 1, health do
        gfx.image(4 * i, 0, 4, 10, "amongus2.png")
    end
    gfx.image(health * 4 + 4, 0, 10, 10, "amongus3.png")
    sizeX = health * 4 + 20
    if centerMogus == true then
        positionX = (gui.width() - sizeX) / 2
    end
end