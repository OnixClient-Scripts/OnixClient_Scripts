name = "Sword Block Animation"
description = "Adds the sword blocking animation. It doesn't do anything except look cool."

cancelHit = client.settings.addNamelessBool("Disallow hitting while blocking", true)

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

isBlocking = false
event.listen("MouseInput", function(button, down)
    if button == 2 then
        if down and isHoldingSword then
            modSettings.translation.x.value = -0.06
            modSettings.translation.y.value = 0.24
            modSettings.translation.z.value = -0.23

            modSettings.rotation.x.value = -72.85
            modSettings.rotation.y.value = 18.05
            modSettings.rotation.z.value = 62.23

            isBlocking = true
        else
            modSettings.translation.x.value = 0
            modSettings.translation.y.value = 0
            modSettings.translation.z.value = 0

            modSettings.rotation.x.value = 0
            modSettings.rotation.y.value = 0
            modSettings.rotation.z.value = 0

            isBlocking = false
        end
    elseif button == 1 and down and cancelHit.value and isBlocking and not gui.mouseGrabbed() then
        return true
    end
end)

isHoldingSword = false
lastThingHeld = nil
function update()
    local thingHeld
    local selectedItem = player.inventory().selectedItem()
    if selectedItem == nil then
        thingHeld = "nothing"
    else
        thingHeld = selectedItem.name
    end

    -- if you switch items, stop blocking
    if isHoldingSword and lastThingHeld ~= thingHeld then
        modSettings.translation.x.value = 0
        modSettings.translation.y.value = 0
        modSettings.translation.z.value = 0

        modSettings.rotation.x.value = 0
        modSettings.rotation.y.value = 0
        modSettings.rotation.z.value = 0

        isBlocking = false
    end

    isHoldingSword = player.inventory().selectedItem() and
        player.inventory().selectedItem().name:match("sword") == "sword"

    lastThingHeld = thingHeld
end
