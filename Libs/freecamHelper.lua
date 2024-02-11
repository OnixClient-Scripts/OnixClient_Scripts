-- Made By O2Flash20 🙂

--[[
    DOCUMENTATION

    freecam.x.value - can be set/read
    freecam.y.value - can be set/read
    freecam.z.value - can be set/read
    freecam.setPosition(x, y, z)

    freecam.pitch.value - can be set/read
    freecam.yaw.value - can be set/read
    freecam.roll.value - can be set/read
    freecam.setRotation(pitch, yaw, roll)

    freecam.isOffsetMode.value - can be set/read. If false, moving the mouse will not affect the camera's rotation. If true, freecam rotation will be added on to rotation from the mouse.

    freecam.enabled(boolean | nil) - If a boolean is passed into the function, freecam will enable (if "true") or disable (if "false"). It will always return a boolean "is freecam enabled".
]]

freecam = {}

-- these two functions are thanks to jqms
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

-----------

function onEnable()
    local creativeToolsMod = getModByInternalName("module.creative_tools.name")

    freecam["x"] =
        getSettingFromMod(creativeToolsMod, "module.creative_tools.setting.freecam_position_x.name")
    freecam["y"] =
        getSettingFromMod(creativeToolsMod, "module.creative_tools.setting.freecam_position_y.name")
    freecam["z"] =
        getSettingFromMod(creativeToolsMod, "module.creative_tools.setting.freecam_position_z.name")
    freecam["yaw"] =
        getSettingFromMod(creativeToolsMod, "module.creative_tools.setting.freecam_rotation_x.name")
    freecam["pitch"] =
        getSettingFromMod(creativeToolsMod, "module.creative_tools.setting.freecam_rotation_y.name")
    freecam["roll"] =
        getSettingFromMod(creativeToolsMod, "module.creative_tools.setting.freecam_rotation_z.name")
    freecam["isOffsetMode"] =
        getSettingFromMod(creativeToolsMod, "module.creative_tools.setting.freecam_rotation_is_offset.name")

    function freecam.enabled(enable)
        local isEnabledSetting =
            getSettingFromMod(creativeToolsMod, "module.creative_tools.setting.freecam_is_freecamming.name")

        if enable ~= nil and isEnabledSetting.value ~= enable then --toggle it
            getSettingFromMod(creativeToolsMod, "module.creative_tools.setting.freecam_wants_toggle.name").value =
                true
        end

        return isEnabledSetting.value
    end

    function freecam.setPosition(x, y, z)
        freecam.x.value = x; freecam.y.value = y; freecam.z.value = z
    end

    function freecam.setRotation(pitch, yaw, roll)
        freecam.pitch.value = pitch; freecam.yaw.value = yaw; freecam.roll.value = roll
    end
end
