name = "Everything Sponge"
description = "Sponge but it removes everything. Even blocks. Only works on the second sponge place for safety reasons. Made by Naomi."

-- made by naomi. thank you rosie for the help <3

function generateSphere(blockX, blockY, blockZ, radius, material)
    local x,y,z = blockX, blockY, blockZ
    local sx = x - radius
    local sy = y - radius
    local sz = z - radius
    local ex = x + radius
    local ey = y + radius
    local ez = z + radius

    for px=sx,ex do
        for py=sy,ey do
            for pz=sz,ez do
                if math.sqrt((px-x)^2 + (py-y)^2 + (pz-z)^2) <= radius then
                    client.execute("execute /setblock " .. px .. " " .. py .. " " .. pz .. " " .. material)
                end
            end
        end
    end
end

local clock = os.clock()
local delay = 1
local waiting = false
local initialTime

function sponge()
    local facingPosX, facingPosY, facingPosZ = player.selectedPos()
    local blockName = dimension.getBlock(facingPosX, facingPosY, facingPosZ).name
    if blockName == "sponge" then
        generateSphere(facingPosX, facingPosY, facingPosZ, 4, "air")
    end
end

event.listen("MouseInput", function(button, down)
    local inventory = player.inventory()
    local heldItem = inventory.selected
    if button == 2 and down then
        if inventory.at(heldItem) then
            if inventory.at(heldItem).name == "sponge" then
                local facingBlock = player.facingBlock()
                if facingBlock then
                    if not waiting or (os.clock() - initialTime > delay) then
                        waiting = true
                        initialTime = os.clock()
                        sponge()
                    end
                end
            end
        end
    else
        waiting = false
    end
end)



event.listen("ChatMessageAdded", function(message, username, type, xuid)
    if message:find("The block couldn't be placed") then
        return true
    end
end)