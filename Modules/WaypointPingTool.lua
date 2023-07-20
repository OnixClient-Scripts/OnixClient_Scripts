name = "Waypoint Ping Tool"
description = "Allows you to set a waypoint with a customisable keybind."

importLib("vectors")

useMouse = client.settings.addNamelessBool("Use Mouse", false)
keybindSetting = client.settings.addNamelessKeybind("Keybind", 0)
mouseSetting = client.settings.addNamelessInt("Mouse Button", 1, 3, 3)

importLib("vectors")
importLib("renderthreeD")

event.listen("KeyboardInput", function(button, down)
    if button == keybindSetting.value and down and gui.screen() == "hud_screen" then
        if useMouse.value then return end
        buttonPressed()
    end
end)

event.listen("MouseInput", function(button, down)
    if button == mouseSetting.value and down and gui.screen() == "hud_screen" then
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

    -- local blockX, blockY, blockZ = block.x, block.y, block.z
    -- local blockName = dimension.getBlock(blockX, blockY, blockZ).name
    -- print(blockName)

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
        table.remove(waypoints, thisClosestPoint)
        client.execute(
            "waypoint remove (" ..
            thisPoint[1] .. "," .. thisPoint[2] .. "," .. thisPoint[3] .. ")"
        )
        client.execute("say Removed waypoint at (" .. thisPoint[1] .. "," .. thisPoint[2] .. "," .. thisPoint[3] .. ")")
    else
        client.execute("say Added waypoint at (" .. block.x .. "," .. block.y .. "," .. block.z .. ")")
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

function update()
    if useMouse.value == true then
        keybindSetting.visible = false
        mouseSetting.visible = true
    else
        keybindSetting.visible = true
        mouseSetting.visible = false
    end
end

event.listen("ChatMessageAdded", function(message, username, type, xuid)
    if message:find("Added waypoint at ") then
        if not message:find(player.name()) and username ~= player.name() then
            local x, y, z = message:match("Added waypoint at %((.-),(.-),(.-)%)")
            client.execute(
                "waypoint add (" ..
                x .. "," .. y .. "," .. z .. ") " ..
                x .. " " .. y .. " " .. z
            )
            table.insert(waypoints, { tonumber(x), tonumber(y), tonumber(z) })
            writeWaypointsToFile()
        end
        return true
    end
    if message:find("Removed waypoint at ") then
        if not message:find(player.name()) and username ~= player.name() then
            local x, y, z = message:match("Removed waypoint at %((.-),(.-),(.-)%)")
            for i = 1, #waypoints do
                if waypoints[i][1] == tonumber(x) and waypoints[i][2] == tonumber(y) and waypoints[i][3] == tonumber(z) then
                    client.execute(
                        "waypoint remove (" ..
                        waypoints[i][1] .. "," .. waypoints[i][2] .. "," .. waypoints[i][3] .. ")"
                    )
                    table.remove(waypoints, i)
                    writeWaypointsToFile()
                end
            end
        end
        return true
    end
end)