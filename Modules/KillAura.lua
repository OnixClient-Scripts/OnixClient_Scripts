name = "Kill Aura"
description = "Automatically kills mobs around you."

mainSettings = client.settings.addCategory("Main Settings")
mob = client.settings.addNamelessTextbox("Mob", "")
clearItems = client.settings.addNamelessBool("Clear Items", false)

client.settings.addAir(5)
chatSettings = client.settings.addCategory("Chat Settings")
hideNoTargetsMatchedSelector = client.settings.addNamelessBool("Hide \"No targets matched selector\" message", true)
hideSyntaxErrorUnexpected = client.settings.addNamelessBool("Hide \"Syntax error, unexpected\" message", true)

client.settings.addAir(5)
viewSettings = client.settings.addCategory("View Settings")
showThroughWalls = client.settings.addNamelessBool("Show Through Walls", false)
client.settings.addAir(2)
circleQuality = client.settings.addNamelessFloat("Circle Quality (1 is highest quality, do NOT slide the slider, either set an exact value or click once!)", 1, 20, 1)
showMovingCircle = client.settings.addNamelessBool("Show Moving Circle", true)
showStaticCircle = client.settings.addNamelessBool("Show Static Circle", true)

client.settings.addAir(2)
showMovingCross = client.settings.addNamelessBool("Show Moving Cross", true)
showStaticCross = client.settings.addNamelessBool("Show Static Cross", true)

client.settings.addAir(5)
miscSettings = client.settings.addCategory("Misc Settings")
range = client.settings.addNamelessFloat("Range (Please disable mod before making any changes!)", 0.1, 15, 3)
yOffsetSetting = client.settings.addNamelessFloat("Y Offset", -1, 5, 1)
fastMode = client.settings.addNamelessBool("Fast Mode (Not Recommended)", false)

function killThem(mob, range)
    if mob == "all" then
        client.execute("execute kill @e[type=!player,r=" .. range .. "]")
    elseif mob ~= "" then
        client.execute("execute kill @e[type=" .. mob .. ",r=" .. range .. "]")
    end
    if clearItems.value then
        client.execute("execute kill @e[type=item,r=" .. range .. "]")
    end
end

function update()
    if fastMode.value == false then
        killThem(mob.value, range.value)
    end
end

function render()
    if fastMode.value then
        killThem(mob.value, range.value)
    end
end

function threeDCircle(radius, yOffset)
    local circle = {}
    if circleQuality.value ~= nil then
        for i = 0, 360, circleQuality.value do
            local x = math.cos(math.rad(i)) * radius
            local y = yOffset + math.sin(math.rad(i)) * radius
            local z = math.sin(math.rad(i)) * radius
            table.insert(circle, {x, y, z})
        end
    end
    return circle
end

function render3d(deltaTime)
    if showThroughWalls.value then
        gfx.renderBehind(true)
    end

    local x, y, z = player.pposition()

    -- Create the dynamic circle
    local yOffset = math.sin(os.clock()) * range.value
    local dynamicCircle = threeDCircle(range.value, yOffset)

    -- Draw the dynamic circle
    for i, v in pairs(dynamicCircle) do
        local x1, y1, z1 = v[1], v[2], v[3]
        local x2, y2, z2
        if i ~= nil then
            if dynamicCircle[i + 1] then
                x2, y2, z2 = dynamicCircle[i + 1][1], dynamicCircle[i + 1][2], dynamicCircle[i + 1][3]
            else
                x2, y2, z2 = dynamicCircle[1][1], dynamicCircle[1][2], dynamicCircle[1][3]
            end
            if showMovingCircle.value then
                gfx.line(x + x1, y - yOffset, z + z1, x + x2, y - yOffset, z + z2)
            end
        end
    end

    -- Create the static circle
    local staticCircleY = 0
    local staticCircle = threeDCircle(range.value, staticCircleY)

    -- Draw the static circle
    for i, v in pairs(staticCircle) do
        local x1, y1, z1 = v[1], v[2], v[3]
        local x2, y2, z2
        if i ~= nil then
            if staticCircle[i + 1] then
                x2, y2, z2 = staticCircle[i + 1][1], staticCircle[i + 1][2], staticCircle[i + 1][3]
            else
                x2, y2, z2 = staticCircle[1][1], staticCircle[1][2], staticCircle[1][3]
            end
            if showStaticCircle.value then
                gfx.line(x + x1, y - yOffsetSetting.value, z + z1, x + x2, y - yOffsetSetting.value, z + z2)
            end
        end
    end

    -- Draw the moving cross
    local crossSize = range.value
    local crossAngle = os.clock() * 20
    local crossX1 = math.cos(math.rad(crossAngle)) * crossSize
    local crossY1 = 0
    local crossZ1 = math.sin(math.rad(crossAngle)) * crossSize

    local crossX2 = math.sin(-math.rad(crossAngle)) * crossSize
    local crossY2 = 0
    local crossZ2 = math.cos(math.rad(crossAngle)) * crossSize
    if showMovingCross.value then
        gfx.line(x + crossX1, y - yOffset, z + crossZ1, x - crossX1, y - yOffset, z - crossZ1)
        gfx.line(x + crossX2, y - yOffset, z + crossZ2, x - crossX2, y - yOffset, z - crossZ2)
    end

    -- Draw the static cross
    local crossX3 = math.cos(math.rad(crossAngle)) * crossSize
    local crossY3 = 0
    local crossZ3 = math.sin(math.rad(crossAngle)) * crossSize

    local crossX4 = math.sin(-math.rad(crossAngle)) * crossSize
    local crossY4 = 0
    local crossZ4 = math.cos(math.rad(crossAngle)) * crossSize
    if showStaticCross.value then
        gfx.line(x + crossX3, y - yOffsetSetting.value, z + crossZ3, x - crossX3, y - yOffsetSetting.value, z - crossZ3)
        gfx.line(x + crossX4, y - yOffsetSetting.value, z + crossZ4, x - crossX4, y - yOffsetSetting.value, z - crossZ4)
    end
end

event.listen("ChatMessageAdded", function(message, username, type, xuid)
    if hideNoTargetsMatchedSelector.value then
        if message:find("§cNo targets matched selector") then
            return true
        end
    end
    if hideSyntaxErrorUnexpected.value then
        if message:find("§cSyntax error: Unexpected") then
            return true
        end
    end
end)