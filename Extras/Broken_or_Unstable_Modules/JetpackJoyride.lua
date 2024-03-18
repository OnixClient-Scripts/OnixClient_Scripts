name = "Jetpack Joyride"
description = "Simple Jetpack Joyride clone."

button, down = nil, nil

sizeX = 200
sizeY = 100
positionX = 100
positionY = 100

localPlayer = {
    coinsCollected = 0,
    isAlive = true,
    position = {x = 30, y = 0},
    velocity = {x = 0, y = 0},
    size = {x = 0, y = 0},
    score = 0
}

game = {
    walls = {},
    coins = {},
    lastWallCreated = os.clock(),
    lastCoinCreated = os.clock(),
    lastDeath = os.clock(),
    shouldContinue = true,
    speed = 50
}

audio = {
    coin = {
        pickup = "JetpackJoyride/coinpickup.mp3",
        shouldPlay = false
    },
    death = {
        death = "JetpackJoyride/death.mp3",
        shouldPlay = false
    },
    music = {
        main = "JetpackJoyride/music.mp3",
        shouldPlay = false
    }
}

function createWall()
    local wall = {
        position = { x = 0, y = 0 },
        size = { x = 0, y = 0 },
        rotation = 0
    }
    wall.position = { x = 260, y = math.random(0, 60) }
    wall.size.y = math.random(30, 60)
    -- local rotations = {0, 45, 90, 135}
    local rotations = {0, 90}
    wall.rotation = rotations[math.random(1, #rotations)] -- Randomly selects one of the specified rotations
    return wall
end


function createCoin()
    local coin = {
        position = {x = 0, y = 0},
        size = 0
    }
    coin.position = {x = 200}
    local coinPositionY = math.random(0, 100)
    coin.size = math.random(5, 5)
    -- check if coin is not outside the screen
    if coinPositionY + coin.size > 100 then
        coinPositionY = coin.size - math.random(0, 100)
    end
    coin.position.y = coinPositionY
    return coin
end

event.listen("MouseInput", function(buttona, downa)
    button, down = buttona, downa
    return game.shouldContinue
end)
function checkCollision(rect1, rect2)
    local function getPoints(rect)
        local points = {}
        local cx = rect.position.x + rect.size.x / 2
        local cy = rect.position.y + rect.size.y / 2

        local cos = math.cos(math.rad(rect.rotation))
        local sin = math.sin(math.rad(rect.rotation))

        local offsetX = rect.position.x - cx
        local offsetY = rect.position.y - cy

        points[1] = {
            x = cx + offsetX * cos - offsetY * sin,
            y = cy + offsetX * sin + offsetY * cos
        }
        points[2] = {
            x = cx + (offsetX + rect.size.x) * cos - offsetY * sin,
            y = cy + (offsetX + rect.size.x) * sin + offsetY * cos
        }
        points[3] = {
            x = cx + (offsetX + rect.size.x) * cos - (offsetY + rect.size.y) * sin,
            y = cy + (offsetX + rect.size.x) * sin + (offsetY + rect.size.y) * cos
        }
        points[4] = {
            x = cx + offsetX * cos - (offsetY + rect.size.y) * sin,
            y = cy + offsetX * sin + (offsetY + rect.size.y) * cos
        }

        return points
    end

    local function isPointInside(point, vertices)
        local j = 4
        local oddNodes = false

        for i = 1, 4 do
            if (vertices[i].y < point.y and vertices[j].y >= point.y) or (vertices[j].y < point.y and vertices[i].y >= point.y) then
                if vertices[i].x + (point.y - vertices[i].y) / (vertices[j].y - vertices[i].y) * (vertices[j].x - vertices[i].x) < point.x then
                    oddNodes = not oddNodes
                end
            end
            j = i
        end

        return oddNodes
    end

    local rect1Vertices = getPoints(rect1)
    local rect2Vertices = getPoints(rect2)

    for i = 1, 4 do
        if isPointInside(rect1Vertices[i], rect2Vertices) or isPointInside(rect2Vertices[i], rect1Vertices) then
            return true
        end
    end

    return false
end

function update()
    if audio.coin.shouldPlay then
        audio.coin.shouldPlay = false
        playCustomSound(audio.coin.pickup)
    end
    if audio.death.shouldPlay then
        audio.death.shouldPlay = false
        playCustomSound(audio.death.death)
    end
    if audio.music.shouldPlay then
        audio.music.shouldPlay = false
        playCustomSound(audio.music.main)
    end
end
backgroundRoundness = 5
function render2(dt)
    gfx2.pushUndocumentedClipArea(0, 0, 200, 100, backgroundRoundness)
    -- background
    gfx2.color(0, 0, 0, 255)
    gfx2.fillRoundRect(0, 0, 200, 100, backgroundRoundness)

    if localPlayer.isAlive == false then
        gfx2.color(255, 255, 255, 255)
        gfx2.text(4, 3, "You died!")
        gfx2.text(4, 13, "Coins collected: " .. localPlayer.coinsCollected)
        gfx2.text(4, 23, "Score: " .. math.floor(localPlayer.score))
        gfx2.text(4, 53, "Click to restart", 3)
        game.shouldContinue = false
    end
    if game.shouldContinue then
        game.speed = localPlayer.coinsCollected * 2 + 50
        localPlayer.score = localPlayer.coinsCollected + math.floor(os.clock() - game.lastDeath)
        -- wall creation
        if os.clock() - game.lastWallCreated > (1 / game.speed) * 60 then
            table.insert(game.walls, createWall())
            game.lastWallCreated = os.clock()
        end
        -- wall movement and rendering
        for i, wall in ipairs(game.walls) do
            wall.position.x = wall.position.x - game.speed * dt
            gfx2.color(255, 0, 0, 255)
            local wallCenter = {x = wall.position.x + 5, y = wall.position.y + wall.size.y / 2}
            gfx2.pushTransformation({
                3,
                wall.rotation,
                wallCenter.x,
                wallCenter.y
            })
            gfx2.fillRoundRect(wall.position.x, wall.position.y, 10, wall.size.y, 2.5)
            gfx2.popTransformation()
            -- check if wall is out of screen based on position and rotation
            if wall.position.x + math.abs(wall.size.y * math.sin(math.rad(wall.rotation))) < -10 then
                table.remove(game.walls, i)
            end
        end
        -- coin creation
        if os.clock() - game.lastCoinCreated > (1 / game.speed) * 80 then
            table.insert(game.coins, createCoin())
            game.lastCoinCreated = os.clock()
        end
    -- player collision
        -- player collision with rotated walls
        for i, wall in ipairs(game.walls) do
            local playerRect = {
                position = { x = localPlayer.position.x, y = localPlayer.position.y },
                size = { x = 10, y = 10 },
                rotation = 0
            }

            local wallRect = {
                position = { x = wall.position.x, y = wall.position.y },
                size = { x = 10, y = wall.size.y },
                rotation = wall.rotation
            }

            if checkCollision(playerRect, wallRect) and localPlayer.isAlive then
                audio.death.shouldPlay = true
                localPlayer.isAlive = false
                game.lastDeath = os.clock()
            end
        end

        -- coin movement and rendering
        for i, coin in ipairs(game.coins) do
            coin.position.x = coin.position.x - game.speed * dt
            gfx2.color(255, 255, 0, 255)
            gfx2.fillElipse(coin.position.x, coin.position.y, coin.size)
            if coin.position.x < -10 then
                table.remove(game.coins, i)
            end
        end
        -- player collision with coins
        for i, coin in ipairs(game.coins) do
            if localPlayer.position.x + 10 > coin.position.x and localPlayer.position.x < coin.position.x + coin.size and localPlayer.position.y + 10 > coin.position.y and localPlayer.position.y < coin.position.y + coin.size then
                table.remove(game.coins, i)
                audio.coin.shouldPlay = true
                localPlayer.coinsCollected = localPlayer.coinsCollected + 1
            end
        end

        -- player movement and rendering
        if button == 1 and down then
            localPlayer.velocity.y = -100
        end
        localPlayer.velocity.y = localPlayer.velocity.y + 275 * dt
        localPlayer.position.y = localPlayer.position.y + localPlayer.velocity.y * dt
        if localPlayer.position.y > 100-10 then
            localPlayer.position.y = 100-10
            localPlayer.velocity.y = 0
        end
        if localPlayer.position.y < 0 then
            localPlayer.position.y = 0
            localPlayer.velocity.y = 0
        end
        gfx2.color(0, 255, 255, 255)
        gfx2.fillRect(localPlayer.position.x, localPlayer.position.y, 10, 10)
        gfx2.color(255, 255, 255, 255)
        gfx2.text(4, 3, "Coins: " .. localPlayer.coinsCollected)
        gfx2.text(4, 10, "Score: " .. math.floor(localPlayer.score))
    elseif button == 1 and down and os.clock() - game.lastDeath > 1.5 then
        game.shouldContinue = true
        localPlayer.isAlive = true
        localPlayer.coinsCollected = 0
        localPlayer.position = {x = 30, y = 0}
        localPlayer.velocity = {x = 0, y = 0}
        localPlayer.size = {x = 0, y = 0}
        game.walls = {}
        game.coins = {}
        game.lastWallCreated = os.clock()
        game.lastCoinCreated = os.clock()
    end
    gfx2.color(255, 255, 255, 255)
    gfx2.drawRoundRect(0, 0, 200, 100, backgroundRoundness, 2)
    gfx2.popUndocumentedClipArea()
end