---@meta


---@class dimension
dimension = {}


---The numerical identifier of the dimension
---0 == Overworld
---1 == Nether
---2 == TheEnd
---@return number id The dimension id of the current dimension
function dimension.id() end


---The name of the dimension
---The default dimensions are:
---"Overworld"
---"Nether"
---"TheEnd"
---@return string name
function dimension.name() end

---The time in the dimension
---Ranges from 0 to 1, 0 is the start of the day 0.5 is night and 1 is the end of the day will wrap to 0
---@return number time The current time in the dimension
function dimension.time() end

---Will return true if it is currently raining
---@return boolean isRaining Is it raining right now?
function dimension.isRaining() end

---Plays a sound at these coordinates
---Will not work on 1.18.30+
---@param x integer | number The x position
---@param y integer | number The y position
---@param z integer | number The z position
---@param name string any minecraft sounds: https://www.digminecraft.com/lists/sound_list_pe.php
function dimension.sound(x, y, z, name) end

---@class LightPair
---@field blockLight integer The light level caused by torches and stuff
---@field skyLight integer The light level of the environement (will not adapt to time)


---@class Block
---@field id integer The numerical identifier of the block (changes with versions)
---@field data integer The data of the block: example the color of the wool in a /setblock
---@field name string The name that would be used in /setblock

---@class Biome
---@field id integer The numerical identifier of the biome (might change with versions)
---@field name string The name of the biome
---@field temperature number The temperature of the biome
---@field snow boolean Can it snow in that biome
---@field canRain boolean Can it rain in that biome


---Gets the light levels of these coordinates
---The highest between sky and block is the real brightness
---note that as the sun goes down this number will not change
---@param x integer | number The x position
---@param y integer | number The y position
---@param z integer | number The z position
---@return LightPair lightPair The light level
function dimension.getBrightness(x, y, z) end

---Gets the block at these coordinates
---@param x integer | number The x position
---@param y integer | number The y position
---@param z integer | number The z position
---@return Block block The block information
function dimension.getBlock(x, y, z) end

---Gets the block at these coordinates
---@param x integer | number The x position
---@param y integer | number The y position
---@param z integer | number The z position
---@return table blockEntity The NBT of the block entity
function dimension.getBlockEntity(x, y, z) end

---Gets the block entity nbt at these coordinates
---@param x integer | number The x position
---@param y integer | number The y position
---@param z integer | number The z position
---@param getServerSideEntity boolean Should we get the server one (unstable outside of the LocalServerUpdate event)
---@return table blockEntity The NBT of the block entity
function dimension.getBlockEntity(x, y, z, getServerSideEntity) end

---Gets the biome at these coordinates
---@param x integer | number The x position
---@param y integer | number The y position
---@param z integer | number The z position
---@return Biome biome The biome information
function dimension.getBiome(x, y, z) end
