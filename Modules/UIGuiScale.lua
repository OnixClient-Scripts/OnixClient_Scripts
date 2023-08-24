name = "UI Gui Scale"
description = "Allows you to change the GUI scale of the client UI, separated from the game GUI scale."

importLib("Utils")
GUIScaleMod = ui.getSettingFromMod("GUI Scale Changer", "GuiScale")

function render3d()
    if gui.screen() == "hud_screen" and gui.mouseGrabbed() then
        GUIScaleMod.value = 3
    else
        GUIScaleMod.value = 2
    end
end