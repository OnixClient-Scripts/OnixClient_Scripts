---@meta

---@class Skin
local _acp__Player_Skin = {}

---Gives you the skin id (you should be able to just check id or fullid to see if player changed skin)
---@return string skinId skin identifier 
function _acp__Player_Skin.id() end

---Gives you the skin id (but sometimes longer)  (you should be able to just check id or fullid to see if player changed skin)
---@return string fullSkinId The full skin identifier (sometimes larger than id)
function _acp__Player_Skin.fullId() end

---Gives you the cape id (you should be able to just check capeId to see if player has changed cape)
---@return string capeid The cape identifier
function _acp__Player_Skin.capeId() end

---Tells you if the skin has a cape or no
---@return boolean hasCape
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

---Gets the skin texture as a gfx2 texture dont have to write to disk 
---this function is slow, well faster than disk but as its convenient to call it every frame, DONT
---@return Gfx2Texture texture The skins gfx2 texture
function _acp__Player_Skin.texture() end

---Gets the cape texture as a gfx2 (check if present with hasCape) texture dont have to write to disk 
---this function is slow, well faster than disk but as its convenient to call it every frame, DONT
---@return Gfx2Texture texture The skins gfx2 texture
function _acp__Player_Skin.capeTexture() end




---@class player
player = {}

---The current gamemode of the player
---@return integer gamemode
---```
---0 = Survival
---1 = Creative
---2 = Adventure
---3 = SurvivalViewer
---4 = CreativeViewer
---5 = Default
---```
function player.gamemode() end

---The position of the player
---@return integer x
---@return integer y
---@return integer z
function player.position() end


---The precise position of the player
---@return number x
---@return number y
---@return number z
function player.pposition() end

---The coordinates of the block that has the outline for the player
---You can check if there is one in the first place with player.facingBlock()
---@return integer x
---@return integer y
---@return integer z
function player.selectedPos() end

---The block face of the currently selected block
---You can check if there is one in the first place with player.facingBlock()
---@return integer selectedFace
function player.selectedFace() end


---The progress for the selected block to be broken (0.0 to 1.0)
---@return number progress
function player.breakProgress() end

---@class PlayerLookingAtEntityInformation
---@field type string The type of entity, exemple "player"
---@field fullType string The full type of entity, exemple "minecraft:player"
---@field nametag string The name of the entity
---@field username string|nil The username of the entity, players only
---@field yaw number The yaw viewing angle of the entity
---@field pitch number The pitch viewing angle of the entity
---@field x integer The X position of the entity
---@field y integer The Y position of the entity
---@field z integer The Z position of the entity
---@field ppx integer The precise X position of the entity
---@field ppy integer The precise Y position of the entity
---@field ppz integer The precise Z position of the entity
---@field vx integer The X velocity of the entity
---@field vy integer The Y velocity of the entity
---@field vz integer The Z velocity of the entity
local _acp__PlayerLookingAtEntityInformation_Skin = {}
---The player skin
---@return Skin skin
function _acp__PlayerLookingAtEntityInformation_Skin.skin() end



---The coordinates of the block that has the outline for the player
---You can check if there is one in the first place with player.facingBlock()
---@return PlayerLookingAtEntityInformation entity
function player.selectedEntity() end


---Where the raytrace hit, exemple: you look at a block far away, where on that block are you looking at
---@return number x
---@return number y
---@return number z
function player.lookingPos() end

---Where the player looks at
---@return number yaw
---@return number pitch
function player.rotation() end

---What perspective the player is in (first person, third person back, third person front)
---@return integer perspective
function player.perspective() end


---If the player were to left click would it attack an entity
---@return boolean
function player.facingEntity() end

---If the player were to left click would it attack a block
---@return boolean
function player.facingBlock() end

---The xbox pro gamering tag
---@return string xboxName
function player.name() end

---empty in vanilla, servers can set a custom nametag there
---@return string nametag
function player.nametag() end


---Returns if  true if the flag is true
---@param flag integer The flag to check
---@return boolean flag
---```
---0: --on fire
---1: --is sneaking
---2: --riding an entity
---3: --sprinting
---4: --using an item
---5: --invisible (example: potion)
---14: --can show nametag
---15: --always show nametag
---16: --immobile (when player is dead or unable to move)
---19: --can climb (if the player can use ladders)
---32: --gliding with elytra
---38: --if player is moving
---39: --if player is breathing
---47: --has collision with other entities
---48: --has gravity
---49: --immune to fire/lava damage
---52: --returning loyalty trident
---55: --doing spin attack with riptide trident
---56: --swimming
---68: --inside a scaffolding block
---69: --on top of a scaffolding block
---70: --falling through a scaffolding block
---71: --blocking (using shield or riding a horse? confused about how this one gets triggered)
---72: --transition blocking (same idea as 71)
---73: --blocked from entity using a shield
---74: --blocked from entity using a damaged shield (why does this exist?)
---75: --sleeping
---88: --if the player should render when they have the invisibility status effect
---
---
---Do note that status flags are sent by the SERVER. Thus, many custom servers may only send essential flags such as on fire or sneaking. However, more niche flags are expected to be sent by the vanilla bedrock server. The other status flags do not apply to players and are thus omitted from the documentation (for now)
---```
function player.getFlag(flag) end



---@class Effect
---@field duration number How long the effect will last in seconds
---@field level integer How strong the effect will be: ex Strenght II
---@field id integer The numerical identifier of the effect
---@field effectTimeText string The formated text of the time remaining (ex: 6:45)
---@field name string The name of the effect ex: night_vision
---@field vname string The visual name ex: Night Vision II


---@return Effect[] effects
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
---@param attribute_name string | "\"minecraft:player.hunger\"" | "\"minecraft:player.saturation\"" | "\"minecraft:player.exhaustion\"" | "\"minecraft:player.level\"" | "\"minecraft:player.experience\"" | "\"minecraft:health\"" | "\"minecraft:follow_range\"" | "\"minecraft:knockback_resistance\"" | "\"minecraft:movement\"" | "\"minecraft:underwater_movement\"" | "\"minecraft:lava_movement\"" | "\"minecraft:attack_damage\"" | "\"minecraft:absorption\"" | "\"minecraft:luck\""
---@return Attribute attrib
function _acp_AttributeListHolder.name(attribute_name) end


---Gets the attribute with this id or nil
---@param attribute_id integer the attribute id
---```
---2: --Hunger
---3: --Saturation
---4: --Exhaustion
---5: --Level
---6: --Experience
---7: --Health
---9: --Knockback Resistance
---10: --Movement Speed
---11: --Underwater Speed
---12: --Lava Speed
---13: --Attack Damage
---14: --Absorption
---15: --Luck
---```
function _acp_AttributeListHolder.id(attribute_id) end

---Gets the attribute at this position in the list or nil
---@param position integer 
---```
--- --you can iterate trough all of them by doing this:
---for i,attributes.size do
---	print(attributes.at(i).id .. ": " .. attributes.at(i).name)
---end
---```
function _acp_AttributeListHolder.at(position) end


---Gets the attributes
---@return AttributeListHolder attribs
function player.attributes() end






---@class Enchants
---@field id integer The numerical identifier ex: 9
---@field level integer the level, ex: 1
---@field name string The name (like in /enchant) ex: sharpness
local _acp_Enchants = {}


---@class Item
---@field count integer The amount of items in this stack
---@field location integer dont touch this dont guess it use it when referencing an item to client functions
---@field id integer The runtime numerical identifier of the item, will change often use for runtime only
---@field blockid integer The runtime numerical identifier of the block assosiated with the item, will change often use for runtime only
---@field name string The name of the item  ex: diamond_sword
---@field blockname string The name of the block assosiated with the item  ex: carrots
---@field maxStackCount integer The maximum amount of this item that can be stacked
---@field maxDamage integer The maximum durability of an item
---@field durability integer The amount of damage applied to that item
---@field data integer The data of the item, like in /give with dye and things like that
---@field customName string The name (ex: from anvils)
---@field enchant Enchants[]


---@class InventoryArmor 
---@field helmet Item|nil the item on the head
---@field chestplate Item|nil the item on the torso
---@field leggings Item|nil the item on the legs
---@field boots Item|nil the item on the feets

---@class Inventory
---@field size integer The size of the inventory
---@field selected integer The selected slot in the inventory (hotbar)
local _acp_Inventory = {}

---The armor inventory
---@return InventoryArmor
function _acp_Inventory.armor() end

---The item in the second hand
---@return Item|nil
function _acp_Inventory.offhand() end

---The item in slot or nil
---@param slot integer The inventory slot
---@return Item|nil
---```
--- --proper iteration (checking for nil for every item you get)
---for i=1,inventory.size do
---	local item = inventory.at(i)
---	if item ~= nil then
---		print(item.name)
---	end
---end
---```
function _acp_Inventory.at(slot) end

---Gets the inventory of the player
---@return Inventory
function player.inventory() end

---Gets the player skin
---@return Skin
function player.skin() end
