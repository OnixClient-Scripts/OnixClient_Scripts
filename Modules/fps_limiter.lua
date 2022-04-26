name = "FPS Limiter"
description = "Limit your game's fps"

--[[
    FPS Limiter Module Script
	
	made by Quoty0
]]

fps = 60

client.settings.addInt("FPS", "fps", 1, 1000)

client.settings.addAir(3)
message1 = "§l§cWARNING"
client.settings.addInfo("message1")
message2 = "It might not be accurate."
client.settings.addInfo("message2")

function render(deltaTime)
    sleep(870 / fps)
end

function sleep(ms)
    local time = os.clock()
    local ms = ms / 1000
    while os.clock() - time <= ms do
    end
end