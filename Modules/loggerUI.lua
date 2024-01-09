name = "Logger"
description = "Logs things better"

positionX = 500
positionY = 25
sizeX = 300
sizeY = 300

logs = {}

wRatio = 0.5
client.settings.addFloat("Width", "wRatio", 0, 1)

tScale = 1
client.settings.addFloat("Text Scale", "tScale", 0, 5)

showNumber = true
client.settings.addBool("Show log number", "showNumber")

backColorSetting = client.settings.addNamelessColor("Background Color", { 51, 51, 51, 255 })

foreColorSetting = client.settings.addNamelessColor("Foreground Color", { 255, 255, 255, 255 })

font = gui.font()
function render()
    sizeX = (wRatio) * 500
    sizeY = (-wRatio + 1) * 500

    backColor = backColorSetting.value
    gfx.color(backColor.r, backColor.g, backColor.b, backColor.a)
    gfx.rect(0, 0, sizeX, sizeY)

    heightLimit = math.floor(sizeY / ((font.height + 3) * tScale))

    for i = 1, #logs, 1 do
        if font.width(logs[i], tScale) > sizeX then
            table.insert(logs, i + 1,
                string.sub(logs[i], math.floor((sizeX / font.width(logs[i], tScale)) * #logs[i]) + 1, #logs[i]))
            logs[i] = string.sub(logs[i], 0, math.floor((sizeX / font.width(logs[i], tScale)) * #logs[i]))
        end
    end

    while #logs > heightLimit do
        table.remove(logs, #logs)
    end

    start = 250
    foreColor = foreColorSetting.value
    gfx.color(foreColor.r, foreColor.g, foreColor.b, foreColor.a)
    for i = 1, #logs, 1 do
        gfx.text(0, (i - 1) * (font.height + 3) * tScale, logs[i], tScale)
    end
end

numLogs = 0
event.listen("LocalDataReceived", function(identifier, content)
    if identifier == "logMessage" then
        numLogs = numLogs + 1
        if showNumber then
            table.insert(logs, 1, "|" .. numLogs .. "| " .. content)
        else
            table.insert(logs, 1, "_ " .. content)
        end
    end
end)

-- logger.lua LIBRARY NEEDED
