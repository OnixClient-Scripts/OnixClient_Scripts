name = "Double Click Prevent Disabler"
description = "Disables Double Click Prevent when not on Zeqa or CubeCraft."

importLib("Utils")

function update()
    dcPrevMod = ui.getModByName("Double Click Prevent")
    dcPrevMod.enabled = (server.ipConnected():find("zeqa") or server.ipConnected():find("cubecraft")) and true
end