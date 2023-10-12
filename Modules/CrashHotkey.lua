name = "Crash Hotkey"
description = "Crashes your game on a specifified hotkey."
crashKey = client.settings.addNamelessKeybind("Crash", 0)

importLib("Utils")

event.listen("KeyboardInput", function(key, down)
    if key == crashKey.value and down then
        ui.crash()
    end
end)