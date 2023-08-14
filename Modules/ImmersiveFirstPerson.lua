-- Made By O2Flash20 🙂

name = "Immersive First Person"
description = "Look at yourself and see... yourself"

importLib("cosmeticTools")

function postInit()
    player.skin().save("IFP_skin.png")
    SkinSource = Texture:newSource("IFP_skin.png", 64, 64)

    bodyFront = Texture:new()
        :addImage(SkinSource, 20, 20, 28, 32)

    bodyTop = Texture:new()
        :addImage(SkinSource, 20, 16, 28, 20)

    rightLeg = Texture:new()
        :addImage(SkinSource, 4, 20, 8, 32)

    leftLeg = Texture:new()
        :addImage(SkinSource, 20, 52, 24, 64)
end

offset = -0.2

t = 0

keysDown = {
    false, false, false, false
}

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

function isAKeyDown()
    for _, key in pairs(keysDown) do if key then return true end end
    return false
end

a = 0
currentA = 0
function render3d(dt)
    updateCosmeticTools()

    local isSwimming = player.getFlag(3) and dimension.getBlock(math.floor(px), math.floor(py), math.floor(pz)).id == 9
    if player.perspective() ~= 0 or player.getFlag(5) or player.getFlag(32) or isSwimming then return end

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
    currentA = currentA * 0.95 + a * 0.05

    Body = Object:new(0, 0, offset)
        :attachToBody()

    Legs = Object:new(0, -0.38, offset)
        :attachToBody()

    -- body
    Cube:new(
        Body,
        0, 0, 0,
        0.5, 0.75, 0.25
    )
        :renderTexture(bodyFront.texture, nil, nil, nil, bodyTop.texture)

    -- right leg
    Cube:new(
        Legs,
        0.12, -0.35, 0,
        0.25, 0.71, 0.25
    )
        :rotateObject(currentA * 0.5 * math.sin(10 * t), 0, 0)
        :renderTexture(leftLeg.texture)

    -- left leg
    Cube:new(
        Legs,
        -0.12, -0.35, 0,
        0.25, 0.71, 0.25
    )
        :rotateObject(currentA * -0.5 * math.sin(10 * t), 0, 0)
        :renderTexture(rightLeg.texture)

    lastPos = { px, py, pz }
end
