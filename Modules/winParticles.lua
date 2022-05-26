name = "Win Particles"
description = "Server win particles"

local initlog = io.open("Chatlog.txt", 'w')
io.close(initlog)

function onChat(message, username, type)
    if message == "§a§aCongratulations, you win!§r" then
        startParticles()
    end
    if string.find(message, "§b§l» §r§aYou survived!") or string.find(message, "are the WINNERS!") or string.find(message, "is the WINNER!") then
        startParticles()
    end
end

event.listen("ChatMessageAdded", onChat)


function startParticles()
    particles = true

    addEmitter(1, 350, 500)
    addEmitter(630, 350, 500)

    doemit = true
end

client.settings.addFunction("Particle Test", "startParticles", "Enter")
function stopEmitter()
    doemit = false
end

function endParticles()
    i = 0
    particles = false
    emitters = {}
end

color = { 255, 0, 0, 255 }
client.settings.addColor("Particle Color", "color")

i = 0
particles = false
doemit = false
function render(deltaTime)
    if particles then
        gfx.color(color.r, color.g, color.b)
        -- EDGE EMITTERS
        i = i + 1
        if i == 1500 then -- MAKE AN INPUT
            endParticles()
        end
        if i == 1000 then -- MAKE AN INPUT
            stopEmitter()
        end

        if doemit then
            emit(emitters[1])
            emit(emitters[2])
        end

        if #emitters > 0 then
            applyForceParticle(emitters[1][4][#emitters[1][4]], math.random(-1, 1) / 10 + 1.5, math.random(-1, 1) / 10 - 2.5)
            applyForceParticle(emitters[2][4][#emitters[2][4]], math.random(-1, 1) / 10 - 1.5, math.random(-1, 1) / 10 - 2.5)

            for i = 1, #emitters[1][4], 1 do
                applyForceParticle(emitters[1][4][i], 0, 0.01)
            end
            for i = 1, #emitters[2][4], 1 do
                applyForceParticle(emitters[2][4][i], 0, 0.01)
            end

            if i > emitters[1][5] then
                table.remove(emitters[1][4], 1)
            end
            if i > emitters[2][5] then
                table.remove(emitters[2][4], 1)
            end
        end

        if #emitters > 0 then
            updateEmitter(emitters[1])
            showEmitter(emitters[1])
            updateEmitter(emitters[2])
            showEmitter(emitters[2])
        end

        -- FIREWORKS
        -- addEmitter(100, 100, 500)
        -- if math.random(1, 200) == 1 then
        --     emit(emitters[3])
        --     print(emitters[3][4][#emitters][1][1])
        --     emitters[3][4][#emitters][1] = {math.random(630), math.random(350)}
        --     applyForceParticle(emitters[3][4][#emitters], 1, -1)
        -- end
        -- updateEmitter(emitters[3])
        -- showEmitter(emitters[3])
    end
end

-- PARTICLE STUFF
-- Emitter = {{x, y}, {velX, velY}, {accX, accY}, {particles}, lifetime}
-- Particle = {{x, y}, {velX, velY}, {accX, accY}}
emitters = {}
function addEmitter(x, y, lifetime)
    table.insert(emitters, { { x, y }, { 0, 0 }, { 0, 0 }, {}, lifetime })
end

function emit(emitter)
    table.insert(emitter[4], { { emitter[1][1], emitter[1][2] }, { emitter[2][1], emitter[2][2] }, { 0, 0 } })
end

function applyForceEmitter(emitter, x, y)
    emitter[3] = { x, y }
end

function updateEmitter(emitter)
    for i = 1, #emitter[4], 1 do
        updateParticle(emitter[4][i])
    end

    emitter[2][1] = emitter[2][1] + emitter[3][1]
    emitter[2][2] = emitter[2][2] + emitter[3][2]

    emitter[1][1] = emitter[1][1] + emitter[2][1]
    emitter[1][2] = emitter[1][2] + emitter[2][2]

    emitter[3] = { 0, 0 }
end

function showEmitter(emitter)
    for i = 1, #emitter[4], 1 do
        showParticle(emitter[4][i])
    end
end

function applyForceParticle(particle, x, y)
    particle[3] = { particle[3][1] + x, particle[3][2] + y }
end

function updateParticle(particle)
    particle[2][1] = particle[2][1] + particle[3][1]
    particle[2][2] = particle[2][2] + particle[3][2]

    particle[1][1] = particle[1][1] + particle[2][1]
    particle[1][2] = particle[1][2] + particle[2][2]

    particle[3] = { 0, 0 }
end

function showParticle(particle)
    gfx.rect(particle[1][1], particle[1][2], 3, 3)
end
