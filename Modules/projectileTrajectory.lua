-- Made By O2Flash20 🙂

name = "Projectile Trajectory"
description = "Shows you where your projectiles will hit"

col = client.settings.addNamelessColor("Trajectory Color", { 255, 0, 0, 255 })
col2 = client.settings.addNamelessColor("Target Color", { 255, 255, 255, 255 })

info =
"Notes: \n- Arrows have a bit of randomness that cannot be predicted.\n- I can only assure that this works on vanilla Minecraft worlds, servers may have different physics."
client.settings.addInfo(info)

function calculateDeltaX(initialVelocity, angle, time)
    return initialVelocity * math.cos(angle) * time
end

function calculateDeltaY(initialVelocity, angle, accelerationY, time)
    return initialVelocity * math.sin(angle) * time - 0.5 * accelerationY * time * time
end

function calculateDeltaXDrag(initalVelocity, angle, terminalVelocity, accelerationFromGravity, time)
    return ((initalVelocity * terminalVelocity * math.cos(angle)) / accelerationFromGravity) *
        (1 - math.exp(-(accelerationFromGravity * time) / terminalVelocity))
end

function calculateDeltaYDrag(initalVelocity, angle, terminalVelocity, accelerationFromGravity, time)
    return (terminalVelocity / accelerationFromGravity) *
        (initalVelocity * math.sin(angle) + terminalVelocity) *
        (1 - math.exp(-(accelerationFromGravity * time) / terminalVelocity)) -
        terminalVelocity * time
end

timeIncrement = 0.01
timeMax = 20

function render3d()
    shouldDrawTarget = false
    local selectedItem = player.inventory().selectedItem()
    if selectedItem == nil or not (selectedItem.id == 425 or selectedItem.id == 393 or selectedItem.id == 377 or selectedItem.id == 303 or selectedItem.id == 583) then return end

    local px, py, pz = player.forwardPosition(0.001)
    local pyaw, ppitch = player.rotation()

    local points = {}
    if selectedItem.id == 377 or selectedItem.id == 393 then --smowball and eggs
        INITIALVEL = 30
        GRAVACC = 11.5
        TERMVEL = 54.5
        local lastX, lastY, lastZ = nil, nil, nil
        for i = 0, timeMax, timeIncrement do
            local deltaX = calculateDeltaXDrag(INITIALVEL, -math.rad(ppitch), TERMVEL, GRAVACC, i) --BUT, this is split between x and z, depending on pyaw
            local x = deltaX * math.sin(math.rad(-pyaw))
            local y = calculateDeltaYDrag(INITIALVEL, -math.rad(ppitch), TERMVEL, GRAVACC, i)
            local z = deltaX * math.cos(math.rad(-pyaw))

            if lastX and lastY and lastZ then
                local raycast = dimension.raycast(lastX + px, lastY + py, lastZ + pz, x + px, y + py, z + pz)
                if raycast.isBlock or raycast.isEntity then
                    table.insert(points, { raycast.px - px, raycast.py - py, raycast.pz - pz })
                    goto drawLine
                else
                    table.insert(points, { x, y, z })
                end
            else
                table.insert(points, { x, y, z })
            end

            lastX, lastY, lastZ = x, y, z
        end
    elseif selectedItem.id == 425 then --ender pearls
        INITIALVEL = 45
        GRAVACC = 22
        local lastX, lastY, lastZ = nil, nil, nil
        for i = 0, timeMax, timeIncrement do
            local deltaX = calculateDeltaX(INITIALVEL, -math.rad(ppitch), i) --BUT, this is split between x and z, depending on pyaw
            local x = deltaX * math.sin(math.rad(-pyaw))
            local y = calculateDeltaY(INITIALVEL, -math.rad(ppitch), GRAVACC, i)
            local z = deltaX * math.cos(math.rad(-pyaw))

            if lastX and lastY and lastZ then
                local raycast = dimension.raycast(lastX + px, lastY + py, lastZ + pz, x + px, y + py, z + pz)
                if raycast.isBlock or raycast.isEntity then
                    table.insert(points, { raycast.px - px, raycast.py - py, raycast.pz - pz })
                    goto drawLine
                else
                    table.insert(points, { x, y, z })
                end
            else
                table.insert(points, { x, y, z })
            end

            lastX, lastY, lastZ = x, y, z
        end
    elseif selectedItem.id == 303 or selectedItem.id == 583 then --bow and crossbow
        INITIALVEL = 83.6
        GRAVACC = 11.5
        TERMVEL = 54.5
        local lastX, lastY, lastZ = nil, nil, nil
        for i = 0, timeMax, timeIncrement do
            local deltaX = calculateDeltaXDrag(INITIALVEL, -math.rad(ppitch), TERMVEL, GRAVACC, i) --BUT, this is split between x and z, depending on pyaw
            local x = deltaX * math.sin(math.rad(-pyaw))
            local y = calculateDeltaYDrag(INITIALVEL, -math.rad(ppitch), TERMVEL, GRAVACC, i)
            local z = deltaX * math.cos(math.rad(-pyaw))
            if lastX and lastY and lastZ then
                local raycast = dimension.raycast(lastX + px, lastY + py, lastZ + pz, x + px, y + py, z + pz)
                if raycast.isBlock or raycast.isEntity then
                    table.insert(points, { raycast.px - px, raycast.py - py, raycast.pz - pz })
                    goto drawLine
                else
                    table.insert(points, { x, y, z })
                end
            else
                table.insert(points, { x, y, z })
            end

            lastX, lastY, lastZ = x, y, z
        end
    end

    ::drawLine::
    if selectedItem.id == 425 or selectedItem.id == 393 or selectedItem.id == 377 or selectedItem.id == 303 or selectedItem.id == 583 then
        gfx.color(col.value.r, col.value.g, col.value.b, col.value.a)
        for i = 1, #points - 1, 1 do
            gfx.line(
                points[i][1] + px, points[i][2] + py, points[i][3] + pz,
                points[i + 1][1] + px, points[i + 1][2] + py, points[i + 1][3] + pz
            )
        end
        shouldDrawTarget = true
        targetX, targetY = gfx.worldToScreen(
            points[#points][1] + px,
            points[#points][2] + py,
            points[#points][3] + pz
        )
    end
end

shouldDrawTarget = false
targetX, targetY = nil, nil

function render()
    if shouldDrawTarget and targetX and targetY then
        gfx.color(col2.value.r, col2.value.g, col2.value.b, col2.value.a)
        gfx.text(targetX - 2.4, targetY - 4, "x")
    end
end
