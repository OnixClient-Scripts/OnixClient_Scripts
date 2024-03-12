---@meta

---@class McStructure
local __acp_McStructure = {}

---Saves a structure file
---@param filepath string The file path to load the structure from
function __acp_McStructure:save(filepath) end

---Gives you the text representation of the structure as NBT
---@return string nbtText The NBT text representation of the structure
function __acp_McStructure:save() end

---Mirrors the structure as requested
---@param mirror "x"|"z"|"xz"|"none"
function __acp_McStructure:miror(mirror) end

---Gets the 3d size of the mcstructure
---@return integer
---@return integer
---@return integer
function __acp_McStructure:size() end

---Gets the index size of the mcstructure (as a 1d array)
---@return integer
function __acp_McStructure:indexSize() end

---Gets the block at the specified position
---@param x integer The x position
---@param y integer The y position
---@param z integer The z position
---@return Block block The block at the specified position
function __acp_McStructure:getBlock(x, y, z) end

---Gets the block at the specified position
---@param index integer The index position
---@return Block block The block at the specified index
function __acp_McStructure:getBlock(index) end

---Sets the block at the specified position
---@param x integer The x position
---@param y integer The y position
---@param z integer The z position
---@param block Block|string The block or block state NBT string to set
function __acp_McStructure:setBlock(x, y, z, block) end

---Sets the block at the specified position
---@param index integer The x position
---@param block Block|string The block or block state NBT string to set
function __acp_McStructure:setBlock(index, block) end

---Gets the current block offset
---@return integer
---@return integer
---@return integer
function __acp_McStructure:getOffset() end

---Gets the coordinate at which it was taken from the world
---@return integer
---@return integer
---@return integer
function __acp_McStructure:getWorldOrigin() end

---Sets the current block offset
---@param x integer The x offset
---@param y integer The y offset
---@param z integer The z offset
function __acp_McStructure:setOffset(x, y, z) end

---Sets the coordinate at which it was taken from the world
---@param x integer The x offset
---@param y integer The y offset
---@param z integer The z offset
function __acp_McStructure:setWorldOrigin(x, y, z) end

---Gets the block at the specified position
---@param x integer The x position
---@param y integer The y position
---@param z integer The z position
---@return Block block The block at the specified index
function __acp_McStructure:getOffsetBlock(x, y, z) end

---Sets the block at the specified position
---@param x integer The x position
---@param y integer The y position
---@param z integer The z position
---@param block Block|string The block or block state NBT string to set
function __acp_McStructure:setOffsetBlock(x, y, z, block) end

---Resizes the structure
---@param x integer The x size
---@param y integer The y size
---@param z integer The z size
---@param preserve boolean Whether to preserve the existing structure or not
function __acp_McStructure:resize(x, y, z, preserve) end

---Creates a new structure that you can fill up
---@param sizeX integer The x size
---@param sizeY integer The y size
---@param sizeZ integer The z size
---@return McStructure structure The newly created structure
function CreateMcStructure(sizeX, sizeY, sizeZ) end

---Creates a new structure from nbt string
---@param nbtString string nbt string
---@return McStructure structure The newly created structure
function CreateMcStructureNbt(nbtString) end

---Creates a new structure from a file
---@param nbtString string nbt string
---@return McStructure structure The newly created structure
function CreateMcStructureFile(nbtString) end