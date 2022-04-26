name = "Funny fps thing"
description = "By MCBE Craft"

--[[
By MCBE Craft
credits to Quoty0 for alternate lagging method
]]--

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
        gui.sound("")
    end
    health = newHealth
    if health == 0 then
        lag = 0
    end
    local time = os.clock()
    while os.clock() - time <= lag * lagIntensity / 1000 do
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
