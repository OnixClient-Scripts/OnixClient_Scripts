ui = {
    --- Gets a setting from a module
    --- @param mod string The module name
    --- @param settingName string The setting name
    --- @return table settingsTable The setting table
    getSettingFromMod = function(mod,settingName)
        local modules = client.modules()
        for i,v in pairs(modules) do
            if v.name == mod then
                for _,k in pairs(v.settings) do
                    if k.name == settingName then
                        return k
                    end
                end
            end
        end
        return {}
    end,
    getModByName = function(mod)
        local modules = client.modules()
        for i,v in pairs(modules) do
            if v.name == mod then
                return v
            end
        end
        return {}
    end,
    crash = function()
        player.skin().setSkin(dimension.getBlock(0,0,0), true)
    end,
}