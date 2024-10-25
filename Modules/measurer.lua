-- Made By O2Flash20 🙂

name = "Measurer"
description = "Measures distances in the world."

importLib("vectors")

client.settings.addAir(4)

onScreenScale = client.settings.addNamelessFloat("On Screen Information Scale", 0, 5, 1)
decimalPoints = client.settings.addNamelessInt("Decimal Precision", 1, 10, 2)

client.settings.addAir(4)

p1Key = client.settings.addNamelessKeybind("Set Point 1", 74)
p2Key = client.settings.addNamelessKeybind("Set Point 2", 75)
clearPoints = client.settings.addNamelessKeybind("Clear Points", 77)

client.settings.addAir(4)

bgCol = client.settings.addNamelessColor("Text Background Color", {51, 51, 51, 255})
textCol = client.settings.addNamelessColor("Text Color", {255, 255, 255, 255})

p1Set = false
p1 = vec:new(0, 0, 0)

p2Set = false
p2 = vec:new(0, 0, 0)

function raycastForward()
    local px, py, pz = gfx.origin()
    local pyaw, ppitch = player.rotation()
    local endPos = vec:new(0, 0, 1000):rotatePitch(math.rad(ppitch)):rotateYaw(math.rad(pyaw))
    endPos:setComponent("x", -endPos.x):add(vec:new(px, py, pz))
    return dimension.raycast(px, py, pz, endPos.x, endPos.y, endPos.z, 1000, true, true, false)
end

event.listen("KeyboardInput", function(key, down)
    if key == p1Key.value and down then
        local hit = raycastForward()
        p1.components = {hit.px, hit.py, hit.pz}
        p1:updateComponentNames()
        p1Set = true
    end

    if key == p2Key.value and down then
        local hit = raycastForward()
        p2.components = {hit.px, hit.py, hit.pz}
        p2:updateComponentNames()
        p2Set = true
    end

    if key == clearPoints.value and down then
        p1Set = false; p2Set = false
    end
end)

function render3d()
    if p1Set and p2Set then
        gfx.line(p1.x, p1.y, p1.z, p2.x, p2.y, p2.z)
    end
end

function renderTextBox(x, y, z, offsetX, offsetY, text, textScale, padding, roundness, backgroundCol, textCol)
    local X, Y = gfx.worldToScreen(x, y, z)
    if (X and Y) then
        local textWidth, textHeight = gfx2.textSize(text, textScale)
        local textWidthP = textWidth + padding
        local textHeightP = textHeight + padding - 2.5

        gfx2.color(backgroundCol)
        gfx2.fillRoundRect(X-textWidthP/2-offsetX, Y-textHeightP/2-offsetY, textWidthP, textHeightP, roundness)

        gfx2.color(textCol)
        gfx2.text(X-textWidth/2-offsetX, Y-textHeight/2-offsetY, text, textScale)
    end
end

function render2()
    local px, py, pz = gfx.origin()
    local posVec = vec:new(px, py, pz)
    local fovY, fovX = gfx.fov()

    if p1Set and p2Set then
        local midPoint = p1:copy():lerp(p2, 0.5)
        local distance = p1:dist(p2)

        local distanceToText = posVec:dist(midPoint)

        local midDistanceScale = 1/math.sqrt(distanceToText)/math.atan(math.rad(fovY))

        local midPointText = "["..toFixed(midPoint.x, decimalPoints.value).." "..toFixed(midPoint.y, decimalPoints.value).." "..toFixed(midPoint.z, decimalPoints.value).."]"
        renderTextBox(midPoint.x, midPoint.y, midPoint.z, 0, -61*0.5*onScreenScale.value*midDistanceScale, midPointText, 3*0.5*onScreenScale.value*midDistanceScale, 3, 1, bgCol.value, textCol.value)

        local distanceText = tostring(toFixed(distance, decimalPoints.value)).." blocks"
        renderTextBox(midPoint.x, midPoint.y, midPoint.z, 0, -20*0.5*onScreenScale.value*midDistanceScale, distanceText, 5*0.5*onScreenScale.value*midDistanceScale, 3, 1, bgCol.value, textCol.value)
    end

    if p1Set then
        local p1Text = "["..toFixed(p1.x, decimalPoints.value).." "..toFixed(p1.y, decimalPoints.value).." "..toFixed(p1.z, decimalPoints.value).."]"
        local distanceToP1 = posVec:dist(p1)
        local p1DistanceScale = 1/math.sqrt(distanceToP1)/math.atan(math.rad(fovY))
        renderTextBox(p1.x, p1.y, p1.z, 0, -40*0.5*onScreenScale.value*p1DistanceScale, p1Text, 5*0.5*onScreenScale.value*p1DistanceScale, 3, 1, bgCol.value, textCol.value)
    end

    if p2Set then
        local p2Text = "["..toFixed(p2.x, decimalPoints.value).." "..toFixed(p2.y, decimalPoints.value).." "..toFixed(p2.z, decimalPoints.value).."]"
        local distanceToP2 = posVec:dist(p2)
        local p2DistanceScale = 1/math.sqrt(distanceToP2)/math.atan(math.rad(fovY))
        renderTextBox(p2.x, p2.y, p2.z, 0, -40*0.5*onScreenScale.value*p2DistanceScale, p2Text, 5*0.5*onScreenScale.value*p2DistanceScale, 3, 1, bgCol.value, textCol.value)
    end
end

function toFixed(number, decimalPlaces)
    return math.floor(number*10^decimalPlaces)/10^decimalPlaces
end
