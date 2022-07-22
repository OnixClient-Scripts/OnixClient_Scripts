---@meta


---@class event
event = {}


---Binds an event to a function
---@param eventName string | '"KeyboardInput", function(key, down)\n\t\nend' | '"MouseInput", function(button, down)\n\t\nend' | '"ChatMessageAdded", function(message, username, type, xuid)\n\t\nend' | '"LocalDataReceived", function(uuid, content)\n\t\nend' | '"ConfigurationSaved", function()\n\tlocal data = {}\n\t\n\treturn data\nend' | '"ConfigurationLoaded", function(data)\n\t\nend' | '"LocalServerUpdate", function()\n\t\nend' Name of the event to listen to
---@param handler function Function that will handle the event
---@return nil
function event.listen(eventName, handler) end

