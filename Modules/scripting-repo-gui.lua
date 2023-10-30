name = "Scripting Repo GUI"
description = "A GUI for installing/uninstalling/updating scripts from the OnixClient-Scripts/OnixClient_Scripts repository. By Tom16 (aka Jerry)"
workingDir = "RoamingState/OnixClient/Scripts"

--[[
  Foreword

  I made this a few months ago, over multiple nights and some days
  There are a lot of janky solutions to problems, and some questionable code practices
  There are also many places where I probably just gave up half way through and went to bed, then to completely forget about them
  i.e A completely normal program by me.
  Basically don't be surprised if it doesn't work, if it deletes or resets custom scripts, or just completely crashes your game.
  As a whole the script definitely isn't finished yet... There are a lot of other features I would like to add (and the settings menu is still empty)
  Hopefully I'll survive long enough to make another tab to put on the sidebar :)
  Enjoy your script repository
    - Tom (discord: @s.amat)
]]

importLib("better-notifications.lua")
importLib("easing-functions.lua")
importLib("scripting-repo.lua")
importLib("key-codes.lua")
importLib("animate.lua")

local settings = {
  openKey = client.settings.addNamelessKeybind("Open", KeyCodes.KeyJ),
}

--#region Variables
local inMenu = false

local mouseDown = false

local openMenuTime = 0
local closeMenuTime = 0

local timeSinceOpen = 0
local timeSinceClose = 0

local modScroll = 0
local prevModScroll = 0
local mouseInScroll = false
local mouseOnScrollBar = false
local mouseScrollStartPos = 0
local isScrolling = false

---@type "all" | "installed" | "updates-available"
local modFilter = "all"
local changeFilterTime = 0

---@type "main" | "module"
local menuContentState = "main"
local menuContentUpdateStart = 0
local menuSelectedModule = nil
local modInfoScroll = 0
local modInfoHeight = 0

---@type "list" | "grid"
local modListViewType = "grid"

---@type "modules" | "settings"
local selectedTab = "modules"
local tabUpdating = false

local mouseInHoverButton = false
local isUpdating = false
local startUpdatingTime = 0

local animateSettings = false
local startSettingsHoverTime = 0
local settingsHoverState = false

local inSearchBar = false
local focusSearchBarTime = 0
local searchBarContent = {}
local searchBarCursor = 0
local lastSearchQuery = "-" -- just something which isn't "" so it fetches the modules
local keysDown = {
  ctrl = false,
  shift = false,
}

local TypeableKeys = {
  [KeyCodes.KeyA] = "a",
  [KeyCodes.KeyB] = "b",
  [KeyCodes.KeyC] = "c",
  [KeyCodes.KeyD] = "d",
  [KeyCodes.KeyE] = "e",
  [KeyCodes.KeyF] = "f",
  [KeyCodes.KeyG] = "g",
  [KeyCodes.KeyH] = "h",
  [KeyCodes.KeyI] = "i",
  [KeyCodes.KeyJ] = "j",
  [KeyCodes.KeyK] = "k",
  [KeyCodes.KeyL] = "l",
  [KeyCodes.KeyM] = "m",
  [KeyCodes.KeyN] = "n",
  [KeyCodes.KeyO] = "o",
  [KeyCodes.KeyP] = "p",
  [KeyCodes.KeyQ] = "q",
  [KeyCodes.KeyR] = "r",
  [KeyCodes.KeyS] = "s",
  [KeyCodes.KeyT] = "t",
  [KeyCodes.KeyU] = "u",
  [KeyCodes.KeyV] = "v",
  [KeyCodes.KeyW] = "w",
  [KeyCodes.KeyX] = "x",
  [KeyCodes.KeyY] = "y",
  [KeyCodes.KeyZ] = "z",

  [KeyCodes.Num0] = "0",
  [KeyCodes.Num1] = "1",
  [KeyCodes.Num2] = "2",
  [KeyCodes.Num3] = "3",
  [KeyCodes.Num4] = "4",
  [KeyCodes.Num5] = "5",
  [KeyCodes.Num6] = "6",
  [KeyCodes.Num7] = "7",
  [KeyCodes.Num8] = "8",
  [KeyCodes.Num9] = "9",

  [KeyCodes.NumPad0] = "0",
  [KeyCodes.NumPad1] = "1",
  [KeyCodes.NumPad2] = "2",
  [KeyCodes.NumPad3] = "3",
  [KeyCodes.NumPad4] = "4",
  [KeyCodes.NumPad5] = "5",
  [KeyCodes.NumPad6] = "6",
  [KeyCodes.NumPad7] = "7",
  [KeyCodes.NumPad8] = "8",
  [KeyCodes.NumPad9] = "9",

  [KeyCodes.NumPadAdd] = "+",
  [KeyCodes.NumPadSubtract] = "-",
  [KeyCodes.NumPadMultiply] = "*",
  [KeyCodes.NumPadDivide] = "/",
  [KeyCodes.NumPadDecimal] = ".",

  [KeyCodes.KeyDot] = ".",
  [KeyCodes.KeyComma] = ",",
  [KeyCodes.KeyMinus] = "-",
  [KeyCodes.KeyPlus] = "+",

  [KeyCodes.Space] = " ",
}
local ANIMATION_DUR = 0.4
  --* 10 --uncomment to make slower for debugging
  --* 0 --uncomment to disable animations

local MODULE_HEIGHT = 30
local GRID_MODULE_WIDTH = 30
local MODULES = {}
local INSTALLED_MODULES = {}
local modIndices = {}
local filteredModules = {}
local visibleModules = {}
local outdatedModules = {}

local IMAGES = {
  Repo = nil,
  Installed = nil,
  UpdateAvailable = nil,
  OutOfSync = nil,
  UpdateAll = nil,
  Settings = nil,
  Search = nil,
  ListView = nil,
  GridView = nil,
}

local IMAGE_FILES = {
  Repo = "repository.png",
  Installed = "check.png",
  UpdateAvailable = "cloud-download.png",
  OutOfSync = "cloud-sync.png",
  UpdateAll = "refresh-double.png",
  Settings = "settings.png",
  Search = "search.png",
  ListView = "list.png",
  GridView = "view-grid.png",
}
--#endregion

--#region Useful functions
local function clamp(num, low, high) return num < low and low or (num > high and high or num) end
local function tableFind(table, fn) for k, v in pairs(table) do if fn(v, k, table) then return v end end end
local function tableLen(table) local len = 0 for _,_ in pairs(table) do len = len + 1 end return len end
local function tableEvery(table, fun) local res = true for i, v in pairs(table) do if not fun(v, i, table) then res = false break end end return res end

local function outOfDate(module)
  if not INSTALLED_MODULES[module.file] then return false end

  local fileHash = fs.hash("Modules/" .. module.file, "r")
  if not fileHash then return true end

  return fileHash ~= module.hash
end
--#endregion

--#region Updating module state
local function filterModules(cb)
  cb = cb or function() end

  local oldModules = table.clone(MODULES)
  local tempFilteredModules1 = {}
  local tempFilteredModules2 = {}
  filteredModules = {}

  for _, module in ipairs(oldModules) do
    if modFilter == "all" then
      local isOutOfDate = outOfDate(module)
      modIndices[module.file] = isOutOfDate and #tempFilteredModules1 or #tempFilteredModules1 + #tempFilteredModules2
      table.insert(isOutOfDate and tempFilteredModules1 or tempFilteredModules2, module)
    elseif modFilter == "installed" then
      if INSTALLED_MODULES[module.file] then table.insert(tempFilteredModules1, module) end
    elseif modFilter == "updates-available" then
      if outdatedModules[module.file] then table.insert(tempFilteredModules1, module) end
    end

    ::cont::
  end

  for _, v in ipairs(tempFilteredModules1) do table.insert(filteredModules, v) end
  for _, v in ipairs(tempFilteredModules2) do table.insert(filteredModules, v) end

  -- funny hack to get the search results to update
  lastSearchQuery = "-"

  cb()
end

local function checkForUpdates(cb)
  outdatedModules = {}

  for file, module in pairs(INSTALLED_MODULES) do
    local localHash = fs.hash("Modules/" .. file, "r")
    if not localHash then goto cont end

    if localHash == module.hash then goto cont end

    outdatedModules[file] = module

    ::cont::
  end

  filterModules(cb)
end

local function getInstalledModules(cb)
  cb = cb or function() end

  INSTALLED_MODULES = {}

  local clientModules = client.modules()
  local fileModules = fs.files("Modules")

  for _, fileModule in ipairs(fileModules) do
    fileModule = fileModule:sub(string.len("Modules\\") + 1)
    local repoModule = tableFind(MODULES, function(x) return x.file == fileModule end)
    if not repoModule then goto cont end

    local clientModule = tableFind(clientModules, function(x) return x.name == repoModule.name end)
    if not clientModule then goto cont end

    INSTALLED_MODULES[fileModule] = repoModule

    ::cont::
  end

  checkForUpdates(cb)
end

local function fetchRepoModules(cb)
  cb = cb or function() end

  scriptingRepo.getIndex(function (index)
    MODULES = {}

    for _, indexModule in ipairs(index.modules) do
      local module = table.clone(indexModule)
      module.hover = { changeTime = 0, value = false }
      modIndices[module.file] = modIndices[module.file] or #MODULES
      table.insert(MODULES, module)
    end

    getInstalledModules(cb)
  end)
end
--#endregion

--#region Saving state
local function saveState(type)
  local stateFile = io.open("Data/ScriptingRepoUI/state.json", "w")
  if stateFile == nil then return end

  stateFile:write(tableToJson({
    inMenu = inMenu,
    contentState = menuContentState,
    selectedModule = menuSelectedModule ~= nil and menuSelectedModule.file or "",
    installType = type,
    searchContent = table.concat(searchBarContent, ""),
    modFilter = modFilter,
    modScroll = modScroll,
  }))

  io.close(stateFile)
end
--#endregion

---@param open boolean
---@return true lol
local function handleMenu(open)
  if open then
    openMenuTime = os.clock()
    fetchRepoModules()
  else
    closeMenuTime = os.clock()
    modScroll = 0

    menuContentState = "main"
    menuSelectedModule = nil

    searchBarContent = {}
    searchBarCursor = 0
  end

  if inMenu == open then return true end

  inMenu = open
  gui.setGrab(open or not (gui.screen() == "hud_screen"))

  mouseDown = false

  saveState("none")

  return true
end

--#region Event listeners
event.listen("KeyboardInput", function(key, down)
  if key == KeyCodes.Ctrl then
    keysDown.ctrl = down
  elseif key == KeyCodes.Shift then
    keysDown.shift = down
  end

  if not inMenu then
    -- open menu
    if key == settings.openKey.value and down then return handleMenu(true) end

    -- ignore event
    return false
  end

  if inSearchBar then
    if not down then return true end

    if key == KeyCodes.Esc then inSearchBar = false focusSearchBarTime = os.clock() return true end

    if key == KeyCodes.LeftArrow or key == KeyCodes.RightArrow then
      -- Arrow key seeking
      if #searchBarContent == 0 then return true end

      if
        (key == KeyCodes.LeftArrow and searchBarCursor == 0) or
        (key == KeyCodes.RightArrow and searchBarCursor == #searchBarContent)
      then
        return true
      end

      if not keysDown.ctrl then
        searchBarCursor = clamp(searchBarCursor + (key == KeyCodes.LeftArrow and -1 or 1), 0, #searchBarContent)

        return true
      else
        local originalSeek = searchBarCursor

        for i = searchBarCursor, (key == KeyCodes.LeftArrow and 0 or #searchBarContent), (key == KeyCodes.LeftArrow and -1 or 1) do
          searchBarCursor = i

          if searchBarContent[i] == " " and searchBarCursor ~= originalSeek then
            searchBarCursor = key == KeyCodes.LeftArrow and i or i - 1
            break
          end
        end

        return true
      end

    elseif key == KeyCodes.Backspace or key == KeyCodes.Delete then
      -- Delete and backspace
      if #searchBarContent == 0 then return true end

      if
        (key == KeyCodes.Backspace and searchBarCursor == 0) or
        (key == KeyCodes.Delete and searchBarCursor == #searchBarContent)
      then
        return true
      end

      if not keysDown.ctrl then
        table.remove(searchBarContent, clamp(searchBarCursor + (key == KeyCodes.Backspace and 0 or 1), 1, #searchBarContent))
        searchBarCursor = searchBarCursor + (key == KeyCodes.Backspace and -1 or 0)

        return true
      else
        local originalSeek = searchBarCursor

        for i = searchBarCursor, (key == KeyCodes.Backspace and 0 or #searchBarContent), (key == KeyCodes.Backspace and -1 or 1) do
          searchBarCursor = i

          if searchBarContent[i] == " " and searchBarCursor ~= originalSeek then
            searchBarCursor = key == KeyCodes.Backspace and i or i - 1
            break
          end

          table.remove(searchBarContent, clamp(key == KeyCodes.Backspace and i or i + 1, 1, #searchBarContent))
        end

        return true
      end
    end

    if TypeableKeys[key] then
      table.insert(searchBarContent, clamp(searchBarCursor + 1, 1, #searchBarContent + 1), (keysDown.shift and TypeableKeys[key]:upper() or TypeableKeys[key]))
      searchBarCursor = searchBarCursor + 1
    end

    return true
  end

  -- close menu
  if (key == settings.openKey.value or key == KeyCodes.Esc) and down then
    if menuContentState == "module" then
      menuContentState = "main"
      menuContentUpdateStart = os.clock()

      return true
    end

    handleMenu(false)

    return true
  end

  -- Other keys

  return true
end)

event.listen("MouseInput", function(button, down)
  if not inMenu then return false end

  if button == 1 then mouseDown = down end

  if button == 4 then
    if not mouseInScroll then return true end

    if menuContentState == "main" then
      modScroll = clamp(
        modScroll + (down and 10 or -10), 0,
        modListViewType == "list"
          and math.max((#visibleModules * MODULE_HEIGHT) - (MODULE_HEIGHT * 6), 0)
          or math.max((#visibleModules // 5) * GRID_MODULE_WIDTH - (GRID_MODULE_WIDTH * 2.5))
      )
    elseif menuContentState == "module" then
      modInfoScroll = clamp(
        modInfoScroll + (down and 10 or -10),
        0, math.max(0, modInfoHeight - gui.height() / 8 * 6)
      )
      --notification("mod info scroll", tostring(modInfoScroll))
    end
  end

  return true
end)
--#endregion

--#region Helper functions
local function wrapText(text, scale, width)
  local contentParts = string.split(text, " ")

  local lines = {""}
  for _, word in ipairs(contentParts) do
    local tmpLine = lines[#lines] .. word .. " "
    local lineW,_ = gfx2.textSize(tmpLine, scale)

    if lineW < width then
      lines[#lines] = tmpLine
    else
      table.insert(lines, word .. " ")
    end
  end

  local _, lineHeight = gfx2.textSize(lines[1])

  return lines, lineHeight
end

local function formatDate(isoStr)
  local year, month, day, hour, min, sec = string.match(isoStr, "(%d+)-(%d+)-(%d+)T(%d+):(%d+):(%d+.%d+)Z")
  local time = os.time({ year = year, month = month, day = day, hour = hour, min = min, sec = math.floor(sec) })

  return time
end

local function searchModules(query)
  query = query or ""

  if query == lastSearchQuery and #filteredModules > 0 then return end

  if #filteredModules > 0 then lastSearchQuery = query end

  visibleModules = {}
  if query == "" then
    visibleModules = table.clone(filteredModules)
    return
  end

  query = string.lower(query)

  local queryWords = string.split(query, " ")

  local titleResults = {}
  local titleResults2 = {}
  local descriptionResults = {}

  for _, module in ipairs(filteredModules) do
    local foundTitleStart = string.find(string.lower(module.name), "^" .. query)
    if not foundTitleStart then goto title2 end

    table.insert(titleResults, module)
    goto cont

    ::title2::

    for _, word in ipairs(queryWords) do
      local found = string.find(string.lower(module.name), word)
      if not found then goto desc end
    end

    table.insert(titleResults2, module)
    goto cont

    ::desc::

    if not module.description or module.description == "" then goto cont end

    for _, word in ipairs(queryWords) do
      local found = string.find(string.lower(module.description), word)
      if not found then goto cont end
    end

    table.insert(descriptionResults, module)

    ::cont::
  end

  for _, titleRes in ipairs(titleResults) do table.insert(visibleModules, titleRes) end
  for _, title2Res in ipairs(titleResults2) do table.insert(visibleModules, title2Res) end
  for _, descRes in ipairs(descriptionResults) do table.insert(visibleModules, descRes) end

  changeFilterTime = os.clock()
end

local function chars(str)
  local res = {}
  for i = 1, #str do table.insert(res, str:sub(i, i)) end
  return res
end

local function outOfSync(module)
  if not INSTALLED_MODULES[module.file] then return false end
  if not outdatedModules[module.file] then return false end

  local stats = fs.stats("Modules/" .. module.file)
  local repoLastUpdate = formatDate(module.lastUpdated)

  return stats.writetime > repoLastUpdate
end

local function updateAllModules()
  local downloaded = {}
  for file, _ in pairs(outdatedModules) do downloaded[file] = false end

  for file, module in pairs(outdatedModules) do
    scriptingRepo.downloadScript(module.url, function()
      downloaded[file] = true
      --print(tableToJson(downloaded))
      if tableEvery(downloaded, function(x) return x end) then
        isUpdating = false
        saveState("update-all")
        client.execute("lua reload")
      end
    end)
  end
end
--#endregion

--#region UI --
local function blur()
  local opacity = 0

  if timeSinceOpen <= ANIMATION_DUR then
    opacity = interpolate(
      0, 0.75, timeSinceOpen,
      easingsFunctions.easeOutExpo
    )
  elseif timeSinceClose <= ANIMATION_DUR then
    opacity = interpolate(
      0.75, 0, timeSinceClose,
      easingsFunctions.easeInExpo
    )
  elseif inMenu then opacity = 0.75 end

  gfx2.blur(0, 0, gui.width(), gui.height(), opacity, 0)
end

local function sidebar(x, y, width, height)
  local mx, my = gui.mousex(), gui.mousey()

  local function tab(tabY, name, type)
    local hover = x < mx and mx < x + width and tabY < my and my < tabY + 20

    if selectedTab == type then
      gfx2.color(gui.theme().highlight)
      gfx2.fillRect(x, tabY, width, 20)
    end

    local modulesTW, modulesTH = gfx2.textSize(name, 1.3)
    gfx2.pushTransformation({ 4, hover and 1.1 or 1, hover and 1.1 or 1, x + width / 2, tabY + 10 })
    gfx2.color(gui.theme().text)
    gfx2.text(x + (width / 2 - modulesTW / 2), tabY + (10 - modulesTH / 2), name, 1.3)
    gfx2.popTransformation()

    if hover and mouseDown and selectedTab ~= type then
      mouseDown = false
      menuContentUpdateStart = os.clock()
      tabUpdating = true
      selectedTab = type
    end

    return hover
  end

  -- The actual graphical stuff
  local function content()
    gfx2.color(gui.theme().windowBackground)
    gfx2.fillRoundRect(x, y, width, height, 5)

    tab(y + 5, "Modules", "modules")

    -- User info
    local nameW, nameH = gfx2.textSize(player.name(), 1.2)
    gfx2.color(gui.theme().text)
    gfx2.cdrawImage(x + 10, y + height - 26, 16, 16, player.skin().texture(), 8, 8, 8, 8)
    gfx2.text(x + 31, y + height - 26 + (8 - nameH / 2), player.name(), 1.2)

    local settingsHover = (x + width - 22) < mx and mx < (x + width - 22) + 12 and (y + height - 26 + 2) < my and my < (y + height - 26 + 2) + 12
    gfx2.pushTransformation({
      3, interpolate(0, settingsHover and 90 or -90, os.clock() - startSettingsHoverTime, easingsFunctions.easeOutExpo),
      (x + width - 22 + 6), (y + height - 26 + 2 + 6)
    })

    gfx2.drawImage(x + width - 22, y + height - 26 + (8 - 6), 12, 12, IMAGES.Settings, 1, true)

    gfx2.popTransformation()

    if settingsHover ~= settingsHoverState and not animateSettings then
      animateSettings = true
      startSettingsHoverTime = os.clock()
      settingsHoverState = settingsHover
    end

    if os.clock() - startSettingsHoverTime > ANIMATION_DUR then
      animateSettings = false
    end

    if settingsHover and mouseDown and selectedTab ~= "settings" then
      mouseDown = false
      menuContentUpdateStart = os.clock()
      tabUpdating = true
      selectedTab = "settings"
    end

    gfx2.color(gui.theme().outline)
    gfx2.drawRoundRect(x, y, width, height, 5, 1)
  end

  -- Rendering logic
  if timeSinceOpen <= ANIMATION_DUR then
    animate.scale(
      openMenuTime, { x = 0, y = 0 }, { x = 1, y = 1 },
      { x = gui.width() / 2, y = gui.height() / 2 },
      content, ANIMATION_DUR, easingsFunctions.easeOutExpo
    )
  elseif timeSinceClose <= ANIMATION_DUR then
    animate.scale(
      closeMenuTime, { x = 1, y = 1 }, { x = 0, y = 0 },
      { x = gui.width() / 2, y = gui.height() / 2 },
      content, ANIMATION_DUR, easingsFunctions.easeInExpo
    )
  elseif inMenu then
    content()
  end
end

local function listMenuModule(module, x, y, width, height, moduleIndex)
  -- The actual graphical stuff
  local function content()
    gfx2.pushClipArea(x - 0.5, y - 0.5, width + 1, height + 1)

    -- Background
    gfx2.color(gui.theme()[module.hover.value and "highlight" or "windowBackground"])
    gfx2.fillRoundRect(x, y, width, height, 5)

    -- Name
    gfx2.color(gui.theme().text)
    gfx2.text(x + 3, y + 1, module.name, 1.2)

    local _, nameHeight = gfx2.textSize(module.name, 1.2)

    -- Last updated
    local timeUpdatedObj = formatDate(module.lastUpdated)
    local timeUpdated = --[["Last updated: " ..]] tostring(os.date("%A, %dth %B %Y, %H:%M", timeUpdatedObj))

    local timeW, timeH = gfx2.textSize(timeUpdated, 1.2)
    gfx2.text(x + width - timeW - 3, y, timeUpdated, 1.2)

    -- Filename
    local fileNameW, _ = gfx2.textSize((modIndices[module.file] .. " ") ..module.file)
    gfx2.text(x + width - fileNameW - 3, y + timeH, (modIndices[module.file] .. " ") .. module.file)

    if outdatedModules[module.file] ~= nil then
      -- Out of sync = The file has been edited since updating.
      -- Outdated = There has been an update to the file on the repo.
      local isOutOfSync = outOfSync(module)

      ---@diagnostic disable-next-line: param-type-mismatch
      gfx2.drawImage(x + width - 15, y + height - 15, 12, 12, isOutOfSync and IMAGES.OutOfSync or IMAGES.UpdateAvailable, 1, true)

      local text = isOutOfSync and "Installed (out of sync with repo)" or "Installed (update available)"

      local installedTextW, installedTextH = gfx2.textSize(text)
      gfx2.text(x + width - 17 - installedTextW, y + height - 15 + (6.5 - installedTextH / 2), text)
    elseif INSTALLED_MODULES[module.file] ~= nil then
      gfx2.drawImage(x + width - 15, y + height - 15, 12, 12, IMAGES.Installed, 1, true)
      local installedTextW, installedTextH = gfx2.textSize("Installed")
      gfx2.text(x + width - 15 - installedTextW, y + height - 15 + (6.5 - installedTextH / 2), "Installed")
    end

    -- Description
    local lines = wrapText(module.description or "", 1, width - fileNameW)
    for lineInd, line in ipairs(lines) do
      local _, lineH = gfx2.textSize(line)
      gfx2.text(x + 3, y + nameHeight + (lineInd - 1) * lineH, line)
    end

    -- Outline
    gfx2.color(gui.theme().outline)
    gfx2.drawRoundRect(x, y, width, height, 5, 1)

    gfx2.popClipArea()
  end

  -- Rendering logic
  local mx, my = gui.mousex(), gui.mousey()
  local hover = (x < mx and mx < x + width and y < my and my < y + height)
    and not mouseInHoverButton
    and not isScrolling

  if module.hover.value ~= hover then
    module.hover.value = hover
    module.hover.changeTime = os.clock()
  end

  if os.clock() - changeFilterTime <= ANIMATION_DUR and modIndices[module.file] ~= moduleIndex - 1 then
    animate.translate(
      changeFilterTime,
      { x = 0, y = modIndices[module.file] * MODULE_HEIGHT },
      { x = 0, y = 0 },
      content, ANIMATION_DUR, easingsFunctions.easeOutExpo
    )
  else
    if os.clock() - changeFilterTime > ANIMATION_DUR then modIndices[module.file] = moduleIndex - 1 end

    if os.clock() - module.hover.changeTime <= ANIMATION_DUR then
      animate.scale(
        module.hover.changeTime,
        hover and { x = 1, y = 1 } or { x = 1.025, y = 1.025 },
        hover and { x = 1.025, y = 1.025 } or { x = 1, y = 1 },
        { x = x, y = y + height / 2 },
        content, ANIMATION_DUR,
        easingsFunctions.easeOutExpo
      )
    else
      gfx2.pushTransformation({
        4, hover and 1.025 or 1, hover and 1.025 or 1,
        x, y + height / 2
      })
      content()
      gfx2.popTransformation()
    end
  end


  if module.hover.value and mouseDown then
    mouseDown = false

    if menuContentState == "module" then return end

    menuContentState = "module"
    menuContentUpdateStart = os.clock()
    menuSelectedModule = module
  end
end

local function gridMenuModule(module, x, y, width, height, moduleIndex)
  -- The actual graphical stuff
  local function content()
    gfx2.pushClipArea(x - 0.5, y - 0.5, width + 1, height + 1)

    -- Background
    gfx2.color(gui.theme()[module.hover.value and "highlight" or "windowBackground"])
    gfx2.fillRoundRect(x, y, width, height, 5)

    -- Name
    gfx2.color(gui.theme().text)
    local nameLines = wrapText(module.name, 1.2, width - 6)
    local nameHeight = 0
    for _, line in ipairs(nameLines) do
      if #line == 0 then goto cont end

      local _, lineH = gfx2.textSize(line)
      gfx2.text(x + 3, y + 1 + nameHeight, line, 1.2)
      nameHeight = nameHeight + lineH

      ::cont::
    end

    -- Filename
    local _, filenameH = gfx2.textSize((modIndices[module.file] .. " ") ..module.file)
    gfx2.text(x + 3, y + nameHeight + 2, module.file, 0.9)

    -- Line
    gfx2.color(gui.theme().outline)
    gfx2.drawLine(x + 3, y + nameHeight + 2 + filenameH + 2, x + width - 3, y + nameHeight + 2 + filenameH + 2, 1)

    gfx2.color(gui.theme().text)
    -- Last updated
    local updatedEpoch = formatDate(module.lastUpdated)
    local timeUpdated = tostring(os.date("%H:%M, " .. (client.language() == "en_US" and "%m/%d/%Y" or "%d/%m/%Y"), updatedEpoch))

    local dateW, dateH = gfx2.textSize(timeUpdated, 1)
    gfx2.text(x + 3, y + nameHeight + 2 + filenameH + 2 + 1 + 2, timeUpdated, 1)


    if outdatedModules[module.file] ~= nil then
      -- Out of sync = The file has been edited since updating.
      -- Outdated = There has been an update to the file on the repo.
      local isOutOfSync = outOfSync(module)

      ---@diagnostic disable-next-line: param-type-mismatch
      gfx2.drawImage(x + 3, y + height - 15, 12, 12, isOutOfSync and IMAGES.OutOfSync or IMAGES.UpdateAvailable, 1, true)
    elseif INSTALLED_MODULES[module.file] ~= nil then
      gfx2.drawImage(x + 3, y + height - 15, 12, 12, IMAGES.Installed, 1, true)
    end

    -- Outline
    gfx2.color(gui.theme().outline)
    gfx2.drawRoundRect(x, y, width, height, 5, 1)

    gfx2.popClipArea()
  end

  -- Rendering logic
  local mx, my = gui.mousex(), gui.mousey()
  local hover = (x < mx and mx < x + width and y < my and my < y + height)
    and not mouseInHoverButton
    and not isScrolling

  if module.hover.value ~= hover then
    module.hover.value = hover
    module.hover.changeTime = os.clock()
  end

  if os.clock() - changeFilterTime <= ANIMATION_DUR and modIndices[module.file] ~= moduleIndex - 1 then
    gfx2.pushTransformation({ 4, hover and 1 or 0.9, hover and 1 or 0.9, x + width / 2, y + height / 2 })

    animate.translate(
      changeFilterTime,
      { x = (modIndices[module.file] % 5) * GRID_MODULE_WIDTH, y = (modIndices[module.file] // 5) * GRID_MODULE_WIDTH },
      { x = 0, y = 0 },
      content, ANIMATION_DUR, easingsFunctions.easeOutExpo
    )

    gfx2.popTransformation()
  else
    if os.clock() - changeFilterTime > ANIMATION_DUR then modIndices[module.file] = moduleIndex - 1 end

    if os.clock() - module.hover.changeTime <= ANIMATION_DUR then
      animate.scale(
        module.hover.changeTime,
        hover and { x = 0.9, y = 0.9 } or { x = 1, y = 1 },
        hover and { x = 1, y = 1 } or { x = 0.9, y = 0.9 },
        { x = x + width / 2, y = y + height / 2 },
        content, ANIMATION_DUR,
        easingsFunctions.easeOutExpo
      )
    else
      gfx2.pushTransformation({
        4, hover and 1 or 0.9, hover and 1 or 0.9,
        x + width / 2, y + height / 2
      })
      content()
      gfx2.popTransformation()
    end
  end


  if module.hover.value and mouseDown then
    mouseDown = false

    if menuContentState == "module" then return end

    menuContentState = "module"
    menuContentUpdateStart = os.clock()
    menuSelectedModule = module
  end
end

local function button(x, y, width, height, text, scale, color)
  color = color or gui.theme().button

  local function content()
    gfx2.color(color)
    gfx2.fillRect(x, y, width, height)

    local textW, textH = gfx2.textSize(text, scale)

    gfx2.color(gui.theme().text)
    gfx2.text(x + (width / 2 - textW / 2), y + (height / 2 - textH / 2), text, scale)
  end

  local mx, my = gui.mousex(), gui.mousey()
  local hover = x < mx and mx < x + width and y < my and my < y + height

  gfx2.pushTransformation({ 4, hover and 1.1 or 1, hover and 1.1 or 1, x + width / 2, y + height / 2 })
  content()
  gfx2.popTransformation()

  return hover
end

local function menu(x, y, width, height)
  -- Actual graphical stuff
  local function content_main()
    -- Render modules
    for i, module in ipairs(visibleModules) do
      if modListViewType == "list" then
        local modY = y + 10 + MODULE_HEIGHT * (i - 1) - modScroll

        -- Only render if the mod is visible
        if modY < height + MODULE_HEIGHT and modY > y - MODULE_HEIGHT then
          listMenuModule(module, x + 5, modY, width - 30, MODULE_HEIGHT - 5, i)
        end
      elseif modListViewType == "grid" then
        local modX = x + 5 + GRID_MODULE_WIDTH * ((i - 1) % 5)
        local modY = y + 10 + GRID_MODULE_WIDTH * ((i - 1) // 5) - modScroll

        if modY < height + GRID_MODULE_WIDTH and modY > y - GRID_MODULE_WIDTH then
          gridMenuModule(module, modX, modY, GRID_MODULE_WIDTH, GRID_MODULE_WIDTH, i)
        end
      end
    end

    -- Handle scrolling
    -- This was and is pain and suffering
    if (modListViewType == "list" and #visibleModules > 6) or (modListViewType == "grid" and #visibleModules > 5 * 3) then
      local barX, barBgY = x + width - 9, y + 10

      gfx2.color(gui.theme().highlight)
      gfx2.fillRoundRect(barX, barBgY, 4, height - 15, 2)

      -- Calculate the scrollbar's Y position and height
      local barY =
        modListViewType == "list"
          and barBgY + ((height - 15) / (#visibleModules * MODULE_HEIGHT)) * modScroll
          or barBgY + ((height - 15) / (math.ceil(#visibleModules / 5) * GRID_MODULE_WIDTH)) * modScroll

      local barHeight =
        modListViewType == "list"
          and ((height - 15) / #visibleModules) * 6 -- 6 modules are visible at a time
          or ((height - 15) / math.ceil(#visibleModules / 5)) * ((height - 15) / GRID_MODULE_WIDTH)

      -- Make it draggable with mouse
      local mx, my = gui.mousex(), gui.mousey()
      mouseOnScrollBar = barX < mx and mx < barX + 4 and barY < my and my < barY + barHeight

      if (mouseOnScrollBar or mouseScrollStartPos ~= 0) and mouseDown then
        -- If wasn't previously dragging, set start pos
        if mouseScrollStartPos == 0 then mouseScrollStartPos = my; isScrolling = true end

        local scrollVal =
          modListViewType == "list"
            and (#visibleModules * MODULE_HEIGHT) * (my - barBgY) / (height - 15)
            or math.ceil(#visibleModules / 5) * GRID_MODULE_WIDTH * (my - barBgY) / (height - 15)

        -- Setting modScroll is enough as the bar's Y position
        -- is calculated from this value too
        modScroll = clamp(
          scrollVal, 0,
          modListViewType == "list"
            and math.max((#visibleModules * MODULE_HEIGHT) - (MODULE_HEIGHT * 6), 0)
            or math.max((math.ceil(#visibleModules / 5) * GRID_MODULE_WIDTH) - (height - 15))
        )

        mouseScrollStartPos = my
      end

      -- Reset the start pos if you stop dragging
      if mouseScrollStartPos ~= 0 and not mouseDown then mouseScrollStartPos = 0; isScrolling = false end

      -- Render the scrollbar
      gfx2.color(gui.theme().scrollbar)
      gfx2.fillRoundRect(barX, barY, 4, barHeight, 2)
    end
  end

  local function content_module()
    local modInfoY = y - modInfoScroll

    gfx2.color(gui.theme().text)

    if not menuSelectedModule then
      gfx2.text(x + 5, modInfoY + 5, "HALLO", 2)
      return
    end

    -- Name
    gfx2.text(x + 5, modInfoY + 5, menuSelectedModule.name, 2)
    local _, titleH = gfx2.textSize(menuSelectedModule.name, 2)

    -- Install / Uninstall / Update buttons
    local isInstalled = INSTALLED_MODULES[menuSelectedModule.file] ~= nil

    local buttonsH = 0
    if isInstalled then
      -- Enable/Disable
      local clientMod = tableFind(client.modules(), function(mod) return menuSelectedModule.name == mod.name end)
      local toggleW, toggleH = 0, 0
      if not clientMod then goto uninstall end

      do
        toggleW, toggleH = gfx2.textSize(clientMod.enabled and "Disable" or "Enable", 1.1)
        local toggleHover = button(
          x + 5, modInfoY + 5 + titleH, toggleW + 6, toggleH,
          clientMod.enabled and "Disable" or "Enable",
          1.1, gui.theme()[clientMod.enabled and "disabled" or "enabled"]
        )

        if toggleHover and mouseDown then
          clientMod.enabled = not clientMod.enabled
          mouseDown = false
        end
      end

      ::uninstall::

      local uninstallW, textH = gfx2.textSize("Uninstall", 1.1)
      do
        local uninstallHover = button(x + 5 + toggleW + (toggleW == 0 and 0 or 10), modInfoY + 5 + titleH, uninstallW + 6, textH, "Uninstall", 1.1)

        if uninstallHover and mouseDown then
          mouseDown = false

          fs.delete("Modules/" .. menuSelectedModule.file)

          saveState("uninstall")
          client.execute("lua reload")

          fetchRepoModules()
        end
      end

      local isOutOfSync = outOfSync(menuSelectedModule)
      local syncUpdateButtonText = isOutOfSync and "Resynchronize" or "Update"
      local updateW, _ = gfx2.textSize(syncUpdateButtonText, 1.1)
      if outdatedModules[menuSelectedModule.file] then
        local updateHover = button(
          x + 5 + toggleW + (toggleW == 0 and 0 or 10) + uninstallW + 10, modInfoY + 5 + titleH,
          updateW + 6, textH, syncUpdateButtonText, 1.1
        )

        if updateHover and mouseDown then
          mouseDown = false

          notification(
            (isOutOfSync and "Resynchronizing" or "Updating") .. " module...",
            (isOutOfSync and "Resynchronizing" or "Updating") .. " module " .. menuSelectedModule.file .. "..."
          )

          scriptingRepo.downloadScript(menuSelectedModule.url, function ()
            saveState(isOutOfSync and "resync" or "update")
            client.execute("lua reload")

            fetchRepoModules()
          end)
        end
      end

      buttonsH = textH
    else
      -- Install
      local installW, installH = gfx2.textSize("Install", 1.1)

      do
        local installHover = button(x + 5, modInfoY + 5 + titleH, installW + 6, installH, "Install", 1.1)

        if installHover and mouseDown then
          mouseDown = false

          notification("Installing module...", "Installing module " .. menuSelectedModule.file .. "...")

          scriptingRepo.downloadScript(menuSelectedModule.url, function ()
            saveState("install")
            client.execute("lua reload")

            fetchRepoModules()
          end)
        end
      end

      buttonsH = installH
    end

    -- Description
    local descLines, lineH = wrapText(menuSelectedModule.description, 1.2, width)
    local descH = lineH * #descLines
    for i, line in ipairs(descLines) do
      gfx2.text(x + 5, modInfoY + 5 + titleH + buttonsH + (i - 1) * lineH, line, 1.2)
    end

    -- Dependencies
    if menuSelectedModule.libs[1] ~= nil then
      local depsTitleW, depsTitleH = gfx2.textSize("Dependencies:", 1.1)
      local depsTitleX, depsTitleY = x + width - depsTitleW - 7, modInfoY + 5

      gfx2.text(depsTitleX, depsTitleY, "Dependencies:", 1.1)

      for i, lib in pairs(menuSelectedModule.libs) do
        local libW, libH = gfx2.textSize(lib .. ".lua", 0.9)
        gfx2.text(x + width - libW - 7, modInfoY + 5 + depsTitleH + (i - 1) * libH, lib .. ".lua", 0.9)
      end
    end

    -- Commands
    local commandsH = 0
    if menuSelectedModule.commands[1] ~= nil then
      local cmdsTitleW, cmdsTitleH = gfx2.textSize("Commands", 1.6)
      local cmdsTitleX, cmdsTitleY = x + 5, modInfoY + 5 + titleH + buttonsH + descH + 10

      gfx2.text(cmdsTitleX, cmdsTitleY, "Commands", 1.6)
      commandsH = cmdsTitleH

      for i, cmd in pairs(menuSelectedModule.commands) do
        local cmdW, cmdH = gfx2.textSize("- ." .. cmd, 1.2)
        gfx2.text(cmdsTitleX + 5, cmdsTitleY + cmdsTitleH - 3 + (i - 1) * (cmdH - 2), "- ." .. cmd, 1.2)
        commandsH = commandsH + (cmdH - 2)
      end
    end

    modInfoHeight = 5 + titleH + buttonsH + descH + 10 + commandsH
  end

  local function content_settings()
    gfx2.color(gui.theme().text)
    gfx2.text(x + 5, y + 5, "Settings", 2)
  end

  local function content()
    gfx2.pushClipArea(x - 0.5, y - 0.5, width + 1, height + 1)

    gfx2.color(gui.theme().windowBackground)
    gfx2.fillRoundRect(x, y, width, height, 5)

    local function innerContent()
      if os.clock() - menuContentUpdateStart <= ANIMATION_DUR then

        gfx2.pushTransformation({ 2, 0, selectedTab == "modules" and 0 or -height })
        do
          gfx2.pushClipArea(x, y, width, height)

          gfx2.pushTransformation({ 2, menuContentState == "main" and 0 or -width, 0 })
          content_main()
          gfx2.popTransformation()

          gfx2.pushTransformation({ 2, menuContentState == "main" and width or 0, 0 })
          content_module()
          gfx2.popTransformation()

          gfx2.popClipArea()
        end
        gfx2.popTransformation()

        gfx2.pushTransformation({ 2, 0, selectedTab == "modules" and height or 0 })
        do
          gfx2.pushClipArea(x, y, width, height)

          content_settings()

          gfx2.popClipArea()
        end
        gfx2.popTransformation()

        return
      end

      if selectedTab == "modules" then
        if menuContentState == "main" then
          if menuSelectedModule then menuSelectedModule = nil end
          content_main()
        elseif menuContentState == "module" then
          content_module()
        end

      elseif selectedTab == "settings" then
        content_settings()
      end
    end

    if os.clock() - menuContentUpdateStart <= ANIMATION_DUR then
      animate.translate(
        menuContentUpdateStart,
        {
          x = tabUpdating and 0 or (menuContentState == "main" and -width or width),
          y = tabUpdating and (selectedTab == "modules" and -height or height) or 0
        },
        { x = 0, y = 0 }, innerContent, ANIMATION_DUR,
        easingsFunctions.easeOutExpo
      )
    else
      tabUpdating = false
      innerContent()
    end

    gfx2.color(gui.theme().outline)
    gfx2.drawRoundRect(x, y, width, height, 5, 1)

    gfx2.popClipArea()
  end

  MODULE_HEIGHT = (height - 10) / 6
  GRID_MODULE_WIDTH = (width - 15) / 5

  local mx, my = gui.mousex(), gui.mousey()
  mouseInScroll = x < mx and mx < x + width and y < my and my < y + height and not mouseInHoverButton

  -- Rendering logic
  if timeSinceOpen <= ANIMATION_DUR then
    animate.scale(
      openMenuTime, { x = 0, y = 0 }, { x = 1, y = 1 },
      { x = gui.width() / 2, y = gui.height() / 2 },
      content, ANIMATION_DUR, easingsFunctions.easeOutExpo
    )
  elseif timeSinceClose <= ANIMATION_DUR then
    animate.scale(
      closeMenuTime, { x = 1, y = 1 }, { x = 0, y = 0 },
      { x = gui.width() / 2, y = gui.height() / 2 },
      content, ANIMATION_DUR, easingsFunctions.easeInExpo
    )
  elseif inMenu then
    content()
  end
end

local function searchbar(x, y, width, height)
  local function content()
    gfx2.color(gui.theme().windowBackground)
    gfx2.fillRoundRect(x, y, width, height, 5)

    if inSearchBar then
      gfx2.color(gui.theme().highlight)
      gfx2.fillRoundRect(x, y, width, height, 5)
    end

    gfx2.drawImage(x + 5, y + 5, 10, 10, IMAGES.Search, 1, true)

    local searchText = ""
    for _, char in ipairs(searchBarContent) do
      searchText = searchText .. (char or "")
    end

    local _, cursorH = gfx2.textSize(searchText)

    local cursorW, _ = gfx2.textSize(searchText:sub(1, clamp(searchBarCursor, 1, #searchBarContent)))
    if math.floor(os.clock() * 2) % 2 == 0 and inSearchBar then
      gfx2.color(gui.theme().text)
      gfx2.drawLine(x + 15 + cursorW + 5, y + (height / 2 - cursorH / 2), x + 15 + cursorW + 5, y + (height / 2 - cursorH / 2) + cursorH, 0.5)
    end

    gfx2.color(gui.theme().text)
    gfx2.text(x + 20, y + (height / 2 - cursorH / 2), table.concat(searchBarContent, ""))

    if #searchBarContent == 0 then gfx2.text(x + 20, y + (height / 2 - cursorH / 2), "Search modules...") end

    searchModules(searchText or "")

    local function barUnderline()
      gfx2.color(gui.theme().outline)
      gfx2.drawLine(x + 3, y + height - 0.5, x + width - 3, y + height - 0.5, 1)
    end

    if os.clock() - focusSearchBarTime <= ANIMATION_DUR then
      animate.scale(
        focusSearchBarTime,
        { x = inSearchBar and 0 or 1, y = 1 }, { x = inSearchBar and 1 or 0, y = 1 },
        { x = x + 3, y = y + height - 0.5 }, barUnderline, ANIMATION_DUR, easingsFunctions.easeOutExpo
      )
    elseif inSearchBar then
      barUnderline()
    end
  end

  local mx, my = gui.mousex(), gui.mousey()
  local hover = x < mx and mx < x + width and y < my and my < y + height

  if mouseDown and inSearchBar ~= hover then
    inSearchBar = hover
    focusSearchBarTime = os.clock()
    searchBarCursor = #searchBarContent
    mouseDown = false
  end

  -- Rendering logic
  if timeSinceOpen <= ANIMATION_DUR then
    animate.scale(
      openMenuTime,
      { x = 0, y = 0 }, { x = 1, y = 1 },
      { x = gui.width() / 2, y = gui.height() / 2 },
      content, ANIMATION_DUR, easingsFunctions.easeOutExpo
    )
  elseif timeSinceClose <= ANIMATION_DUR then
    animate.scale(
      closeMenuTime,
      { x = 1, y = 1 }, { x = 0, y = 0 },
      { x = gui.width() / 2, y = gui.height() / 2 },
      content, ANIMATION_DUR, easingsFunctions.easeInExpo
    )
  elseif os.clock() - menuContentUpdateStart <= ANIMATION_DUR then
    gfx2.pushClipArea(x - 7, y - 1, width + 9, height + 7)

    animate.scale(
      menuContentUpdateStart,
      ((selectedTab == "modules" and menuContentState == "main") and { x = 0, y = 0 } or (menuContentState == "main" and { x = 1, y = 1 } or { x = 0, y = 0 })),
      ((selectedTab == "modules" and menuContentState == "main") and { x = 1, y = 1 } or { x = 0, y = 0 }),
      { x = gui.width() / 2, y = gui.height() / 2 }, content, ANIMATION_DUR,
      ((selectedTab == "modules" and menuContentState == "main") and easingsFunctions.easeOutExpo or easingsFunctions.easeInExpo)
    )

    gfx2.popClipArea()
  elseif inMenu and selectedTab == "modules" and menuContentState == "main" then
    content()
  end
end

local function listfilters(x, y, width, height)
  local mx, my = gui.mousex(), gui.mousey()

  local function filterButton(x, type, texture)
    local y, width, height = y + 2.5, height - 5, height - 5

    gfx2.color(gui.theme()[modFilter == type and "button" or "windowBackground"])
    gfx2.fillRoundRect(x, y, width, height, 2.5)

    gfx2.color(gui.theme().text)
    gfx2.drawImage(x + 2, y + 2, width - 4, height - 4, texture, 1, true)

    local hover = x < mx and mx < x + width and y < my and my < y + height

    if hover and mouseDown then
      mouseDown = false
      if modFilter == type then return end
      changeFilterTime = os.clock()
      modFilter = type
      filterModules()
    end

    if os.clock() - changeFilterTime <= ANIMATION_DUR then
      modScroll = interpolate(prevModScroll, 0, (os.clock() - changeFilterTime) / ANIMATION_DUR, easingsFunctions.easeInOutExpo)
    else
      prevModScroll = modScroll
    end
  end

  local function content()
    gfx2.color(gui.theme().windowBackground)
    gfx2.fillRoundRect(x, y, width, height, 5)

    local infoW, infoH = gfx2.textSize("Filter by:", 1.1)
    gfx2.color(gui.theme().text)
    gfx2.text(x + 5, y + (height / 2 - infoH / 2), "Filter by:", 1.1)

    filterButton(x + 10 + infoW + (height - 2.5) * 0, "all", IMAGES.Repo)
    filterButton(x + 10 + infoW + (height - 2.5) * 1, "installed", IMAGES.Installed)

    local showUpdatesFilter = tableLen(outdatedModules) > 0
    if showUpdatesFilter then
      filterButton(x + 10 + infoW + (height - 2.5) * 2, "updates-available", IMAGES.UpdateAvailable)
    end

    gfx2.text(
      x + 10 + infoW + (height - 2.5) * (showUpdatesFilter and 3 or 2) + 5,
      y + (height / 2 - infoH / 2),
      ({["all"] = "All scripts", ["installed"] = "Installed scripts", ["updates-available"] = "Available updates"})[modFilter],
      1.1
    )

    local viewTypeHover =
      (x + width - (height - 5) - 2.5) < mx and mx < (x + width - (height - 5) - 2.5) + (height - 5) and
      (y + 2.5) < my and my < (y + 2.5) + (height - 5)

    gfx2.color(gui.theme()[viewTypeHover and "button" or "windowBackground"])
    gfx2.fillRoundRect(x + width - (height - 5) - 2.5, y + 2.5, height - 5, height - 5, 2.5)

    gfx2.color(gui.theme().text)
    gfx2.drawImage(
      x + width - (height - 5) - 2.5 + 2, y + 2.5 + 2, height - 9, height - 9,
      ({ list = IMAGES.ListView, grid = IMAGES.GridView })[modListViewType], 1, true
    )

    if viewTypeHover and mouseDown then
      mouseDown = false
      modListViewType = ({ list = "grid", grid = "list" })[modListViewType]
      menuContentUpdateStart = os.clock()
    end
  end

  -- Rendering logic
  if timeSinceOpen <= ANIMATION_DUR then
    animate.scale(
      openMenuTime,
      { x = 0, y = 0 }, { x = 1, y = 1 },
      { x = gui.width() / 2, y = gui.height() / 2 },
      content, ANIMATION_DUR, easingsFunctions.easeOutExpo
    )
  elseif timeSinceClose <= ANIMATION_DUR then
    animate.scale(
      closeMenuTime,
      { x = 1, y = 1 }, { x = 0, y = 0 },
      { x = gui.width() / 2, y = gui.height() / 2 },
      content, ANIMATION_DUR, easingsFunctions.easeInExpo
    )
  elseif os.clock() - menuContentUpdateStart <= ANIMATION_DUR then
    gfx2.pushClipArea(x - 7, y - 1, width + 9, height + 7)

    animate.scale(
      menuContentUpdateStart,
      ((selectedTab == "modules" and menuContentState == "main") and { x = 0, y = 0 } or (menuContentState == "main" and { x = 1, y = 1 } or { x = 0, y = 0 })),
      ((selectedTab == "modules" and menuContentState == "main") and { x = 1, y = 1 } or { x = 0, y = 0 }),
      { x = gui.width() / 2, y = gui.height() / 2 },
      content, ANIMATION_DUR,
      ((selectedTab == "modules" and menuContentState == "main") and easingsFunctions.easeOutExpo or easingsFunctions.easeInExpo)
    )

    gfx2.popClipArea()
  elseif inMenu and selectedTab == "modules" and menuContentState == "main" then
    content()
  end
end

local function hoveringbuttons(x, y, width, height)
  local mx, my = gui.mousex(), gui.mousey()

  local function content()
    gfx2.color(gui.theme().windowBackground)
    gfx2.fillRoundRect(x, y, width, height, 5)

    gfx2.color(gui.theme().outline)
    gfx2.drawRoundRect(x, y, width, height, 5, 1)

    do
      local updAllX, updAllY = x + 3.75, y + 3.75
      local updAllW, updAllH = height - 7.5, height - 7.5
      local updAllHover = updAllX < mx and mx < updAllX + updAllW and updAllY < my and my < updAllY + updAllH

      gfx2.color(gui.theme()[updAllHover and "button" or "windowBackground"])
      gfx2.fillRoundRect(updAllX, updAllY, updAllW, updAllH, 2)

      gfx2.pushTransformation({ 3, isUpdating and (os.clock() - startUpdatingTime) * 360 or 0, updAllX + (updAllW / 2), updAllY + (updAllH / 2) })
      gfx2.drawImage(updAllX + 3, updAllY + 3, updAllW - 6, updAllH - 6, IMAGES.UpdateAll, 1, true)
      gfx2.popTransformation()

      local _, textH = gfx2.textSize("Update all modules", 1.2)
      gfx2.color(gui.theme().text)
      gfx2.text(updAllX + updAllW + 5, updAllY + (updAllH / 2 - textH / 2), "Update all modules", 1.2)


      if updAllHover and mouseDown then
        mouseDown = false
        isUpdating = true
        startUpdatingTime = os.clock()
        notification("Updating modules", "Updating " .. tableLen(outdatedModules) .. " modules...")
        updateAllModules()
      end
    end
  end

  -- Rendering logic
  if not (modFilter == "updates-available" and tableLen(outdatedModules) > 0) then return end

  local hover = x < mx and mx < x + width and y < my and my < y + height
  mouseInHoverButton = hover

  gfx2.pushClipArea(x - 1, y - 1, width + 2, height + 10)

  if os.clock() - changeFilterTime <= ANIMATION_DUR then
    animate.translate(
      changeFilterTime, { x = 0, y = height + 10 }, { x = 0, y = 0 },
      content, ANIMATION_DUR, easingsFunctions.easeOutExpo
    )
  elseif os.clock() - changeFilterTime <= ANIMATION_DUR then
    animate.scale(
      closeMenuTime, { x = 1, y = 1 }, { x = 0, y = 0 },
      { x = gui.width() / 2, y = gui.height() / 2 },
      content, ANIMATION_DUR, easingsFunctions.easeInExpo
    )
  elseif inMenu then

    content()
  end

  gfx2.popClipArea()
end

function renderUI()
  local width, height = gui.width() / 8 * 6, gui.height() / 8 * 6
  local x, y = gui.width() / 8, gui.height() / 8

  timeSinceOpen = os.clock() - openMenuTime
  timeSinceClose = os.clock() - closeMenuTime

  blur()

  -- Render the sidebar
  sidebar(x, y, width / 5, height)

  -- Render the module list filters
  listfilters(x + (width / 5) + 5, y - 25, (width / 5 * 2) - 10, 20)

  -- Render the search bar
  searchbar(x + (width / 5) + 5 + (width / 5 * 2), y - 25, (width / 5 * 2) - 10, 20)

  -- Render the main menu
  menu(x + (width / 5) + 5, y, (width / 5 * 4) - 10, height)

  -- Render hovering buttons
  hoveringbuttons(x + (width / 5 * 3.5) - 15, y + height - 35, (width / 5 * 1.5), 25)
end
--#endregion UI --

function render2()
  renderUI()

  renderNotifications()

  gfx2.color(gui.theme().text)
  gfx2.text(0, 40, mouseDown and "Mouse DOWN" or "Mouse UP", 1.3)
end

function update()
  if not inMenu then return end

  if gui.screen() ~= "hud_screen" then handleMenu(false) end
  if not gui.mouseGrabbed() then gui.setGrab(true) end
end

function firstTimeLoad()
  -- Create folder
  fs.mkdir("Data/ScriptingRepoUI")

  -- Make state file
  local statefile = io.open("Data/ScriptingRepoUI/state.json", "w")
  if statefile == nil then return error("lua dont wanna do the file thingy :(") end
  statefile:write("{}")
  io.close(statefile)

  -- Download icons
  for key, file in pairs(IMAGE_FILES) do
    if not fs.exist("Data/ScriptingRepoUI/" .. file) then
      notification("Downloading asset", "Downloading image " .. file .. ". This should only need to happen once.")
      scriptingRepo.downloadDataFile(
        "ScriptingRepoUI/" .. file,
        function () IMAGES[key] = gfx2.loadImage("Data/ScriptingRepoUI/" .. file) end
      );
    else
      --print("Was already here lol")
      IMAGES[key] = gfx2.loadImage("Data/ScriptingRepoUI/" .. file)
    end
  end
end

function onEnable()
  print("§aUI Loaded.§r")

  if not fs.exist("Data/ScriptingRepoUI") then firstTimeLoad() goto firsttime end

  do
    local stateFile = io.open("Data/ScriptingRepoUI/state.json", "r")
    if not stateFile then goto closefile end

    --IMAGES.Repo = gfx2.loadImage("Data/ScriptingRepoUI/repository.png")
    --IMAGES.Installed = gfx2.loadImage("Data/ScriptingRepoUI/check.png")
    --IMAGES.UpdateAvailabe = gfx2.loadImage("Data/ScriptingRepoUI/cloud-download.png")
    --IMAGES.OutOfSync = gfx2.loadImage("Data/ScriptingRepoUI/cloud-sync.png")
    --IMAGES.UpdateAll = gfx2.loadImage("Data/ScriptingRepoUI/refresh-double.png")
    --IMAGES.Settings = gfx2.loadImage("Data/ScriptingRepoUI/settings.png")
    --IMAGES.Search = gfx2.loadImage("Data/ScriptingRepoUI/search.png")
    --IMAGES.ListView = gfx2.loadImage("Data/ScriptingRepoUI/list.png")
    --IMAGES.GridView = gfx2.loadImage("Data/ScriptingRepoUI/view-grid.png")

    do
      local state = stateFile:read("a")
      if not state or #state == 0 then goto closefile end
      state = jsonToTable(state)

      if not state.inMenu then goto closefile end

      fetchRepoModules(function()
        if state.contentState == "module" then
          menuSelectedModule = tableFind(MODULES, function (x) return x.file == state.selectedModule end)
          menuContentState = "module"

          if state.installType == "install" then
            local clientMod = tableFind(client.modules(), function (x) return x.name == menuSelectedModule.name end)
            if clientMod then clientMod.enabled = true end
          end
        end

        handleMenu(true)
      end)

      if state.installType == "install" then
        notification("Module installed", "Successfully installed module " .. state.selectedModule)
        searchBarContent = chars(state.searchContent)

      elseif state.installType == "uninstall" then
        notification("Module uninstalled", "Successfully uninstalled " .. state.selectedModule)
        searchBarContent = chars(state.searchContent)

      elseif state.installType == "update" then
        notification("Module updated", "Successfully updated " .. state.selectedModule)
        searchBarContent = chars(state.searchContent)

      elseif state.installType == "resync" then
        notification("Module synchronized", "Successfully synchronized " .. state.selectedModule)
        searchBarContent = chars(state.searchContent)

      elseif state.installType == "update-all" then
        notification("Modules updated", "Updated all outdated modules.")
        searchBarContent = chars(state.searchContent)
        state.modFilter = "installed"

      end

      modFilter = state.modFilter
      modScroll = state.modScroll
    end

    ::closefile::

    if stateFile then io.close(stateFile) end
  end

  for key, file in pairs(IMAGE_FILES) do IMAGES[key] = gfx2.loadImage("Data/ScriptingRepoUI/" .. file) end

  ::firsttime::

  fetchRepoModules(function ()
    local outdated = tableLen(outdatedModules)
    if outdated > 0 then notification("Script Updates Available", "You have " .. outdated .. " updates available. Install them through the GUI.") end
  end)
end

function onNetworkData(...) scriptingRepo.fetchNetworkData(...) end
