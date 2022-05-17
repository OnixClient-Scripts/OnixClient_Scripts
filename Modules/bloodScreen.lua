name = "Blood screen"
description = "Darkens your screen when low on health"

function render(deltaTime)
    if player.gamemode() == 0 then
        local health = player.attributes().name("minecraft:health")
        if health.value < health.max / 2 then
            local a = 255 * (1 - (health.value / (health.max/2)))
            gfx.cimage(0, 0, gui.width(), gui.height(), "blood.png", 0, 0, 1, 1)
            gfx.cfimage(255, 255, 255, a)
        end
    end
end