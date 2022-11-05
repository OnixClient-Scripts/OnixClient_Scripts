---@meta

client = client or {}

---@class Client_Settings
client.settings = {}


---Adds a space in the ui
---@param Space number Pixels of air to pad
---@return Setting
function client.settings.addAir(Space) end

---Adds text in the ui, you can change the content of the variable and the ui will display the changes
---@param variableName string The name of the global variable holding the default value
---@return Setting
function client.settings.addInfo(variableName) end


---Adds text in the ui, you can change the content of the variable and the ui will display the changes
---@param variableName string The name of the global variable holding the default value
---@return Setting
function client.settings.addTitle(variableName) end


---Adds a toggle switch in the ui
---@param name string The name of the setting in the ui
---@param variableName string The name of the global variable holding the default value
---@return Setting
function client.settings.addBool(name, variableName) end

---Adds a keybind for the user to set in the ui
---@param name string The name of the setting in the ui
---@param variableName string The name of the global variable holding the default value [Keycodes](https://docs.microsoft.com/en-us/windows/win32/inputdev/virtual-key-codes)
---@return Setting
function client.settings.addKeybind(name, variableName) end

---Adds a slider in the ui
---@param name string The name of the setting in the ui
---@param variableName string The name of the global variable holding the default value
---@param minimum integer The minimum value of this setting
---@param maximum integer The maximum value of this setting
---@return Setting
function client.settings.addInt(name, variableName, minimum, maximum) end

---Adds a slider in the ui
---@param name string The name of the setting in the ui
---@param variableName string The name of the global variable holding the default value
---@param minimum number The minimum value of this setting
---@param maximum number The maximum value of this setting
---@return Setting
function client.settings.addFloat(name, variableName, minimum, maximum) end

---Adds a color for the user to change in the ui
---@param name string The name of the setting in the ui
---@param variableName string The name of the global variable holding the default value ex: var = {255,255,255,255}/{255,255,255} for white
---@return Setting
function client.settings.addColor(name, variableName) end

---Adds a button in the ui
---@param name string The name of the setting in the ui
---@param variableName string The name of the global variable holding the default value (a function)
---@param buttonName string The text on the ui button
---@return Setting
function client.settings.addFunction(name, variableName, buttonName) end





---Adds a toggle switch in the ui
---@param name string The name of the setting in the ui
---@param defaultValue boolean The name of the global variable holding the default value
---@return Setting
function client.settings.addNamelessBool(name, defaultValue) end

---Adds a keybind for the user to set in the ui
---@param name string The name of the setting in the ui
---@param defaultValue integer The name of the global variable holding the default value [Keycodes](https://docs.microsoft.com/en-us/windows/win32/inputdev/virtual-key-codes)
---@return Setting
function client.settings.addNamelessKeybind(name, defaultValue) end

---Adds a slider in the ui
---@param name string The name of the setting in the ui
---@param minimum integer The minimum value of this setting
---@param maximum integer The maximum value of this setting
---@param defaultValue integer The default value of the setting
---@return Setting
function client.settings.addNamelessInt(name, minimum, maximum, defaultValue) end

---Adds a slider in the ui
---@param name string The name of the setting in the ui
---@param minimum number The minimum value of this setting
---@param maximum number The maximum value of this setting
---@param defaultValue number The default value of the setting
---@return Setting
function client.settings.addNamelessFloat(name, minimum, maximum, defaultValue) end

---Adds a color for the user to change in the ui
---@param name string The name of the setting in the ui
---@param defaultValue integer[3]|integer[4]
---@return Setting
function client.settings.addNamelessColor(name, defaultValue) end



---Sends setting value from the script to the client
---If you change one of the settings yourself it may not apply, this will make it apply
---@param invisbleSettingsOnly boolean The name of the setting in the ui
---@return nil
function client.settings.send(invisbleSettingsOnly) end

---Sends setting value from the script to the client
---If you change one of the settings yourself it may not apply, this will make it apply
---@return nil
function client.settings.send() end


---Gets the latest settings from the client
---Close to useless
---@return nil
function client.settings.reload() end


