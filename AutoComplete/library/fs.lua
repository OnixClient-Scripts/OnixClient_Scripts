---@meta

---@class fs
fs = {}


---Checks if a file exist
---@param path string The path from Scripts/Data
---@return boolean
function fs.exist(path) end

---Checks if a path is a directory
---@param path string The path from Scripts/Data
---@return boolean
function fs.isdir(path) end

---Creates a directory
---@param path string The path from Scripts/Data
---@return nil
function fs.mkdir(path) end

---Deletes a file
---@param path string The path from Scripts/Data
---@return nil
function fs.delete(path) end

---Copies a file
---@param pathFrom string The path from Scripts/Data
---@param pathTo string The path from Scripts/Data
---@return nil
function fs.copy(pathFrom, pathTo) end

---Moves a file
---@param pathFrom string The path from Scripts/Data
---@param pathTo string The path from Scripts/Data
---@return nil
function fs.move(pathFrom, pathTo) end

---Give you a list of all files in a directory
---@param path string The path from Scripts/Data
---@return string[]
function fs.files(path) end

---Give you a list of all directories in a directory
---@param path string The path from Scripts/Data
---@return string[]
function fs.directories(path) end






---@class Stats
---@field size integer Size of the file in bytes
---@field readtime integer The last time the file was accessed (unix time)
---@field writetime integer The last time the file was written to (unix time)
---@field statustime integer The last time the file was accessed (unix time)


---Gets information about a file
---@path string The path from Scripts/Data
---@return Stats
function fs.stats(path) end




---@class BinaryFile
local _acp_BinaryFile = {}

---Close the file 
---@return nil
function _acp_BinaryFile:close() end

---Flushes the buffer, Makes what you wrote to it actually go to disk without closing it
---@return nil
function _acp_BinaryFile:flush() end

---If the file has reach the end of the file
---@return boolean
function _acp_BinaryFile:eof() end

---The size of the file in bytes (**not remaining bytes to read**)
---@return integer
function _acp_BinaryFile:size() end

---Goes to a position in the file
---@param position integer Where to go from the begin(0)
---@return nil
function _acp_BinaryFile:seek(position) end

---The current position in the file (ex: reading from begin + 56)
---@return integer
function _acp_BinaryFile:tell() end



---Writes content to the file, make sure not to screw up the byteCount
---@param content string What to take the bytes from
---@param byteCount how many bytes we taking
---@return nil
function _acp_BinaryFile:write(content, byteCount) end

---Writes a byte to the file
---@param Byte integer a number in the range of -128 to 127
---@return nil
function _acp_BinaryFile:writeByte(Byte) end

---Writes a short to the file
---@param Short integer a number in the range of -32768 to 35767
---@return nil
function _acp_BinaryFile:writeShort(Short) end

---Writes an int to the file
---@param Int integer a number from from -2147483648 to 2147483647
---@return nil
function _acp_BinaryFile:writeInt(Int) end

---Writes a float to the file
---@param Float number a number with decimal places
---@return nil
function _acp_BinaryFile:writeFloat(Float) end

---Writes a double to the file
---@param Double number a number with decimal places
---@return nil
function _acp_BinaryFile:writeDouble(Double) end

---Writes Text to the file
---@param Text the text to put in the file
---@return nil
function _acp_BinaryFile:writeString(Text) end





---Reads content from the file, make sure not to screw up the byteCount
---@param content string What to take the bytes from
---@param byteCount how many bytes we taking
---@return string
function _acp_BinaryFile:read(byteCount) end

---Reads a byte from the file
---@return integer Byte
function _acp_BinaryFile:readByte() end

---Reads a short from the file
---@return integer Short
function _acp_BinaryFile:readShort() end

---Reads an int from the file
---@return integer Int
function _acp_BinaryFile:readInt() end

---Reads a float from the 
---@return number Float
function _acp_BinaryFile:readFloat() end

---Reads a double from the file
---@return number Double
function _acp_BinaryFile:readDouble() end

---Reads Text from the file
---@return string Text
function _acp_BinaryFile:readString() end




---Opens a file to read/write data
---@param path string The path from Scripts/Data
---@param openmode string | "'w'" | "'r'" | "'a'" how to open the file
---@return BinaryFile file
function fs.open(path, openmode) end


