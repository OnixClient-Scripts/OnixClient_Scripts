command = "we"
help_message = "world edit: setpos, cut, clone, fill"

--[[
    World Edit command script
    setpos1: sets the first position
    setpos2: sets the second position
    pos: tells you which coordinates are selected
    wand: gives you the wand tool (wooden sword cuz it doesn't break blocks in creative)
    cut: removes the selected area
    clone: clones the selected area to your current position
    fill: fills the selected area
    
    made by MCBE
]]--


ImportedLib = importLib("readfile.lua")

function execute(arguments)
    local weData = readFile("weData.txt")
    local wordlist = {}
    for word in string.gmatch(arguments, "[^%s]+") do
        table.insert(wordlist, word)
    end
    if (arguments == "setpos1" or arguments == "setpos 1") then
        local x,y,z = player.position()
        weData[1] = x
        weData[2] = y
        weData[3] = z
        local text = ""
        for i = 1, 6 do
            text = text .. weData[i] .. "\n"
        end
        writeFile("weData.txt", text)
        print("§eposition 1  set to " .. x .. ", " .. y .. ", " .. z)
    elseif (arguments == "setpos2" or arguments == "setpos 2") then
        local x,y,z = player.position()
        weData[4] = x
        weData[5] = y
        weData[6] = z
        local text = ""
        for i = 1, 6 do
            text = text .. weData[i] .. "\n"
        end
        writeFile("weData.txt", text)
        print("§eposition 2  set to " .. x .. ", " .. y .. ", " .. z)
    elseif (arguments == "pos") then
        local text = "position 1: " .. weData[1] .. " " .. weData[2] .. " " .. weData[3] .. "\nposition 2: " .. weData[4] .. " " .. weData[5] .. " " .. weData[6]
        print("§e" ..text)
    elseif (arguments == "help") then
        local text = "Welcome to Onix World Edit mod by MCBE Craft, here is a list of all the current available commands and their uses.\n.we wand: will give your the wand object(a wooden sword because it doesn't break blocks in creative\n.we setpos1: sets the first position of the selection\n.we setpos2: sets the second position of the selection\n.we pos: will tell you the coordinates of the 2 position\n.we cut: removes the selected area by doing a /fill\n.we clone: clones the selected area to your current coordinates\n.we fill {argument}: fills the selected area by the block and data you input in the argument eg: .we fill stone 2 will fill the area with polished granite"
        print("§e" .. text)
    elseif (arguments == "cut") then
        local text = "/fill " .. weData[1] .. " " .. weData[2] .. " " .. weData[3] .. " " .. weData[4] .. " " .. weData[5] .. " " .. weData[6] .. " air" 
        client.execute("execute " .. text)
        print("§ecut from " .. weData[1] .. " " .. weData[2] .. " " .. weData[3] .. " to " .. weData[4] .. " " .. weData[5] .. " " .. weData[6])
    elseif (arguments == "wand") then
        local text = "/give @s wooden_sword" 
        client.execute("execute " .. text)
        print("§egave wand")
    elseif (wordlist[1] == "fill") then
        local text = "/fill " .. weData[1] .. " " .. weData[2] .. " " .. weData[3] .. " " .. weData[4] .. " " .. weData[5] .. " " .. weData[6] .. " " .. string.gsub(arguments, "fill ", "") 
        client.execute("execute " .. text)
        print("§efilled " .. weData[1] .. " " .. weData[2] .. " " .. weData[3] .. ", " .. weData[4] .. " " .. weData[5] .. " " .. weData[6] .. " with " .. string.gsub(arguments, "fill ", ""))
    elseif (arguments == "clone") then
        local text = "/clone " .. weData[1] .. " " .. weData[2] .. " " .. weData[3] .. " " .. weData[4] .. " " .. weData[5] .. " " .. weData[6] .. " ~ ~ ~" 
        client.execute("execute " .. text)
        print("§ecloned " .. weData[1] .. " " .. weData[2] .. " " .. weData[3] .. ", " .. weData[4] .. " " .. weData[5] .. " " .. weData[6])
    end

end
