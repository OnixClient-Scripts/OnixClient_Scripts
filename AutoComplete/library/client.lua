---@meta


---@class client
---@field version string The client version
---@field mcversion string The minecraft version
client = client or {}

---Sends a client notification
---@param text string The text in the notification
---@return nil
function client.notification(text) end

---Executes a client command, do not include the prefix
---@param command string The command without the prefix
---@return nil
function client.execute(command) end




---@class Waypoint
---@field x integer The x position of the waypoint
---@field y integer The y position of the waypoint
---@field z integer The z position of the waypoint
---@field name string The name of the waypoint
---@field dimensionId integer The dimension id the waypoint is for

---@class Waypoints
local _acp__Waypoints_ = {}

---Get waypoint list
---@return Waypoint[]
function _acp__Waypoints_.get() end

---Adds a waypoint
---@param x integer The x position of the waypoint
---@param y integer The y position of the waypoint
---@param z integer The z position of the waypoint
---@param name string The name of the waypoint
function _acp__Waypoints_.add(x, y, z, name) end

---Adds a waypoint
---@param x integer The x position of the waypoint
---@param y integer The y position of the waypoint
---@param z integer The z position of the waypoint
---@param name string The name of the waypoint
---@param dimensionId integer In what dimension is it
function _acp__Waypoints_.add(x, y, z, name, dimensionId) end

---Removes a waypoint by its name
---@param name string The name of the waypoint to remove
function _acp__Waypoints_.remove(name) end

---Removes a waypoint by its position
---@param x integer The x position of the waypoint to remove
---@param y integer The y position of the waypoint to remove
---@param z integer The z position of the waypoint to remove
function _acp__Waypoints_.remove(x, y, z) end

---Saves the waypoint list to file
function _acp__Waypoints_.save() end
---Loads the waypoint list to file
function _acp__Waypoints_.load() end

---Clears all waypoints
function _acp__Waypoints_.clear() end


---@return Waypoints
function client.waypoints() end







---@class MathematicalVector2
---@field x number
---@field y number




---@class ColorSetting
---@field r number The amount of Red from a range of 0 to 1
---@field g number The amount of Green from a range of 0 to 1
---@field b number The amount of Blue from a range of 0 to 1
---@field a number The amount of Opacity from a range of 0 to 1
---@field alphaVisible boolean alphaVisible Should the opacity slider be availible
---@field rainbow boolean Is this color rainbow
---@field rainbowSpeed number The speed of the rainbow effect (default=0.003)


---@class Setting
---@field type integer [Types](http://onixclient.xyz/scripting/setting_type.html)
---@field name string The display name of the setting_type
---@field saveName string The name used to save/load this Setting, no spaces
---@field visible boolean Should show in the ui
---@field value boolean|integer|number|MathematicalVector2|ColorSetting The value of the setting
---@field default boolean|integer|number|MathematicalVector2|ColorSetting The default value of the setting
---@field min integer|number|MathematicalVector2|nil Minimum value of the setting
---@field max integer|number|MathematicalVector2|nil Maximum value of the setting







---@class Module
---@field name string The name of the module
---@field description string The description of the module
---@field isVisual boolean if the module is a VisualModule
---@field isScript boolean if the module is a ScriptingModule
---@field visible boolean if the module is visible in the clickgui
---@field enabled boolean [you can set] if the module is enabled
---@field settings Setting[] A list with all the module's settings

---@class VisualModule : Module
---@field size MathematicalVector2 The size of the module
---@field pos MathematicalVector2 The position of the module
---@field relativepos MathematicalVector2 The relative position of the module (relative from anchor position)
---@field anchor 0 = Invalid, 1 = Top Left, 2 = Top Right, 3 = Bottom Left, 4 = Bottom Right

---@class ScriptingModule : Module
---@field movable boolean If the module is movable
---@field scale number The scale of the module
---@field size MathematicalVector2 The size of the module
---@field pos MathematicalVector2 The position of the module





---Gets a list of all the modules in the client
---@return Module[] | VisualModule[] | ScriptingModule[]
function client.modules() end


