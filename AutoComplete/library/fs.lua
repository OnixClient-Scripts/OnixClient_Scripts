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

---Hashes a file using md5.
---@param path string The path from Scripts/Data
---@return string|nil hash The file md5 hash or nil if the file does not exist
function fs.hash(path) end

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
---@return string[] files The filepath of every file in the directory
function fs.files(path) end

---Give you a list of all directories in a directory
---@param path string The path from Scripts/Data
---@return string[] directories The filepath of every directory in the directory
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

---The amount of bytes availible forward from the current position
---@return integer availible The size of the availible bytes forward from the current position
function _acp_BinaryFile:availible() end

---Goes to a position in the file
---@param position integer Where to go from the file start(0)
function _acp_BinaryFile:seek(position) end

---The current position in the file (ex: reading from start + 56)
---@return integer filepos Position in the file
function _acp_BinaryFile:tell() end

---Tells you if the current mode is little endian, x86 cpus are little endian and so its the default here too. Its included because some web/file formats require big endian.
---Endianness is how multi-bytes numbers are read, for example 0x12345678 is 305419896 in decimal, in little endian it would be read as 0x78563412 and in big endian it would be read as 0x12345678
---@return boolean isLittleEndian Position in the file
function _acp_BinaryFile:isLittleEndian() end

---Sets the endianness of the file
---Endianness is how multi-bytes numbers are read, for example 0x12345678 is 305419896 in decimal, in little endian it would be read as 0x78563412 and in big endian it would be read as 0x12345678
---@param isLittleEndian boolean If the file should be treated as is little endian
function _acp_BinaryFile:setLittleEndian(isLittleEndian) end



---Writes content to the file, make sure not to screw up the byteCount
---@param content string What to take the bytes from
---@param byteCount integer how many bytes we taking from your string
function _acp_BinaryFile:write(content, byteCount) end

---Writes content to the file
---@param content string What to take the bytes from, will take everything
function _acp_BinaryFile:write(content) end

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

---Writes an unsinged long to the file
---@param Long integer a number from from 0 to 18,446,744,073,709,551,615
function _acp_BinaryFile:writeULong(Long) end

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

---Writes text to the file (max 65535 characters)
---@param Text string the text to put in the file
function _acp_BinaryFile:writeString(Text) end

---Writes text to the file (max 4294967295 characters)
---@param Text string the text to put in the file
function _acp_BinaryFile:writeBigString(Text) end

---Writes text to the file and includes the null character at the end
---@param Text string the text to put in the file
function _acp_BinaryFile:writeUtf8StringWithNull(Text) end

---Writes text to the file and includes the null character at the end
---Note: This is affected by the current endianness (:setLittleEndian)
---@param Text string the text to put in the file
function _acp_BinaryFile:writeUtf16StringWithNull(Text) end

---Writes Data to the file
---@param Data userdata the data to put in the file
function _acp_BinaryFile:writeRaw(Data) end

---Writes an entire stream to the file
---@param Stream BinaryFile the data to put in the file
function _acp_BinaryFile:writeStream(Stream) end

---Writes part of a stream to the file
---If the stream you write is compressed it will write the compressed data to this stream you can use :readRaw or :writeRaw to not compress it
---@param Stream BinaryFile the data to put in the file
---@param Begin integer|nil Where to start reading from the stream, nil will be 0 you can use :tell() to get the current position
---@param End integer|nil Where to stop reading from the stream, nil will be the end of the stream
function _acp_BinaryFile:writeStream(Stream, Begin, End) end

---Writes an image inside a file
---@param Image Gfx2Texture the image to put in the file
function _acp_BinaryFile:writeImage(Image) end

---Writes an image inside a file potentially jpg
---@param Image Gfx2Texture the image to put in the file
---@param isJpg boolean|nil If the image should be written as a jpg, if nil or false it will be written as a png
function _acp_BinaryFile:writeImage(Image, isJpg) end

---Writes an image inside a file with jpg quality
---@param Image Gfx2Texture the image to put in the file
---@param isJpg boolean|nil If the image should be written as a jpg, if nil or false it will be written as a png
---@param jpgQuality integer|nil The quality of the jpg, 1 is the worst quality and 100 is the best quality
function _acp_BinaryFile:writeImage(Image, isJpg, jpgQuality) end







---Reads content from the file, make sure not to fail on the byteCount
---@param byteCount integer how many bytes we taking from the file
---@return string content What was read
function _acp_BinaryFile:read(byteCount) end

---Reads all content from the file
---@return string content What was read
function _acp_BinaryFile:read() end

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

---Reads a long from the file
---@return integer Long The long that was read
function _acp_BinaryFile:readULong() end

---Reads a float from the file
---@return number Float The float that was read
function _acp_BinaryFile:readFloat() end

---Reads a double from the file
---@return number Double The double that was read
function _acp_BinaryFile:readDouble() end

---Reads text from the file (max 65535 characters)
---@return string Text The text that was read
function _acp_BinaryFile:readString() end

---Reads text from the file (max 4294967295 characters)
---@return string Text The text that was read
function _acp_BinaryFile:readBigString() end

---Reads text from the file until a null character is found (0)
---@return string Text The text that was read
function _acp_BinaryFile:readStringUtf8UntilNull() end

---Reads text from the file until a null character is found (0)
---Note: This is affected by the current endianness (:setLittleEndian)
---@return string Text The text that was read
function _acp_BinaryFile:readStringUtf16UntilNull() end

---Reads Data from the file
---@param bytesToRead integer How many bytes to read
---@return userdata Data The data that was read
function _acp_BinaryFile:readRaw(bytesToRead) end

---Reads a memory stream from the file
---@param bytesToRead integer|nil How many bytes to read, nil would be everything ahead (:size() - :tell())
---@return BinaryFile|nil Stream The stream that was read
function _acp_BinaryFile:readStream(bytesToRead) end

---Reads a memory stream from the file with potentially compressed data
---@param bytesToRead integer|nil How many bytes to read, nil would be everything ahead (:size() - :tell())
---@param compressionType string | "'lzma'" | "'deflate'" | "'gzip2'" | "'store'" | "'none'" The compression type to use, anything that isn't store or none will have compression enabled
---@param compressionLevel integer | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 The compression level to use, 0 is terrible compression, 1 is fastest, 6 is balanced, 9 is best compression, if you get an output stream this will be its compression level.
---@param compressionHeader boolean|nil If you want to skip the header, if you do you can't read the file without knowing the compression type
---@param isOutputStream boolean|nil If you want to read the stream as an output stream, this will make it so you can write to the stream and it will write to it
---@return BinaryFile|nil Stream The stream that was read
function _acp_BinaryFile:readStream(bytesToRead, compressionType, compressionLevel, compressionHeader, isOutputStream) end


---Parses an image from the stream and returns the image data in a Gfx2Texture
---@param bytesToRead integer|nil How many bytes to read, nil would be everything ahead (:size() - :tell())
---@return Gfx2Texture|nil Texture The texture that was read
function _acp_BinaryFile:parseImage(bytesToRead) end

---Opens a file to read/write data
---@param path string The path from Scripts/Data
---@param openmode string | "'w'" | "'r'" | "'a'" how to open the file, w is write mode, r is read mode, a is append(and it will add to an existing file or start)
---@return BinaryFile|nil file The (hopefully) opened file
function fs.open(path, openmode) end

---Opens a memory stream to write data to (you can then write that stream to a file stream using :writeStream)
---@return BinaryFile|nil file The (hopefully) opened stream
function fs.open() end

---Opens a file to read/write data that can also be compressed
---If you dont skip the header putting anything that isn't 'store' or 'none' will ignore what you supply and read the header, otherwise it will trust you
---@param path string The path from Scripts/Data
---@param openmode string | "'w'" | "'r'" | "'a'" how to open the file, w is write mode, r is read mode, a is append(and it will add to an existing file or start)
---@param compressionType string | "'lzma'" | "'deflate'" | "'gzip2'" | "'store'" | "'none'" The compression type to use, anything that isn't store or none will have compression enabled
---@param compressionLevel integer | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 The compression level to use, 0 is terrible compression, 1 is fastest, 6 is balanced, 9 is best compression
---@param compressionHeader boolean | true | false If you want to skip the header, if you do you can't read the file without knowing the compression type
function fs.open(path, openmode, compressionType, compressionLevel, compressionHeader) end

---Opens a memory stream to write data that can also be compressed
---If you dont skip the header putting anything that isn't 'store' or 'none' will ignore what you supply and read the header, otherwise it will trust you
---@param path nil Leave nil to open a memory stream
---@param openmode string | "'w'" | "'a'" how to open the file, w is write mode, a is append(and it will add to an existing file or start)
---@param compressionType string | "'lzma'" | "'deflate'" | "'gzip2'" | "'store'" | "'none'" The compression type to use, anything that isn't store or none will have compression enabled
---@param compressionLevel integer | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 The compression level to use, 0 is terrible compression, 1 is fastest, 6 is balanced, 9 is best compression
---@param compressionHeader boolean | true | false If you want to skip the header, if you do you can't read the file without knowing the compression type
function fs.open(path, openmode, compressionType, compressionLevel, compressionHeader) end


