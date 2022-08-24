name="Chroma Keystrokes"
description="Custom Keystrokes with chroma"

importLib("chroma.lua")
importLib("module.lua")
importLib("keyconverter.lua")

backgroundColor = {0, 0, 0, 100}
client.settings.addColor("Background Color", "backgroundColor")

mouseButtons = true
client.settings.addBool("Show mouse strokes", "mouseButtons")

positionX = 100
positionY = 100
sizeX = 64
sizeY = 81
local keyButtonLog = {}
local keystrokeModule


function update(dt)
    keystrokeModule = getModule("Keystrokes")
    if mouseButtons then
        sizeY = 81
    else
        sizeY = 59
    end
end

local moveShape = {
    {nil, "keyForward"},
    {"keyLeft", "keyBackward", "keyRight"},
}

function checkKey(id)
    if keyButtonLog[id] then return 3 end
    return 1
end

function render(dt)
    local chromaControlerMod = getModule("Chroma Controller", true)
    gfx.color(backgroundColor.r, backgroundColor.g, backgroundColor.b, backgroundColor.a)

    local yValue = 0
    for k, line in pairs(moveShape) do
        for i2, value in pairs(line) do
            if value then
                for i = 1, checkKey(getSetting(keystrokeModule, value).value), 1 do
                    gfx.rect((i2-1)*22, yValue, 20, 20)
                end
            end
        end
        yValue = yValue + 22
    end

    if mouseButtons then
        for i = 1, 2, 1 do
            for j = 1, checkKey(i), 1 do
                gfx.rect((i-1)*33, yValue, 31, 20)
            end
        end
        yValue = yValue + 22
    end

    for j = 1, checkKey(32), 1 do
        gfx.rect(0, yValue, 64, 15)
    end

    local texts = {
        {text=keytostr(getSetting(keystrokeModule, "keyForward").value), x=27, y=5},
        {text=keytostr(getSetting(keystrokeModule, "keyLeft").value), x=5, y=27},
        {text=keytostr(getSetting(keystrokeModule, "keyBackward").value), x=27, y=27},
        {text=keytostr(getSetting(keystrokeModule, "keyRight").value), x=49, y=27}
    }
    if mouseButtons then
        table.insert(texts, {text=keytostr(1), x=4, y=49})
        table.insert(texts, {text=keytostr(2), x=37, y=49})
        table.insert(texts, {text="-------", x=7, y=69})
    else
        table.insert(texts, {text="-------", x=7, y=47})
    end

    chromaTextList(0, 0, texts)
end

event.listen("KeyboardInput", function(key, down)
    if not gui.mouseGrabbed() or not down then
        keyButtonLog[key] = down
    end
end)

event.listen("MouseInput", function(button, down)
    if not gui.mouseGrabbed() or not down then
        keyButtonLog[button] = down
    end
end)


