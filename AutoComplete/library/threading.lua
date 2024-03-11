---@meta


---@class ThreadingBlockGetter
local __acp_ThreadingBlockGetter = {}

---When going outside a world or changing dimension this will return false, it is important to :recreate() the blockGetter when this happens.
---@return boolean isValid Tells you if this block getter needs to be re-created
function __acp_ThreadingBlockGetter:isValid() end

---Recreates the blockGetter, this is useful when you change dimension or go outside a world
---You can probably spam this instead of asking isValid as it will return true if already valid
---Which lets you do an if (:recreate) then ... end to make sure you are ready to use it
---@return boolean success If the recreation was successful or if we arent ready to create one.
function __acp_ThreadingBlockGetter:recreate() end

---Gets the light levels of these coordinates
---The highest between sky and block is the real brightness
---note that as the sun goes down this number will not change
---@param x integer | number The x position
---@param y integer | number The y position
---@param z integer | number The z position
---@return LightPair lightPair The light level
function __acp_ThreadingBlockGetter:getBrightness(x, y, z) end

---Gets the block at these coordinates
---@param x integer | number The x position
---@param y integer | number The y position
---@param z integer | number The z position
---@return Block block The block information
function __acp_ThreadingBlockGetter:getBlock(x, y, z) end

---Finds a block among the world 
---local positons = result[1] change the 1 to whatever index you wish to use! you can use the # operator to get the size (#result)
---@param name string The name of the block
---@return integer[][] blockPositions The block information
function __acp_ThreadingBlockGetter:findBlock(name) end

---Finds a block among the world 
---local positons = result[1] change the 1 to whatever index you wish to use! you can use the # operator to get the size (#result)
---@param name string The name of the block
---@param blockData integer | number The data of the block
---@return integer[][] blockPositions The block information
function __acp_ThreadingBlockGetter:findBlock(name, blockData) end

---Finds a block among the world 
---local positons = result[1] change the 1 to whatever index you wish to use! you can use the # operator to get the size (#result)
---@param name string The name of the block
---@param blockData integer | number The data of the block
---@param radius integer | number The radius to search in (will be chunk aligned to then center of the chunk
---@return integer[][] blockPositions The block information
function __acp_ThreadingBlockGetter:findBlock(name, blockData, radius) end

---Finds a block among the world 
---local positons = result[1] change the 1 to whatever index you wish to use! you can use the # operator to get the size (#result)
---@param name string The name of the block
---@param blockData integer | number The data of the block
---@param radius integer | number The radius to search in (will be chunk aligned to then center of the chunk
---@param x integer | number The x center position
---@param y integer | number The y center position
---@param z integer | number The z center position
---@return integer[][] blockPositions The block information
function __acp_ThreadingBlockGetter:findBlock(name, blockData, radius, x, y, z) end

---Gives you the height of the the block that would be chosen by the game to generate map data
---This is pretty much the height of the world but chests or glass or torches arent included
---@param x integer | number The x position
---@param z integer | number The z position
---@return integer y The height of the world
function __acp_ThreadingBlockGetter:getMapHeight(x, z) end

---Finds a block among the world 
---local x,y,z = result[1] change the 1 to whatever index you wish to use! you can use the # operator to get the size (#result)
---@param x integer | number The x center position
---@param y integer | number The y center position
---@param z integer | number The z center position
---@return BiomeColorData colorData The color of the water and grass at this x,z
function __acp_ThreadingBlockGetter:getBiomeColor(x, y, z) end

---Gets the block at these coordinates
---@param x integer | number The x position
---@param y integer | number The y position
---@param z integer | number The z position
---@return table blockEntity The NBT of the block entity
function __acp_ThreadingBlockGetter:getBlockEntity(x, y, z) end

---Gets the block entity nbt at these coordinates
---@param x integer | number The x position
---@param y integer | number The y position
---@param z integer | number The z position
---@param getServerSideEntity boolean Should we get the server one (unstable outside of the LocalServerUpdate event)
---@return table blockEntity The NBT of the block entity
function __acp_ThreadingBlockGetter:getBlockEntity(x, y, z, getServerSideEntity) end

---Gets the biome at these coordinates
---@param x integer | number The x position
---@param y integer | number The y position
---@param z integer | number The z position
---@return Biome biome The biome information
function __acp_ThreadingBlockGetter:getBiome(x, y, z) end


---Gets the color that would show on a minecraft map
---@param x integer | number The x position
---@param y integer | number The y position
---@param z integer | number The z position
---@return integer r The red part of the color
---@return integer g The green part of the color
---@return integer b The blue part of the color
---@return integer a The opacity part of the color
function __acp_ThreadingBlockGetter:getMapColor(x,y,z) end


---Casts a ray in the world between two points
---Traces a line in the world hoping or not to hit a block
---@param startX number The x start position
---@param startY number The y start position
---@param startZ number The y start position
---@param endX number the x end position, where are we going
---@param endY number the y end position, where are we going
---@param endZ number the z end position, where are we going
---@return RaycastInfo hit The result of the raycast
function __acp_ThreadingBlockGetter:raycast(startX, startY, startZ, endX, endY, endZ) end

---Casts a ray in the world between two points
---Traces a line in the world hoping or not to hit a block
---@param startX number The x start position
---@param startY number The y start position
---@param startZ number The y start position
---@param endX number the x end position, where are we going
---@param endY number the y end position, where are we going
---@param endZ number the z end position, where are we going
---@param maxDistance integer (default: distance between start and stop) Maximum distance to travel before giving up (lower values can make no hit waste less time)
---@return RaycastInfo hit The result of the raycast
function __acp_ThreadingBlockGetter:raycast(startX, startY, startZ, endX, endY, endZ, maxDistance) end

---Casts a ray in the world between two points
---Traces a line in the world hoping or not to hit a block
---@param startX number The x start position
---@param startY number The y start position
---@param startZ number The y start position
---@param endX number the x end position, where are we going
---@param endY number the y end position, where are we going
---@param endZ number the z end position, where are we going
---@param maxDistance integer (default: distance between start and stop) Maximum distance to travel before giving up (lower values can make no hit waste less time)
---@param hitLiquid boolean (default: false) If don't want to go through liquid make this true
---@return RaycastInfo hit The result of the raycast
function __acp_ThreadingBlockGetter:raycast(startX, startY, startZ, endX, endY, endZ, maxDistance, hitLiquid) end

---Casts a ray in the world between two points
---Traces a line in the world hoping or not to hit a block
---@param startX number The x start position
---@param startY number The y start position
---@param startZ number The y start position
---@param endX number the x end position, where are we going
---@param endY number the y end position, where are we going
---@param endZ number the z end position, where are we going
---@param maxDistance integer (default: distance between start and stop) Maximum distance to travel before giving up (lower values can make no hit waste less time)
---@param hitLiquid boolean (default: false) If don't want to go through liquid make this true
---@param solidBlocksOnly boolean (default: true) Will ignore things like grass, flowers, etc that you can walk through
---@return RaycastInfo hit The result of the raycast
function __acp_ThreadingBlockGetter:raycast(startX, startY, startZ, endX, endY, endZ, maxDistance, hitLiquid, solidBlocksOnly) end

---Casts a ray in the world between two points
---Traces a line in the world hoping or not to hit a block
---@param startX number The x start position
---@param startY number The y start position
---@param startZ number The y start position
---@param endX number the x end position, where are we going
---@param endY number the y end position, where are we going
---@param endZ number the z end position, where are we going
---@param maxDistance integer (default: distance between start and stop) Maximum distance to travel before giving up (lower values can make no hit waste less time)
---@param hitLiquid boolean (default: false) If don't want to go through liquid make this true
---@param solidBlocksOnly boolean (default: true) Will ignore things like grass, flowers, etc that you can walk through
---@param fullBlocksOnly boolean (default: false) not certain, probably wont go through opened trapdoors and that kindof stuff
---@return RaycastInfo hit The result of the raycast
function __acp_ThreadingBlockGetter:raycast(startX, startY, startZ, endX, endY, endZ, maxDistance, hitLiquid, solidBlocksOnly, fullBlocksOnly) end









---@class Thread
local __acp_Thread = {}

---Creates a new thread, it is started as soon as created.
---Only the function is sent over, not the environment or the global variables.
---Make sure to send over the things you need either as params or messages
---tableToJson and jsonToTable support sending lua functions
---@param func function The function to be executed by the thread.
---@param arguments string|nil The optional arguments to be passed to the function.
---@param createBlockGetter boolean|nil If true, a blockGetter will be created for the thread. (default: false)
---@return Thread thread The newly created thread.
function CreateThread(func, arguments, createBlockGetter) end

---Waits for the thread to finish. (creator only)
---Yous should probably never use this, as it will block the current thread.
function __acp_Thread:join() end

--- Makes the thread sleep for the specified amount of time. (thread only)
---@param ms integer The amount of time to sleep in milliseconds.
function __acp_Thread:sleep(ms) end

---Returns true if the thread is alive, false otherwise. (creator only)
function __acp_Thread:isAlive() end

---Returns true if there a new message, false otherwise. (shared)
---@return boolean hasMessage
function __acp_Thread:hasMessage() end

---Returns the next message in the queue and removes it from the queue. (shared)
---@return string message
function __acp_Thread:popMessage() end

---Returns the last message clearing the queue. (shared)
---@return string message
function __acp_Thread:popAllMessages() end

---Returns the next message in the queue without removing it (shared)
---@return string message
function __acp_Thread:peekMessage() end

---Adds a message to the queue. (shared)
---@param message string The message to add to the queue.
function __acp_Thread:pushMessage(message) end

---Adds a message to the queue. (shared)
---@return boolean isInWorld Tells you if you are in a world, do not access inapropriate things when outside a world!
function __acp_Thread:isInWorld() end








