-- This script was originally written in TypeScript.
name = "Scripting UI"
description = "Regular Onix Client UI, but with only scripts shown."
openKey = client.settings.addNamelessKeybind("Scripting Key", 0)
instantlyOpenGUI = client.settings.addNamelessBool("Instantly Open Module Editor", false)
function toggleScriptsOn(self)
    local modules = client.modules()
    do
        local i = 0
        while i < #modules do
            if not modules[i + 1].isScript then
                modules[i + 1].settings[1].parent.visible = false
            end
            if modules[i + 1].name == "Global Settings" or modules[i + 1].name == "Color Options" then
                modules[i + 1].settings[1].parent.visible = true
            end
            i = i + 1
        end
    end
    if not instantlyOpenGUI.value then
        gui.showScreen("HudEditor")
    end
    if instantlyOpenGUI.value then
        gui.showScreen("ModuleEditor")
    end
end
function toggleScriptsOff(self)
    local modules = client.modules()
    do
        local i = 0
        while i < #modules do
            if not modules[i + 1].isScript then
                modules[i + 1].settings[1].parent.visible = true
            end
            i = i + 1
        end
    end
end
event.listen(
    "KeyboardInput",
    function(key, state)
        if key == openKey.value and state == true then
            toggleScriptsOn(nil)
        else
            toggleScriptsOff(nil)
        end
        if key == 9 and state == true then
            toggleScriptsOff(nil)
        end
    end
)
