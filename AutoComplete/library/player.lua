---@meta

---@class Skin
local _acp__Player_Skin = {}

---Gives you the skin id (you should be able to just check id or fullid to see if player changed skin)
---@return string skinId skin The skin identifier 
function _acp__Player_Skin.id() end

---Gives you the skin id (but sometimes longer)  (you should be able to just check id or fullid to see if player changed skin)
---@return string fullSkinId The full skin identifier (sometimes larger than id)
function _acp__Player_Skin.fullId() end

---Gives you the cape id (you should be able to just check capeId to see if player has changed cape)
---@return string capeid The cape identifier
function _acp__Player_Skin.capeId() end

---Tells you if the skin has a cape or no
---@return boolean hasCape If this skin has a cape
function _acp__Player_Skin.hasCape() end

---Saves the skin's texture into a file
---@param FilePath string The path to save the texture to
---@return boolean HasSaved If the skin saved or no
function _acp__Player_Skin.save(FilePath) end

---Saves the cape's texture into a file (check if present with hasCape)
---@param FilePath string The path to save the texture to
---@return boolean HasSaved If the cape saved or no
function _acp__Player_Skin.saveCape(FilePath) end

---Gets you the skin geometry
---@return string geometry Json skin geometry
function _acp__Player_Skin.geometry() end

---Gets you the skin geometry name
---@return string geometryName skin geometry name
function _acp__Player_Skin.geometryName() end

---Gets you the skin default geometry name
---@return string defaultGeometryName default skin geometry name
function _acp__Player_Skin.defaultGeometryName() end


---Gets the skin texture as a gfx2 texture dont have to write to disk 
---this function is slow, well faster than disk but as its convenient to call it every frame, DONT
---@return Gfx2Texture texture The skins gfx2 texture
function _acp__Player_Skin.texture() end

---Gets the cape texture as a gfx2 (check if present with hasCape) texture dont have to write to disk 
---this function is slow, well faster than disk but as its convenient to call it every frame, DONT
---@return Gfx2Texture texture The skins gfx2 texture
function _acp__Player_Skin.capeTexture() end

---@class PlayerSkin : Skin
local _acp__Player_PlayerSkin = {}

---Changes the skin of the player
---@param skinTextureOrFilepath string|Gfx2Texture The skin texture or the path to the skin texture.
function _acp__Player_PlayerSkin.setSkin(skinTextureOrFilepath) end

---Changes the cape of the player
---@param capeTextureOrFilepath string|Gfx2Texture|nil The cape texture or the path to the cape texture, nil to remove the cape.
function _acp__Player_PlayerSkin.setCape(capeTextureOrFilepath) end

---Changes the geometry of the player
---@param geometry string The geometry data of the player
---@param geometryName string The name of the geometry among the geometryData
---@param defaultGeometryName string The name of the default geometry 
function _acp__Player_PlayerSkin.setGeometry(geometry, defaultGeometryName, geometryName) end

---Changes the skin and cape of the player
---@param skinTextureOrFilepath string|Gfx2Texture The skin texture or the path to the skin texture.
---@param capeTextureOrFilepath string|Gfx2Texture|nil The cape texture or the path to the cape texture, nil to remove the cape.
function _acp__Player_PlayerSkin.setSkinCape(skinTextureOrFilepath, capeTextureOrFilepath) end

---Changes the skin the cape and the geometry of the player.
---@param skinTextureOrFilepath string|Gfx2Texture The skin texture or the path to the skin texture.
---@param capeTextureOrFilepath string|Gfx2Texture|nil The cape texture or the path to the cape texture, nil to remove the cape.
---@param geometry string|nil The geometry data of the player
---@param geometryName string|nil The name of the geometry among the geometryData
function _acp__Player_PlayerSkin.setSkinCapeGeometry(skinTextureOrFilepath, capeTextureOrFilepath, geometry, defaultGeometryName, geometryName) end

---Changes the skin the cape and the geometry of the player aswell as the id of the skin.
---@param id string The skin id
---@param fullId string the full string id
---@param skinTextureOrFilepath string|Gfx2Texture The skin texture or the path to the skin texture.
---@param capeTextureOrFilepath string|Gfx2Texture|nil The cape texture or the path to the cape texture, nil to remove the cape.
---@param geometry string|nil The geometry data of the player
---@param geometryName string|nil The name of the geometry among the geometryData
function _acp__Player_PlayerSkin.setSkinCapeGeometryId(id, fullId, skinTextureOrFilepath, capeTextureOrFilepath, geometry, defaultGeometryName, geometryName) end


---Changes the skin of the player
---@param skinTextureOrFilepath string|Gfx2Texture The skin texture or the path to the skin texture.
---@param isLocal boolean If the skin change is client sided or a proper skin change (server sided)
function _acp__Player_PlayerSkin.setSkin(skinTextureOrFilepath, isLocal) end

---Changes the cape of the player
---@param capeTextureOrFilepath string|Gfx2Texture The cape texture or the path to the cape texture.
---@param isLocal boolean If the cape change is client sided or a proper cape change (server sided)
function _acp__Player_PlayerSkin.setCape(capeTextureOrFilepath, isLocal) end

---Changes the geometry of the player
---@param geometry string The geometry data of the player
---@param geometryName string The name of the geometry among the geometryData
---@param isLocal boolean If the geometry change is client sided or a proper geometry change (server sided)
function _acp__Player_PlayerSkin.setGeometry(geometry, defaultGeometryName, geometryName, isLocal) end

---Changes the skin and cape of the player
---@param skinTextureOrFilepath string|Gfx2Texture The skin texture or the path to the skin texture.
---@param capeTextureOrFilepath string|Gfx2Texture|nil The cape texture or the path to the cape texture, nil to remove the cape.
---@param isLocal boolean If the skin and cape change is client sided or a proper skin and cape change (server sided)
function _acp__Player_PlayerSkin.setSkinCape(skinTextureOrFilepath, capeTextureOrFilepath, isLocal) end

---Changes the skin the cape and the geometry of the player.
---@param skinTextureOrFilepath string|Gfx2Texture The skin texture or the path to the skin texture.
---@param capeTextureOrFilepath string|Gfx2Texture|nil The cape texture or the path to the cape texture, nil to remove the cape.
---@param geometry string|nil The geometry data of the player
---@param geometryName string|nil The name of the geometry among the geometryData
---@param isLocal boolean If the skin cape and geometry change is client sided or a proper skin cape and geometry change (server sided)
function _acp__Player_PlayerSkin.setSkinCapeGeometry(skinTextureOrFilepath, capeTextureOrFilepath, geometry, defaultGeometryName, geometryName, isLocal) end

---Changes the skin the cape and the geometry of the player aswell as the id of the skin.
---@param id string The skin id
---@param fullId string the full string id
---@param skinTextureOrFilepath string|Gfx2Texture The skin texture or the path to the skin texture.
---@param capeTextureOrFilepath string|Gfx2Texture|nil The cape texture or the path to the cape texture, nil to remove the cape.
---@param geometry string|nil The geometry data of the player
---@param geometryName string|nil The name of the geometry among the geometryData
---@param isLocal boolean If the skin cape geometry and id change is client sided or a proper skin cape geometry and id change (server sided)
function _acp__Player_PlayerSkin.setSkinCapeGeometryId(id, fullId, skinTextureOrFilepath, capeTextureOrFilepath, geometry, defaultGeometryName, geometryName, isLocal) end





---@class player
player = {}

---Returns the current gamemode of the player
---0 = Survival
---1 = Creative
---2 = Adventure
---3 = SurvivalViewer
---4 = CreativeViewer
---5 = Default
---6 = spectator (1.19.60+ if i remember correctly)
---@return integer gamemode The player's current gamemode
function player.gamemode() end

---Returns the position of the player in integer coordinates
---@return integer x The player's current x position
---@return integer y The player's current y position
---@return integer z The player's current z position
function player.position() end

---Returns the precise position of the player in floating point coordinates
---@return number x The player's current precise x position
---@return number y The player's current precise y position
---@return number z The player's current precise z position
function player.pposition() end

---Returns the raw position of the player in floating point coordinates, not interpolated bound to ticks, will look jittery if rendered directly
---@return number x The player's current precise x position
---@return number y The player's current precise y position
---@return number z The player's current precise z position
---@return number x The player's previous precise x position
---@return number y The player's previous precise y position
---@return number z The player's previous precise z position
function player.rawposition() end

---Returns the velocity of the player in floating point coordinates
---@return number vx The player's current velocity along the x-axis
---@return number vy The player's current velocity along the y-axis
---@return number vz The player's current velocity along the z-axis
function player.velocity() end

---Returns the position at a chosen distance from the player
---@param distance number The distance in front of the player
---@return number x The x position at the specified distance from the player
---@return number y The y position at the specified distance from the player
---@return number z The z position at the specified distance from the player
function player.forwardPosition(distance) end

---Returns the coordinates of the block that the player is currently selecting
---Use player.facingBlock() to check if a block is being selected
---@return integer x The x position of the selected block
---@return integer y The y position of the selected block
---@return integer z The z position of the selected block
function player.selectedPos() end

---Returns the face of the currently selected block
---Use player.facingBlock() to check if a block is being selected
---@return integer selectedFace The face of the block the player is currently looking at
function player.selectedFace() end

---Returns the progress for the selected block to be broken (0.0 to 1.0)
---@return number progress The progress of block breaking
function player.breakProgress() end

---@class SelectedEntityInfo
---@field type string The type of entity, example "player"
---@field fullType string The full type of entity, example "minecraft:player"
---@field nametag string The name of the entity
---@field username string|nil The username of the entity, players only
---@field yaw number The yaw viewing angle of the entity
---@field pitch number The pitch viewing angle of the entity
---@field x integer The X position of the entity
---@field y integer The Y position of the entity
---@field z integer The Z position of the entity
---@field ppx number The precise X position of the entity
---@field ppy number The precise Y position of the entity
---@field ppz number The precise Z position of the entity
---@field vx integer The X velocity of the entity
---@field vy integer The Y velocity of the entity
---@field vz integer The Z velocity of the entity
local _acp__SelectedEntityInfo_Skin = {}

---Returns the player skin
---@return Skin skin
function _acp__SelectedEntityInfo_Skin.skin() end

---Returns the entity the player is currently looking at
---Use player.facingEntity() to check if an entity is being looked at
---@return SelectedEntityInfo entity The entity the player is looking at
function player.selectedEntity() end

---Returns the precise position where the player's gaze intersects a block
---@return number x The precise X position of the intersection
---@return number y The precise Y position of the intersection
---@return number z The precise Z position of the intersection
function player.lookingPos() end

---Returns the direction the player is looking at
---@return number yaw The current yaw rotation
---@return number pitch The current pitch rotation
function player.rotation() end

---Returns the direction the player's body is facing
---@return number yaw The current yaw rotation
function player.bodyRotation() end

---Returns the player's current perspective 
---0 == First Person(first person, third person back, third person front)
---1 == Third Person Back
---2 == Third Person Front
---@return integer perspective The current perspective
function player.perspective() end

---Checks if the player is currently facing an entity within reach
---@return boolean facingEntity Whether the player is looking at an entity or not
function player.facingEntity() end

---Checks if the player is currently facing a block within reach
---@return boolean facingBlock Whether the player is looking at a block or not
function player.facingBlock() end

---Returns the Xbox username of the player
---@return string xboxName The Xbox username of the player
function player.name() end

---Returns the nametag of the player
---@return string nametag The nametag of the player
function player.nametag() end

---Returns the hurt time of the player
---@return integer hurttime The time the player has been hurt (in ticks)
---@return integer hurttimeduration The duration of the player's hurt time (in ticks)
function player.hurttime() end


---Returns if  true if the flag is true...
---0: on fire
---1: is sneaking
---2: riding an entity
---3: sprinting
---4: using an item
---5: invisible (example: potion)
---14: can show nametag
---15: always show nametag
---16: immobile (when player is dead or unable to move)
---19: can climb (if the player can use ladders)
---32: gliding with elytra
---38: if player is moving
---39: if player is breathing
---47: has collision with other entities
---48: has gravity
---49: immune to fire/lava damage
---52: returning loyalty trident
---55: doing spin attack with riptide trident
---56: swimming
---68: inside a scaffolding block
---69: on top of a scaffolding block
---70: falling through a scaffolding block
---71: blocking (using shield or riding a horse? confused about how this one gets triggered)
---72: transition blocking (same idea as 71)
---73: blocked from entity using a shield
---74: blocked from entity using a damaged shield (why does this exist?)
---75: sleeping
---88: if the player should render when they have the invisibility status effect
---
---Do note that status flags are sent by the SERVER. 
---Thus, many custom servers may only send essential flags such as on fire or sneaking. 
---However, more niche flags are expected to be sent by the vanilla bedrock server. 
---The other status flags do not apply to players and are thus omitted from the documentation (for now)
---@param flag integer The flag to check
---@return boolean flag Whether the flag is on/off
function player.getFlag(flag) end



---@class Effect
---@field duration number How long the effect will last in seconds
---@field level integer How strong the effect will be: ex Strength II
---@field id integer The numerical identifier of the effect
---@field effectTimeText string The formated text of the time remaining (ex: 6:45)
---@field name string The name of the effect ex: night_vision
---@field visualName string The visual name ex: Night Vision II


---@return Effect[] effects The list of effects
function player.effects() end



---@class AttributeListHolder
---@field size integer
local _acp_AttributeListHolder = {}

---@class Attribute
---@field name string The name of the attribute
---@field id integer The numerical identifier of the attribute
---@field value number The value of the attribute
---@field default number The default value of the attribute
---@field min number The minimum value of the attribute
---@field max number The maximum value of the attribute

---Gets the attribute with this name or nil
---Attribute Names
---"minecraft:player.hunger"
---"minecraft:player.saturation"
---"minecraft:player.exhaustion"
---"minecraft:player.level"
---"minecraft:player.experience"
---"minecraft:health"
---"minecraft:follow_range"
---"minecraft:knockback_resistance"
---"minecraft:movement"
---"minecraft:underwater_movement"
---"minecraft:lava_movement"
---"minecraft:attack_damage"
---"minecraft:absorption"
---"minecraft:luck"
---
---@param attribute_name string | '"minecraft:player.hunger"' | "\"minecraft:player.saturation\"" | "\"minecraft:player.exhaustion\"" | "\"minecraft:player.level\"" | "\"minecraft:player.experience\"" | "\"minecraft:health\"" | "\"minecraft:follow_range\"" | "\"minecraft:knockback_resistance\"" | "\"minecraft:movement\"" | "\"minecraft:underwater_movement\"" | "\"minecraft:lava_movement\"" | "\"minecraft:attack_damage\"" | "\"minecraft:absorption\"" | "\"minecraft:luck\""
---@return Attribute attribute Probably the attribute, but it could be nil.
function _acp_AttributeListHolder.name(attribute_name) end


---Gets the attribute with its id or nil
---Attribute ids
---1: Hunger
---2: Saturation
---3: Exhaustion
---4: Level
---5: Experience
---7: Health
---8: Follow Range
---9: Knockback Resistance
---10: Movement Speed
---11: Underwater Speed
---12: Lava Speed
---13: Attack Damage
---14: Absorption
---15: Luck
---@param attribute_id integer The attribute id
---@return Attribute|nil attribute Probably the attribute, but it could be nil.
function _acp_AttributeListHolder.id(attribute_id) end

---Gets the attribute at this position in the list or nil
--- --you can iterate trough all of them by doing this:
---for i,attributes.size do
---	print(attributes.at(i).id .. ": " .. attributes.at(i).name)
---end
---@param position integer 
---@return Attribute|nil attribute Probably the attribute, but it could be nil.
function _acp_AttributeListHolder.at(position) end


---Gets the attributes
---@return AttributeListHolder attributes The attributes
function player.attributes() end






---@class Enchants
---@field id integer The numerical identifier ex: 9
---@field level integer the level, ex: 1
---@field name string The name (like in /enchant) ex: sharpness
local _acp_Enchants = {}

---@class Item
---@field count integer The quantity of items in this stack
---@field location integer This is used when referencing an item to client functions. Do not modify or guess its value.
---@field id integer The runtime numerical identifier of the item. This value changes often and should be used for runtime only.
---@field blockid integer The runtime numerical identifier of the block associated with the item. This value changes often and should be used for runtime only.
---@field name string The name of the item, e.g., "diamond_sword"
---@field blockname string The name of the block associated with the item, e.g., "carrots"
---@field blockstate table The state of the block associated with the item
---@field maxStackCount integer The maximum quantity of this item that can be stacked
---@field maxDamage integer The maximum durability of an item
---@field durability integer The current durability of the item
---@field data integer The data of the item, similar to the /give command with dye and other items
---@field customName string The custom name of the item, e.g., from anvils
---@field enchant Enchants[] The item's enchantments
---@field displayName string The item's display name (the one that would show above the hotbar)
---@field creativeCategory integer The creative category of the item (0=all,1=construction,2=nature,3=equipment,4=items,5=itemscommandonly,6=undefined)

---@class InventoryArmor 
---@field helmet Item|nil The item equipped on the head
---@field chestplate Item|nil The item equipped on the torso
---@field leggings Item|nil The item equipped on the legs
---@field boots Item|nil The item equipped on the feet

---@class ModyfiableInventory
---@field lastHoverSlotValue integer The last hovered slot value
---@field lastHoverSlotName string The last hovered slot name
local _acp__ModyfiableInventory = {}

---Determines if items can be placed and taken from the container. Returns false for search bars and similar containers.
---@param container string The container name
---@return boolean shouldIgnore If the container should be ignored
function _acp__ModyfiableInventory.shouldIgnore(container) end

---Gets the item in the specified slot for a container
---@param container string The container name
---@param slot integer The slot to get the item from
---@return Item|nil item The item in the slot
function _acp__ModyfiableInventory.at(container, slot) end

---Gets the position of the container block, if any
---@return integer|nil x The X position of the container block
---@return integer|nil y The Y position of the container block
---@return integer|nil z The Z position of the container block
function _acp__ModyfiableInventory.blockpos() end

---Gets the unique id of the entity, if any
---@return integer|nil entity The entity unique id
function _acp__ModyfiableInventory.entity() end

---Takes all the items from the specified slot (as if you left-clicked an item)
---@param container string The container name
---@param slot integer The slot to take from
function _acp__ModyfiableInventory.takeAll(container, slot) end

---Takes half the items from the specified slot (as if you right-clicked an item)
---@param container string The container name
---@param slot integer The slot to take from
function _acp__ModyfiableInventory.takeHalf(container, slot) end

---Transfers the item to another location if possible (same as shift+click)
---@param container string The container name
---@param slot integer The slot to take from
---@param amount integer|nil The amount to transfer (defaults to the whole stack)
function _acp__ModyfiableInventory.autoPlace(container, slot, amount) end

---Places all the items from the specified slot (as if you left-clicked an item)
---@param container string The container name
---@param slot integer The slot to place items in
function _acp__ModyfiableInventory.placeAll(container, slot) end

---Places one item from the specified slot (as if you right-clicked an item)
---@param container string The container name
---@param slot integer The slot to place item in
function _acp__ModyfiableInventory.placeOne(container, slot) end

---Drops all the items from the specified slot (as if you pressed ctrl+Q)
---@param container string The container name
---@param slot integer The slot to drop items from
function _acp__ModyfiableInventory.dropAll(container, slot) end

---Drops one item from the specified slot (as if you pressed Q)
---@param container string The container name
---@param slot integer The slot to drop item from
function _acp__ModyfiableInventory.dropOne(container, slot) end

---Transfers an item from one slot to another
---@param fromContainer string The container name to send from
---@param fromSlot integer The slot to send from
---@param toContainer string The container name to send to
---@param toSlot integer The slot to send to
function _acp__ModyfiableInventory.sendFlyingItem(fromContainer, fromSlot, toContainer, toSlot) end

---Transfers a specific item from one slot to another
---@param fromContainer string The container name to send from
---@param fromSlot integer The slot to send from
---@param toContainer string The container name to send to
---@param toSlot integer The slot to send to
---@param item Item|integer The item to transfer
function _acp__ModyfiableInventory.sendFlyingItem(fromContainer, fromSlot, toContainer, toSlot, item) end






---@class Inventory
---@field size integer The size of the inventory
---@field selected integer The selected slot in the inventory (hotbar)
local _acp_Inventory = {}

---Returns the armor inventory
---@return InventoryArmor armorInventory The armor the player is currently wearing
function _acp_Inventory.armor() end

---Returns the item in the second hand
---@return Item|nil offhand The item in the offhand, nil if empty
function _acp_Inventory.offhand() end

---Returns the item in the main hand
---@return Item|nil handItem The item in the main hand, nil if empty
function _acp_Inventory.selectedItem() end

---Returns a modifiable version of the inventory
---@return ModyfiableInventory|nil modify The modifiable inventory, nil if not modifiable
function _acp_Inventory.modify() end

---Returns the item in the specified slot or nil if the slot is empty
---@param slot integer The inventory slot
---@return Item|nil item The item in the specified slot, nil if the slot is empty
function _acp_Inventory.at(slot) end

---Changes the player's selected slot
---@param slot integer The slot to be selected
function _acp_Inventory.setSelectedSlot(slot) end

--- Which slot to access, slots are listed below
--- 1 = Inventory Holding 
--- 2 = Anvil Input
--- 3 = Anvil Material
--- 4 = Stone Cutter Input
--- 5 = Trade2 Ingredient 1
--- 6 = Trade2 Ingredient 2
--- 7 = Trade Ingredient 1
--- 8 = Trade Ingredient 2
--- 10 = Loom Input
--- 11 = Loom Dye
--- 12 = Loom Material
--- 13 = Cartography Input
--- 14 = Cartography Additional
--- 15 = Enchanting Input
--- 16 = Enchanting Material
--- 17 = Grindstone Input
--- 18 = Grindstone Additional
--- 28 = BeaconPayment
--- 29 = Crafting 2x2 Input 1
--- 30 = Crafting 2x2 Input 2
--- 31 = Crafting 2x2 Input 3
--- 32 = Crafting 2x2 Input 4
---
--- 33 = Crafting 3x3 Input 1
--- 34 = Crafting 3x3 Input 2
--- 35 = Crafting 3x3 Input 3
--- 36 = Crafting 3x3 Input 4
--- 37 = Crafting 3x3 Input 5
--- 38 = Crafting 3x3 Input 6
--- 39 = Crafting 3x3 Input 7
--- 40 = Crafting 3x3 Input 8
--- 41 = Crafting 3x3 Input 9
--- 51 = CreatedItemOutput
---Returns the item in the specified UI slot or nil if the slot is empty
---@param slot integer The UI slot
---@return Item|nil The item in the specified UI slot, nil if the slot is empty
function _acp_Inventory.ui(slot) end

---Returns the player's inventory
---@return Inventory The player's inventory
function player.inventory() end

---Returns the player's current skin
---@return PlayerSkin The user's current skin
function player.skin() end
