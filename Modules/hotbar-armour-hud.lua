name = "Hotbar Armour HUD"
description = "Armour HUD and offhand slot next to the hotbar."

--[[
  Version: 1.0.0
  By: Tom16
]]

Settings = {
  client.settings.addTitle("Armour HUD"),
  showArmourHud = client.settings.addNamelessBool("Show Armour HUD", true),
  hideArmourHud = client.settings.addNamelessBool("Auto hide Armour HUD", true),
  client.settings.addInfo("Hide Armour HUD when you're not wearing armour."),
  client.settings.addTitle("Offhand HUD"),
  showOffhandHud = client.settings.addNamelessBool("Show Offhand HUD", true),
  hideOffhandHud = client.settings.addNamelessBool("Auto hide Offhand HUD", true),
  client.settings.addInfo("Hide Offhand HUD when you're not holding anything in your offhand.")
}

local slot_texture = "textures/ui/hotbar_0" -- 20x22
local start_cap = "textures/ui/hotbar_start_cap" -- 1x22
local end_cap = "textures/ui/hotbar_end_cap" -- 1x22

local function renderSlots(x, y, num, items)
  items = items or {}

  gfx.texture(x, y, 1, 22, start_cap)
  for i = 0, num - 1 do
    gfx.texture(x + 1 + i * 20, y, 20, 22, slot_texture)
    if items[i + 1] then gfx.item(x + 1 + i * 20 + 2, y + 3, items[i + 1], 1, true) end
  end
  gfx.texture(x + 1 + num * 20, y, 1, 22, end_cap)
end

local function armourHud()
  local items = {
    player.inventory().armor().helmet,
    player.inventory().armor().chestplate,
    player.inventory().armor().leggings,
    player.inventory().armor().boots,
  }

  if Settings.hideArmourHud and items[1] == nil and items[2] == nil and items[3] == nil and items[4] == nil then return end

  renderSlots((gui.width() / 2) - 210, gui.height() - 23.5, 4, items)
end

local function offhandHud()
  local items = { player.inventory().offhand() }
  if Settings.hideOffhandHud and items[1] == nil then return end

  renderSlots((gui.width() / 2) - 120, gui.height() - 23.5, 1, items)
end

function render()
  if Settings.showArmourHud then armourHud() end
  if Settings.showOffhandHud then offhandHud() end
end
