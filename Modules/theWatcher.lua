-- Made By O2Flash20 🙂

---@diagnostic disable: redundant-parameter

name = "The Watcher"
description = "He watches you... always watching..."

importLib("anetwork")
importLib("vectors")

allFilesAreLoaded = false
loadedFiles = 0
function onEnable()
    anetwork.Initialise(1)
    if not fs.isdir("Watcher") then --the needed assets aren't here, download them automatically
        fs.mkdir("Watcher")
        anetwork.fileget(
            "https://raw.githubusercontent.com/OnixClient-Scripts/OnixClient_Scripts/master/Data/Watcher/textures.png", "Watcher/textures.png", {},
            function (response, error) fileDownloaded(response, error) end
        )
        anetwork.fileget(
            "https://raw.githubusercontent.com/OnixClient-Scripts/OnixClient_Scripts/master/Data/Watcher/face.obj", "Watcher/face.obj", {},
            function (response, error) fileDownloaded(response, error) end
        )
        anetwork.fileget(
            "https://raw.githubusercontent.com/OnixClient-Scripts/OnixClient_Scripts/master/Data/Watcher/eyeMove.mp3", "Watcher/eyeMove.mp3", {},
            function (response, error) fileDownloaded(response, error) end
        )
    else
        allFilesAreLoaded = true
        start()
    end
end

function fileDownloaded(response, error, message)
    loadedFiles = loadedFiles + 1

    if loadedFiles == 3 then
        allFilesAreLoaded = true
        start()
    end
end

function start()
    mesh = gfx.objLoad("Watcher/face.obj")
    moveSound:play("Watcher/eyeMove.mp3")
end


NEARLIMIT = 3
FARLIMIT = 10
EYESIZE = 1

positions = {}
delay = 0.1

moveSound = AudioPlayer()
moveSound.volume = 0
moveSound.looping = true

eyePos = vec:new(10, 0, 0)
seenSinceMoved = false

originalFOV = player.fov()

time = 0
timeLookingAtEye = 0
function render3d(dt)
    anetwork.Tick()

    if not allFilesAreLoaded then return end

    local X, Y, Z = gfx.origin()
    pYaw, pPitch = player.rotation()
    camPos = vec:new(X, Y, Z)

    time = time + dt

    table.insert(positions, { X, Y + math.sin(time) / 4 - 0.25, Z, time })
    while time - positions[1][4] > delay do
        table.remove(positions, 1)
    end

    local lookPos = vec:new(positions[1][1], positions[1][2], positions[1][3])

    local lastDirToPlayer = dirToPlayer
    dirToPlayer = eyePos:copy():sub(lookPos):dir()

    if lastDirToPlayer then
        local moveAmount = math.sqrt(
            (lastDirToPlayer[1] - dirToPlayer[1]) ^ 2 +
            (lastDirToPlayer[2] - dirToPlayer[2]) ^ 2
        )
        if moveAmount > 0.005 then
            moveSound.volume = 10 / math.clamp(camPos:dist(eyePos), 0, 10)
        else
            moveSound.volume = 0
        end
    end

    gfx.pushTransformation(
        {
            4,     -- scales transform id
            0.075, -- x
            0.075, -- y
            0.075  -- z
        },
        {
            3,              -- rotates transform id
            dirToPlayer[2], -- pitch angle
            0,              -- x
            1,              -- y
            0               -- z
        },
        {
            3,                             -- rotates transform id
            -dirToPlayer[1] - math.pi / 2, -- yaw angle
            0,                             -- x
            0,                             -- y
            1                              -- z
        },
        {
            2,
            eyePos.x,
            eyePos.y,
            eyePos.z
        }
    )
    gfx.objRender(mesh, "Watcher/textures.png")

    local eyeIsVisible = not blockIsOccluded(eyePos, camPos) and posIsVisible(eyePos, camPos, EYESIZE)
    if eyeIsVisible then seenSinceMoved = true end

    -- if the eye is not visible, move it to another spot that is not visible
    if not eyeIsVisible and (seenSinceMoved or math.random() < 0.001) then
        local newSpot = randomNonOcculuded(camPos)
        if newSpot then
            eyePos = newSpot
            seenSinceMoved = false
        end
    end


    local vecToCam = eyePos:copy():sub(camPos)
    local distToCam = eyePos:dist(camPos)
    eyePos:add(vecToCam:copy():setMag(math.max(1 / distToCam - 1 / NEARLIMIT, 0)))
    if distToCam > FARLIMIT then eyePos:add(vecToCam:copy():setMag(-(distToCam - FARLIMIT) ^ 2)) end

    local lookingAtEye = math.acos(
        vec:fromAngle(1, math.rad(pYaw + 90), math.rad(-pPitch)):dot(vecToCam:copy():normalize())
    ) < 0.1

    if lookingAtEye then
        timeLookingAtEye = timeLookingAtEye + dt
    else
        timeLookingAtEye = 0
    end
end

function posIsVisible(pos, camPos, radius)
    local sx, sy = gfx.worldToScreen(pos.x, pos.y, pos.z)
    if not sx or not sy then return false end

    local posTranslated = pos:copy():sub(camPos):rotateYaw(math.rad(pYaw)):rotatePitch(math.rad(-pPitch))

    local fovH, fovV = gfx.fov()
    local r = radius * gui.height() / (posTranslated.z * math.tan(math.rad(fovV / 2))) * 1

    return sx and sy and sx + r >= 0 and sx - r < gui.width() and sy + r >= 0 and sy - r < gui.height()
end

-- if there's something blocking the player's view to this block
RaycastLength = 1000
function blockIsOccluded(pos, camPos)
    local raycasts = {}
    local endPos = pos:copy():sub(camPos):setMag(RaycastLength):add(camPos)
    table.insert(raycasts,
        {
            dimension.raycast(
                camPos.x, camPos.y, camPos.z, endPos.x, endPos.y, endPos.z, RaycastLength, false, true, false
            ),
            { 0, 0, 0 }
        }
    )
    endPos = pos:copy():add(vec:new(1, 0, 0)):sub(camPos):setMag(RaycastLength):add(camPos)
    table.insert(raycasts,
        {
            dimension.raycast(
                camPos.x, camPos.y, camPos.z, endPos.x + 1, endPos.y, endPos.z, RaycastLength, false, true, false
            ),
            { 1, 0, 0 }
        }
    )
    endPos = pos:copy():add(vec:new(0, 1, 0)):sub(camPos):setMag(RaycastLength):add(camPos)
    table.insert(raycasts,
        {
            dimension.raycast(
                camPos.x, camPos.y, camPos.z, endPos.x, endPos.y + 1, endPos.z, RaycastLength, false, true, false
            ),
            { 0, 1, 0 }
        }
    )
    endPos = pos:copy():add(vec:new(0, 0, 1)):sub(camPos):setMag(RaycastLength):add(camPos)
    table.insert(raycasts,
        {
            dimension.raycast(
                camPos.x, camPos.y, camPos.z, endPos.x, endPos.y, endPos.z + 1, RaycastLength, false, true, false
            ),
            { 0, 0, 1 }
        }
    )
    endPos = pos:copy():add(vec:new(1, 1, 0)):sub(camPos):setMag(RaycastLength):add(camPos)
    table.insert(raycasts,
        {
            dimension.raycast(
                camPos.x, camPos.y, camPos.z, endPos.x + 1, endPos.y + 1, endPos.z, RaycastLength, false, true, false
            ),
            { 1, 1, 0 }
        }
    )
    endPos = pos:copy():add(vec:new(0, 1, 1)):sub(camPos):setMag(RaycastLength):add(camPos)
    table.insert(raycasts,
        {
            dimension.raycast(
                camPos.x, camPos.y, camPos.z, endPos.x, endPos.y + 1, endPos.z + 1, RaycastLength, false, true, false
            ),
            { 0, 1, 1 }
        }
    )
    endPos = pos:copy():add(vec:new(1, 0, 1)):sub(camPos):setMag(RaycastLength):add(camPos)
    table.insert(raycasts,
        {
            dimension.raycast(
                camPos.x, camPos.y, camPos.z, endPos.x + 1, endPos.y, endPos.z + 1, RaycastLength, false, true, false
            ),
            { 1, 0, 1 }
        }
    )
    endPos = pos:copy():add(vec:new(1, 1, 1)):sub(camPos):setMag(RaycastLength):add(camPos)
    table.insert(raycasts,
        {
            dimension.raycast(
                camPos.x, camPos.y, camPos.z, endPos.x + 1, endPos.y + 1, endPos.z + 1, RaycastLength, false, true,
                false
            ),
            { 1, 1, 1 } }

    )

    -- if the raycast to any corner of the block hits something past that corner itself, there is nothing blocking that corner so the block is not occluded
    for i = 1, #raycasts, 1 do
        local h = raycasts[i][1]
        local o = raycasts[i][2]
        if (h.px - camPos.x) ^ 2 + (h.py - camPos.y) ^ 2 + (h.pz - camPos.z) ^ 2 > (pos.x + o[1] - camPos.x) ^ 2 + (pos.y + o[2] - camPos.y) ^ 2 + (pos.z + o[3] - camPos.z) ^ 2 then return false end
    end

    return true
end

function randomNonOcculuded(camPos)
    for i = 1, 10, 1 do
        local phi = math.random() * math.pi * 2
        local u = 2 * (math.random() - 0.5)
        local theta = math.acos(u)
        local randomDir = vec:new(
            math.sin(theta) * math.cos(phi),
            math.sin(theta) * math.sin(phi),
            math.cos(theta)
        )
        local raycastEnd = randomDir:copy():setMag(RaycastLength):add(camPos)

        local raycast = dimension.raycast(
            camPos.x, camPos.y, camPos.z,
            raycastEnd.x, raycastEnd.y, raycastEnd.z,
            RaycastLength, true, true, false
        )
        local raycastHit = vec:new(raycast.px, raycast.py, raycast.pz)
        local newEyePos = raycastHit:copy()
            :sub(camPos)
            :setMag(math.clamp(raycastHit:dist(camPos), NEARLIMIT, FARLIMIT)) --respect NEARLIMIT and FARLIMIT
            :add(camPos)
        local newPosIsVisible = posIsVisible(newEyePos, camPos, EYESIZE)

        if not newPosIsVisible then --if this random spot is not visible, it's a valid solution, if not, go back and try again
            if
                dimension.getBlock(math.floor(newEyePos.x), math.floor(newEyePos.y), math.floor(newEyePos.z)).name == "air"
                and
                dimension.getBlock(math.floor(newEyePos.x) - 1, math.floor(newEyePos.y), math.floor(newEyePos.z)).name == "air"
                and
                dimension.getBlock(math.floor(newEyePos.x) + 1, math.floor(newEyePos.y), math.floor(newEyePos.z)).name == "air"
                and
                dimension.getBlock(math.floor(newEyePos.x), math.floor(newEyePos.y) - 1, math.floor(newEyePos.z)).name == "air"
                and
                dimension.getBlock(math.floor(newEyePos.x), math.floor(newEyePos.y) + 1, math.floor(newEyePos.z)).name == "air"
                and
                dimension.getBlock(math.floor(newEyePos.x), math.floor(newEyePos.y), math.floor(newEyePos.z) - 1).name == "air"
                and
                dimension.getBlock(math.floor(newEyePos.x), math.floor(newEyePos.y), math.floor(newEyePos.z) + 1).name == "air"
            then
                return newEyePos
            end
        end
    end

    return false
end
