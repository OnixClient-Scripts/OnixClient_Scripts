name = "TW Resource Counter"
description = "Helps blind users see what is right in front of them"

positionX = gui.width() - 70
positionY = 30
sizeX = 60
sizeY = 48

--[[
    made by Onix86
]]

local GoldTexture = nil
local DiamondTexture = nil
local EmeraldTexture = nil


textColor = client.settings.addNamelessColor("Text Color", {255,255,255,255})
backColor = client.settings.addNamelessColor("Background Color", {0,0,0,127})
backRadius = client.settings.addNamelessFloat("Background Radius", 0, 24, 0)
showEmpty = client.settings.addNamelessBool("Show Empty", true)


function getItemCount(name)
    local result = 0
    local inv= player.inventory()
    for i=1,inv.size do
        local item = inv.at(i)
        if item ~= nil then
            if item.name == name then result = result + item.count end
        end
    end
    return result
end


WidestResourceText = 16
ResourceTexts = {}
ResourceImages = {}
function renderResource(name, vname, ypos, texture)
    local itemCount = getItemCount(name)    
    if (itemCount > 0 or showEmpty.value == true) and texture ~= nil then
        local text = vname .. ": " .. itemCount
        local textWidth, textHeight = gfx2.textSize(text)

        table.insert(ResourceTexts, {20, (8 - (textHeight / 2)) + ypos, text})
        table.insert(ResourceImages, {2, ypos, 16, 16, texture, textColor.value.a, false})

        WidestResourceText = math.max(WidestResourceText, textWidth)
        return 18
    end
    return 0
end

function render2()
    loadTextures()
    local currY = 2

    WidestResourceText = 16
    ResourceTexts = {}
    ResourceImages = {}

    currY = currY + renderResource("gold_ingot", "Gold", currY, GoldTexture)
    currY = currY + renderResource("diamond", "Diamond", currY, DiamondTexture)
    currY = currY + renderResource("emerald", "Emerald", currY, EmeraldTexture)

    sizeY = math.max(20, currY)
    sizeX = WidestResourceText + 22

    gfx2.color(backColor)
    gfx2.fillRoundRect(0, 0, sizeX, sizeY, backRadius.value)

    gfx2.color(textColor)
    for _, text in pairs(ResourceTexts) do
        gfx2.text(text[1], text[2], text[3])
    end

    for _, image in pairs(ResourceImages) do
        gfx2.drawImage(image[1], image[2], image[3], image[4], image[5], image[6], image[7])
    end
end

















function loadTextures() --only load textures when we are enabled to make the script load faster for non users
    GoldTexture = GoldTexture or gfx2.loadImage(16, 16, "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAsmQR/7JkEf8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAALJkEf+yZBH/smQR//rWSv/61kr/smQR/wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACyZBH/smQR/7JkEf/99V///fVf//31X//99V///fVf//31X/+yZBH/AAAAAAAAAAAAAAAAsmQR/7JkEf+yZBH/+tZK//31X//99V///fVf//31X//99V///fVf//31X//99V//+tZK/3UoAv8AAAAAsmQR///94P/99V///fVf//31X//99V///fVf//31X//99V///fVf//31X//99V////3g///94P/99V//dSgC/7JkEf/61kr///3g//31X//99V///fVf//31X//99V///fVf///94P///eD///3g//31X//clhP/+tZK/3UoAv+yZBH/+tZK//31X////eD//fVf//31X////eD///3g///94P/99V//6bEV/9yWE//clhP/3JYT//rWSv91KAL/smQR//rWSv/99V//+tZK/////////eD//fVf/+mxFf/clhP/3JYT/9yWE//clhP/6bEV//rWSv/61kr/dSgC/7JkEf/psRX//fVf//rWSv/99V//6bEV/9yWE//clhP/3JYT/9yWE//psRX/+tZK//rWSv91KAL/dSgC/wAAAAAAAAAAsmQR/+mxFf/61kr//fVf/+mxFf/clhP/3JYT/+mxFf/psRX/dSgC/3UoAv91KAL/AAAAAAAAAAAAAAAAAAAAAAAAAACyZBH/6bEV//rWSv/psRX/6bEV/3UoAv91KAL/dSgC/wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAALJkEf+yZBH/dSgC/3UoAv8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==")
    DiamondTexture = DiamondTexture or gfx2.loadImage(16, 16, "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAARcnr/EXJ6/xFyev8Rcnr/AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAARcnr/////////////////1f/2/xFyev8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAARcnr//////0rt2f9K7dn/ofvo/9X/9v8gxbX/FF5T/wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAARcnr//////0rt2f+h++j/ofvo/9X/9v+h++j/Su3Z/yDFtf8UXlP/AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEXJ6//////9K7dn//////9X/9v//////1f/2/0rt2f9K7dn/FF5T/wAAAAAAAAAAAAAAAAAAAAAAAAAAEXJ6//////9K7dn//////0rt2f9K7dn/ofvo/6H76P8aqqf/IMW1/xqqp/8UXlP/AAAAAAAAAAAAAAAAAAAAABFyev//////Su3Z/9X/9v9K7dn/ofvo/6H76P+h++j/HJGa/yDFtf8aqqf/FF5T/wAAAAAAAAAAAAAAAAAAAAARcnr///////////8gxbX/ofvo/6H76P+h++j/Su3Z/xyRmv8aqqf/Gqqn/xReU/8AAAAAAAAAAAAAAAAAAAAAEXJ6/9X/9v9K7dn/Su3Z/xqqp/8aqqf/Gqqn/xqqp/8gxbX/IMW1/xyRmv8UXlP/AAAAAAAAAAAAAAAAAAAAAAAAAAAUXlP/Su3Z/xqqp/8gxbX/IMW1/yDFtf8gxbX/Gqqn/yDFtf8UXlP/AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAFF5T/yzg2P8aqqf/IMW1/yDFtf8gxbX/IMW1/xqqp/+h++j/FF5T/wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAUXlP/HJGa/0rt2f9K7dn/ofvo/6H76P8gxbX/FF5T/wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABReU/8UXlP/FF5T/xReU/8UXlP/FF5T/wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==")
    EmeraldTexture = EmeraldTexture or gfx2.loadImage(16, 16, "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAUwD/AFMA/wBTAP8AUwD/AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAUwD/2//r/0HzhP9B84T/F91i/wBTAP8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAUwD/2//r/6/9zf9B84T/QfOE/wCqLP8X3WL/AC0A/wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAUwD/2//r/6/9zf+v/c3/QfOE/0HzhP8Aqiz/AKos/xfdYv8ALQD/AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAFMA/6/9zf8X3WL/F91i/6/9zf+v/c3/AKos/wCVKf8Aqiz/AC0A/wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABTAP+v/c3/F91i/xfdYv+v/c3/gvat/wCqLP8Aexj/AKos/wAtAP8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAUwD/r/3N/xfdYv8X3WL/r/3N/4L2rf8Aqiz/AHsY/wCqLP8ALQD/AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAFMA/6/9zf8X3WL/F91i/4L2rf+C9q3/AKos/wB7GP8X3WL/AC0A/wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABTAP+v/c3/F91i/xfdYv+C9q3/QfOE/wB7GP8AlSn/F91i/wAtAP8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAFMA/wCqLP8AlSn/AHsY/wB7GP8AlSn/gvat/wAtAP8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAUwD/AKos/wCVKf8Aexj/F91i/wAtAP8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAtAP8ALQD/AC0A/wAtAP8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==")
end
