name = "Click Limiter"
description = "Limits your CPS to user defined values."

client.settings.addAir(5)
client.settings.addCategory("CPS Limiter")
cpsLimitLeft = client.settings.addNamelessInt("Left Click CPS Limit", 0, 50, 15)
cpsLimitRight = client.settings.addNamelessInt("Right Click CPS Limit", 0, 50, 25)

lastClickLeft = 0
lastClickRight = 0

event.listen("MouseInput", function(button, down)
    if down and button == 1 then
        if os.clock() - lastClickLeft < 1 / (cpsLimitLeft.value + 1) then
            return true
        end
        lastClickLeft = os.clock()
    end

    if down and button == 2 then
        if os.clock() - lastClickRight < 1 / (cpsLimitRight.value + 1) then
            return true
        end
        lastClickRight = os.clock()
    end
end)