name = "Debug Menu plus"
description = "Addition to \"Java Debug Menu\", shows information about Target Entity and Current Item"


mds_open = false
left_side = false
mds_key = 121
client.settings.addBool("Left Side", "left_side")
seting = client.settings.addKeybind("Modules list open key", "mds_key" )


event.listen("KeyboardInput", function(key, down)
    if key == mds_key and down == true then
        mds_open = not mds_open
    end
end) 

function render(dt)
    local font = gui.font()
    local info = {}
    local last = -font.height -3 
    local inv = player.inventory()
    local selection = inv.at(inv.selected)
    local targetEntity = player.selectedEntity()
    local mds = client.modules()
    if selection ~= nil then
        table.insert(info, "Current Item       ")
        table.insert(info, "#Id: " .. selection.id)
        table.insert(info, "Count: " .. selection.count)
        table.insert(info, "Data: " .. selection.data)
        table.insert(info, "Name: " .. selection.name)
        table.insert(info, "Durability: " .. selection.maxDamage - selection.durability .. " / " .. selection.maxDamage)
        table.insert(info, " ") 
    end

    if targetEntity ~= nil then
        table.insert(info, "Target Entity         ")
        table.insert(info, "Yaw: " ..targetEntity.yaw)
        table.insert(info, "Pitch: " ..targetEntity.pitch)
        table.insert(info, "X: " .. targetEntity.x .. " Y: " .. targetEntity.y .. " Z: " .. targetEntity.z)
        if targetEntity.nametag ~= "" then
            table.insert(info, "Nametag: " ..targetEntity.nametag)
        end
        table.insert(info, "Type: " ..targetEntity.fullType)
        table.insert(info, " ")
    end

    if mds_open then
        table.insert(info, "Modules list [Press OpenKey (default: F10) ] -Open")
        for i = 1, #mds do
            if mds[i].enabled then
                table.insert(info, mds[i].name)
            end
        end
    else
        table.insert(info, "Modules list [Press OpenKey (default: F10) ]")
    end  
    
    for i = 1, #info do
        if left_side then
            gfx.text(0, last+font.height +3, info[i])
        else
            gfx.text(640 - font.width(info[i]), last+font.height +3, info[i])
        end
        last = last + font.height +3
    end

end