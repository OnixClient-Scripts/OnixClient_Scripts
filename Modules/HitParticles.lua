name = "Hit Particles"
description = name

particleCount = client.settings.addNamelessInt("Particle Per Hit", 1, 500, 20)
maxParticles = client.settings.addNamelessInt("Max Particles Alive", 1, 500, 60)
particleLifetime = client.settings.addNamelessFloat("Particle Lifetime", 1, 100, 50)
particleScale = client.settings.addNamelessFloat("Particle Scale", 0.002, 50, 0.4)
particleRotationScale = client.settings.addNamelessFloat("Rotation Scale", 0.002, 2, 0.25)

function update()
    bsaeHueColor = math.floor(math.random(0, 360))
end


function HSVToRGB(hue, saturation, value)
    hue = hue / 360
    saturation = saturation / 100
    value = value / 100
	if saturation == 0 then
		return value*255, value*255, value*255
	end
    hue = (hue % 1.0) / 0.166666667
        local i = math.floor(hue)
	local f = hue - i
	local p = value * (1.0 - saturation)
	local q = value * (1.0 - saturation * f)
	local t = value * (1.0 - saturation * (1.0 - f))

    if i == 0 then return math.floor(value*255), math.floor(t*255), math.floor(p*255) end
	if i ==  1 then return math.floor(q*255), math.floor(value*255),   math.floor(p*255) end
	if i ==  2 then return math.floor(p*255), math.floor(value*255),   math.floor(t*255) end
	if i ==  3 then return math.floor(p*255), math.floor(q*255), math.floor(value*255) end
	if i ==  4 then return math.floor(t*255), math.floor(p*255), math.floor(value*255) end
    return math.floor(value*255),math.floor(p*255),math.floor(q*255)
end


local particles = {}
function makeParticle(x,y,z)
    local particle = {x=x,y=y,z=z}
    particle.dx = (math.random() * 2 - 1.0)
    particle.dy = (math.random() * 2 - 1.25)
    particle.dz = (math.random() * 2 - 1.0)
    particle.vx = math.random()
    particle.vy = math.random()
    particle.vz = math.random()
    local startVal = 70 - math.random(0, 45)
    local r,g,b = HSVToRGB(bsaeHueColor, startVal, 100)
    particle.startr = r
    particle.startg = g
    particle.startb = b
    local r,g,b = HSVToRGB(bsaeHueColor, startVal + math.random(0,12), 100)
    particle.endr = r
    particle.endg = g
    particle.endb = b


    particle.life = particleLifetime.value or 20
    table.insert(particles, particle)
end


function render3d(dt)
    if dt > 10 then dt = 0 end
    local slowerdt = dt * 0.25
    
    
    local newParticles = {}
    for _, particle in pairs(particles) do
          --update particle 
        if particle.life < 0 then
            goto next_iteration
        else
            table.insert(newParticles, particle)
        end
        --particle.dy = -(particleLifetime.value - particle.life) / 8
        particle.x = particle.x + particle.dx * dt
        particle.y = particle.y + particle.dy * dt
        particle.z = particle.z + particle.dz * dt
        particle.vx = particle.vx + particle.dx * dt
        particle.vy = particle.vy + particle.dy * dt
        particle.vz = particle.vz + particle.dz * dt
        particle.dx = particle.dx > 0 and (particle.dx - slowerdt) or (particle.dx + slowerdt)
        particle.dy = (particle.dy - slowerdt)
        particle.dz = particle.dz > 0 and (particle.dz - slowerdt) or (particle.dz + slowerdt)
        particle.life = particle.life - dt*10

        local particleSuspicions = math.max(particle.life / particleLifetime.value, 0) ^ 3
        gfx.tcolor((particle.startr - particle.endr) * particleSuspicions + particle.endr, (particle.startg - particle.endg) * particleSuspicions + particle.endg, (particle.startb - particle.endb) * particleSuspicions + particle.endb, particleSuspicions * 255)

    

        gfx.pushTransformation(
            {4, particleScale.value, particleScale.value, particleScale.value},
            {3, math.sin(os.clock()) * particleRotationScale.value * particle.life, particle.vx, particle.vy, particle.vz },
            {2, particle.x, particle.y, particle.z}
        )

        gfx.tquad(      -0.2, 0.2, 0, 0.4453125, 0.5703125,
                        -0.2, -0.2, 0, 0.4453125, 0.625,
                        0.2, -0.2, 0, 0.50, 0.625,
                        0.2, 0.2, 0, 0.50, 0.5703125,
                        "textures/particle/particles", true)
        gfx.popTransformation()
        ::next_iteration::
    end
    particles = newParticles
end


event.listen("MouseInput", function(button, down)
    if player.facingEntity() == false or down == false or gui.mouseGrabbed() == true and button == 1 then return end
    local e = player.selectedEntity()
    if e.type == "player" then
        e.ppy = e.ppy - 0.6
    else
        e.ppy = e.ppy + 0.6
    end
    
    for i=1,particleCount.value do
        makeParticle(e.ppx, e.ppy, e.ppz)
        if #particles > maxParticles.value then return end
    end
end)