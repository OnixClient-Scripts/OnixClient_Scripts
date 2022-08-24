name="Chest Visualizer"
description="Shows content of the selected chest"

local content

importLib("fileUtility.lua")

positionX = 100
positionY = 100
sizeX = 100
sizeY = 100

function render()
    local x,y,z = player.selectedPos()
    local block = dimension.getBlock(math.floor(x),math.floor(y),math.floor(z))
    if content then
        for i, v in pairs(content) do
            gfx.text(0, i*20, v.name .. ", " .. v.count .. ", " .. v.damage)
        end
    end
end


event.listen("LocalServerUpdate", function()
    local x,y,z = player.selectedPos()
    local block = dimension.getBlock(math.floor(x),math.floor(y),math.floor(z))

    if block.id == 54 then
        local serverBlock = dimension.getBlockEntity(x,y,z, true)
        content = {}
        for k, v in pairs(serverBlock["Items"]) do
            if v["Slot"] then 
                -- print(tostring(v["Slot"]) .. ", " .. tostring(v["Name"]) .. ", " .. tostring(v["Count"]) .. ", " .. tostring(v["Damage"]))
                content[v["Slot"]] = {name=v["Name"], count=v["Count"], damage=v["Damage"]}
            end
        end
        -- jsonDump(content, "test", true)
        -- if note ~= nil then
        --     if note ~= 24 then
        --         currentNoteNum = note
        --         nextNoteNum = note + 1
        --     else
        --         currentNoteNum = note
        --         nextNoteNum = 0
        --     end
        -- end
    else
        content = nil
    end
end)