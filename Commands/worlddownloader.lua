command = "WorldDownloader"
description = "WARNING, GAME WILL FREEZE OR CRASH DURING DOWNLOAD OR IMPORTr"
help_message = "World Downloader /  WARNING, GAME WILL FREEZE OR CRASH DURING DOWNLOAD OR IMPORT"

--[[
    World Downloader Module Script
    
    made by Onix86

============== WARNING ==============
GAME WILL FREEZE OR CRASH DURING DOWNLOAD OR IMPORT
]]


function execute(arguments)

    local file = io.open("import.mcfunction", "w")
    io.output(file)

    local x,y,z = player.position()
    x = x - 512
    y = y - 512
    z = z - 512
    local ex = x + 1024
    local ey = y + 1024
    local ez = z + 1024

    io.write("/fill " .. x .. " " .. y .. " " .. z .. " " .. ex .. " " .. ey .. " " .. ez .. " air 0 replace\n")

    for px=x,ey do
        for py=x,ey do
            for pz=x,ey do
                local block = dimension.getBlock(px,py,pz)
                if (block.id ~= 0) then
                    io.write("/setblock " .. px .. " " .. py .. " " .. pz .. " " .. block.name .. " " .. block.data .. "\n")
                end
            end
        end
    end
    io.close(file)
    print ("§aSuccessfully downloaded world!")
end
