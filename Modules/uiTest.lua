name = "ui Test"
description = "testing module for uis"

importLib("uiLib.lua")

gfx.setUiKey(0x4A)

function postInit()
    client.execute("toggle on script " .. name)
end
local show
local text = gfx.createTextArea(100, 120, 100, 20, { r = 0, g = 0, b = 0, a = 255 }, nil)
local slider = gfx.createSlider(200, 100, 20, 100, 0, 100, 10, false)
local button = gfx.createButton(100, 100, 100, 20, {r=255, g=0, b=0, a=255}, nil, function () text.display = not text.display slider.display = not slider.display end, function () show = not show end)

function update(dt)
    button.value = text.value
end

function render(dt)
    renderUi(dt)
    if show then gfx.image(220, 100, slider.value, slider.value, "amogus.jpg") end
end

event.listen("MouseInput", function(button, down)
    return updateUiMouse(button, down)
end)

event.listen("KeyboardInput", function(key, down)
    return updateUiKey(key, down)
end)
