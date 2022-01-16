name = "Toggle Sprint Indicator"
description = "customizable toggle sprint"

--[[
    Toggle sprint indicator

    make sure to have the tsData.txt file in the data folder and the sprintCommand.lua in the command folder and readfile.lua library in the library folder
    in  tsData.txt file, first line is the text that will be displayed as text in [text: (Toggled)]
    second, third, fourth and fifth are the rgba value codes
    to use the command, do ".ts color r g b a" by replacing r, g, b and a by the value from 0 to 255 or ".ts text New Text" to change the indicator text

    made by MCBE Craft
]]

-- toggle sprint key, you can find key value here https://docs.microsoft.com/en-us/windows/win32/inputdev/virtual-key-codes
sprint_key = 17
client.settings.addKeybind("Toggle Sprint Key", "sprint_key")

-- if your togglesprint isn't on when you log onto a world, set this to false, otherwise set it to true
toggle_by_default = false


--reading data file
not_toggled_text = "[" .. "Sprint" .. ": (Not Toggled)]"
toggled_text = "[" .. "Sprint" .. ": (Toggled)]"

textColor = {255,255,255,255}
client.settings.addColor("Text Color","textColor")

-- useless data that gets changed, just initializing values
positionX = 100
positionY = 100
sizeX = 100
sizeY = 100

if (toggle_by_default) then
    text = toggled_text
else
    text = not_toggled_text
end

firstUpdate = true

function keyboard(key, isDown)
    if (isDown == true and key == sprint_key) then
        toggle_by_default = not toggle_by_default
    end
    if (toggle_by_default) then
        text = toggled_text
    else
        text = not_toggled_text
    end
end
event.listen("KeyboardInput", keyboard)

function update(deltaTime)
    local font = gui.font()
    sizeX = font.width(text)
    sizeY = font.wrap
    if firstUpdate then
        positionX = 0
        positionY = gui.height() - font.wrap
        firstUpdate = false
    end
end


function render(deltaTime)
    gfx.color(textColor.r,textColor.g,textColor.b,textColor.a)
    gfx.text(0, 0, text)
end
