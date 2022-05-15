name="AreaSearcherExemple"
description="an exemple for the area searcher"


importLib("AreaSearcher") --Made by Onix86

BarrierBlocks = 0

--let the user decide on the AreaSearcher library's settings
area.addSettings()
--radius is not included so we have it there
Radius = 50
client.settings.addInt("Radius", "Radius", 5, 100)

--we use render because we can allow faster scans
function render(dt)
    --you need to call this for it to be able to do some more work
    area.update(dt)
end

--we do our command in a module since we need the update function 
registerCommand("search", function(args)
    --settings that you can change

    --ChunkSize is how big the area you scan per update
    --area.setChunkSize(10)
    --DoCloserFirst will analyze the chunks closer to you first
    --area.setDoCloserFirst(true)
    -- Will scan a new area 20 times per second (1000/50=20) (if called enough to achieve this, hence why we use render)
    --area.setSearchInterval(50)
    --we wont change those as we will let the user decide in module settings
    
    --area.WorldHeightMin is set automatically depending on version but you can change it if youd like
    --area.WorldHeightMax is set automatically depending on version but you can change it if youd like


    BarrierBlocks = 0
    local x,y,z = player.position()
    area.scan(x,y,z, 50, --where to scan from and the radius (rn a 100x100x100 cube around the player where the player is in the center)
    function (block, x, y, z) --BlockCallback is going to get called with every block that is not air
        --do what u want rn we just print the coordinates of all barrier blocks
        if (block.name == "barrier") then
            print("There is a barrier block at " .. x .. " " .. y .. " " .. z)
            BarrierBlocks = BarrierBlocks + 1
        end
    end,
    function() --DoneCallback is called when the entire area was finished scanning
        print("Finished Scanning, found: " .. BarrierBlocks .. " blocks!")
    end)
end)

--There are more things, tho
--area.scanAir(...)
--its the same as area.scan but includes air blocks

--and finally:
--area.cancel()
--cancels the current search

--note: only one search can be done at one single time
