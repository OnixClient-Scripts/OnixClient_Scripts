name = "Debug Menu plus"
description = "Addition to \"Java Debug Menu\", shows information about Target Entity and Current Item"

importLib("Utils")

mds_open = false
---@type Module
local ogMod = ui.getModByName("Java Debug Menu")

moduleListOpenKey = client.settings.addNamelessKeybind("Modules list open key", 121)

event.listen("KeyboardInput", function(key, down)
    if key == moduleListOpenKey.value and down == true and gui.mouseGrabbed() == false then
        mds_open = not mds_open
    end
end)

rightSideSetting = ui.getSettingFromMod("Java Debug Menu", "Right Side")

function render(dt)
    if ogMod.enabled == false then return end
    local font = gui.font()
    local info = {}
    local last = -font.height -3
    local inv = player.inventory()
    local selection = inv.at(inv.selected)
    local targetEntity = player.selectedEntity()
    local mds = client.modules()
    if selection ~= nil then
        table.insert(info, "Current Item")
        table.insert(info, "#Id: " .. selection.id)
        table.insert(info, "Count: " .. selection.count)
        table.insert(info, "Data: " .. selection.data)
        table.insert(info, "Name: " .. selection.name)
        table.insert(info, "Durability: " .. selection.maxDamage - selection.durability .. " / " .. selection.maxDamage .. "\n")
    end

    if targetEntity ~= nil then
        table.insert(info, "Target Entity")
        table.insert(info, "Yaw: " ..targetEntity.yaw)
        table.insert(info, "Pitch: " ..targetEntity.pitch)
        table.insert(info, "X: " .. targetEntity.x .. " Y: " .. targetEntity.y .. " Z: " .. targetEntity.z)
        if targetEntity.nametag ~= "" then
            local ent = targetEntity.nametag:split("\n")
            table.insert(info, "Nametag: " .. ent[1])
            for i = 2, #ent do
                table.insert(info, ent[i])
            end
        end
        table.insert(info, "Type: " .. targetEntity.fullType .. "\n")
    end

    if mds_open then
        table.insert(info, "Modules list [Press OpenKey (default: F10)] -Open")
        for i = 1, #mds do
            if mds[i].enabled then
                table.insert(info, mds[i].name)
            end
        end
    else
        table.insert(info, "Modules list [Press OpenKey (default: F10)]")
    end

    for i = 1, #info do
        if rightSideSetting.value then
            gfx.text(0, last+font.height +3, info[i])
        else
            gfx.text(gui.width() - font.width(info[i]), last+font.height + 3, info[i])
        end
        last = last + font.height + 3
    end
end