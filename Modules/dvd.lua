name = "DVD Logo"
description = "It will never hit the corner."

--[[
    originally attempted by jqms but made 6969% better by MCBE Craft :)
]]

client.settings.addAir(5)
isRGB = true
client.settings.addBool("Color changes when it hits the edge", "isRGB")

client.settings.addAir(5)
rainbow_speed = 50
client.settings.addInt("Changing color strength", "rainbow_speed", 0, 255)

client.settings.addAir(5)
color = {255, 255, 255, 255}
client.settings.addColor("Color if not changing on edge", "color")

client.settings.addAir(5)
speed = 2
client.settings.addInt("Moving speed", "speed", 1, 25)


local sizeImage = 200

local posX = 0
local posY = 0
local hue = 0
local speedX = speed
local speedY = speed
local timeStamp = 0
local leftStamps = {}
local rightStamps = {}

function colorFromHue(hue)
    while (hue > 360) do hue = hue - 360 end
    while (hue < 0  ) do hue = hue + 360 end

    if (hue < 60) then
        return 255, hue*255/60, 0
    elseif (hue < 120.1) then
        return 255 - (hue-60)*255/60, 255, 0
    elseif (hue < 180.1) then
        return 0, 255, (hue-120)*255/60
    elseif (hue < 240.1) then
        return 0, 255 - (hue-180)*255/60, 255
    elseif (hue < 300.1) then
        return (hue-240)*255/60, 0, 255
    elseif (hue < 360.1)  then
        return 255, 0, 255 - (hue-300)*255/60
    end
    return 255,255,255;
end

function update(deltaTime)
    timeStamp = timeStamp + deltaTime
    for i = #leftStamps, 1, -1 do
        if leftStamps[i] < (timeStamp - 0.3) then
            table.remove(leftStamps, i)
        end
    end
    for i = #rightStamps, 1, -1 do
        if rightStamps[i] < (timeStamp - 0.3) then
            table.remove(rightStamps, i)
        end
    end
end


function render(deltaTime)
    if hue > 360 then hue = 0 end
    if hue < 0 then hue = 360 end
    posX = posX + speedX + speedX * #leftStamps
    posY = posY + speedY + speedY * #leftStamps
    if posX > gui.width() - 199 then
        speedX = -speed
        hue = hue + rainbow_speed
    end
    if posX < 0 then
        speedX = speed
        hue = hue + rainbow_speed
    end
    if posY > gui.height() - 140 then
        speedY = -speed
        hue = hue + rainbow_speed
    end
    if posY < -60 then
        speedY = speed
        hue = hue + rainbow_speed
    end
    gfx.cimage(posX, posY, sizeImage, sizeImage, "dvdlogo.png", 0, 0, 1, 1)
    if isRGB then
        txthue = hue
        r,g,b = colorFromHue(txthue)
    else
        r,g,b = color.r, color.g, color.b
    end
    gfx.cfimage(r, g, b, color.a)
end

function onMouse(button, down)
    if down then
        if button == 1 then
            table.insert(leftStamps, timeStamp)
        end
        if button == 2 then
            table.insert(rightStamps, timeStamp)
        end
    end
end
event.listen("MouseInput", onMouse)

