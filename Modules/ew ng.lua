name = "ew ng"
description = "firetruck you ng"

--[[
    firetruck you ng
    -rice

    also made by rice
]]

local ip = server.ip()

function render(deltaTime)
	if ip == ("play.nethergames.org") then
            gfx.color (255,255,255,255)
            gfx.text (0, 26, "because ng has stupid rules,\nyou can no longer use onix client on this server\n\nyou can press Ctrl + L to remove the client,\nor play a different server", 2)
            gfx.color(0,0,0,255)
            gfx.rect(0, 0, gui.width(), gui.height())
    end
end
