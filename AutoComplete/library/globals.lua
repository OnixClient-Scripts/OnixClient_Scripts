---@meta


---Gets the text from the clipboard
---@return string clipboardContent The text om the clipboard
function getClipboard() end

---Sets the text in the clipboard
---@param newClipboardContent string The new content of the clipboard
function setClipboard(newClipboardContent) end

---Executes a lua file from the Scripts/Libs folder
---@param libraryName string The name of the file in the libs folder (with or without the .lua)
function importLib(libraryName) end


---Converts a lua table to a json string possibly pretty
---@param Table table The table to convert into JSON
---@param pretty boolean make a nicely formatted string
---@return string jsonStr The json string converted from the table
function tableToJson(Table, pretty) end

---Converts a lua table to a json string
---@param Table table The table to convert into JSON
---@return string jsonStr The json string converted from the table
function tableToJson(Table) end

---Converts a json string to a lua table for easier parsing
---@param JSON string The JSON string to convert into a table
---@return table jsonTable The lua table made from the json string
function jsonToTable(JSON) end

---Puts json into a file
---@param FilePath string The file path to save to
---@param JSON string The JSON string to convert into a table
---@return boolean saved if it was saved to the file or not
function jsonToFile(FilePath, JSON) end

---Puts json into a file
---@param FilePath string The file path to save to
---@param JSON string The JSON string to convert into a table
---@param pretty boolean make a nicely formatted string
---@return boolean saved if it was saved to the file or not
function jsonToFile(FilePath, JSON, pretty) end

---Puts json into a file
---@param FilePath string The file path to save to
---@param JSON string The JSON string to convert into a table
---@param pretty boolean make a nicely formatted string
---@param compressionType string|"lzma"|"deflate"|"bzip2"|"store"|"none" The compression type to use
---@param compressionLevel integer|0|1|2|3|4|5|6|7|8|9 The compression level to use 1 to 9
---@return boolean saved if it was saved to the file or not
function jsonToFile(FilePath, JSON, pretty, compressionType, compressionLevel) end

---Reads json from a file
---@param FilePath string The file path to read from
---@return string|nil jsonStr The json string read from the file
function jsonFromFile(FilePath) end

---Reads json from a file with potential compression
---@param FilePath string The file path to read from
---@param isCompressed boolean If the file is compressed or not
---@return string|nil jsonStr The json string read from the file
function jsonFromFile(FilePath, isCompressed) end

---Sends data to all modules via the LocalDataReceived event
---You should uniquely identify the messages that you want via the uuid parameter
---It can be any string you want unique enough to uniquely identify the data origin
---@param uuid string Something unique enough to make sure what sent the data to read things that you expect only
---@param data string Data to send, you can use tableToJson and jsonToTable to send tables via string
function sendLocalData(uuid, data) end
  
  
---Allows you to make a command in a module
---You dont need a command file but it does not show in .help
---@param Command string The text after .  ex: .lol would be "lol"
---@param OnExecuted fun(arguments:string):nil Function to execute when the command is executed, same as the command files
---@param OnIntellisense fun(intellisense:IntellisenseHelper):nil Function to execute when the command is being typed in the chat for autocomplete
---@param description string? The description of the command
function registerCommand(Command, OnExecuted, OnIntellisense, description) end

---Registers a new command combining the intellisense part with the execute part
---If you dont care about having intellisense just use registerCommand 
---@param name string The command to be registered, what the user will execute
---@param callback fun(intellisense:IntellisenseHelper, isExecuted:boolean):nil The function to be called when the command is executed or asked about intellisense
---@param description string? The description of the command
function registerCombinedCommand(name, callback, description) end
  
  
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
---@param ItemNBT table The nbt tag
---@return Item item
function itemFromNbt(ItemNBT) end


---Returns the translated message/text (for minecraft)
---@param translationKey string The key to translate (you can check in vanilla text files ex: gui.yes)
---@return string translated The translated string or the translation key
function getTranslatedMessage(translationKey) end
---Returns the translated message/text (for minecraft) with params
---@param translationKey string The key to translate (you can check in vanilla text files ex: gui.yes)
---@param params string[] The params the key takes (like a name or number things like that)
---@return string translated The translated string or the translation key
function getTranslatedMessage(translationKey, params) end


---Plays a sound file
---@param path string The path to the audio file
function playCustomSound(path) end
