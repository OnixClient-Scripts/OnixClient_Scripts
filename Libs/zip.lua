
zip = {internal={}}
zip.internal.LocalFileHeaderSignature = 0x04034b50
zip.internal.CentralDirectoryFileHeaderSignature = 0x02014b50
zip.internal.EndOfCentralDirectorySignature = 0x06054b50



---@class ZipInternal_LocalFileHeader
---@field VersionNeededToExtract integer
---@field GeneralPurposeBitFlag integer
---@field CompressionMethod integer
---@field LastModFileTime integer
---@field LastModFileDate integer
---@field Crc32 integer
---@field CompressedSize integer
---@field UncompressedSize integer
---@field FileNameLength integer
---@field ExtraFieldLength integer
---@field FileName string
---@field ExtraField string
---@field FileOffset integer --not on disk, offset of data from disk start
local __acp_ZipInternal_LocalFileHeader = {}

---Seeks to the compressed data of the file
---@param f BinaryFile The file to seek in
function __acp_ZipInternal_LocalFileHeader:seek(f)
    f:seek(self.FileOffset)
end

---@param f BinaryFile
---@return ZipInternal_LocalFileHeader
function zip.internal.readLocalFileHeader(f)
    local result = {}
    result.VersionNeededToExtract = f:readShort()
    result.GeneralPurposeBitFlag = f:readShort()
    result.CompressionMethod = f:readShort()
    result.LastModFileTime = f:readShort()
    result.LastModFileDate = f:readShort()
    result.Crc32 = f:readUInt()
    result.CompressedSize = f:readUInt()
    result.UncompressedSize = f:readUInt()
    result.FileNameLength = f:readShort()
    result.ExtraFieldLength = f:readShort()
    result.FileName = f:read(result.FileNameLength)
    result.ExtraField = f:read(result.ExtraFieldLength)
    result.FileOffset = f:tell()
    f:seek(f:tell() + result.CompressedSize)

    function result:seek(f)
        f:seek(self.FileOffset)
    end

    return result
end

---@class ZipInternal_CentralDirectoryFileHeader
---@field VersionMadeBy integer
---@field VersionNeededToExtract integer
---@field GeneralPurposeBitFlag integer
---@field CompressionMethod integer
---@field LastModFileTime integer
---@field LastModFileDate integer
---@field Crc32 integer
---@field CompressedSize integer
---@field UncompressedSize integer
---@field FileNameLength integer
---@field ExtraFieldLength integer
---@field FileCommentLength integer
---@field DiskNumberStart integer
---@field InternalFileAttributes integer
---@field ExternalFileAttributes integer
---@field RelativeOffsetOfLocalHeader integer
---@field FileName string
---@field ExtraField string
---@field FileComment string
---@field FileOffset integer --not on disk, offset of LocalFileHeader from disk start
local __acp_ZipInternal_CentralDirectoryFileHeader = {}

---Seeks to the LocalZipHeader for this file
---@param f BinaryFile The file to seek in
function __acp_ZipInternal_CentralDirectoryFileHeader:seek(f)
    f:seek(self.FileOffset)
end

---@param f BinaryFile
---@param startOfDiskFileOffset? integer
---@return ZipInternal_CentralDirectoryFileHeader
function zip.internal.readCentralDirectoryFileHeader(f, startOfDiskFileOffset)
    if startOfDiskFileOffset == nil then
        startOfDiskFileOffset = 0
    end

    local result = {}
    result.VersionMadeBy = f:readShort()
    result.VersionNeededToExtract = f:readShort()
    result.GeneralPurposeBitFlag = f:readShort()
    result.CompressionMethod = f:readShort()
    result.LastModFileTime = f:readShort()
    result.LastModFileDate = f:readShort()
    result.Crc32 = f:readUInt()
    result.CompressedSize = f:readUInt()
    result.UncompressedSize = f:readUInt()
    result.FileNameLength = f:readShort()
    result.ExtraFieldLength = f:readShort()
    result.FileCommentLength = f:readShort()
    result.DiskNumberStart = f:readShort()
    result.InternalFileAttributes = f:readShort()
    result.ExternalFileAttributes = f:readUInt()
    result.RelativeOffsetOfLocalHeader = f:readUInt()
    result.FileName = f:read(result.FileNameLength)
    result.ExtraField = f:read(result.ExtraFieldLength)
    result.FileComment = f:read(result.FileCommentLength)
    result.FileOffset = result.RelativeOffsetOfLocalHeader + startOfDiskFileOffset + 4 --4 because of the header which isn't read by that function

    function result:seek(f)
        f:seek(self.FileOffset)
    end
    return result
end

---@class ZipInternal_EndOfCentralDirectoryRecord
---@field DiskNumber integer
---@field DiskNumberWithStartOfCentralDirectory integer
---@field NumberOfCentralDirectoryRecordsOnThisDisk integer
---@field TotalNumberOfCentralDirectoryRecords integer
---@field SizeOfCentralDirectory integer
---@field OffsetOfStartOfCentralDirectory integer
---@field CommentLength integer
---@field Comment string

---@param f BinaryFile
---@return ZipInternal_EndOfCentralDirectoryRecord
function zip.internal.readEndOfCentralDirectoryRecord(f)
    local result = {}
    result.DiskNumber = f:readShort()
    result.DiskNumberWithStartOfCentralDirectory = f:readShort()
    result.NumberOfCentralDirectoryRecordsOnThisDisk = f:readShort()
    result.TotalNumberOfCentralDirectoryRecords = f:readShort()
    result.SizeOfCentralDirectory = f:readUInt()
    result.OffsetOfStartOfCentralDirectory = f:readUInt()
    result.CommentLength = f:readShort()
    result.Comment = f:read(result.CommentLength)
    return result
end

---@param path string The among zip path to check
---@return boolean isDirectory True if the path is a directory
function zip.internal.isDirectory(path)
    return path:sub(-1) == "/"
end


---Adds the ZipArchive functions to the incomplete archive
---@param incompleteArchive ZipArchive
function zip.internal.addZipArchiveFunctions(incompleteArchive)


    function incompleteArchive:GetFolder(path)
        if path == nil then
            path = ""
        end
        if path == "" or path == "." then
            return self.Entries
        end
        if #path > 0 and path:sub(-1) == "/" then
            path = path:sub(1,-2)
        end
        local pathParts = string.split(path, "/")

        local result = self.Entries
        for _, part in pairs(pathParts) do
            if result == nil then break end
            result = result[part]
        end
        return result
    end

   function incompleteArchive:DumpOnDisk(diskPath, inZipFolder)
        if inZipFolder == nil then
            inZipFolder = ""
        end
        if #inZipFolder > 0 and inZipFolder:sub(-1) ~= "/" then
            inZipFolder = inZipFolder .. "/"
        end
        if #diskPath > 0 and diskPath:sub(-1) ~= "/" then
            diskPath = diskPath .. "/"
        end
        if not fs.isdir(diskPath) or not fs.exist(diskPath) then
            fs.mkdir(diskPath)
        end

        

        local entryDirectories = self:GetFolder(inZipFolder)
        if (entryDirectories) then
            for path, entry in pairs(entryDirectories) do
                if type(entry) == "table" and entry.DumpOnDisk ~= nil then
                    local diskFilePath = diskPath .. path
                    entry:DumpOnDisk(diskFilePath, self.File)
                else
                    self:DumpOnDisk(diskPath .. path, inZipFolder .. path)
                end
            end
        end
   end

end


---Adds the ZipArchive functions to the incomplete archive
---@param incompleteEntry ZipArchiveEntry
function zip.internal.addZipArchiveEntryFunctions(incompleteEntry)
    function incompleteEntry:GetFullPath()
        return self.Header.FileName
    end
    ---@param diskFilePath string
    ---@param archiveFile BinaryFile
    ---@return boolean
    function incompleteEntry:DumpOnDisk(diskFilePath, archiveFile)
        local diskFile = fs.open(diskFilePath, "w")
        if diskFile == nil then
            return false
        end
        --we are at data header
        self.Header:seek(archiveFile)
        local localHeader = zip.internal.readLocalFileHeader(archiveFile)
        localHeader:seek(archiveFile)
        --we are now at the data
        diskFile:writeRaw(archiveFile:readRaw(localHeader.CompressedSize))
        diskFile:close()
        return true
    end

end


---@class ZipArchiveEntry
---@field FileName string The name of the entry
---@field Header ZipInternal_CentralDirectoryFileHeader
local __acp_ZipInternal_ZipArchiveEntry = {}

---@param filepath string The path to the file to dump to
---@param archiveFile BinaryFile The Archive's file to read from
---@return boolean success True if the file was dumped
function __acp_ZipInternal_ZipArchiveEntry:DumpOnDisk(filepath, archiveFile) return false end

---@alias ZipArchiveEntries table<string, ZipArchiveEntries|ZipArchiveEntry> The header of the entry



---@class ZipArchive
---@field Entries ZipArchiveEntries The entries in the archive
---@field File BinaryFile The opened file to the archive
local __acp_ZipInternal_ZipArchive = {}

---Dumps the archive or a folder among the archive on disk
---@param diskPath string The path to dump the archive into
---@param inZipFolder? string The folder to dump in the archive
function __acp_ZipInternal_ZipArchive:DumpOnDisk(diskPath, inZipFolder) end

---Gets a folder among the archive
---@param path string The path to the folder
---@return ZipArchiveEntries? entries The entries in the folder
function __acp_ZipInternal_ZipArchive:GetFolder(path) end


---This opens a zip file from disk
---note that this DOES NOT support any compression so make sure to do it as uncompressed (called `store` in the zip standard)
---Do not use this for untrusted zip files.
---@param filename string The filepath of the zip archive
---@return ZipArchive? archive The zip archive object
---@return string? error The error message
function zip.open(filename)
    local f = fs.open(filename, "r")
    if f == nil then
        return nil, "Could not open the file."
    end

    
    local filepaths = {}
    --current zip disk file offset
    local DiskOffset = 0
    while true do
        if (f:eof()) then
            break
        end
        local HeaderKind = f:readUInt()
        if HeaderKind == zip.internal.LocalFileHeaderSignature then
            local LocalFileHeader = zip.internal.readLocalFileHeader(f)
        elseif HeaderKind == zip.internal.CentralDirectoryFileHeaderSignature then
            local CentralDirectoryFileHeader = zip.internal.readCentralDirectoryFileHeader(f, DiskOffset)
            filepaths[CentralDirectoryFileHeader.FileName] = CentralDirectoryFileHeader
        elseif HeaderKind == zip.internal.EndOfCentralDirectorySignature then
            local EndOfCentralDirectory = zip.internal.readEndOfCentralDirectoryRecord(f)
            DiskOffset = f:tell()
        else
            if f:eof() then
                break
            end
            f:close()
            return nil, "The file is not a zip file"
        end

    end

    ---@type ZipArchive
    local result = {
        File=f,
        Entries = {}
    }
    zip.internal.addZipArchiveFunctions(result)

    for path, entry in pairs(filepaths) do
        local entriesTable = result.Entries
        local pathParts = path:split("/")
        for i=1, #pathParts-1 do
            local part = pathParts[i]
            if entriesTable[part] == nil then
                -- in this case its just a folder
---@diagnostic disable-next-line: missing-fields
                entriesTable[part] = {} 
            end
            entriesTable = entriesTable[part]
        end
        if zip.internal.isDirectory(path) == false then
            ---@type ZipArchiveEntry
            local zipEntry = {
                FileName = pathParts[#pathParts],
                Header = entry,
            }
            zip.internal.addZipArchiveEntryFunctions(zipEntry)
            entriesTable[pathParts[#pathParts]] = zipEntry
        end
    end
    
    setmetatable(result, {
        __gc = function(self)
            if self.File ~= nil then
                self.File:close()
                self.File = nil
            end
        end
    })

    return result
end


