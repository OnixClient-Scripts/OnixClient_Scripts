name = "Left Hand"
description = "Moves the left hand to the left side of the screen."

function getModByInternalName(name)
    for _, mod in pairs(client.modules()) do
        if mod.saveName == name then
            return mod
        end
    end
end

function getSettingFromMod(mod, saveName)
    for _, setting in pairs(mod.settings) do
        if setting.saveName == saveName then
            return setting
        end
    end
end

function postInit()
    mod = getModByInternalName("module.view_model.name")

    modSettings = {
        translation = {
            x = getSettingFromMod(mod, "module.view_model.setting.translation_x.name"),
            y = getSettingFromMod(mod, "module.view_model.setting.translation_y.name"),
            z = getSettingFromMod(mod, "module.view_model.setting.translation_z.name"),
        },
        rotation = {
            x = getSettingFromMod(mod, "module.view_model.setting.rotation_x.name"),
            y = getSettingFromMod(mod, "module.view_model.setting.rotation_y.name"),
            z = getSettingFromMod(mod, "module.view_model.setting.rotation_z.name"),
        },
        scale = {
            x = getSettingFromMod(mod, "module.view_model.setting.scale_x.name"),
            y = getSettingFromMod(mod, "module.view_model.setting.scale_y.name"),
            z = getSettingFromMod(mod, "module.view_model.setting.scale_z.name"),
        }
    }
end

function onEnable(dt)
    mod.enabled = true
    modSettings.scale.x.value = -1
end

function onDisable()
    modSettings.scale.x.value = 1
end