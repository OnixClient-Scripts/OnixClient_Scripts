-- Made By O2Flash20 🙂

name = "Birds"
description = "Adds birds that fly around in your world."

importLib("vectors")
importLib("anetwork")

allFilesAreLoaded = false
loadedFiles = 0
function postInit()
    anetwork.Initialise(1)
    if not fs.isdir("Birds") then
        fs.mkdir("Birds")

        anetwork.fileget(
            "https://raw.githubusercontent.com/OnixClient-Scripts/OnixClient_Scripts/master/Data/Birds/texture.png", "Birds/texture.png", {},
            function (response, error) fileDownloaded(response, error) end
        )
        anetwork.fileget(
            "https://raw.githubusercontent.com/OnixClient-Scripts/OnixClient_Scripts/master/Data/Birds/body.obj", "Birds/body.obj", {},
            function (response, error) fileDownloaded(response, error) end
        )
        anetwork.fileget(
            "https://raw.githubusercontent.com/OnixClient-Scripts/OnixClient_Scripts/master/Data/Birds/wingL.obj", "Birds/wingL.obj", {},
            function (response, error) fileDownloaded(response, error) end
        )
        anetwork.fileget(
            "https://raw.githubusercontent.com/OnixClient-Scripts/OnixClient_Scripts/master/Data/Birds/wingR.obj", "Birds/wingR.obj", {},
            function (response, error) fileDownloaded(response, error) end
        )
    else
        allFilesAreLoaded = true
        start()
    end
end

function fileDownloaded(response, error)
    loadedFiles = loadedFiles + 1

    if loadedFiles == 4 then
        allFilesAreLoaded = true
        start()
    end
end

function start()
    birdBodyMesh = gfx.objLoad("Birds/body.obj")
    birdWingLMesh = gfx.objLoad("Birds/wingL.obj")
    birdWingRMesh = gfx.objLoad("Birds/wingR.obj")
end

numBirds = client.settings.addNamelessInt("Number of Birds", 1, 25, 5)

MAXBIRDS = numBirds.value
TIMEPERKEYFRAME = 5
CLOSESTSPAWNDIST = 10
FURTHESTSPAWNDIST = 50
KEYFRAMESPACING = 40
FLYHEIGHT = 30
MAXTURNANGLE = 90
DISAPPEARDIST = 60

birds = {}

function update(dt)
    if not dimension.name() == "Overworld" or not allFilesAreLoaded then return end

    MAXBIRDS = numBirds.value

    px, py, pz = player.pposition()
    pYaw, pPitch = player.rotation()
    pPos = vec:new(px, py, pz)

    if #birds < MAXBIRDS and math.abs(4*dimension.time() - 2) > 1 then --pick a spot for a bird to spawn
        local offset = vec:fromAngle(1, math.random() * math.pi * 2)
        offset:setMag(math.random(CLOSESTSPAWNDIST, FURTHESTSPAWNDIST))

        local mapHeight = dimension.getMapHeight(math.floor(offset.x + px), math.floor(offset.y + pz))
        if mapHeight then

            local spawnPos = vec:new(
                offset.x + px,
                mapHeight + 1.2,
                offset.y + pz
            )

            if not posIsVisible(spawnPos, pPos, 1) then
                table.insert(birds, { t, { spawnPos } })
            end

        end
    end

    updateBirdsKeyframes()
end

function posIsVisible(pos, camPos, radius)
    local sx, sy = gfx.worldToScreen(pos.x, pos.y, pos.z)
    if not sx or not sy then return false end

    local posTranslated = pos:copy():sub(camPos):rotateYaw(math.rad(pYaw)):rotatePitch(math.rad(-pPitch))

    local fovH, fovV = gfx.fov()
    local r = radius * gui.height() / (posTranslated.z * math.tan(math.rad(fovV / 2))) * 1

    return sx and sy and sx + r >= 0 and sx - r < gui.width() and sy + r >= 0 and sy - r < gui.height()
end

function updateBirdsKeyframes() --finds the birds new positions to go to if they need
    local birdsToRemove = {}
    for i = 1, #birds, 1 do
        local thisBird = birds[i]
        local thisBirdSpawnTime = thisBird[1]
        local thisBirdKeyframes = thisBird[2] --the spawn position counts as a keyframe

        local nextKeyframe = thisBirdKeyframes[#thisBirdKeyframes-2]

        if 
        nextKeyframe and (nextKeyframe.x-px)^2 + (nextKeyframe.z-pz)^2 >= DISAPPEARDIST^2 and not posIsVisible(nextKeyframe, pPos, 1) --far and not on screen
        or
        nextKeyframe and (nextKeyframe.x-px)^2 + (nextKeyframe.z-pz)^2 >= 200^2 --far enough that it's not visible
        then --remove it
            table.insert(birdsToRemove, i)

        else
            local timeSinceSpawn = t - thisBirdSpawnTime
            local currentKeyframe = math.ceil(timeSinceSpawn / TIMEPERKEYFRAME) --the first keyframe is 1, and "current" is the one that was just passed

            local j = 0
            while #thisBirdKeyframes < currentKeyframe + 3 do --needs more keyframes
                if j > 10 then --it has tried too many times to find a spot, give up because this bird is stuck
                    table.insert(birdsToRemove, i)
                    break
                else
                    local newPos = findNewPosition(thisBirdKeyframes[#thisBirdKeyframes], thisBirdKeyframes[#thisBirdKeyframes-1])
                    if not newPos == false then
                        table.insert(thisBirdKeyframes, newPos)
                    end
                end

                j=j+1
            end
        end
    end

    for i = #birdsToRemove, 1, -1 do
        table.remove(birds, birdsToRemove[i])
    end
end

function findNewPosition(lastPos, beforeLastPos)
    local offset
    if beforeLastPos == nil then
        offset = vec:fromAngle(KEYFRAMESPACING, math.random() * math.pi * 2)
    else
        offset = vec:fromAngle(KEYFRAMESPACING, lastPos:copy():sub(beforeLastPos):dir()[1] + 2*math.rad(MAXTURNANGLE)*(math.random() - 0.5))
    end

    local mapHeight = dimension.getMapHeight(math.floor(offset.x + lastPos.x), math.floor(offset.y + lastPos.z))
    if not mapHeight then return false end
    local newPos = vec:new(
        offset.x + lastPos.x,
        mapHeight + FLYHEIGHT,
        offset.y + lastPos.z
    )

    if dimension.raycast(lastPos.x, lastPos.y, lastPos.z, newPos.x, newPos.y, newPos.z).isBlock then --the bird would hit something on its way to the next position, so call the function again until it doesnt
        return false --this new position is invalid :(
    else
        return newPos
    end
end

t = 0

function render3d(dt)
    anetwork.Tick()

    if not dimension.name() == "Overworld" or not allFilesAreLoaded then return end

    t = t + dt

    px, py, pz = player.pposition()
    pYaw, pPitch = player.rotation()
    pPos = vec:new(px, py, pz)

    local brightness = sunBrightness(dimension.time())
    gfx.color(brightness, brightness, brightness)

    for i = 1, #birds, 1 do
        local thisBird = birds[i]
        local thisBirdSpawnTime = thisBird[1]
        local thisBirdKeyframes = thisBird[2]

        local timeSinceSpawn = t - thisBirdSpawnTime

        local currentPos = catmullRomSpline3D(thisBirdKeyframes, timeSinceSpawn/TIMEPERKEYFRAME, 0, 0)
        local nextPos = catmullRomSpline3D(thisBirdKeyframes, timeSinceSpawn/TIMEPERKEYFRAME+0.01, 0, 0)
        local velocity = nextPos:copy():sub(currentPos):div(0.01)
        local facingDir = velocity:dir()

        local nextNextPos = catmullRomSpline3D(thisBirdKeyframes, timeSinceSpawn/TIMEPERKEYFRAME+0.02, 0, 0)
        local nextVelocity = nextNextPos:copy():sub(nextPos):div(0.01)
        local acceleration = nextVelocity:copy():sub(velocity):div(0.01)

        lastVelocity = velocity:copy()
        local turnDir = acceleration:copy():set(-acceleration.x, acceleration.y, acceleration.z):rotateYaw(-facingDir[1]):rotatePitch(-facingDir[2])

        renderBird(currentPos, facingDir[1], facingDir[2], math.clamp(velocity.y/10 + 1, 0, 1.5), turnDir.z/200, t)

        if math.random() < 0.001 then
            dimension.sound("mob.parrot.idle", currentPos.x, currentPos.y, currentPos.z)
        end
    end
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

function catmullRomSpline3D(points, t, alpha, tension)
    -- the point at the first index will be in there twice to say that it's not moving at the start
    local xPoints = {points[1].x}
    local yPoints = {points[1].y}
    local zPoints = {points[1].z}

    for i = 1, #points, 1 do
        table.insert(xPoints, points[i].x)
        table.insert(yPoints, points[i].y)
        table.insert(zPoints, points[i].z)
    end

    local xPos = catmullRomSpline1D(xPoints, t, alpha, tension)
    local yPos = catmullRomSpline1D(yPoints, t, alpha, tension)
    local zPos = catmullRomSpline1D(zPoints, t, alpha, tension)

    return vec:new(xPos, yPos, zPos)
end

function renderBird(position, yaw, pitch, flapStrength, roll, t)
    local shakeAmount = -0.03*flapStrength*math.sin(20*t)
    gfx.pushTransformation(
        { 3, math.rad(90), 0, 0, 1 },
        { 3, roll, 0, 1, 0 }, --apply turning roll
        { 3, math.rad(-90), 0, 0, 1 },
        { 2, 0, shakeAmount, 0},
        { 3, -pitch, 0, 1, 0 },
        { 3, math.pi/2-yaw, 0, 0, 1 },
        { 2, position.x, position.y, position.z }
    )
    gfx.objRender(birdBodyMesh, "Birds/texture.png")
    gfx.popTransformation()

    gfx.pushTransformation(
        { 3, -flapStrength*0.5*math.cos(20*t), 0, 1, 0 }, --two directions of flap animation
        { 3, math.rad(90), 0, 0, 1 },
        { 3, flapStrength*math.sin(20*t), 0, 1, 0 }, --two directions of flap animation
        { 3, math.rad(-90), 0, 0, 1 },
        { 2, 0.06, 0, 0 },
        { 3, math.rad(90), 0, 0, 1 },
        { 3, roll, 0, 1, 0 }, --apply turing roll
        { 3, math.rad(-90), 0, 0, 1 },
        { 2, 0, shakeAmount, 0 },

        -- align with body
        { 3, -pitch, 0, 1, 0 },
        { 3, math.pi/2-yaw, 0, 0, 1 },
        { 2, position.x, position.y, position.z }
    )
    gfx.objRender(birdWingLMesh, "Birds/texture.png")
    gfx.popTransformation()

    gfx.pushTransformation(
        { 3, -flapStrength*0.5*math.cos(20*t), 0, 1, 0 }, --two directions of flap animation
        { 3, math.rad(90), 0, 0, 1 },
        { 3, -flapStrength*math.sin(20*t), 0, 1, 0 }, --two directions of flap animation
        { 3, math.rad(-90), 0, 0, 1 },
        { 2, -0.06, 0, 0 },
        { 3, math.rad(90), 0, 0, 1 },
        { 3, roll, 0, 1, 0 }, --apply turing roll
        { 3, math.rad(-90), 0, 0, 1 },
        { 2, 0, shakeAmount, 0 },

        -- align with body
        { 3, -pitch, 0, 1, 0 },
        { 3, math.pi/2-yaw, 0, 0, 1 },
        { 2, position.x, position.y, position.z }
    )
    gfx.objRender(birdWingRMesh, "Birds/texture.png")
    gfx.popTransformation()
end

function sunBrightness(time)
    local t = math.abs(time-0.5)

    if t < 0.2 then return 90 end
    if t > 0.3 then return 255 end
    return (165/0.1)*(t-0.2) + 90
end
