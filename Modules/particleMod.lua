name = "Particle Mod"
description = "Adds more particles"

client.settings.addAir(5)
color = {172, 140, 99, 255}
client.settings.addColor("Particle color", "color")

client.settings.addAir(5)
particleCount = 10
client.settings.addInt("Amount of particles", "particleCount", 0, 100)

client.settings.addAir(5)
particleTime = 10
client.settings.addInt("Time of the particles (in 0.1 sec)", "particleTime", 0, 50)

client.settings.addAir(5)
particleSpeed = 10
client.settings.addInt("Speed of the particles ", "particleSpeed", 0, 100)

local particlePos = {}

fileLib2 = importLib("renderthreeD.lua")

local time = 0

function onMouse(button, down)
    if down and button == 1 and player.facingEntity() then
        x, y, z = player.lookingPos()
        for i = 1, particleCount, 1 do
            table.insert(particlePos, {x + math.random(-10, 10)/10, y + math.random(-10, 10)/10, z + math.random(-10, 10)/10, time, math.random(-particleSpeed, particleSpeed)/10, math.random(-particleSpeed, particleSpeed)/10, math.random(-particleSpeed, particleSpeed)/10})
        end
    end
end
event.listen("MouseInput", onMouse)

function update(dt)
    time = time + dt
    for i = #particlePos, 1, -1 do
        if particlePos[i][4] < (time - (particleTime / 10)) then
            table.remove(particlePos, i)
        else
            particlePos[i][1] = particlePos[i][1] + particlePos[i][5]
            particlePos[i][2] = particlePos[i][2] + particlePos[i][6]
            particlePos[i][3] = particlePos[i][3] + particlePos[i][7]
            particlePos[i][5] = particlePos[i][5] / 2
            particlePos[i][6] = particlePos[i][6] / 2
            particlePos[i][7] = particlePos[i][7] / 2
        end
    end
end

function render3d(dt)
    if not gui.mouseGrabbed() then
        gfx.color(color.r, color.g, color.b, color.a)
        for i, value in ipairs(particlePos) do
            cube(value[1], value[2], value[3], 0.05)
        end
    end
end