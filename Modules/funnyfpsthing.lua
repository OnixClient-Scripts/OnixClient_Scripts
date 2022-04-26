name = "Funny fps thing"
description = "By MCBE Craft"

local lag = 0
local health = 0
local newHealth = health
local timer = 0
local clickStamp = 0

lagIntensity = 10
client.settings.addInt("Itensity of lag (the more the laggier it gets)", "lagIntensity", 0, 100)

function render(dt)
    timer = timer + dt
    newHealth = player.attributes().name("minecraft:health").value
    if newHealth < health then
        lag = lag + 1
    end
    health = newHealth
    if health == 0 then
        lag = 0
    end
    for i = 0, lag*lagIntensity*100, 1 do
        gfx.roundRect(-gui.width(), -gui.height(), gui.width(), gui.height(), lagIntensity, lagIntensity)
    end
end

event.listen("MouseInput", function(button, down)
    if button == 1 and down and player.facingEntity() and timer > clickStamp + 0.5 then
        clickStamp = timer
        if lag > 0 then
            lag = lag - 1
        end
    end
end)
