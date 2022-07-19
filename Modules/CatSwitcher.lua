name="Cat Switcher"
description="xJqms's favorite module!"

positionX = 80
positionY = 80
sizeX = 80
sizeY = 64


switchkey = 0
client.settings.addKeybind("Get New", "switchkey")


--status = "nothing"
shouldRefreshImage = false


function searchImage()
    --status = "getting url..."
    network.get("https://api.thecatapi.com/v1/images/search", "url", {"bloat1", "bloat2", "bloat3"})
end

function onNetworkData(code, id, data)
    if id == "url" then
        thing = jsonToTable(data)
        if type(thing) ~= "table" then
            searchImage()
        else
            local url = thing["url"]
            if type(url) ~= "string" then
                searchImage()
            else
                --status = "downloading " .. url
                network.fileget("catimage.jpg", thing["url"], "image")
            end
        end
    elseif id == "image" then
        shouldRefreshImage = true
        --status = ""
    end
end



event.listen("KeyboardInput", function(key, down)
    if down == true and gui.mouseGrabbed() == false and key == switchkey then
        searchImage()
    end
end)

searchImage()
function render(dt)
    if shouldRefreshImage == true then
        gfx.unloadimage("catimage.jpg")
        shouldRefreshImage = false
    end
    --gfx.text(0, 0, status, 0.5)
    gfx.image(0, 0, sizeX, sizeY, "catimage.jpg")
end
