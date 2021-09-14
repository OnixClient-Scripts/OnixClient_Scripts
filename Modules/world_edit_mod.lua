name = "Input Example"
description = "Keyboard, Mouse input example module script"

--[[
    World Edit Module
    needed to use the wand tool (wooden sword)
    
    made by MCBE Craft
]]

ImportedLib = importLib("readfile.lua")

function mouse(button, isDown)
	local inventory = player.inventory()
    local selected = inventory.at(inventory.selected)
    local x,y,z = player.selectedPos()
    if (isDown == true and gui.mouseGrabbed() == false and selected ~= nil and selected.id == 308) then
        if (x == 0 and y == 0 and z == 0) then
            x,y,z = player.position()
        end
        local weData = readFile("weData.txt")
        if (button == 1) then
            weData[1] = x
            weData[2] = y
            weData[3] = z
            local text = ""
            for i = 1, 6 do
                text = text .. weData[i] .. "\n"
            end
            writeFile("weData.txt", text)
            print("§eposition 1 set to " .. x .. ", " .. y .. ", " .. z)
        elseif (button == 2) then
            weData[4] = x
            weData[5] = y
            weData[6] = z
            local text = ""
            for i = 1, 6 do
                text = text .. weData[i] .. "\n"
            end
            writeFile("weData.txt", text)
            print("§eposition 2 set to " .. x .. ", " .. y .. ", " .. z)
        end
    end
end

function update(deltaTime)
    
end


function render(deltaTime)

end
