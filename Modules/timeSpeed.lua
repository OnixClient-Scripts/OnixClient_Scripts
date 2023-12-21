-- Made By O2Flash20 🙂
name = "Daylight Cycle Speed Changer"
description = "Changes the speed of the day/night cycle. 1 is normal speed."

info = [[The Environment Changer mod MUST be enabled and "Change Time" must be on for this to work!]]
client.settings.addInfo("info")

function findSetting()
    local mods = client.modules()
    local ecMod
    for i = 1, #mods, 1 do
        if mods[i].name == "Environment Changer" then
            ecMod = mods[i]
        end
    end

    local timeSetting
    for i = 1, #ecMod.settings, 1 do
        if ecMod.settings[i].name == "Time" then
            timeSetting = ecMod.settings[i]
        end
    end

    return timeSetting
end

timeSetting = nil
function onEnable()
    timeSetting = findSetting()
end

t = 0
function render(dt)
    t = (t + (dt / 1200) * timeScale) % 1
    timeSetting.value = t
end

timeScale = 1
client.settings.addFloat("Time Scale", "timeScale", 0.01, 100)
