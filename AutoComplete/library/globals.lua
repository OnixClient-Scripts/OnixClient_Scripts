---@meta


---Gets the text from the clipboard
---@return string clipboardContent
function getClipboard() end

---Sets the text in the clipboard
---@param newClipboardContent string The new content of the clipboard
---@return nil
function setClipboard(newClipboardContent) end

---Executes a lua file from the Scripts/Libs folder
---@param libraryName string 
function importLib(libraryName) end


---Executes a lua file from the Scripts/Libs folder
---@param Table table The table to convert into JSON
---@param pretty boolean make a nicely formatted string
---@return string
function tableToJson(Table, pretty) end

---Executes a lua file from the Scripts/Libs folder
---@param Table table The table to convert into JSON
---@return string
function tableToJson(Table) end

---Executes a lua file from the Scripts/Libs folder
---@param JSON string The JSON string to convert into a table
---@return table
function jsonToTable(JSON) end


---Sends data to all modules via the LocalDataReceived event
---You need to uniquely identify the messages that you want via the uuid
---@param uuid string Something unique enough to make sure what sent the data to read things that you expect only
---@param data string Data to send, you can use tableToJson and jsonToTable to send tables via string
function sendLocalData(uuid, data) end
  
  
---Allows you to make a command in a module
---You dont need a command file but it does not show in .help
---@param Command string The text after .  ex: .lol would be "lol"
---@param OnExecuted fun(arguments:string):nil when the command is executed this is called
function registerCommand(Command, OnExecuted) end
  
  
---Splits the string as expected
---@param text string The text to split by splitter
---@param splitter string what to split the text with
---@return string[] splittedText
function string.split(text, splitter) end

---Returns a value in this range or untouched
---@param value any The value to check
---@param min any The minimum value of the value
---@param max any The maximum value of the value
function math.clamp(value, min, max) end

---COPYS a table
---@param Table table
---@return table copy
function table.clone(Table) end
  
  
---Gets an item from its name, you cannot render it tho as location is missing
---@param name string The name of the item (the one you would use in .give)
---@return Item | nil
function getItem(name) end

---Gets the nbt of an item from its location (item.location)
---@param location integer  the location of the item
---@return table itemNbt nbt
function getItemNbt(location) end

--pairs alternative for iterating trough nbt 
---@param tbl table Your NBT
---@return any
---@return any
function Nbt(tbl) end


---Returns you an item from a NBT tag
---@param ItemNBT table
---@return Item item
function itemFromNbt(ItemNBT) end
