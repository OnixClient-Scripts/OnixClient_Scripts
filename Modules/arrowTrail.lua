-- Made by O2Flash20

-- CONTROLS, if you want to add physics for a new server, copy paste them in update like I did for Cubecraft
-- essentially just do it by eye, that's what I did
-- also I should mention that it only shows the path it would take if the bow is at full draw
MaxXVelocity = 3.87
MaxYVelocity = 3.55
GravityAcceleration = 0.025
AirDrag = 0.99
--

name = "Arrow Trajectory"
description = "Shows where your arrow will hit"

showTrail = true
client.settings.addBool("Show arrow trail", "showTrail")
renderBehind = false
client.settings.addBool("Render behind", "renderBehind")
color = { 0, 255, 255, 100 }
client.settings.addColor("Color", "color")

importLib("renderthreeD")

function update()
    -- neither of these are perfect, but good enough
    if (server.ip() == "mco.cubecraft.net") then
        MaxXVelocity = 2.9
        MaxYVelocity = 2.7
        GravityAcceleration = 0.05
        AirDrag = 0.99
    elseif server.ip():find("zeqa") then
        MaxXVelocity = 3.95
        MaxYVelocity = 3.55
        GravityAcceleration = 0.095
        AirDrag = 0.99
    elseif server.ip():find("hive") then
        MaxXVelocity = 2.9
        MaxYVelocity = 2.7
        GravityAcceleration = 0.05
        AirDrag = 0.99
    else
        -- MaxXVelocity = 3.87
        -- MaxYVelocity = 3.55
        -- GravityAcceleration = 0.025
        -- AirDrag = 0.99
        MaxXVelocity = 2.55
        MaxYVelocity = 2.8
        GravityAcceleration = 0.05
        AirDrag = 0.99
    end
end

function render3d()
    if player.inventory().selectedItem() == nil or player.inventory().selectedItem().name ~= "bow" then return end
    px, py, pz = player.pposition()
    rx, ry = player.rotation()

    client.settings.reload()

    if renderBehind then gfx.renderBehind(true) end
    gfx.color(color.r, color.g, color.b, color.a)

    a1 = ry + 90
    x1 = math.sin(math.rad(a1))
    y1 = math.cos(math.rad(a1))
    xzVel = x1 * MaxXVelocity
    yVel = y1 * MaxYVelocity

    xVel = xzVel * math.sin(math.rad(rx + 180))
    zVel = xzVel * math.cos(math.rad(rx))

    xPos = px
    yPos = py
    zPos = pz

    res = 6

    foundHit = false

    for i = 1, res * 100, 1 do
        xPos = xPos + xVel / res
        yPos = yPos + yVel / res
        zPos = zPos + zVel / res

        if foundHit == false then
            if i % res == 0 and showTrail then
                cube(xPos, yPos, zPos, 0.1)
            end

            currentBlock = dimension.getBlock(math.floor(xPos), math.floor(yPos), math.floor(zPos)).name
            if currentBlock ~= "air" then
                cube(math.floor(xPos) - 0.025, math.floor(yPos) - 0.025, math.floor(zPos) - 0.025, 1.05)
                foundHit = true
            end
        end

        if i % res == 0 then
            xVel = xVel * AirDrag
            zVel = zVel * AirDrag
            yVel = yVel - GravityAcceleration
        end
    end
end
