name = "Shulker display"
description = "Show a shulker box's contents in your inventory"

--[[
  Version: 1.0.0
  By: Tom16
]]

importLib("key-codes.lua")

--[[
  smol shulker contents viewer script that took waaaaaay too long to release
  originally used mouse coordinates to locate currently hovered inv slots
  thank onix for the better api via inventory.modify
  though it isn't perfect and you might get the shulker window showing when it
  isn't supposed to (if the shulker was the last slot you hovered)
  though I have no idea if there's an easy way to fix that
  anyway, enjoy

  -- Tom16 (aka. Jerry)
]]

renderEverywhere = true

local settings = {
  client.settings.addAir(2),

  client.settings.addInfo("Tint the background of the contents hover to the dye colour of the viewed shulker box."),
  colouredShulkers = client.settings.addNamelessBool("Coloured shulkers", true),

  client.settings.addAir(2),

  client.settings.addInfo("Assign a button to toggle between views (Full view and condensed item count view)"),
  ---@diagnostic disable-next-line: undefined-global
  toggleView = client.settings.addNamelessKeybind("Toggle view", KeyCodes.LeftShift),
  defaultView = client.settings.addNamelessEnum("Default view", 2, {{ 1, "Item count" }, { 2, "Full view" }}),
  countView = client.settings.addNamelessEnum("Count format", 1, {{ 1, "Total items" }, { 2, "Total stacks (rounded up)" }, { 3, "Total stacks (rounded down)" }}),

  client.settings.addInfo("This only applies to the condensed item count view."),

  client.settings.addCategory("Examples"),
  client.settings.addInfo("Total items: 2 stacks and 23 will show 151."),
  client.settings.addInfo("Total stacks (rounded up): 2 stacks and 23 will show 3."),
  client.settings.addInfo("Total stacks (rounded down): 2 stacks and 23 will show 2."),
  client.settings.stopCategory(),
}

MX, MY = gui.mousex, gui.mousey
local toggleView = false

function mouseIn(x, y, w, h)
  return (x <= MX() and MX() < x + w) and (y <= MY() and MY() < y + h)
end

function screenIs(...)
  for _, s in ipairs({ ... }) do if gui.screen() == s then return true end end
  return false
end

local shulkerItem = (function ()
  return function(item)
    if not item then return end
    if not item.name:find("shulker_box") then return end

    local nbt = (item.location ~= nil and item.location ~= -1) and getItemNbt(item.location) or item.nbt
    if not nbt or not nbt.Items or #nbt.Items == 0 then return end

    local items = {}
    local itemCounts = {}
    for key, value in pairs(nbt.Items) do
      if key == "str" or key == "strf" then goto cont end

      items[value.Slot] = value
      itemCounts[value.Name] = (itemCounts[value.Name] or 0) + value.Count

      ::cont::
    end

    local sortedCounts = {}
    for name, count in pairs(itemCounts) do table.insert(sortedCounts, { name, count }) end
    table.sort(sortedCounts, function (a, b) return a[2] > b[2] end)

    return {
      items = items,
      itemCounts = sortedCounts,
      colour = item.name:gsub("_shulker_box", "")
    }
  end
end)()
local renderShulker = (function ()
  ---@diagnostic disable: undefined-global

  -- Thanks onix for the tinting stuff
  local colourMult = { r = 1, g = 1, b = 1, a = 1 }
  local function setColour(r, g, b, a) gfx.color(r * colourMult.r, g * colourMult.g, b * colourMult.b, (a or 255) * colourMult.a) end
  local function setTint(r, g, b, a) colourMult = { r = (r or 255) / 255, g = (g or 255) / 255, b = (b or 255) / 255, a = (a or 255) / 255 } end

  local COLOURS = {
    white = "e4e9e9",
    light_gray = "8b8282",
    gray = "3e4246",
    black = "1f1f23",
    brown = "724728",
    red = "9a2422",
    orange = "f4730f",
    yellow = "fcc724",
    lime = "71bc18",
    green = "546d1c",
    cyan = "168691",
    light_blue = "3ab3da",
    blue = "33359b",
    purple = "7426a9",
    magenta = "b93eae",
    pink = "f38aa9",

    undyed = "ffffff"
  }

  local function renderBackground(x, y, w, h)
    setColour(0xc6, 0xc6, 0xc6)
    gfx.rect(x, y, w, h)

    setColour(0xff, 0xff, 0xff)
    gfx.rect(x, MY() - h - 12, w, 2)
    gfx.rect(x, MY() - h - 12, 2, h)

    setColour(0x55, 0x55, 0x55, 128)
    gfx.rect(x + w - 2, y, 2, h)
    gfx.rect(x, y + h - 2, w, 2)

    setColour(0, 0, 0)
    gfx.drawRect(x - 1, MY() - h - 13, w + 2, h + 2, 1)
  end

  local function itemCountText(count, slotX, slotY)
    if count == 1 then return end
    local countText = tostring(count)

    if settings.countView.value == 2 then
      countText = tostring((count + 63) // 64) .. "s"
    elseif settings.countView.value == 3 then
      local stacks = count // 64
      countText = stacks == 0 and tostring(count) or (tostring(stacks) .. "s")
    end

    -- Autocomplete typo xd (minecrafttia??? too much t)
    ---@diagnostic disable-next-line: undefined-field
    local textScale = gui.font().isMinecraftia and 1 or 1.2

    local tW, tH = gui.font().width(countText, textScale), gui.font().height * textScale
    gfx.color(255, 255, 255)
    gfx.text(slotX + 17 - tW, slotY + 17 - tH, countText, textScale)
  end

  local function drawSlot(slotX, slotY)
    setColour(0x8b, 0x8b, 0x8b)
    gfx.rect(slotX, slotY, 16, 16)

    setColour(0x37, 0x37, 0x37)
    gfx.rect(slotX - 1, slotY - 1, 1, 18)
    gfx.rect(slotX - 1, slotY - 1, 18, 1)

    setColour(0xff, 0xff, 0xff)
    gfx.rect(slotX - 1, slotY + 16, 18, 1)
    gfx.rect(slotX + 16, slotY - 1, 1, 18)
  end

  local function renderItemCounts(shulker, bgW, bgH, renderLeft)
    local i = 0

    for _, itemCount in ipairs(shulker.itemCounts) do
      local slotX = (MX() + 16) + 18 * (i % 9)
      local slotY = (MY() - bgH - 7) + 18 * (i // 9)

      if renderLeft then slotX = slotX - bgW - 22 end

      drawSlot(slotX, slotY)

      local item = getItem(itemCount[1])
      item.count = itemCount[2]

      ---@diagnostic disable-next-line: param-type-mismatch
      gfx.item(slotX, slotY, item)

      itemCountText(itemCount[2], slotX, slotY)

      i = i + 1
    end
  end

  local function renderItemSlots(shulker, bgW, bgH, renderLeft)
    for i = 0, 26 do
      local slotX = (MX() + 16) + 18 * (i % 9)
      local slotY = (MY() - bgH - 7) + 18 * (i // 9)

      if renderLeft then slotX = slotX - bgW - 22 end

      drawSlot(slotX, slotY)

      if not shulker.items[i] then goto cont end

      local item = itemFromNbt(shulker.items[i])

      ---@diagnostic disable-next-line: param-type-mismatch
      gfx.item(slotX, slotY, item, 1, true)

      ::cont::
    end
  end

  return function(shulker, counts)
    local bgW = (counts and (#shulker.itemCounts < 9 and #shulker.itemCounts or 9) or 9) * 18 + 8
    local bgH = (counts and #shulker.itemCounts // 9 + 1 or 3) * 18 + 8

    local bgX, bgY = MX() + 11, MY() - bgH - 12

    local renderLeft = bgX + bgW > gui.width()
    if renderLeft then bgX = MX() - bgW - 11 end

    if shulker.colour and settings.colouredShulkers.value then
      local hex = tonumber(COLOURS[shulker.colour], 16)
      local r, g, b = (hex >> 16) & 0xff, (hex >> 8) & 0xff, hex & 0xff

      setTint(r, g, b)
    else
      setTint(255, 255, 255)
    end

    renderBackground(bgX, bgY, bgW, bgH)

    if counts then
      renderItemCounts(shulker, bgW, bgH, renderLeft)
    else
      renderItemSlots(shulker, bgW, bgH, renderLeft)
    end
  end
end)()

-- might be missing some inv screens
local SUPPORTED_SCREENS = {
  "inventory_screen",
  "crafting_screen",
  "small_chest_screen",
  "ender_chest_screen",
  "barrel_screen",
  "shulker_box_screen",
  "large_chest_screen",
  "furnace_screen",
  "blast_furnace_screen",
  "smoker_screen",
  "dropper_screen",
  "dispenser_screen",
  "hopper_screen",
  "anvil_screen",
  "loom_screen",
  "enchanting_screen",
  "cartography_screen",
  "beacon_screen",
  "trade_screen",
  "horse_screen",
  "brewing_stand_screen",
  "smithing_table_screen",
  "grindstone_screen",
  "stonecutter_screen"
}

event.listen("KeyboardInput", function(key, down)
  if key == settings.toggleView.value then toggleView = down end
end)

local currentShulker = nil
event.listen("InventoryTick", function()
  currentShulker = nil

  local inv = player.inventory().modify()
  if not inv then return end

  -- small problem - if you dont hover another slot, as this is LAST hover
  -- slot val, the shulker view will stay (most visible on e.g. anvil or top of inv)
  -- no easy way to tell if im currently hovering a slot or not
  local item = inv.at(inv.lastHoverSlotName, inv.lastHoverSlotValue)
  currentShulker = shulkerItem(item)
end)

function render()
  if currentShulker == nil or not screenIs(table.unpack(SUPPORTED_SCREENS)) then return end

  renderShulker(currentShulker, toggleView == (settings.defaultView.value == 2))
end
