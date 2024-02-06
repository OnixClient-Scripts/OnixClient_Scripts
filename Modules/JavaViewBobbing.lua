name = "Java View Bobbing"
description = "Makes the view bobbing like in Java Edition."

speed = client.settings.addNamelessFloat("Velocity Factor", 0.1, 10, 1)
jumpInSpeedMultiplier = client.settings.addNamelessFloat("Jump Velocity Factor", 0, 10, 4)

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

function postInit()
    mod = getModByInternalName("module.view_model.name")

    modSettings = {
        translation = {
            x = getSettingFromMod(mod, "module.view_model.setting.translation_x.name"),
            y = getSettingFromMod(mod, "module.view_model.setting.translation_y.name"),
            z = getSettingFromMod(mod, "module.view_model.setting.translation_z.name"),
        },
        rotation = {
            x = getSettingFromMod(mod, "module.view_model.setting.rotation_x.name"),
            y = getSettingFromMod(mod, "module.view_model.setting.rotation_y.name"),
            z = getSettingFromMod(mod, "module.view_model.setting.rotation_z.name"),
        },
        scale = {
            x = getSettingFromMod(mod, "module.view_model.setting.scale_x.name"),
            y = getSettingFromMod(mod, "module.view_model.setting.scale_y.name"),
            z = getSettingFromMod(mod, "module.view_model.setting.scale_z.name"),
        }
    }
    yaw, pitch = player.rotation()
    prevYaw, prevPitch = player.rotation()
    lastX, lastY, lastZ = player.pposition()
end

shouldUpdate = false

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

function onEnable()
    if mod.enabled == false then
        print("§4[§c!§4] §r§7Java View Bobbing: §e§lView Model §r§eis not enabled!")
    end
end

function onDisable()
    for i,v in pairs(mod.settings) do
        v.value = v.default
    end
end

function math.lerp(t, a, b)
    return a + (b - a) * t
end

function toInt(num)
    if num >= 0 then
        return math.floor(num)
    else
        return math.ceil(num)
    end
end

time = os.clock()
deltaYaw = 0
deltaPitch = 0

function render3d(dt)
    time = os.clock()
    local outSpeed = 0.025
    local xVal = modSettings.translation.x.value
    local yVal = modSettings.translation.y.value
    xVal = 0
    yVal = 0
    yaw, pitch = player.rotation()
    if prevYaw then
        deltaYaw = prevYaw - yaw
        if deltaYaw < -180 then
            deltaYaw = deltaYaw + 360
        elseif deltaYaw > 180 then
            deltaYaw = deltaYaw - 360
        end
    end
    deltaPitch = -(prevPitch - pitch)

    xVal = (xVal + deltaYaw * 0.1) * speed.value
    yVal = (yVal + deltaPitch * 0.1) * speed.value

    modSettings.translation.x.value = math.lerp(outSpeed, modSettings.translation.x.value, xVal)
    modSettings.translation.y.value = math.lerp(outSpeed, modSettings.translation.y.value, yVal)
    modSettings.translation.z.value = math.lerp(outSpeed, modSettings.translation.z.value, 0)

    calculateVelocity()
    local inSpeed = 0.0625*jumpInSpeedMultiplier.value
    local velocityMultiplier = 0.1

    local localYVelocity = yVelocity
    if not (localYVelocity ~= localYVelocity) then
        local yValueSet = (modSettings.translation.y.value - localYVelocity * dt * inSpeed * (velocityMultiplier))

        modSettings.translation.y.value = math.clamp(yValueSet, -0.3, 0.3)
    end
    prevYaw, prevPitch = yaw, pitch
end