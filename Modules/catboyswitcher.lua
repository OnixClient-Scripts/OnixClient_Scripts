name = "Catboy fetcher"
description = "Gets a random image from the cat boy api"

-- https://api.catboys.com/img

fs.mkdir("fileGet")
workingDir = "RoamingState\\OnixClient\\Scripts\\Data\\fileGet"
switchkey = 0
client.settings.addKeybind("Key to fetch new image: ", "switchkey")

function newImage()
    network.get("https://api.catboys.com/img", "url", {"url", "artist", "artist_url", "source_url", "error"})
end

local infoTable = {}
function onNetworkData(code, id, data)
    if id == "url" then
        infoTable = jsonToTable(data)
        if type(infoTable) ~= "table" then
            newImage()
        else
            local url = infoTable["url"]
            if type(url) ~= "string" then
                newImage()
            else
                network.fileget("catboy.jpg", infoTable["url"], "image")
                texture = gfx2.loadImage("catboy.jpg")
                shouldRefreshImage = true
            end
        end
    end
end

event.listen("KeyboardInput", function(key, down)
    if down == true and gui.mouseGrabbed() == false and key == switchkey then
        newImage()
    end
end)

newImage()
sizeX, sizeY = 120, 160
positionX, positionY = gui.width() - sizeX, gui.height() - sizeY
infoTable["artist"] = ""
function render2(dt)
    gfx2.color(40, 40, 60)
    gfx2.fillRect(-2, -14, sizeX + 4, sizeY + 16)
    gfx2.drawImage(0, 0, sizeX, sizeY, texture, 1, false)
    gfx2.color(20, 20, 40)
    gfx2.fillRect(0, -12, sizeX, 10)
    gfx2.color(240, 240, 240)
    gfx2.text(2, -12, "Artist: " .. infoTable["artist"])
end