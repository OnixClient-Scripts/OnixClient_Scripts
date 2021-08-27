command = "color"
help_message = "changes module color"

--[[
to use
make sure you have the readfile.lua in the lib folder

in the module files have

at the beginning:
ImportedLib = importLib("readfile.lua")
color = readFile("color.txt")

in the update function:
color = {}
color = readFile("color.txt")

for your rendering:
gfx.color(color[5], color[6], color[7], color[8])
gfx.rect(0, 0, sizeX, sizeY)
gfx.color(color[1], color[2], color[3], color[4])
gfx.text(0, 0, text)

]]--

function execute(arguments)
    local result = ""
    for word in string.gmatch(arguments, "[^%s]+") do
        result = result .. word .. "\n"
    end
    
    DelayFile = io.open("color.txt", "w")
    io.output(DelayFile)
    io.write(result)
    io.close(DelayFile)
    print("successfully changed color")

end
