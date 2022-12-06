name = "Armor Damage Reduction Viewer"
description = "View some interesting details of your armor like: Enchantment level | Damage reduced | Armor durability"

--[[
  References 
    - Armor/Bedrock_Edition -> https://minecraft.fandom.com/wiki/Armor/Bedrock_Edition
    - Minecraft Combat Simulator -> https://www.qxbytes.com/combat/
    - Complete Guide To Armor In Minecraft -> https://hypixel.net/threads/complete-guide-to-armor-in-minecraft.74945/
]]--

positionX = 0
positionY = 0

sizeX = 60
sizeY = 80

damage = 7.0
client.settings.addFloat("Base damage for apply to the armor", "damage", 0.1, 1000.0)

renderArmor = true
client.settings.addBool("Render armor and its information", "renderArmor")

javaMechanism = true
client.settings.addBool("Use Java 1.9 Combat Mechanism (using toughness)", "javaMechanism")

armor_points = {
  netherite_helmet     = { defence_points = 3, toughness = 3 },
  netherite_chestplate = { defence_points = 8, toughness = 3 },
  netherite_leggings   = { defence_points = 6, toughness = 3 },
  netherite_boots      = { defence_points = 3, toughness = 3 },
  
  diamond_helmet       = { defence_points = 3, toughness = 2 },
  diamond_chestplate   = { defence_points = 8, toughness = 2 },
  diamond_leggings     = { defence_points = 6, toughness = 2 },
  diamond_boots        = { defence_points = 3, toughness = 2 },
  
  iron_helmet          = { defence_points = 2, toughness = 0 },
  iron_chestplate      = { defence_points = 6, toughness = 0 },
  iron_leggings        = { defence_points = 5, toughness = 0 },
  iron_boots           = { defence_points = 2, toughness = 0 },
  
  turtle_helmet        = { defence_points = 2, toughness = 0 },
  
  chainmail_helmet     = { defence_points = 2, toughness = 0 },
  chainmail_chestplate = { defence_points = 5, toughness = 0 },
  chainmail_leggings   = { defence_points = 4, toughness = 0 },
  chainmail_boots      = { defence_points = 1, toughness = 0 },
  
  golden_helmet        = { defence_points = 2, toughness = 0 },
  golden_chestplate    = { defence_points = 5, toughness = 0 },
  golden_leggings      = { defence_points = 3, toughness = 0 },
  golden_boots         = { defence_points = 1, toughness = 0 },
  
  leather_helmet       = { defence_points = 1, toughness = 0 },
  leather_chestplate   = { defence_points = 3, toughness = 0 },
  leather_leggings     = { defence_points = 2, toughness = 0 },
  leather_boots        = { defence_points = 1, toughness = 0 }
}

protection_epf = {
  [0] = 0,
  [1] = 1,
  [2] = 2,
  [3] = 3,
  [4] = 5
}

armor_info = {
  [100] = { ix = 0, iy = 0 , tx = 16, ty = 5  },
  [101] = { ix = 0, iy = 16, tx = 16, ty = 21 },
  [102] = { ix = 0, iy = 32, tx = 16, ty = 37 },
  [103] = { ix = 0, iy = 48, tx = 16, ty = 55 }
}

function render() 
  local inventory = player.inventory().armor()
  local armor_values = { defence_points = 0, toughness = 0, protection_level = 0 }
  
  for index, item in pairs({ inventory.helmet, inventory.chestplate, inventory.leggings, inventory.boots }) do 
    if item ~= nil then 
      local armor = armor_info[item.location]
      local armor_data = { defence_points = armor_points[item.name].defence_points, toughness = armor_points[item.name].toughness, protection_level = getArmorProtectionLevel(item) } 
      
      if renderArmor then 
        gfx.item(armor.ix, armor.iy, item.location, 1)
        gfx.text(armor.tx, armor.ty, armor_data.protection_level .. " | " .. string.format("%.3f", calculateReceivedDamage(armor_data, damage)) .. " | " .. tostring(item.maxDamage) .. "/" .. tostring(item.maxDamage - item.durability), 0.8)
      end 
        
      armor_values.toughness = armor_values.toughness + armor_data.toughness
      armor_values.defence_points = armor_values.defence_points + armor_data.defence_points
      armor_values.protection_level = armor_values.protection_level + (javaMechanism and armor_data.protection_level or protection_epf[armor_data.protection_level])
    end
  end 

  gfx.text(0, 69, "Damage reduction: " .. string.format("%.3f", calculateReceivedDamage(armor_values, damage)), 0.8)
end

function getArmorProtectionLevel(armor)
  for index, enchantment in pairs(armor.enchant) do 
    if enchantment.name == "protection" then 
      return enchantment.level
    end
  end
  return 0
end

function calculateReceivedDamage(armor_data, damage) 
  if armor_data then 
    if javaMechanism then
      local total = damage * (1 - math.min(20, math.max(armor_data.defence_points / 5, armor_data.defence_points - damage / (2 + armor_data.toughness / 4))) / 25)
      return total - (((4 * armor_data.protection_level) / 100) * total)
    else 
      if armor_data.defence_points <= 0 then 
        return damage
      else 
        local defence = armor_data.defence_points * 4
        if armor_data.protection_level > 0 then
          defence = defence + ((100 - (armor_data.defence_points * 4)) * armor_data.protection_level * 0.4 * 0.075)
        end
        return damage - ((defence / 100) * damage)
      end
    end
  end 
end
