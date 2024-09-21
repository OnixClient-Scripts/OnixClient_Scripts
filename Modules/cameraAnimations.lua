-- Made by O2Flash20 🙂

name = "Camera Animations"
description = "A camera animation system, only works in creative mode and is still buggy."

sizeX = 300
sizeY = 50
positionX = 0
positionY = 0

importLib("freecamHelper")

if not fs.isdir("ReplayMod") then fs.mkdir("ReplayMod") end

workingDir = "RoamingState/OnixClient/Scripts/Data/ReplayMod"

APPROXIMATIONRESOLUTION = 15

playing = false
timeInReplay = 0
lastKeyframe = 1
function render2(dt)
    -- background
    gfx2.color(38, 38, 38, 230)
    gfx2.fillRoundRect(0, 0, 300, 50, 2)
    gfx2.color(255, 255, 255, 115)
    gfx2.drawRoundRect(0, 0, 300, 50, 1, 1)

    -- time slider
    gfx2.color(26, 26, 16)
    gfx2.fillRoundRect(30, 25, 240, 15, 5)

    -- keyframes
    for _, keyframe in pairs(keyframes) do
        if keyframe.time == math.floor(currentTime * 10) / 10 then
            gfx2.color(255, 120, 0)
        else
            gfx2.color(255, 0, 0)
        end
        gfx2.fillQuad(
            30 + keyframe.time * (240 / totalTime) - 2.5,
            25,
            30 + keyframe.time * (240 / totalTime),
            27.5,
            30 + keyframe.time * (240 / totalTime) + 2.5,
            25,
            30 + keyframe.time * (240 / totalTime),
            22.5
        )
    end

    -- selected keyframe arrow
    local selectedK = keyframes[selectedKeyframe]
    if selectedK then
        gfx2.color(255, 255, 255)
        gfx2.fillTriangle(
            30 + selectedK.time * (240 / totalTime) - 2.5, 22,
            30 + selectedK.time * (240 / totalTime), 25,
            30 + selectedK.time * (240 / totalTime) + 2.5, 22
        )
    end

    -- pointer
    gfx2.color(255, 255, 255)
    gfx2.drawRoundRect(
        (currentTime / totalTime) * (sizeX - 60) + 30 - 1, 25,
        2, 15,
        1, 1
    )

    -- time reading
    gfx2.color(255, 255, 255)
    gfx2.text(
        (currentTime / totalTime) * (sizeX - 60) + 20, 40,
        stylizedTime(currentTime)
    )

    -- status system
    gfx2.color(255, 255, 255)
    gfx2.text(25, 10, "Status: " .. statusText, 1)
    if statusLength then
        currentStatusTime = currentStatusTime + dt
        if currentStatusTime > statusLength then
            statusText = "";
            statusLength = nil
        end
    end

    -- file
    gfx2.color(255, 255, 255)
    if selectedFile ~= "" then
        gfx2.text(130, 10, "Selected File: " .. selectedFile .. ".anim")
    else
        gfx2.text(130, 10, "No File is Selected")
    end
end

statusText = ""
statusLength = nil
currentStatusTime = 0
function setStatus(text, length)
    currentStatusTime = 0
    statusText = text
    statusLength = length
end

function stylizedTime(seconds)
    seconds = math.floor(seconds * 10) / 10
    minutes = math.floor(seconds / 60)
    seconds = seconds % 60

    if seconds < 10 then seconds = "0" .. seconds end
    if minutes < 10 then minutes = "0" .. minutes end

    return minutes .. ":" .. seconds
end

-- bigger = worse
LINERESOLUTION = 2
function render3d(dt)
    if not playing then
        for i = 1, #PATHPOINTS - LINERESOLUTION, LINERESOLUTION do
            local thisPoint = { PATHPOINTS[i][1], PATHPOINTS[i][2], PATHPOINTS[i][3] }
            local nextPoint = {
                PATHPOINTS[i + LINERESOLUTION][1],
                PATHPOINTS[i + LINERESOLUTION][2],
                PATHPOINTS[i + LINERESOLUTION][3]
            }
            gfx.line(
                thisPoint[1], thisPoint[2], thisPoint[3],
                nextPoint[1], nextPoint[2], nextPoint[3]
            )

            -- *MAYBE?
            drawPlayerHead(
                PATHPOINTS[i][1], PATHPOINTS[i][2], PATHPOINTS[i][3],
                math.rad(-PATHPOINTS[i][5]), -math.rad(PATHPOINTS[i][4] + 180), math.rad(PATHPOINTS[i][6]), 0.25
            )
        end

        for i = 1, #keyframes do
            drawPlayerHead(
                keyframes[i].position[1], keyframes[i].position[2], keyframes[i].position[3],
                math.rad(-keyframes[i].rotation[2]), -math.rad(keyframes[i].rotation[1] + 180), math.rad(keyframes[i].rotation[3]), 0.75
            )
        end
    else
        currentTime = currentTime + dt

        if currentTime >= keyframes[#keyframes].time then
            setStatus("Replay Over", 3)
            freecam.enabled(false)
            playing = false
            currentTime = 0
            currentTime = 0.0
            lastKeyframe = 1
            client.execute("execute /effect @s clear")
        end

        local lastPathPoint
        local nextPathPoint
        for i = 1, #TIMEPATHPOINTS, 1 do
            if currentTime >= TIMEPATHPOINTS[i] and currentTime < TIMEPATHPOINTS[i + 1] then
                lastPathPoint = i
                nextPathPoint = i + 1
                break
            end
        end

        -- the index of the path, smoothed
        local smoothedTime = map(
            currentTime, TIMEPATHPOINTS[lastPathPoint], TIMEPATHPOINTS[nextPathPoint], lastPathPoint, nextPathPoint
        ) / APPROXIMATIONRESOLUTION

        local smoothedTimeIndex = smoothedTime * APPROXIMATIONRESOLUTION

        local currentX = map(
            smoothedTimeIndex,
            math.floor(smoothedTimeIndex), math.floor(smoothedTimeIndex) + 1,
            PATHPOINTS[math.floor(smoothedTimeIndex)][1], PATHPOINTS[math.floor(smoothedTimeIndex) + 1][1]
        )
        local currentY = map(
            smoothedTimeIndex,
            math.floor(smoothedTimeIndex), math.floor(smoothedTimeIndex) + 1,
            PATHPOINTS[math.floor(smoothedTimeIndex)][2], PATHPOINTS[math.floor(smoothedTimeIndex) + 1][2]
        )
        local currentZ = map(
            smoothedTimeIndex,
            math.floor(smoothedTimeIndex), math.floor(smoothedTimeIndex) + 1,
            PATHPOINTS[math.floor(smoothedTimeIndex)][3], PATHPOINTS[math.floor(smoothedTimeIndex) + 1][3]
        )

        local currentYaw = map(
            smoothedTimeIndex,
            math.floor(smoothedTimeIndex), math.floor(smoothedTimeIndex) + 1,
            PATHPOINTS[math.floor(smoothedTimeIndex)][4], PATHPOINTS[math.floor(smoothedTimeIndex) + 1][4]
        )
        local currentPitch = map(
            smoothedTimeIndex,
            math.floor(smoothedTimeIndex), math.floor(smoothedTimeIndex) + 1,
            PATHPOINTS[math.floor(smoothedTimeIndex)][5], PATHPOINTS[math.floor(smoothedTimeIndex) + 1][5]
        )

        local currentRoll = map(
            smoothedTimeIndex,
            math.floor(smoothedTimeIndex), math.floor(smoothedTimeIndex) + 1,
            PATHPOINTS[math.floor(smoothedTimeIndex)][6], PATHPOINTS[math.floor(smoothedTimeIndex) + 1][6]
        )

        freecam["isOffsetMode"].value = false
        freecam.setPosition(currentX, currentY, currentZ)
        freecam.setRotation(-currentPitch, -currentYaw + 180, 0)
        rollSetting.value = currentRoll
    end
end

currentTime = 0.0
totalTime = 60 -- start time end time instead?

function createKeyFrame()
    -- delete the old one there
    for i = 1, #keyframes do
        if keyframes[i].time == math.floor(currentTime * 10) / 10 then
            table.remove(keyframes, i)
            break
        end
    end

    -- wrap yaw & roll around because -1 degree == 359 degrees
    if #keyframes > 0 then

        local lastYaw = keyframes[#keyframes].rotation[1]
        if math.abs(yaw - lastYaw) > 180 then
            if yaw > lastYaw then
                while math.abs(yaw - lastYaw) > 180 do
                    yaw = yaw - 360
                end
            end
            if yaw < lastYaw then
                while math.abs(yaw - lastYaw) > 180 do
                    yaw = yaw + 360
                end
            end
        end

        local lastRoll = keyframes[#keyframes].rotation[3]
        if math.abs(roll - lastRoll) > 180 then
            if roll > lastRoll then
                while math.abs(roll - lastRoll) > 180 do
                    roll = roll - 360
                end
            end
            if roll < lastRoll then
                while math.abs(roll - lastRoll) > 180 do
                    roll = roll + 360
                end
            end
        end
    end

    table.insert(keyframes, {
        position = { px, py, pz },
        rotation = { yaw, pitch, roll },
        time = currentTime
    })

    sortKeyframes()
end

selectedKeyframe = 0
function selectKeyframe()
    local closestTime = 1000000000
    local closestIndex = -1
    for i = 1, #keyframes do
        if math.abs(keyframes[i].time - currentTime) < closestTime then
            closestTime = math.abs(keyframes[i].time - currentTime)
            closestIndex = i
        end
    end

    selectedKeyframe = closestIndex
end

function moveSelectedKeyframe()
    if keyframes[selectedKeyframe] then
        keyframes[selectedKeyframe].time = currentTime
        sortKeyframes()
    end
end

-- sorts the keyframes from earliest to latest
function sortKeyframes()
    local keyframeTimes = {}
    for i = 1, #keyframes do
        table.insert(keyframeTimes, keyframes[i].time)
    end

    orderedIndices = insertionSort(keyframeTimes)

    local output = {}
    for i = 1, #orderedIndices do
        table.insert(output, keyframes[orderedIndices[i]])
    end

    selectedKeyframe = orderedIndices[selectedKeyframe] or 0

    keyframes = output
end

-- takes in an array of values and returns the indices corresponding to the values smallest -> largest
function insertionSort(arr)
    local len = #arr

    local indices = {}
    for i = 1, len, 1 do
        table.insert(indices, i)
    end

    local index = 2
    while index <= len do
        local curr = arr[index]
        local currI = indices[index]
        local prev = index - 1

        while prev >= 1 and arr[prev] > curr do
            arr[prev + 1] = arr[prev]
            indices[prev + 1] = indices[prev] --
            prev = prev - 1
        end

        arr[prev + 1] = curr
        indices[prev + 1] = currI --

        index = index + 1
    end

    return indices
end

function clearPath() keyframes = {} end

client.settings.addFunction("Clear Path", "clearPath", "Clear")

-- _______________________________________________________________________________

client.settings.addAir(10)

client.settings.addTitle("Saving and Loading")

selectedFile = ""
client.settings.addTextbox("Selected File Name:", "selectedFile")

-- saves keyframes to a file
function saveKeyframes()
    fs.delete(selectedFile .. ".anim")
    local saveFile = fs.open(selectedFile .. ".anim", 'w')
    if not saveFile then return end

    saveFile:writeFloat(CURVEALPHA)
    saveFile:writeFloat(CURVETENSION)
    for _, key in pairs(keyframes) do
        saveFile:writeFloat(key.position[1])
        saveFile:writeFloat(key.position[2])
        saveFile:writeFloat(key.position[3])

        saveFile:writeFloat(key.rotation[1])
        saveFile:writeFloat(key.rotation[2])
        saveFile:writeFloat(key.rotation[3])

        saveFile:writeFloat(key.time)
    end

    saveFile:close()
    setStatus("File Saved to " .. selectedFile .. ".anim", 6)
end

client.settings.addFunction("Save File", "saveKeyframes", "Save")

-- reads keyframes from a file_________
function readKeyframes()
    local saveFile = fs.open(selectedFile .. ".anim", "r")
    if not saveFile then return end

    local tempKeyframes = {}

    -- load alpha and tension values
    local a = saveFile:readFloat()
    CURVEALPHA = a
    alphaSetting.value = a

    local t = saveFile:readFloat()
    CURVETENSION = t
    tensionSetting.value = t

    -- loop over all keyframes until the end of the file
    while not saveFile:eof() do
        local x = saveFile:readFloat()
        local y = saveFile:readFloat()
        local z = saveFile:readFloat()
        local yaw = saveFile:readFloat()
        local pitch = saveFile:readFloat()
        local roll = saveFile:readFloat()
        local time = saveFile:readFloat()

        table.insert(tempKeyframes, {
            position = { x, y, z },
            rotation = { yaw, pitch, roll },
            time = time
        })
    end

    keyframes = tempKeyframes

    setStatus("Loaded " .. selectedFile .. ".anim", 6)
end

client.settings.addFunction("Load File", "readKeyframes", "Load")

-- _______________________________________________________________________________

client.settings.addAir(10)

client.settings.addTitle("Camera Controls")

rollLeftKey = 89
client.settings.addKeybind("Roll left: ", "rollLeftKey")

rollRightKey = 85
client.settings.addKeybind("Roll right: ", "rollRightKey")

resetRollKey = 73
client.settings.addKeybind("Reset roll: ", "resetRollKey")

-- _______________________________________________________________________________

client.settings.addAir(10)

keyframes = {}

client.settings.addTitle("Timeline Controls")

teleportToKey = 0x37
client.settings.addKeybind("Teleport to spot on timeline: ", "teleportToKey")

selectKeyframeKey = 0x38
client.settings.addKeybind("Select nearest keyframe: ", "selectKeyframeKey")

togglePlayKey = 0x39
client.settings.addKeybind("Start/Stop playing: ", "togglePlayKey")

setKeyframeKey = 0x30
client.settings.addKeybind("Create/Delete keyframe: ", "setKeyframeKey")

event.listen("KeyboardInput", function(key, down)

    -- roll controls
    if key == rollLeftKey then shouldRollLeft = down end
    if key == rollRightKey then shouldRollRight = down end
    if key == resetRollKey and down then rollSetting.value = 0 end

    -- create keyframe
    if key == setKeyframeKey and down then
        if selectedKeyframe ~= 0 then
            -- delete keyframe
            table.remove(keyframes, selectedKeyframe)
            selectedKeyframe = 0
            setStatus("Keyframe Deleted", 2)
        else
            -- add keyframe
            createKeyFrame()
            setStatus("Keyframe Created", 2)
        end
    end

    -- select keyframe
    if key == selectKeyframeKey and down then
        if selectedKeyframe ~= 0 then
            selectedKeyframe = 0
            setStatus("Keyframe Unselected", 2)
        else
            selectKeyframe()
            setStatus("Keyframe Selected")
        end
    end

    -- start/stop playing
    if key == togglePlayKey and down then
        if not playing then
            freecam.isOffsetMode.value = false
            freecam.enabled(true)
            timeInReplay = currentTime
            setStatus("Playing")
            client.execute("execute /effect @s invisibility 60 1 true")
        else
            setStatus("Playing Stopped", 2)
            freecam.enabled(false)
            client.execute("execute /effect @s clear")
        end
        playing = not playing
        currentTime = math.floor(currentTime * 10) / 10
    end

    -- teleport to timeline
    if key == teleportToKey and down then
        local doTeleportStatus = true
        if currentTime > keyframes[#keyframes].time then
            setStatus("No Keyframes Here", 2)
            doTeleportStatus = false
            playing = false
            currentTime = 0
            currentTime = 0.0
            lastKeyframe = 1
        end

        local lastPathPoint
        local nextPathPoint
        for i = 1, #TIMEPATHPOINTS, 1 do
            if currentTime >= TIMEPATHPOINTS[i] and currentTime < TIMEPATHPOINTS[i + 1] then
                lastPathPoint = i
                nextPathPoint = i + 1
                break
            end
        end

        -- the index of the path, smoothed
        local smoothedTime = map(
            currentTime, TIMEPATHPOINTS[lastPathPoint], TIMEPATHPOINTS[nextPathPoint], lastPathPoint, nextPathPoint
        ) / APPROXIMATIONRESOLUTION

        local smoothedTimeIndex = smoothedTime * APPROXIMATIONRESOLUTION

        local currentX = map(
            smoothedTimeIndex,
            math.floor(smoothedTimeIndex), math.floor(smoothedTimeIndex) + 1,
            PATHPOINTS[math.floor(smoothedTimeIndex)][1], PATHPOINTS[math.floor(smoothedTimeIndex) + 1][1]
        )
        local currentY = map(
            smoothedTimeIndex,
            math.floor(smoothedTimeIndex), math.floor(smoothedTimeIndex) + 1,
            PATHPOINTS[math.floor(smoothedTimeIndex)][2], PATHPOINTS[math.floor(smoothedTimeIndex) + 1][2]
        )
        local currentZ = map(
            smoothedTimeIndex,
            math.floor(smoothedTimeIndex), math.floor(smoothedTimeIndex) + 1,
            PATHPOINTS[math.floor(smoothedTimeIndex)][3], PATHPOINTS[math.floor(smoothedTimeIndex) + 1][3]
        )

        local currentYaw = map(
            smoothedTimeIndex,
            math.floor(smoothedTimeIndex), math.floor(smoothedTimeIndex) + 1,
            PATHPOINTS[math.floor(smoothedTimeIndex)][4], PATHPOINTS[math.floor(smoothedTimeIndex) + 1][4]
        )
        local currentPitch = map(
            smoothedTimeIndex,
            math.floor(smoothedTimeIndex), math.floor(smoothedTimeIndex) + 1,
            PATHPOINTS[math.floor(smoothedTimeIndex)][5], PATHPOINTS[math.floor(smoothedTimeIndex) + 1][5]
        )
        local currentRoll = map(
            smoothedTimeIndex,
            math.floor(smoothedTimeIndex), math.floor(smoothedTimeIndex) + 1,
            PATHPOINTS[math.floor(smoothedTimeIndex)][6], PATHPOINTS[math.floor(smoothedTimeIndex) + 1][6]
        )


        -- teleport to that spot on the timeline
        client.execute(
            "execute /tp @s "
            .. currentX .. " "
            .. currentY - 1.6 .. " "
            .. currentZ .. " "
            .. currentYaw .. " "
            .. currentPitch
        )
        rollSetting.value = currentRoll

        if doTeleportStatus then setStatus("Teleported", 2) end
    end

    -- move the timeline cursor
    local RIGHTARROW = 0x27
    local LEFTARROW = 0x25
    local UPARROW = 0x26
    local DOWNARROW = 0x28
    if key == RIGHTARROW and down then
        currentTime = currentTime + 1
        moveSelectedKeyframe()
    end
    if key == LEFTARROW and down then
        currentTime = currentTime - 1
        moveSelectedKeyframe()
    end
    if key == UPARROW and down then
        currentTime = currentTime + 0.1
        moveSelectedKeyframe()
    end
    if key == DOWNARROW and down then
        currentTime = currentTime - 0.1
        moveSelectedKeyframe()
    end

    currentTime = math.clamp(currentTime, 0, totalTime)
    currentTime = math.floor(currentTime * 10) / 10
end)

-- _______________________________________________________________________________

client.settings.addAir(5)

client.settings.addTitle("Path Controls")

CURVEALPHA = 0.5
alphaSetting = client.settings.addFloat("Curve Alpha", "CURVEALPHA", 0, 1)

CURVETENSION = 0
tensionSetting = client.settings.addFloat("Curve Tension", "CURVETENSION", 0, 1)

-- _______________________________________________________________________________

TIMEPATHPOINTS = {}
PATHPOINTS = {}

lastKeyframes = {}

function update(dt)
    px, py, pz = player.pposition()
    yaw, pitch = player.rotation()
    roll = rollSetting.value

    -- time to update the path?
    if (lastKeyframes ~= keyframes and #keyframes >= 2) or CURVEALPHA ~= lastCURVEALPHA or CURVETENSION ~= lastCURVETENSION then
        local times = {}
        for i = 1, #keyframes do
            table.insert(times, keyframes[i].time)
            if i == 1 then table.insert(times, keyframes[i].time - 1) end
            if i == #keyframes then table.insert(times, keyframes[i].time + 1) end
        end
        TIMEPATHPOINTS = approximateCurve(
            function(x)
                return catmullRomSpline1D(times, x, 0.5, 0)
            end
            , #times - 3, 1 / APPROXIMATIONRESOLUTION
        )


        PATHPOINTS = {}

        local xs = {}
        for i = 1, #keyframes do
            table.insert(xs, keyframes[i].position[1])
            if i == 1 then table.insert(xs, keyframes[i].position[1] - 1) end
            if i == #keyframes then table.insert(xs, keyframes[i].position[1] + 1) end
        end
        local xPath = approximateCurve(
            function(x)
                return catmullRomSpline1D(xs, x, CURVEALPHA, CURVETENSION)
            end
            , #xs - 3, 1 / APPROXIMATIONRESOLUTION
        )

        local ys = {}
        for i = 1, #keyframes do
            table.insert(ys, keyframes[i].position[2])
            if i == 1 then table.insert(ys, keyframes[i].position[2] - 1) end
            if i == #keyframes then table.insert(ys, keyframes[i].position[2] + 1) end
        end
        local yPath = approximateCurve(
            function(x)
                return catmullRomSpline1D(ys, x, CURVEALPHA, CURVETENSION)
            end
            , #ys - 3, 1 / APPROXIMATIONRESOLUTION
        )

        local zs = {}
        for i = 1, #keyframes do
            table.insert(zs, keyframes[i].position[3])
            if i == 1 then table.insert(zs, keyframes[i].position[3] - 1) end
            if i == #keyframes then table.insert(zs, keyframes[i].position[3] + 1) end
        end
        local zPath = approximateCurve(
            function(x)
                return catmullRomSpline1D(zs, x, CURVEALPHA, CURVETENSION)
            end
            , #zs - 3, 1 / APPROXIMATIONRESOLUTION
        )

        local yaws = {}
        for i = 1, #keyframes do
            table.insert(yaws, keyframes[i].rotation[1])
            if i == 1 then table.insert(yaws, keyframes[i].rotation[1] - 1) end
            if i == #keyframes then table.insert(yaws, keyframes[i].rotation[1] + 1) end
        end
        local yawPath = approximateCurve(
            function(x)
                return catmullRomSpline1D(yaws, x, CURVEALPHA, CURVETENSION)
            end
            , #yaws - 3, 1 / APPROXIMATIONRESOLUTION
        )

        local pitches = {}
        for i = 1, #keyframes do
            table.insert(pitches, keyframes[i].rotation[2])
            if i == 1 then table.insert(pitches, keyframes[i].rotation[2] - 1) end
            if i == #keyframes then table.insert(pitches, keyframes[i].rotation[2] + 1) end
        end
        local pitchPath = approximateCurve(
            function(x)
                return catmullRomSpline1D(pitches, x, CURVEALPHA, CURVETENSION)
            end
            , #pitches - 3, 1 / APPROXIMATIONRESOLUTION
        )

        local rolls = {}
        for i = 1, #keyframes do
            table.insert(rolls, keyframes[i].rotation[3])
            if i == 1 then table.insert(rolls, keyframes[i].rotation[3] - 1) end
            if i == #keyframes then table.insert(rolls, keyframes[i].rotation[3] + 1) end
        end
        local rollPath = approximateCurve(
            function(x)
                return catmullRomSpline1D(rolls, x, CURVEALPHA, CURVETENSION)
            end
            , #rolls - 3, 1 / APPROXIMATIONRESOLUTION
        )

        for i = 1, #xPath do
            table.insert(PATHPOINTS, { xPath[i], yPath[i], zPath[i], yawPath[i], pitchPath[i], rollPath[i] })
        end
    end

    lastKeyframes = keyframes

    lastCURVEALPHA = CURVEALPHA
    lastCURVETENSION = CURVETENSION
end

function catmullRomSpline1D(points, t, alpha, tension)
    local i = math.floor(t) + 1

    if #points < i + 3 then
        return points[#points - 1]
    end

    local p1 = points[i]
    local p2 = points[i + 1]
    local p3 = points[i + 2]
    local p4 = points[i + 3]

    -- stop it from giving errors of two points are the same (there's probably a better way of doing this)
    if p1 == p2 then p2 = p2 + 0.001 end
    if p2 == p3 then p3 = p3 + 0.001 end
    if p3 == p4 then p4 = p4 + 0.001 end

    t = t - math.floor(t)

    local t12 = math.abs(p1 - p2) ^ alpha
    local t23 = math.abs(p2 - p3) ^ alpha
    local t34 = math.abs(p3 - p4) ^ alpha

    local m1 = (1 - tension) *
        (p3 - p2 + t23 * ((p2 - p1) / t12 - (p3 - p1) / (t12 + t23)))

    local m2 = (1 - tension) *
        (p3 - p2 + t23 * ((p4 - p3) / t34 - (p4 - p2) / (t23 + t34)))

    local a = 2 * (p2 - p3) + m1 + m2
    local b = -3 * (p2 - p3) - m1 - m1 - m2
    local c = m1
    local d = p2

    return a * t ^ 3 +
        b * t ^ 2 +
        c * t +
        d
end

function approximateCurve(curveFunction, max, delta)
    local points = {}
    for i = 0, max, delta do
        table.insert(points, curveFunction(i))
    end
    return points
end

function render(dt)
    if unload then
        gfx.unloadimage("skin.png")
        unload = false
    end

    if shouldRollLeft then rollSetting.value = rollSetting.value + 25*dt end
    if shouldRollRight then rollSetting.value = rollSetting.value - 25*dt end
end

function postInit()
    unload = true
    player.skin().save("skin.png")

    -- get the setting to let the mod roll the camera
    rollSetting = getSettingFromMod(getModByInternalName("module.rotatable_screen.name"), "module.rotatable_screen.setting.angle.name")
end

function drawPlayerHead(x, y, z, pitch, yaw, roll, scale)
    local s = scale / 2
    local vertices = {
        { -s, -s, -s },
        { s,  -s, -s },
        { -s, s,  -s },
        { s,  s,  -s },
        { -s, -s, s },
        { s,  -s, s },
        { -s, s,  s },
        { s,  s,  s }
    }

    local verticesRotated = {}
    for i, vertex in pairs(vertices) do
        local vertexRotated = rotatePoint(vertex[1], vertex[2], vertex[3], 0, 0, 0, pitch, yaw, roll)
        table.insert(verticesRotated, { vertexRotated[1] + x, vertexRotated[2] + y, vertexRotated[3] + z })
    end
    vertices = verticesRotated

    -- front
    gfx.tquad(
        vertices[3][1], vertices[3][2], vertices[3][3], 0.125, 0.125,
        vertices[4][1], vertices[4][2], vertices[4][3], 0.25, 0.125,
        vertices[2][1], vertices[2][2], vertices[2][3], 0.25, 0.25,
        vertices[1][1], vertices[1][2], vertices[1][3], 0.125, 0.25,
        "skin.png"
    )
    -- back
    gfx.tquad(
        vertices[5][1], vertices[5][2], vertices[5][3], 0.375, 0.25,
        vertices[6][1], vertices[6][2], vertices[6][3], 0.5, 0.25,
        vertices[8][1], vertices[8][2], vertices[8][3], 0.5, 0.125,
        vertices[7][1], vertices[7][2], vertices[7][3], 0.375, 0.125,
        "skin.png"
    )

    -- bottom
    gfx.tquad(
        vertices[1][1], vertices[1][2], vertices[1][3], 0.25, 0.125,
        vertices[2][1], vertices[2][2], vertices[2][3], 0.375, 0.125,
        vertices[6][1], vertices[6][2], vertices[6][3], 0.375, 0,
        vertices[5][1], vertices[5][2], vertices[5][3], 0.25, 0,
        "skin.png"
    )
    -- top
    gfx.tquad(
        vertices[7][1], vertices[7][2], vertices[7][3], 0.125, 0,
        vertices[8][1], vertices[8][2], vertices[8][3], 0.25, 0,
        vertices[4][1], vertices[4][2], vertices[4][3], 0.25, 0.125,
        vertices[3][1], vertices[3][2], vertices[3][3], 0.125, 0.125,
        "skin.png"
    )

    -- left
    gfx.tquad(
        vertices[5][1], vertices[5][2], vertices[5][3], 0, 0.25,
        vertices[7][1], vertices[7][2], vertices[7][3], 0, 0.125,
        vertices[3][1], vertices[3][2], vertices[3][3], 0.125, 0.125,
        vertices[1][1], vertices[1][2], vertices[1][3], 0.125, 0.25,
        "skin.png"
    )
    -- right
    gfx.tquad(
        vertices[2][1], vertices[2][2], vertices[2][3], 0.25, 0.25,
        vertices[4][1], vertices[4][2], vertices[4][3], 0.25, 0.125,
        vertices[8][1], vertices[8][2], vertices[8][3], 0.375, 0.125,
        vertices[6][1], vertices[6][2], vertices[6][3], 0.375, 0.25,
        "skin.png"
    )
end

-- rotates a point in 3d space
function rotatePoint(x, y, z, originX, originY, originZ, pitch, yaw, roll)
    local newX, newY, newZ

    -- rotate along z axis
    x = x - originX
    y = y - originY

    newX = x * math.cos(roll) - y * math.sin(roll)
    newY = x * math.sin(roll) + y * math.cos(roll)

    x = newX + originX
    y = newY + originY

    -- rotate along x axis
    y = y - originY
    z = z - originZ

    newY = y * math.cos(pitch) - z * math.sin(pitch)
    newZ = y * math.sin(pitch) + z * math.cos(pitch)

    y = newY + originY
    z = newZ + originZ

    -- rotate along y axis
    x = x - originX
    z = z - originZ

    newX = z * math.sin(yaw) + x * math.cos(yaw)
    newZ = z * math.cos(yaw) - x * math.sin(yaw)

    x = newX + originX
    z = newZ + originZ

    return { x, y, z }
end

-- maps a value from one range to another
function map(value, min1, max1, min2, max2)
    return (value - min1) * ((max2 - min2) / (max1 - min1)) + min2
end

-- these two functions are thanks to jqms
function getModByInternalName(name)
    for _, mod in pairs(client.modules()) do
        if mod.saveName == name then
            return mod
        end
    end
end

function getSettingFromMod(mod, saveName)
    for _, setting in pairs(mod.settings) do
        if setting.saveName == saveName then
            return setting
        end
    end
end

--[[
up arrow sometimes not working

!fix all those errors when the replay ends

what's up with the keyframes starting a bit before the first actual keyframe

https://dev.to/ndesmic/splines-from-scratch-catmull-rom-3m66
https://qroph.github.io/2018/07/30/smooth-paths-using-catmull-rom-splines.html
]]
