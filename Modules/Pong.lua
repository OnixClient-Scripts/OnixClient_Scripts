name="Pong"
description="Pong"

--lets be honest, its made by onix, not rosie

positionX = 10
positionY = 10
sizeX = 200
sizeY = 100

pauseKey = client.settings.addNamelessKeybind("Pause",0x50)
isTheMinecraftBedrockEditionAdaptationOfTheGameCalledPongWhichWasOriginallyMadeIn1972ByDeveloperAllanAlcornCurrentlyPausedAtThisSpecificMomentInTheTimeSpaceContinuum = false
isAutoPlaying = client.settings.addNamelessBool("Autoplay", false)

client.settings.addAir(5)

outline = client.settings.addNamelessBool("Outline", false)
client.settings.addAir(2)
ballColor = client.settings.addNamelessColor("Ball Color", {255,255,255})
paddleColor = client.settings.addNamelessColor("Paddle Color", {255,255,255})

textColor = client.settings.addNamelessColor("Text",{255,255,255})
backColor = client.settings.addNamelessColor("Background",{0,0,0})

PADDLE_HEIGHT = 20
BALL_MOVEMENT_SPEED = 75

PADDLE_MOVEMENT_SPEED = client.settings.addNamelessInt("Paddle Movement Speed", 10, 250, 75)

LastResetTime = os.clock()

function postInit()
    client.execute("toggle script on ".. name)
end

function makePlayer(isP1)
    --add fields to the table
    local player = {score = 0, paddleY = 0, isP1 = isP1, paddleHits = 0}
    player.movingUp = false
    player.movingDown = false

    function player:move(dt)
        --if we are not player1 do math to control it
        if self.isP1 == false or isAutoPlaying.value then
            --get center of ball and paddle cuz lazyness to do a better system
            local myPaddleCenterY = self.paddleY + PADDLE_HEIGHT / 2
            local ballCenterY = ball.y + ball.size / 2
           -- if math.random(1,2) == 1 then --make the ai fail since it was "too good"
                --if the ball is above us go up otherwise go down
                if ballCenterY < myPaddleCenterY then
                    self.movingDown = false
                    self.movingUp = true
                else
                    self.movingDown = true
                    self.movingUp = false
                end
           --[[ else
                --just dont do anything at all
                self.movingDown = false
                self.movingUp = false
            end]]
        end

        --do movement, if we go up then move the thing up and/or down then move down, multiplied by the deltaTime so its framerate independent 
        if self.movingUp == true then
            self.paddleY = self.paddleY - PADDLE_MOVEMENT_SPEED.value * dt
        end
        if self.movingDown == true then
            self.paddleY = self.paddleY + PADDLE_MOVEMENT_SPEED.value * dt
        end

        --stay in the playing field tho thx
        self.paddleY = math.clamp(self.paddleY, 02, sizeY - PADDLE_HEIGHT - 2)
    end

    function player:render()
        gfx2.color(paddleColor)
        --render the player at correct place depending on if we are 1 or 2 atm
        if isP1 then
            gfx2.fillRect(2, self.paddleY, 2, PADDLE_HEIGHT)
        else
            gfx2.fillRect(sizeX - 4, self.paddleY, 2, PADDLE_HEIGHT)
        end
    end

    return player
end

--create player 1 and 2
p1 = makePlayer(true)
p2 = makePlayer(false)

function Ball()
    local b = {size=6}

    --sets the ball in the center of the playing field moving in a random direction
    function b:reset()
        --center ball
        b.x = sizeX / 2 - b.size/2
        b.y = sizeY / 2 - b.size/2
        --set x movement to left or right "randomly", but note that there is no "random number generator". It's all PSEUDO-random number generator. So therefore it should be PNG or PRNG and not RNG. I am a mathematician, this is important to me, thank you. Using incorrect terms make you lose unprofessional and amateurish and make you lose credibility
        if math.random(1, 2) == 1 then
            b.mx = 1.0
        else
            b.mx = -1.0
        end
        --random y between -1 to 1, avoid values between -0.1 to 0.1 since it doesn't move enough
        b.my = 0
        while b.my < 0.1 and b.my > -0.1 do
            b.my = math.random() * 2 - 1
        end
        LastResetTime = os.clock()
    end
    b:reset()

    function b:update(dt)
        --change position with the movement
        self.x = self.x + (BALL_MOVEMENT_SPEED * self.mx) * dt
        self.y = self.y + (BALL_MOVEMENT_SPEED * self.my) * dt

        --colide wiht ceiling and wet floor
        if self.y + self.size > sizeY then
            self.y = sizeY - self.size
            self.my = -self.my
        elseif self.y < 0 then
            self.y = 0
            self.my = -self.my
        end
        
        --if the ball goes past the X boundaries add the score and reset balls
        if self.x < 0 then
            p2.score = p2.score + 1
            p1.paddleHits = 0
            p2.paddleHits = 0
            b:reset()
        elseif self.x + self.size > sizeX then
            p1.score = p1.score + 1
            p1.paddleHits = 0
            p2.paddleHits = 0
            b:reset()
        end
        
        --collide against paddle
        --if the ball's top left corner is smaller than 4 which is the right of paddle 1
        if self.x < 4 then 
            --check if we are withing the paddle's range in any way
            if self.y + self.size > p1.paddleY and self.y < (p1.paddleY + PADDLE_HEIGHT) then
                --revert ball back otherwise next frame it will probably go out of bounds and granting a point
                self.x = 4
                self.mx = -self.mx
                p1.paddleHits = p1.paddleHits + 1
            end
        end
        
        --same as above but for the player2
        --so we are at field sizeX - 2 px of padding and 2 px for paddle, and we check against our right side instead of left
        if (self.x + self.size) > (sizeX - 4) then
            --same thing to check if we are in the paddle's range
            if self.y + self.size > p2.paddleY and self.y < (p2.paddleY + PADDLE_HEIGHT) then
                --revert otherwise it next frame it will probably go out of bound granting a point
                self.x = sizeX - 4 - self.size
                self.mx = -self.mx
                p2.paddleHits = p2.paddleHits + 1
            end
        end
    end

    function b:render()
        --set the ball color and render the elipse
        gfx2.color(ballColor)
        gfx2.fillElipse(self.x + self.size / 2, self.y + self.size / 2, self.size / 2)
    end
    return b
end
--create the BALL (balls)
ball = Ball()

function render2(dt)
    --sometimes it just is amongus
    if dt > 10 then dt = 0 LastResetTime = os.clock() end
    --handle pausing the game
    if isTheMinecraftBedrockEditionAdaptationOfTheGameCalledPongWhichWasOriginallyMadeIn1972ByDeveloperAllanAlcornCurrentlyPausedAtThisSpecificMomentInTheTimeSpaceContinuum == true then
        dt = 0
    end

    --the "Slowdown" when the game start so you can see where the ball goes when it first starts
    --this slows down the entire game not just the ball
    dt = dt * math.min((os.clock() - LastResetTime)/1.5, 1.0)
    if isAutoPlaying.value == true then dt = dt * 3 end

    --change movement speed based on how many time the paddle has bounced off the ball
    local speedLimit = 5
    if isAutoPlaying.value == true then speedLimit = speedLimit * 3 end
    BALL_MOVEMENT_SPEED = 750 * (math.max(1, math.min(p1.paddleHits, 5))/15)
    
    --render Background
        gfx2.color(backColor)
        gfx2.fillRoundRect(0,0,sizeX,sizeY,2)

        --render middle line and scores
        gfx2.color(textColor)
        gfx2.fillRoundRect(sizeX/2,0,2,sizeY,1)
        if outline == true then
            gfx2.drawRoundRect(0,0,sizeX,sizeY,2,1)
        end
        gfx2.text(sizeX/2-gfx2.textSize("" .. p1.score,2)-2, sizeY/2-50,"" .. p1.score,2)
        gfx2.text(sizeX/2+4, sizeY/2-50,"" .. p2.score,2)

    --apply movement and render player1
    p1:move(dt)
    p1:render()

    --apply movement and render player2
    p2:move(dt)
    p2:render()


    --move and render ball
    ball:update(dt)
    ball:render()
end

local function keyboard(key, isDown)
    --if we are in the hud
    if gui.screen() ~= "hud_screen" then return end
    if key == pauseKey.value and isDown then
        if isTheMinecraftBedrockEditionAdaptationOfTheGameCalledPongWhichWasOriginallyMadeIn1972ByDeveloperAllanAlcornCurrentlyPausedAtThisSpecificMomentInTheTimeSpaceContinuum == false then isTheMinecraftBedrockEditionAdaptationOfTheGameCalledPongWhichWasOriginallyMadeIn1972ByDeveloperAllanAlcornCurrentlyPausedAtThisSpecificMomentInTheTimeSpaceContinuum = true else isTheMinecraftBedrockEditionAdaptationOfTheGameCalledPongWhichWasOriginallyMadeIn1972ByDeveloperAllanAlcornCurrentlyPausedAtThisSpecificMomentInTheTimeSpaceContinuum = false end
    end
        --set new movement value 0x26 is up and 0x28 is down
    if key == 0x26 then
        p1.movingUp = isDown
    end
    if key == 0x28 then
        p1.movingDown = isDown
    end
end
event.listen("KeyboardInput", keyboard)