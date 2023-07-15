name = "Movable Action Bar"
description = "Allows you to move the action bar around."

positionX = 6
positionY = 300
sizeX = 35
sizeY = 10
scale = 1.0

client.settings.addNamelessCategory("Visual Settings")
textColor = client.settings.addNamelessColor("Text Color", {255,255,255,255})
backgroundColor = client.settings.addNamelessColor("Background Color", {0,0,0,127})
roundness = client.settings.addNamelessFloat("Background Radius", 0, 20, 1.5)
roundnessQuality = client.settings.addNamelessFloat("Background Roundness Quality", 0, 20, 0.75)
paddingX = client.settings.addNamelessFloat("Padding X", 0, 20, 3)
paddingY = client.settings.addNamelessFloat("Padding Y", 0, 20, 3)

client.settings.addNamelessCategory("Display Settings")
displayTime = client.settings.addNamelessFloat("Display Time", 0.1, 60, 5)
-- fadeTime = client.settings.addNamelessFloat("Fade Time", 0.1, 10, 1)
keepCentered = client.settings.addNamelessBool("Keep Centered", true)

currentTitle = ""

event.listen("TitleChanged", function(text, titleType)
    if titleType == "actionbar" then
        currentTitle = text
        return true
    end
end)

time = os.clock()

function render(deltaTime)
    if currentTitle ~= "" then
        local visualTitle = currentTitle:gsub("§.", "")
        if time + displayTime.value < os.clock() then
            currentTitle = ""
            time = os.clock()
        end
        local textWidth = gui.font().width(visualTitle)
        local boxWidth = textWidth + paddingX.value
        local boxHeight = 10 + paddingY.value
        gfx.color(backgroundColor)
        gfx.roundRect(0, 0, boxWidth, boxHeight, roundness.value, roundnessQuality.value)
        if not keepCentered.value then
            gfx.color(textColor)
            gfx.text(paddingX.value / 2, paddingY.value / 2, currentTitle)
        else
            gfx.color(textColor)
            gfx.text((boxWidth - textWidth) / 2, paddingY.value / 2, currentTitle)
            positionX = (gui.width() / 2) - (boxWidth / 2)
        end
        sizeX = boxWidth
        sizeY = boxHeight
    else
        time = os.clock()
    end
end