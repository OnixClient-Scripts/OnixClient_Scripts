-- Made by O2Flash20 🙂

sizeX = 10
sizeY = 10
positionX = 350
positionY = 165

name = "PvP Helper"
description = "A mod that can help you improve your PvP."

-- this function was written by Raspberry
function cubexyz(x, y, z, sx, sy, sz)
    gfx.quad(x, y, z, x + sx, y, z, x + sx, y + sy, z, x, y + sy, z, true)
    gfx.quad(x, y, z + sz, x + sx, y, z + sz, x + sx, y + sy, z + sz, x, y + sy, z + sz, true)
    gfx.quad(x, y, z, x, y, z + sz, x, y + sy, z + sz, x, y + sy, z, true)
    gfx.quad(x + sx, y, z, x + sx, y, z + sz, x + sx, y + sy, z + sz, x + sx, y + sy, z, true)
    gfx.quad(x, y, z, x + sx, y, z, x + sx, y, z + sz, x, y, z + sz, true)
    gfx.quad(x, y + sy, z, x + sx, y + sy, z, x + sx, y + sy, z + sz, x, y + sy, z + sz, true)
end

function render3d()
    px, py, pz = player.pposition()
    if player.getFlag(1) then py = py - 0.125 end

    entity = player.selectedEntity()
    if entity and entity.type == "player" then
        -- hitbox
        if showHitbox.value then
            gfx.renderBehind(true)
            gfx.color(hitboxColor.r, hitboxColor.g, hitboxColor.b, hitboxColor.a)
            cubexyz(entity.ppx - 0.3, entity.ppy - 1.62, entity.ppz - 0.3, 0.6, 1.8, 0.6)
        end

        gfx.renderBehind(false)

        -- target
        if showTarget.value then
            pointX, pointY, pointZ = getClosestPointToPlayer(px, py, pz, entity.ppx, entity.ppy, entity.ppz)

            if targetIndicator.value then
                gfx.color(indicatorColor[1], indicatorColor[2], indicatorColor[3])
            else
                gfx.color(targetColor.r, targetColor.g, targetColor.b, targetColor.a)
            end
            xyzCross(pointX, pointY, pointZ, crossSize)
        end

        -- eye line
        if showEyeline.value then
            gfx.color(eyelineColor.r, eyelineColor.g, eyelineColor.b, eyelineColor.a)
            cubexyz(entity.ppx - 0.325, entity.ppy - 0.03, entity.ppz - 0.325, 0.65, 0.06, 0.65)
        end
    end
end

indicatorColor = {}
function render2()
    -- combo indicator
    if entity and entity.type == "player" and showComboIndicator.value then
        local distToPlayer = 10000
        raycastPoint = { entity.ppx, entity.ppy, entity.ppz }
        for i = 1, 20, 1 do
            distToPlayer = getDistToPlayer(
                raycastPoint[1], raycastPoint[2], raycastPoint[3], px, py - 0.72, pz
            )
            raycastPoint = raycastFromPlayer(
                raycastPoint[1], raycastPoint[2], raycastPoint[3], entity.pitch, entity.yaw, distToPlayer
            )

            if distToPlayer <= 0.4 then
                indicatorColor = { comboIndicatorDanger.r, comboIndicatorDanger.g, comboIndicatorDanger.b }
                break
            end

            if distToPlayer > 6 then
                indicatorColor = { comboIndicatorGood.r, comboIndicatorGood.g, comboIndicatorGood.b }
                break
            end
        end

        if not targetIndicator.value then
            gfx2.color(
                comboIndicatorBorderColor.r,
                comboIndicatorBorderColor.g,
                comboIndicatorBorderColor.b,
                comboIndicatorBorderColor.a
            )
            gfx2.drawRoundRect(0, 0, 10, 10, comboIndicatorRoundness, 2)

            gfx2.color(indicatorColor[1], indicatorColor[2], indicatorColor[3])
            gfx2.fillRoundRect(0, 0, 10, 10, comboIndicatorRoundness)
        end
    end
end

function update()
    client.settings.reload()
    client.settings.send()
end

function getClosestPointToPlayer(playerX, playerY, playerZ, otherPlayerX, otherPlayerY, otherPlayerZ)
    if not (playerX and playerY and playerZ and otherPlayerX and otherPlayerY and otherPlayerZ) then return end

    -- move the other player to the origin
    local dx = playerX - otherPlayerX
    local dy = playerY - (otherPlayerY - 0.72)
    local dz = playerZ - otherPlayerZ

    -- turn the hitbox form a prism to a cube to make it easy
    dx = dx / 0.3
    dy = dy / 0.9
    dz = dz / 0.3

    -- logic stuff
    local flipX, flipY, flipZ = false, false, false
    if dx < 0 then
        dx = dx * -1
        flipX = true
    end
    if dy < 0 then
        dy = dy * -1
        flipY = true
    end
    if dz < 0 then
        dz = dz * -1
        flipZ = true
    end

    -- more logic stuff
    local ox, oy, oz
    if dx > dy and dx > dz then
        ox = 1
        oy = math.min(1, dy)
        oz = math.min(1, dz)
    end
    if dy > dx and dy > dz then
        ox = math.min(1, dx)
        oy = 1
        oz = math.min(1, dz)
    end
    if dz > dx and dz > dy then
        ox = math.min(1, dx)
        oy = math.min(1, dy)
        oz = 1
    end

    -- stops errors hopefully
    if not (ox and oy and oz) then return 0, 0, 0 end

    -- put everything back and render
    if flipX then ox = -ox end
    if flipY then oy = -oy end
    if flipZ then oz = -oz end

    ox = ox * 0.3
    oy = oy * 0.9
    oz = oz * 0.3

    ox = ox + otherPlayerX
    oy = oy + (otherPlayerY - 0.72)
    oz = oz + otherPlayerZ

    return ox, oy, oz
end

function getDistToPlayer(x, y, z, playerX, playerY, playerZ)
    x = x - playerX
    y = y - playerY
    z = z - playerZ

    local qX = math.abs(x) - 0.3
    local qY = math.abs(y) - 0.9
    local qZ = math.abs(z) - 0.3

    local oX = math.max(qX, 0)
    local oY = math.max(qY, 0)
    local oZ = math.max(qZ, 0)

    return math.sqrt(oX ^ 2 + oY ^ 2 + oZ ^ 2) + math.min(math.max(qX, math.max(qY, qZ)), 0)
end

function xyzCross(x, y, z, size)
    local scale = size / 0.6
    cubexyz(x - 0.3 * scale, y - 0.01 * scale, z - 0.01 * scale, 0.6 * scale, 0.02 * scale, 0.02 * scale)
    cubexyz(x - 0.01 * scale, y - 0.3 * scale, z - 0.01 * scale, 0.02 * scale, 0.6 * scale, 0.02 * scale)
    cubexyz(x - 0.01 * scale, y - 0.01 * scale, z - 0.3 * scale, 0.02 * scale, 0.02 * scale, 0.6 * scale)

    cubexyz(x - 0.03 * scale, y - 0.03 * scale, z - 0.03 * scale, 0.06, 0.06, 0.06)
end

function raycastFromPlayer(playerX, playerY, playerZ, playerPitch, playerYaw, maxDistance)
    playerPitch = math.rad(playerPitch)
    playerYaw = math.rad( -playerYaw)

    y = -maxDistance * math.sin(playerPitch)
    z = maxDistance * math.cos(playerPitch)
    x = z * math.sin(playerYaw)
    z = z * math.cos(playerYaw)

    return { x + playerX, y + playerY, z + playerZ }
end

--SETTINGS
client.settings.addAir(6)

targetColor = { 255, 0, 0 }
client.settings.addColor("Target Color", "targetColor")
crossSize = 0.6
client.settings.addFloat("Target Size", "crossSize", 0.1, 2)

client.settings.addAir(6)

hitboxColor = { 0, 200, 255, 15 }
client.settings.addColor("Hitbox Color", "hitboxColor")
eyelineColor = { 0, 0, 120 }
client.settings.addColor("Eye Line Color", "eyelineColor")

client.settings.addAir(6)

comboIndicatorGood = { 0, 255, 0 }
client.settings.addColor("Combo Indicator: Good", "comboIndicatorGood")
comboIndicatorDanger = { 255, 0, 0 }
client.settings.addColor("Combo Indicator: Danger", "comboIndicatorDanger")
comboIndicatorBorderColor = { 0, 0, 0 }
client.settings.addColor("Combo Indicator: Border", "comboIndicatorBorderColor")
comboIndicatorRoundness = 2
client.settings.addFloat("Combo Indicator: Roundness", "comboIndicatorRoundness", 0, 5)

client.settings.addAir(6)

targetIndicator = client.settings.addNamelessBool("Use target as combo indicator", false)

client.settings.addAir(6)

showTarget = client.settings.addNamelessBool("Show Target", true)
showHitbox = client.settings.addNamelessBool("Show Hitbox", true)
showEyeline = client.settings.addNamelessBool("Show Eyeline", true)
showComboIndicator = client.settings.addNamelessBool("Show Combo Indicator", true)

client.settings.addAir(10)

client.settings.addTitle(
    "How to use:\nKeep your mouse on the target and keep the square on the good color,\nand you'll probably get a combo.")
------------
