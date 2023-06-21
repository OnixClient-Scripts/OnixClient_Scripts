-- Made By O2Flash20 🙂

name = "Quick Waypoints"
description = "Waypoints but quick"

importLib("vectors")
importLib("renderthreeD")

keybind = 0x56
client.settings.addKeybind("Add/Remove Waypoint", "keybind")

event.listen("KeyboardInput", function(button, down)
    if button == keybind and down then
        buttonPressed()
    end
end)

waypoints = {}
function buttonPressed()
    local px, py, pz = player.pposition()
    local pyaw, ppitch = player.rotation()
    local endPos = vec:fromAngle(1000, math.rad(pyaw + 90), math.rad(-ppitch)):add(vec:new(px, py, pz))

    local block = dimension.raycast(px, py, pz, endPos.x, endPos.y, endPos.z)
    if block.x == 0 and block.y == 0 and block.z == 0 then --the raycast didnt find anything
        return
    end

    local playerFacingVec = vec:fromAngle(1, math.rad(pyaw + 90), math.rad(-ppitch))

    local thisClosestAmount = 0
    local thisClosestPoint = -1
    for i = 1, #waypoints do
        local w = waypoints[i]
        local wToCamVec = vec:new(w[1] - px, w[2] - py, w[3] - pz):normalize()

        if wToCamVec:dot(playerFacingVec) > thisClosestAmount then
            thisClosestPoint = i
            thisClosestAmount = wToCamVec:dot(playerFacingVec)
        end
    end

    if thisClosestAmount > 0.9 then
        local thisPoint = waypoints[thisClosestPoint]
        client.execute(
            "waypoint remove (" ..
            thisPoint[1] .. "," .. thisPoint[2] .. "," .. thisPoint[3] .. ")"
        )
        table.remove(waypoints, thisClosestPoint)
    else
        table.insert(waypoints, { block.x, block.y, block.z })
        client.execute(
            "waypoint add (" ..
            block.x .. "," .. block.y .. "," .. block.z .. ") " ..
            block.x .. " " .. block.y .. " " .. block.z
        )
    end

    writeWaypointsToFile()
end

function onEnable()
    local saveFile = fs.open("quickwaypoints.txt", "r")
    if not saveFile then return end
    local numberOfWaypoints = saveFile:readUInt()
    for i = 1, numberOfWaypoints do
        local x = saveFile:readInt()
        local y = saveFile:readInt()
        local z = saveFile:readInt()
        table.insert(waypoints, { x, y, z })
    end
end

function writeWaypointsToFile()
    local saveFile = fs.open("quickwaypoints.txt", "w")
    if not saveFile then return end
    saveFile:writeUInt(#waypoints)
    for i = 1, #waypoints do
        saveFile:writeInt(waypoints[i][1])
        saveFile:writeInt(waypoints[i][2])
        saveFile:writeInt(waypoints[i][3])
    end
    saveFile:close()
end
