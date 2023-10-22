name = "AFK Grayscale"
description = "Makes your skin grayscale when you're AFK."

afkTime = client.settings.addNamelessInt("AFK Time (seconds)", 5, 3600, 60)
serverSided = client.settings.addNamelessBool("Server Sided", false)

function onEnable()
    originalSkin = player.skin().texture()
end

function math.round(num, numDecimalPlaces)
    local mult = 10^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

function greyscale()
    local newSkin = player.skin().texture()
    local width, height = newSkin.width, newSkin.height
    for x = 1, width do
        for y = 1, height do
            local pixelColor = newSkin:getPixel(x,y)
            if pixelColor.a ~= 0 then
                local average = math.round((pixelColor.r + pixelColor.g + pixelColor.b) / 3)
                pixelColor.r = average
                pixelColor.g = average
                pixelColor.b = average
                newSkin:setPixel(x,y,pixelColor.r, pixelColor.g, pixelColor.b)
            end
        end
    end
    player.skin().setSkin(newSkin,  not serverSided.value)
end

lastInput = os.clock()

event.listen("KeyboardInput", function(key, down)
    lastInput = os.clock()
end)

event.listen("MouseInput", function(button, down)
    lastInput = os.clock()
end)

function onDisable()
    player.skin().setSkin(originalSkin,  not serverSided.value)
end

hasAppliedGray = false
hasSetOriginalSkin = false

lastRotationTime = os.clock()

function update()
    if os.clock() - lastInput > afkTime.value and not hasAppliedGray then
        greyscale()
        hasAppliedGray = true
        hasSetOriginalSkin = false
    elseif os.clock() - lastInput < afkTime.value and hasAppliedGray and not hasSetOriginalSkin then
        player.skin().setSkin(originalSkin, not serverSided.value)
        hasAppliedGray = false
        hasSetOriginalSkin = true
    end
    if lastRotation ~= player.rotation() then
        lastInput = os.clock()
        lastRotation = player.rotation()
    end
end