---@meta

---@class fs
fs = {}


---Checks if a file exist
---@param path string The path from Scripts/Data
---@return boolean exists If the file exists
function fs.exist(path) end

---Opens a folder in explorer
---@param path string The path from Scripts/Data to open
---@return boolean showed If the folder was showed
function fs.showFolder(path) end

---Checks if a path is a directory
---@param path string The path from Scripts/Data
---@return boolean isDirectory If the path is a directory
function fs.isdir(path) end

---Creates a directory
---@param path string The path from Scripts/Data
function fs.mkdir(path) end

---Deletes a file
---@param path string The path from Scripts/Data
function fs.delete(path) end

---Copies a file
---@param pathFrom string The source path from Scripts/Data
---@param pathTo string The destination path from Scripts/Data
function fs.copy(pathFrom, pathTo) end

---Moves a file
---@param pathFrom string The source path from Scripts/Data
---@param pathTo string The destination path from Scripts/Data
function fs.move(pathFrom, pathTo) end

---Renames a file
---@param pathFrom string The source path from Scripts/Data
---@param pathTo string The destination path from Scripts/Data
function fs.rename(pathFrom, pathTo) end

---Give you a list of all files in a directory
---@param path string The path from Scripts/Data
---@return string[] files The filepath o every file in the directory
function fs.files(path) end

---Give you a list of all directories in a directory
---@param path string The path from Scripts/Data
---@return string[] directories The filepath o every directory in the directory
function fs.directories(path) end






---@class Stats
---@field size integer Size of the file in bytes
---@field readtime integer The last time the file was accessed (unix time)
---@field writetime integer The last time the file was written to (unix time)
---@field statustime integer The last time the file was accessed (unix time)


---Gets information about a file
---@path string The path from Scripts/Data
---@return Stats stats The file informtion
function fs.stats(path) end




---@class BinaryFile
local _acp_BinaryFile = {}

---Close the file (when you are done with it please close thx)
function _acp_BinaryFile:close() end

---Flushes the written content to the file, Makes what you wrote to it actually go to disk without closing it
function _acp_BinaryFile:flush() end

---If the file has reach the end of the file
---@return boolean eof Is is the end of the file
function _acp_BinaryFile:eof() end

---The size of the file in bytes (**not remaining bytes to read**)
---@return integer fileSize The size of the file
function _acp_BinaryFile:size() end

---Goes to a position in the file
---@param position integer Where to go from the file start(0)
function _acp_BinaryFile:seek(position) end

---The current position in the file (ex: reading from start + 56)
---@return integer filepos Position in the file
function _acp_BinaryFile:tell() end



---Writes content to the file, make sure not to screw up the byteCount
---@param content string What to take the bytes from
---@param byteCount integer how many bytes we taking from your string
function _acp_BinaryFile:write(content, byteCount) end

---Writes a byte to the file
---@param Byte integer a number in the range of -128 to 127
function _acp_BinaryFile:writeByte(Byte) end

---Writes a short to the file
---@param Short integer a number in the range of -32768 to 35767
function _acp_BinaryFile:writeShort(Short) end

---Writes an int to the file
---@param Int integer a number from from -2147483648 to 2147483647
function _acp_BinaryFile:writeInt(Int) end

---Writes a byte to the file
---@param Byte integer a number in the range of -0 to 255
function _acp_BinaryFile:writeUByte(Byte) end

---Writes a short to the file
---@param Short integer a number in the range of 0 to 65535
function _acp_BinaryFile:writeUShort(Short) end

---Writes an int to the file
---@param Int integer a number from from 0 to 4294967295
function _acp_BinaryFile:writeUInt(Int) end

---Writes a long to the file
---@param Long integer a number from from -9,223,372,036,854,775,808 to 9,223,372,036,854,775,807
function _acp_BinaryFile:writeLong(Long) end

---Writes a float to the file
---@param Float number a number with decimal places
---@return nil
function _acp_BinaryFile:writeFloat(Float) end

---Writes a double to the file
---@param Double number a number with decimal 
function _acp_BinaryFile:writeDouble(Double) end

---Writes Text to the file
---@param Text string the text to put in the file
function _acp_BinaryFile:writeString(Text) end

---Writes Data to the file
---@param Data userdata the data to put in the file
function _acp_BinaryFile:writeRaw(Data) end





---Reads content from the file, make sure not to fail on the byteCount
---@param byteCount integer how many bytes we taking from the file
---@return string content What was read
function _acp_BinaryFile:read(byteCount) end

---Reads a byte from the file
---@return integer Byte The byte that was read
function _acp_BinaryFile:readByte() end

---Reads a short from the file
---@return integer Short The short that was read
function _acp_BinaryFile:readShort() end

---Reads an int from the file
---@return integer Int The int that was read
function _acp_BinaryFile:readInt() end

---Reads a byte from the file
---@return integer Byte The unsigned byte that was read
function _acp_BinaryFile:readUByte() end

---Reads a short from the file
---@return integer Short The unsigned short that was read
function _acp_BinaryFile:readUShort() end

---Reads an int from the file
---@return integer Int The unsigned int that was read
function _acp_BinaryFile:readUInt() end

---Reads a long from the file
---@return integer Long The long that was read
function _acp_BinaryFile:readLong() end

---Reads a float from the file
---@return number Float The float that was read
function _acp_BinaryFile:readFloat() end

---Reads a double from the file
---@return number Double The double that was read
function _acp_BinaryFile:readDouble() end

---Reads Text from the file
---@return string Text The text that was read
function _acp_BinaryFile:readString() end

---Reads Data from the file
---@return userdata Data The data that was read
function _acp_BinaryFile:readRaw() end



---Opens a file to read/write data
---@param path string The path from Scripts/Data
---@param openmode string | "'w'" | "'r'" | "'a'" how to open the file, w is write mode, r is read mode, a is append(and it will add to an existing file or start)
---@return BinaryFile|nil file The (hopefully) opened file
function fs.open(path, openmode) end


