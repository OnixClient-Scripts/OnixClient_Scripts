name = "Better Camera"
description = "Overhauls the camera!"

client.settings.addCategory("Main Settings")
elytraOnly = client.settings.addNamelessBool("Elytra Only", false)
client.settings.addAir(5)

client.settings.addCategory("Mouse Rotate Settings")
clampMouseRotationAngle = client.settings.addNamelessBool("Clamp Mouse Rotation Angle", true)
mouseRotateAmount = client.settings.addNamelessFloat("Mouse Rotate Max", 0, 360, 45)
mouseRotateMultiplier = client.settings.addNamelessFloat("Mouse Rotate Multiplier", 0, 10, 0.05)
reverseCameraRotation = client.settings.addNamelessBool("Reverse Mouse Rotation", false)
client.settings.addAir(5)

client.settings.addCategory("Velocity Settings")
velocityRotationMultiplier = client.settings.addNamelessFloat("Velocity Rotation Multiplier", 0, 10, 1)
reverseVelocity = client.settings.addNamelessBool("Reverse Velocity Rotation", false)

function getModByInternalName(name)
    for _, mod in pairs(client.modules()) do
        if mod.saveName == name then
            return mod
        end
    end
end

function getSettingFromMod(mod, saveName)
    for _, setting in pairs(mod.settings) do
        if setting.saveName == saveName then
            return setting
        end
    end
end


function lerp(a, b, t)
    return a + (b - a) * t
end

function postInit()
    mod = getModByInternalName("module.rotatable_screen.name")
    lastX, lastY, lastZ = player.pposition()
end

function onEnable()
    if mod.enabled == false then
        print("Better Camera: Rotatable Camera/Screen is not enabled!")
    end
end

prevYaw = nil
shouldUpdate = false
yaw, pitch = 0, 0
xVelocity, yVelocity, zVelocity = 0, 0, 0


function math.sign(x)
    if x < 0 then
        return -1
    elseif x > 0 then
        return 1
    else
        return 0
    end
end
lastUpdateTime = os.clock()
function calculateVelocity()
    local currentX, currentY, currentZ = player.pposition()

    if lastX and lastY and lastZ then
        local deltaTime = os.clock() - lastUpdateTime
        xVelocity = (currentX - lastX) / deltaTime
        yVelocity = (currentY - lastY) / deltaTime
        zVelocity = (currentZ - lastZ) / deltaTime
    end

    lastX, lastY, lastZ = currentX, currentY, currentZ
    lastUpdateTime = os.clock()
end

function render3d(dt)
    mouseRotateAmount.visible = clampMouseRotationAngle.value

    local setting = getSettingFromMod(mod, "module.rotatable_screen.setting.angle.name")
    local value = setting.value
    local inSpeed = 0.00625
    local outSpeed = 0.025
    value = lerp(value, 0, outSpeed)
    calculateVelocity()

    -- causes issues with the rotation when in f1 and i cant figure out why
    -- it also sometimes becomes NaN without the if not (localXVelocity ~= localXVelocity) check and i cant figure out why
    -- works fine when not in f1

    if (xVelocity ~= 0 or zVelocity ~= 0) and yaw ~= 0 then
        local localXVelocity = xVelocity * math.cos(math.rad(yaw)) + zVelocity * math.sin(math.rad(yaw))
        localXVelocity = reverseVelocity.value and -localXVelocity or localXVelocity
        if (not (localXVelocity ~= localXVelocity)) and ((player.getFlag(32)) or elytraOnly.value == false) then
            value = (value - localXVelocity * dt * inSpeed * (velocityRotationMultiplier.value * 100))
        end
    end

    yaw, pitch = player.rotation()
    if shouldUpdate then
        if prevYaw then
            local deltaYaw = prevYaw - yaw
            if deltaYaw < -180 then
                deltaYaw = deltaYaw + 360
            elseif deltaYaw > 180 then
                deltaYaw = deltaYaw - 360
            end
            deltaYaw = reverseCameraRotation.value and -deltaYaw or deltaYaw
            value = value + deltaYaw * mouseRotateMultiplier.value
        end
    end
    prevYaw = yaw
    if (player.getFlag(32)) or elytraOnly.value == false then
        if clampMouseRotationAngle.value then
            value = math.clamp(value, -mouseRotateAmount.value, mouseRotateAmount.value)
        end
        setting.value = value
        shouldUpdate = true
    else
        setting.value = lerp(value, 0, outSpeed)
        shouldUpdate = false
        if setting.value < 0.01 and setting.value > -0.01 then
            setting.value = 0
        end
    end
end

function onDisable()
    local setting = getSettingFromMod(mod, "module.rotatable_screen.setting.angle.name")
    setting.value = 0
end