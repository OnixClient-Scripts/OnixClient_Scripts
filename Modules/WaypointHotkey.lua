name = "Waypoint Hotkey"
description = "Allows you to create a waypoint on a hotkey."

waypointKey = client.settings.addNamelessKeybind("Waypoint Key", 0)
waypointText = client.settings.addNamelessTextbox("Waypoint Text", "Waypoint")

function table.clear(t)
    for k in pairs(t) do
        t[k] = nil
    end
end

event.listen("KeyboardInput", function(key, down)
    if key == waypointKey.value and down and gui.screen() == "hud_screen" and gui.mouseGrabbed() == false then
        local waypoints = client.waypoints()
        local waypointName = waypointText.value
        for i, waypoint in pairs(waypoints.get()) do
            while waypoint.name == waypointName do
                waypointName = waypointText.value .. " " .. i
                break
            end
        end
        local x,y,z = player.position()
        waypoints.add(x,y,z, waypointName)
        local text = string.format("§aAdded waypoint §e%s §aat §e%s§a, §e%s§a, §e%s§a.", waypointName, x, y, z)
        waypointName = waypointText.value
        print(text)
    end
end)