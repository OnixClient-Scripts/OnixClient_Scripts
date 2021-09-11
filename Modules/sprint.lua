name = "Toggle Sprint Indicator"
description = "customizable toggle sprint"

--[[
    Toggle sprint indicator

    make sure to have the tsData.txt file in the data folder and the sprintCommand.lua in the command folder
    in  tsData.txt file, first line is the text that will be displayed as text in [text: (Toggled)]
    second, third, fourth and fifth are the rgba value codes
    to use the command, do ".ts color r g b a" by replacing r, g, b and a by the value from 0 to 255 or ".ts text New Text" to change the indicator text

    made by MCBE Craft
]]

-- toggle sprint key, you can find key value here https://docs.microsoft.com/en-us/windows/win32/inputdev/virtual-key-codes
sprint_key = 17

-- if your togglesprint isn't on when you log onto a world, set this to false, otherwise set it to true
toggle_by_default = false


--reading data file
ImportedLib = importLib("readfile.lua")
tsData = readFile("tsData.txt")
not_toggled_text = "[" .. tsData[1] .. ": (Not Toggled)"
toggled_text = "[" .. tsData[1] .. ": (Toggled)"

color = {tsData[2], tsData[3], tsData[4], tsData[5]}


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

function update(deltaTime)
    local font = gui.font()
    sizeX = font.width(text)
    sizeY = font.height
    if firstUpdate then
        positionX = 0
        positionY = gui.height() - font.height
        firstUpdate = false
    end


    tsData = {}
    tsData = readFile("tsData.txt")

    not_toggled_text = "[" .. tsData[1] .. ": (Not Toggled)"
    toggled_text = "[" .. tsData[1] .. ": (Toggled)"

    color = {tsData[2], tsData[3], tsData[4], tsData[5]}

end


function render(deltaTime)
    gfx.color(color[1], color[2], color[3], color[4])
    gfx.text(0, 0, text)
end
