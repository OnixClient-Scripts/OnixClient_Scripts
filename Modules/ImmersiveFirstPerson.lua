-- Made By O2Flash20 🙂
-- Some stuff done my rosie 🙂

name = "Immersive First Person"
description = "Look at yourself.. to see yourself.."

importLib("cosmeticTools")
importLib("Utils")

client.settings.addInfo("For the best experience, enable Hide Hand in Minecraft's Video settings.")
client.settings.addInfo("Doesn't work will all block and any items sorry :(")

function postInit()
    player.skin().save("IFP_skin.png")
    SkinSource = Texture:newSource("IFP_skin.png", 64, 64)

    -- head
    headFront = Texture:new():addImage(SkinSource, 24, 8, 32, 16)
    headBack = Texture:new():addImage(SkinSource, 8, 8, 16, 16)
    headLeft = Texture:new():addImage(SkinSource, 0, 8, 8, 16)
    headRight = Texture:new():addImage(SkinSource, 16, 8, 24, 16)
    headTop = Texture:new():addImage(SkinSource, 8, 0, 16, 8)
    headBottom = Texture:new():addImage(SkinSource, 16, 0, 24, 8)

    -- right arm (slim)
    rightArmFront = Texture:new():addImage(SkinSource, 44, 20, 47, 32)
    rightArmBack = Texture:new():addImage(SkinSource, 51, 20, 54, 32)
    rightArmLeft = Texture:new():addImage(SkinSource, 47, 20, 51, 32)
    rightArmRight = Texture:new():addImage(SkinSource, 40, 20, 44, 32)
    rightArmTop = Texture:new():addImage(SkinSource, 44, 16, 47, 20)
    rightArmBottom = Texture:new():addImage(SkinSource, 47, 16, 50, 20)

    -- left arm (slim)
    leftArmFront = Texture:new():addImage(SkinSource, 36, 52, 39, 64)
    leftArmBack = Texture:new():addImage(SkinSource, 43, 52, 46, 64)
    leftArmLeft = Texture:new():addImage(SkinSource, 39, 52, 43, 64)
    leftArmRight = Texture:new():addImage(SkinSource, 32, 52, 36, 64)
    leftArmTop = Texture:new():addImage(SkinSource, 36, 48, 39, 52)
    leftArmBottom = Texture:new():addImage(SkinSource, 39, 48, 42, 52)

    -- right leg (slim)
    rightLegFront = Texture:new():addImage(SkinSource, 4, 20, 8, 32)
    rightLegBack = Texture:new():addImage(SkinSource, 12, 20, 16, 32)
    rightLegLeft = Texture:new():addImage(SkinSource, 8, 20, 12, 32)
    rightLegRight = Texture:new():addImage(SkinSource, 0, 20, 4, 32)
    rightLegTop = Texture:new():addImage(SkinSource, 4, 16, 8, 20)
    rightLegBottom = Texture:new():addImage(SkinSource, 8, 16, 12, 20)

    -- left leg (slim)
    leftLegFront = Texture:new():addImage(SkinSource, 20, 52, 24, 64)
    leftLegBack = Texture:new():addImage(SkinSource, 28, 52, 32, 64)
    leftLegLeft = Texture:new():addImage(SkinSource, 24, 52, 28, 64)
    leftLegRight = Texture:new():addImage(SkinSource, 16, 52, 20, 64)
    leftLegTop = Texture:new():addImage(SkinSource, 20, 48, 24, 52)
    leftLegBottom = Texture:new():addImage(SkinSource, 24, 48, 28, 52)

    -- body (slim)
    bodyFront = Texture:new():addImage(SkinSource, 20, 20, 28, 32)
    bodyBack = Texture:new():addImage(SkinSource, 32, 20, 40, 32)
    bodyLeft = Texture:new():addImage(SkinSource, 28, 20, 32, 32)
    bodyRight = Texture:new():addImage(SkinSource, 16, 20, 20, 32)
    bodyTop = Texture:new():addImage(SkinSource, 20, 16, 28, 20)
    bodyBottom = Texture:new():addImage(SkinSource, 28, 16, 36, 20)
end

offset = -0.2

t = 0

keysDown = {
    false, false, false, false
}

hasHit = false
lastHitTime = 100
local hitDuration = 0.3
event.listen("MouseInput", function(button, down)
    if (button == 1 or button == 2) and lastHitTime > hitDuration then
        hasHit = down
    end
end)

shouldBreathe = true
event.listen("KeyboardInput", function(key, down)
    if key == 0x57 then
        keysDown[1] = down
    elseif key == 0x41 then
        keysDown[2] = down
    elseif key == 0x53 then
        keysDown[3] = down
    elseif key == 0x44 then
        keysDown[4] = down
    end
end)

function onEnable()
    local handItemRenderer = ui.getSettingFromMod("Render Options", "Disable Render for Item in Hand")
    handItemRenderer.value = true
end

function onDisable()
    local handItemRenderer = ui.getSettingFromMod("Render Options", "Disable Render for Item in Hand")
    handItemRenderer.value = false
end

function isAKeyDown()
    for _, key in pairs(keysDown) do if key then return true end end
    return false
end

a = 0
currentA = 0
function render3d(dt)
    if hasHit then
        lastHitTime = 0
        hasHit = false
    end
    lastHitTime = lastHitTime + dt
    local hitPitchAmplitude = 50
    local hitPitch
    local k = 1.3
    if hitDuration - (hitDuration / k) < lastHitTime and lastHitTime < hitDuration then
        hitPitch =
            -math.rad(
                hitPitchAmplitude -
                (hitPitchAmplitude / 2) * math.cos(((2 * math.pi * k) / hitDuration) * (lastHitTime - hitDuration)) +
                hitPitchAmplitude / 2
            )
    else
        hitPitch = 0
    end

    local hitYawAmplitude = 50
    local hitYaw
    if lastHitTime <= hitDuration / 2 and lastHitTime > 0 then
        hitYaw = -math.rad(hitYawAmplitude * math.sin(2 * math.pi * lastHitTime / hitDuration))
    elseif lastHitTime < hitDuration and lastHitTime > hitDuration / 2 then
        hitYaw = -math.rad((hitYawAmplitude / 4) * math.sin(2 * math.pi * lastHitTime / hitDuration))
    else
        hitYaw = 0
    end

    updateCosmeticTools()
    local isSwimming = player.getFlag(3) and dimension.getBlock(math.floor(px), math.floor(py), math.floor(pz)).id == 9
    -- if player.perspective() ~= 0 or player.getFlag(5) or player.getFlag(32) or isSwimming then return end

    local itemToRender = ""

    local slot = player.inventory().selected
    local item = player.inventory().at(slot) or nil
    if item ~= nil then
        itemToRender = "textures/blocks/" .. item.name
    end

    t = t + dt

    a = 1
    offset = -0.2
    if player.getFlag(3) then
        a = 2
    elseif player.getFlag(1) then
        a = 0.5
        offset = -0.4
    end
    if not isAKeyDown() then
        a = 0
    end
    currentA = currentA * 0.8 + a * 0.25
    posX, posY, posZ = player.pposition()
    customPosX = 0
    customPosY = 0
    customPosZ = 0.02 -- + 0.02

    Body = Object:new(customPosX + 0, customPosY, customPosZ + offset)
        :attachToBody()

    Head = Object:new(customPosX + 0, customPosY + .4, customPosZ + offset)
        :attachToBody()

    Legs = Object:new(customPosX + 0, customPosY - 0.38, customPosZ + offset)
        :attachToBody()

    rightArms = Object:new(customPosX - 0.345, customPosY + .34, customPosZ + offset)
        :attachToBody()

    leftArms = Object:new(customPosX + 0.345, customPosY + .34, customPosZ + offset)
        :attachToBody()


    -- frontTex, backTex, leftTex, rightTex, topTex, bottomTex

    -- body
    Cube:new(
        Body,
        0, 0, 0,
        0.5, 0.75, 0.25
    )
        :renderTexture(bodyFront.texture, bodyBack.texture, bodyLeft.texture, bodyRight.texture, bodyTop.texture,
            bodyBottom.texture)

    local legsRunRotation = currentA * 0.5 * math.sin(10 * t)
    -- right leg
    Cube:new(
        Legs,
        0.12, -0.35, 0,
        0.25, 0.71, 0.25
    )
        :rotateObject(legsRunRotation, 0, 0)
        :renderTexture(rightLegFront.texture, rightLegBack.texture, rightLegLeft.texture, rightLegRight.texture,
            rightLegTop.texture, rightLegBottom.texture)

    -- left leg
    Cube:new(
        Legs,
        -0.12, -0.35, 0,
        0.25, 0.71, 0.25
    )
        :rotateObject(-legsRunRotation, 0, 0)
        :renderTexture(leftLegFront.texture, leftLegBack.texture, leftLegLeft.texture, leftLegRight.texture,
            leftLegTop.texture, leftLegBottom.texture)


    local breathingSpeed = 1
    local breathingAmplitude = 0.15
    local breathingRotation = 0.25 * math.sin(breathingSpeed * t) * breathingAmplitude + 0.045

    local armsRunRotation = currentA * -0.4 * math.sin(12 * t)
    -- left arm
    Cube:new(
        leftArms,
        0, -0.33, 0,
        0.20, 0.71, 0.25
    )
        :rotateObject(
            -armsRunRotation,
            0,
            -breathingRotation
        )
        :renderTexture(leftArmFront.texture, leftArmBack.texture, leftArmLeft.texture, leftArmRight.texture,
            leftArmTop.texture, leftArmBottom.texture)

    -- item
    local heldItemOffset = 0
    if itemToRender ~= "" then
        heldItemOffset = -0.2
        Cube:new(
            rightArms,
            0.015, -0.75, 0.3,
            0.35, 0.35, 0.35
        )
            :rotateSelf(0, math.rad(60), 0)
            :rotateObject(
                armsRunRotation,
                0,
                breathingRotation
            )
            :rotateObject(
                hitPitch,
                hitYaw,
                0
            )
            :renderTexture(itemToRender, itemToRender, itemToRender, itemToRender,
                itemToRender, itemToRender)
    end

    -- right arm
    Cube:new(
        rightArms,
        0, -0.33, 0,
        0.20, 0.71, 0.25
    )
        :rotateObject(
            armsRunRotation + heldItemOffset,
            0,
            breathingRotation
        )
        :rotateObject(
            hitPitch,
            0,
            hitYaw
        )
        :renderTexture(rightArmFront.texture, rightArmBack.texture, rightArmLeft.texture, rightArmRight.texture,
            rightArmTop.texture, rightArmBottom.texture)

    -- head

    -- -- frontTex, backTex, leftTex, rightTex, topTex, bottomTex
    -- local pitch, yaw = player.rotation()
    -- local tempNumber = 0 -- 3.2
    -- Cube:new(
    --     Head,
    --     0, 0.2, 0,
    --     0.5, 0.5, 0.5
    -- )
    --     :rotateObject(-yaw / 57.5, tempNumber + -(pitch / 57.5), 0)
    --     :renderTexture(headFront.texture, headBack.texture, headLeft.texture, headRight.texture, headTop.texture,
    --         headBottom.texture)

    px, py, pz = player.position()

    lastPos = { px, py, pz }
end
