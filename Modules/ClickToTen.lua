name = "Click To Ten"
description = "Click to ten and then crash."

function crash()
    player.skin().setSkin(player.inventory())
end

clickcount = 0

event.listen("MouseInput", function(button, down)
    if button == 1 and down then
        clickcount = clickcount + 1
        if clickcount == 10 then
            crash()
        end
        return true
    end
end)

function render2()
    gfx2.color(86,86,86,255)
    gfx2.fillRect(0,0,gfx2.width(), gfx2.height())
    guiWidth = gfx2.width() / 2
    guiHeight = gfx2.height() / 2
    gfx2.color(255,255,255,255)
    textSize = gfx2.textSize("Click To Ten", 4)
    gfx2.text(guiWidth - textSize / 2, (guiHeight / 2)-40, "Click To Ten", 4)
    textSize2 = gfx2.textSize("Clicks: " .. clickcount, 2)
    gfx2.text(guiWidth - textSize2 / 2, (guiHeight / 2)+100, "Clicks: " .. clickcount, 2)
end