---@meta

client = client or {}

---@class client.setting
client.settings = {}

---Adds a space in the UI
---@param space number Pixels of air to pad
---@return Setting setting The setting that was added
function client.settings.addAir(space) end

---Adds text in the UI, you can change the content of the variable and the UI will display the changes
---@param variableName string The name of the global variable that contains the setting value or just the text to display
---@return Setting setting The setting that was added
function client.settings.addInfo(variableName) end

---Adds larger text in the UI, you can change the content of the variable and the UI will display the changes
---@param variableName string The name of the global variable that contains the setting value or just the text to display
---@return Setting setting The setting that was added
function client.settings.addTitle(variableName) end

---Adds a toggle switch in the UI
---@param name string The name of the setting in the UI
---@param variableName string The name of the global variable that contains the setting value 
---@return Setting setting The setting that was added
function client.settings.addBool(name, variableName) end

---Adds a keybind for the user to set in the UI
---@param name string The name of the setting in the UI
---@param variableName string The name of the global variable that contains the setting value  [Keycodes](https://docs.microsoft.com/en-us/windows/win32/inputdev/virtual-key-codes)
---@return Setting setting The setting that was added
function client.settings.addKeybind(name, variableName) end

---Adds an integer slider in the UI
---@param name string The name of the setting in the UI
---@param variableName string The name of the global variable that contains the setting value 
---@param minimum integer The minimum value of this setting
---@param maximum integer The maximum value of this setting
---@return Setting setting The setting that was added
function client.settings.addInt(name, variableName, minimum, maximum) end

---Adds a float slider in the UI
---@param name string The name of the setting in the UI
---@param variableName string The name of the global variable that contains the setting value 
---@param minimum number The minimum value of this setting
---@param maximum number The maximum value of this setting
---@return Setting setting The setting that was added
function client.settings.addFloat(name, variableName, minimum, maximum) end

---Adds a color for the user to change in the UI
---The value you set is a table containing 3 or 4 number from 0 to 255
---It will be transformed into a table containing 4 numbers, r,g,b,a  ex: var.r, var.g, var.b ...
---@param name string The name of the setting in the UI
---@param variableName string The name of the global variable that contains the setting value  ex: var = {255,255,255,255}/{255,255,255} for white
---@return Setting setting The setting that was added
function client.settings.addColor(name, variableName) end

---Adds a button in the UI
---@param name string The name of the setting in the UI
---@param variableName string The name of the global variable that contains the setting value  (a function to be executed when clicked)
---@param buttonName string The text on the UI button
---@return Setting setting The setting that was added
function client.settings.addFunction(name, variableName, buttonName) end

---Adds a textbox in the UI
---@param name string The name of the setting in the UI
---@param variableName string The name of the global variable that contains the setting value
---@return Setting setting The setting that was added
function client.settings.addTextbox(name, variableName) end

---Adds a textbox in the UI with a maximum amount of letters
---@param name string The name of the setting in the UI
---@param variableName string The name of the global variable that contains the setting value
---@param maxCharacters integer The maximum amount of letters in the textbox
---@return Setting setting The setting that was added
function client.settings.addTextbox(name, variableName, maxCharacters) end

---Adds a category in the UI
---@param name string The name of the setting in the UI
---@return Setting setting The setting that was added
function client.settings.addCategory(name) end

---Adds a category in the UI with a specified amount of settings included
---@param name string The name of the setting in the UI
---@param settingCount integer The maximum amount of letters in the textbox
---@return Setting setting The setting that was added
function client.settings.addCategory(name, settingCount) end

---Ends the last added category here
function client.settings.stopCategory() end

---Adds a dropdown of values in the UI
---@param name string The name of the setting in the UI
---@param variableName string The name of the global variable that contains the setting value 
---@param enumValues table[] The values of the enum in the following format: { {1, "first"}, {7, "second"} } basically number value and a name for that number
---@return Setting setting The setting that was added
function client.settings.addEnum(name, variableName, enumValues) end

---Adds a dropdown of values in the UI
---@param name string The name of the setting in the UI
---@param defaultValue integer The default value, make sure it exists tho
---@param enumValues table[] The values of the enum in the following format: { {1, "first"}, {7, "second"} } basically number value and a name for that number
---@return Setting setting The setting that was added
function client.settings.addNamelessEnum(name, defaultValue, enumValues) end


--- https://github.com/OnixClient-Scripts/OnixClient_Scripts/blob/master/Modules/CustomSettingExample.lua
--- Adds an instance of a custom setting
---@param name string The name of this setting instance in the UI
---@param CustomSettingTypeId integer The type of this custom setting given by client.settings.registerCustomRenderer
---@param defaultValue integer Custom settings act like ints in scripting. This is the default value of this setting.
---@return Setting setting The setting that was added
function client.settings.addCustom(name, CustomSettingTypeId, defaultValue) end




---Adds a toggle switch in the UI
---@param name string The name of the setting in the UI
---@param defaultValue boolean The name of the global variable that contains the setting value 
---@return Setting setting The setting that was added
function client.settings.addNamelessBool(name, defaultValue) end

---Adds a keybind for the user to set in the UI
---@param name string The name of the setting in the UI
---@param defaultValue integer The name of the global variable that contains the setting value  [Keycodes](https://docs.microsoft.com/en-us/windows/win32/inputdev/virtual-key-codes)
---@return Setting setting The setting that was added
function client.settings.addNamelessKeybind(name, defaultValue) end

---Adds an int slider in the UI
---@param name string The name of the setting in the UI
---@param minimum integer The minimum value of this setting
---@param maximum integer The maximum value of this setting
---@param defaultValue integer The default value of the setting
---@return Setting setting The setting that was added
function client.settings.addNamelessInt(name, minimum, maximum, defaultValue) end

---Adds a float slider in the UI
---@param name string The name of the setting in the UI
---@param minimum number The minimum value of this setting
---@param maximum number The maximum value of this setting
---@param defaultValue number The default value of the setting
---@return Setting setting The setting that was added
function client.settings.addNamelessFloat(name, minimum, maximum, defaultValue) end

---Adds a color for the user to change in the UI
---@param name string The name of the setting in the UI
---@param defaultValue integer[3]|integer[4]
---@return Setting setting The setting that was added
function client.settings.addNamelessColor(name, defaultValue) end

---Adds a textbox for the user to type in the UI
---@param name string The name of the setting in the UI
---@param defaultValue string Default textbox text
---@return Setting setting The setting that was added
function client.settings.addNamelessTextbox(name, defaultValue) end

---Adds a textbox for the user to type in the UI
---@param name string The name of the setting in the UI
---@param defaultValue string Default textbox text
---@param maxCharacters integer The maximum amount of letters in the textbox
---@return Setting setting The setting that was added
function client.settings.addNamelessTextbox(name, defaultValue, maxCharacters) end


---Adds a category in the ui
---@param name string The name of this category
function client.settings.addNamelessCategory(name) end
---Adds a category in the ui
---@param name string The name of this category
---@param SettingCount integer How many settings to include in this category
function client.settings.addNamelessCategory(name, SettingCount) end


--- https://github.com/OnixClient-Scripts/OnixClient_Scripts/blob/master/Modules/CustomSettingExample.lua
--- Adds a custom renderer for custom settings
---@param getHeightCallback function|fun():number A function that returns the height of the custom setting.
---@param renderCallback function|fun(setting: Setting, width: number, height: number, mouseX: number, mouseY: number, didClick: boolean, mouseButton: integer, lmbDown: boolean, rmbDown: boolean, mouseInside: boolean) A function that renders the custom setting.
---@return integer CustomSettingTypeId The type id of the custom setting. This is used in client.settings.addCustom to create an instance.
function client.settings.registerCustomRenderer(getHeightCallback, renderCallback) end

--- https://github.com/OnixClient-Scripts/OnixClient_Scripts/blob/master/Modules/CustomSettingExample.lua
--- Replaces a renderer for a setting, custom setting types might change for the client but non custom ones should remain the same.
---@param SettingType integer The type of the setting to replace, you can replace client setting types using this.
---@param getHeightCallback function|fun():number A function that returns the height of the custom setting.
---@param renderCallback function|fun(setting: Setting, width: number, height: number, mouseX: number, mouseY: number, didClick: boolean, mouseButton: integer, lmbDown: boolean, rmbDown: boolean, mouseInside: boolean) A function that renders the custom setting.
---@return integer CustomSettingTypeId The type id of the custom setting. This is used in client.settings.addCustom to create an instance.
function client.settings.registerCustomRendererOverride(SettingType, getHeightCallback, renderCallback) end




---Sends setting value from the script to the client and maybe only the invisible settings
---If you change one of the settings yourself it may not apply, this will make it apply
---@param invisbleSettingsOnly boolean The name of the setting in the UI
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
