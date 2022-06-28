
local DependentSettings_Dependency = {}
local DependentSettings_CurrentModuleRef = nil

function client.settings.addDependentBool(visualName, luaVariableName, luaDependencyName)
    client.settings.addBool(visualName, luaVariableName)
    DependentSettings_Dependency[luaVariableName] = luaDependencyName
end
function client.settings.addDependentFloat(visualName, luaVariableName, luaDependencyName, minimum, maximum)
    client.settings.addFloat(visualName, luaVariableName, minimum, maximum)
    DependentSettings_Dependency[luaVariableName] = luaDependencyName
end
function client.settings.addDependentInt(visualName, luaVariableName, luaDependencyName, minimum, maximum)
    client.settings.addInt(visualName, luaVariableName, minimum, maximum)
    DependentSettings_Dependency[luaVariableName] = luaDependencyName
end
function client.settings.addDependentKeybind(visualName, luaVariableName, luaDependencyName)
    client.settings.addKeybind(visualName, luaVariableName)
    DependentSettings_Dependency[luaVariableName] = luaDependencyName
end
function client.settings.addDependentColor(visualName, luaVariableName, luaDependencyName)
    client.settings.addColor(visualName, luaVariableName)
    DependentSettings_Dependency[luaVariableName] = luaDependencyName
end
function client.settings.addDependentFunction(visualName, luaVariableName, buttonName, luaDependencyName)
    client.settings.addFunction(visualName, luaVariableName, buttonName)
    DependentSettings_Dependency[luaVariableName] = luaDependencyName
end
function client.settings.addDependentInfo(luaVariableName, luaDependencyName)
    client.settings.addInfo(luaVariableName)
    DependentSettings_Dependency[luaVariableName] = luaDependencyName
end





function client.settings.updateDependencies()
    if DependentSettings_CurrentModuleRef == nil then
        local mods = client.modules()
        for _, mod in pairs(mods) do
            if mod.name == name then
                DependentSettings_CurrentModuleRef = mod
                break
            end
        end  
        if DependentSettings_CurrentModuleRef == nil then error("[DependentBoolean] Could not find self module!") return end
    end
    
    local function getSetting(settingName)
        for _, setting in pairs(DependentSettings_CurrentModuleRef.settings) do
            if setting.saveName == settingName then
                return setting
            end
        end
    end

    for nsetting, ndependency in pairs(DependentSettings_Dependency) do
        local setting = getSetting(nsetting)
        local dependency = getSetting(ndependency)
        if dependency == nil  then
            error("[DependentBoolean] " .. ndependency .. " could not be found!")
            goto next_setting
        end
        if setting == nil  then
            error("[DependentBoolean] " .. nsetting .. " could not be found!")
            goto next_setting
        end
        if dependency.type ~= 1 then
            error("[DependentBoolean] " .. dependency.visualName .. " (" .. dependency.saveName .. ")  is not a boolean setting")
            goto next_setting
        end
        setting.invisible = dependency.value
        ::next_setting::
    end

end