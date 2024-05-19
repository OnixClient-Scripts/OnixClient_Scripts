-- Made By O2Flash20 🙂

name = "Fall Trajectory"
description = "Shows you where you'll fall"

importLib("PlayerPhysics")
importLib("vectors")

topCol = client.settings.addNamelessColor("Will land on block color", { 255, 255, 255, 255 })
sideCol = client.settings.addNamelessColor("Will hit the side of block color", { 255, 0, 0, 255 })
targetSize = client.settings.addNamelessFloat("Target size", 1, 6, 1.5)

function render(dt)
    PlayerPhysics.update(dt)

    if PlayerPhysics.velocity.y < -10 and not player.getFlag(32) then --player is falling and not with elytra
        local lastPosition
        for i = 1, 100, 1 do
            local hasACollision = false --keep track of whether or not a collision has been found yet

            local thisPosition = predictMotion(
                i / 10,
                PlayerPhysics.position:copy(),
                PlayerPhysics.velocity:copy(),
                PlayerPhysics.acceleration:copy()
            )

            if i > 1 then -- see if there's a collision between the last position and this one
                local blockCollisions = {}

                for j = -0.3, 0.3, 0.6 do --cast 4 rays, one from each corner of the player's hitbox
                    for k = -0.3, 0.3, 0.6 do
                        local hit = dimension.raycast(
                            lastPosition.x + j,
                            lastPosition.y,
                            lastPosition.z + k,
                            thisPosition.x + j,
                            thisPosition.y,
                            thisPosition.z + k
                        )
                        if hit.isBlock then
                            hasACollision = true
                            local isTopFace = 0
                            if hit.blockFace == 1 then isTopFace = 1 end
                            table.insert(blockCollisions, vec:new(hit.px, hit.py, hit.pz, isTopFace, j, k))
                        end
                    end
                end

                local highestBlockCollision = vec:new(0, -1000, 0, 0, 0, 0) --just a placeholder for now
                for j = 1, #blockCollisions do
                    if blockCollisions[j].y > highestBlockCollision.y then
                        highestBlockCollision = blockCollisions[j]:copy()
                    end
                end

                -- draw the target
                local targetX, targetY = gfx.worldToScreen(
                    highestBlockCollision.x - highestBlockCollision.components[5],
                    highestBlockCollision.y,
                    highestBlockCollision.z - highestBlockCollision.components[6]
                )
                if targetX and targetY and #blockCollisions > 0 then
                    if highestBlockCollision.w == 1 then
                        gfx.color(topCol.value.r, topCol.value.g, topCol.value.b, topCol.value.a)
                    else
                        gfx.color(sideCol.value.r, sideCol.value.g, sideCol.value.b, sideCol.value.a)
                    end

                    gfx.line(
                        targetX - targetSize.value,
                        targetY - targetSize.value,
                        targetX + targetSize.value,
                        targetY + targetSize.value
                    )
                    gfx.line(
                        targetX - targetSize.value,
                        targetY + targetSize.value,
                        targetX + targetSize.value,
                        targetY - targetSize.value
                    )
                end
            end
            if hasACollision then break end
            lastPosition = thisPosition
        end
    end
end

function predictMotion(time, position, velocity, acceleration)
    -- x = x0 + v0 t + (1/2) a t^2
    return position:add(velocity:mult(time)):add(acceleration:mult(0.5 * time * time))
end
