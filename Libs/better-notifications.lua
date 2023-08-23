importLib("easing-functions")

---Clamp
---@param x number
---@param low number
---@param high number
---@return number
local function clamp(x, low, high) return (x < low) and low or (x > high) and high or x end

----- Might move this to its own lib later on -----
local startTimes = {}
---Animate GFX things. Use inside `render2`.
---@param name string A unique ID to identify the rectangle
---@param startPos { x: number, y: number } The initial position of the rectangle
---@param endPos { x: number, y: number } The final position of the rectangle
---@param content fun(x: number, y: number):nil Content to animate. x and y are absolute position, 0, 0 is relative top left.
---@param duration? number Duration of the animation in seconds (default is 1 second)
---@param easeFunc? (fun(x: number):number) Ease in/out function for the animation (default is linear)
local function animate(name, startPos, endPos, content, duration, easeFunc)
  -- 1 second by default
  if not duration then duration = 1 end
  -- linear by default
  if not easeFunc then easeFunc = function (x) return x end end

  -- Start the animation
  if not startTimes[name] then startTimes[name] = os.clock() end

  -- Return if the animation is done
  if os.clock() - startTimes[name] > duration then return end

  local t = clamp((os.clock() - startTimes[name]) / duration, 0, 1)
  local x = interpolate(startPos.x, endPos.x, t, easeFunc)
  local y = interpolate(startPos.y, endPos.y, t, easeFunc)

  gfx2.pushTransformation({ 2, x, y })

  content(x, y)

  gfx2.popTransformation()
end
----- Currently isn't perfect though -----

local notifQueue = {}

---Better notifications. This shows animated round rectangles in the
---bottom right of the screen, with a title and content. The colours
---are automatically filled in from the current theme.
---Example:
---```lua
----- Show a notification for 2 seconds
---notification("A very nice title", "This is a very nice notification.", 2)
---```
---@param title string Title of the notification.
---@param content string Content of the notification.
---@param duration? number How long to keep the notification on screen for in seconds. Default value is 5.
function notification(title, content, duration)
  local id = tostring(os.clock()) .. tostring(math.random())
  table.insert(notifQueue, { title = title, content = content, start = os.clock(), duration = duration or 5, id = id })
  table.sort(notifQueue, function (a, b) return a.start > b.start end)
end

---Run this function in the `render2` function.
---```lua
---function render2(dt)
---  renderNotifications()
---end
---```
function renderNotifications()
  for i, notif in ipairs(notifQueue) do
    local notifPos = {
      x = (gui.width() - 20) / 5 * 4,
      y = ((gui.height() - 20) / 7) * (7 - i) + 15,
      width = (gui.width() - 20) / 5,
      height = ((gui.height() - 20) / 7) - 10,
    }

    local notifContent = function()
      gfx2.pushClipArea(-0.5, -0.5, notifPos.width + 1, notifPos.height + 1)

      local notification = {}

      -- Title
      notification.title = notif.title
      local titlew, titleh = gfx2.textSize(notif.title, 1.3)
      if titlew > notifPos.width / 20 * 18 then
        for charIndex = #notification.title, 0, -1 do
          local tmpTitle = string.sub(notification.title, 1, charIndex) .. "..."
          local tw,_ = gfx2.textSize(tmpTitle, 1.3)

          if tw <= notifPos.width / 20 * 18 then notification.title = tmpTitle break end
        end
      end

      -- Content
      local contentParts = string.split(notif.content, " ")
      local lines = {""}
      for _,word in ipairs(contentParts) do
        local tmpLine = lines[#lines] .. word .. " "
        local linew,_ = gfx2.textSize(tmpLine)

        if linew < notifPos.width / 20 * 18 then
          lines[#lines] = tmpLine
        else
          table.insert(lines, word .. " ")
        end
      end

      local _,lineh = gfx2.textSize(lines[1])
      notification.height = (titleh + 5 + lineh * #lines) / 18 * 20

      -- Background
      gfx2.color(gui.theme().windowBackground)
      gfx2.fillRoundRect(0, 0, notifPos.width, notifPos.height, 5)

      -- Title
      gfx2.color(gui.theme().text)
      gfx2.text(notifPos.width / 20, notifPos.height / 20, notification.title, 1.3)

      -- Separator line
      gfx2.color(gui.theme().outline)
      gfx2.drawLine(notifPos.width / 20, notifPos.height / 20 + titleh + 2.5, notifPos.width / 20 * 19, notifPos.height / 20 + titleh + 2.5, 1)

      -- Content
      gfx2.color(gui.theme().text)
      for lineIndex, line in ipairs(lines) do gfx2.text(notifPos.width / 20, notifPos.height / 20 + titleh + 5 + (lineIndex - 1) * lineh, line) end

      -- Outline
      gfx2.color(gui.theme().outline)
      gfx2.drawRoundRect(0, 0, notifPos.width, notifPos.height, 6, 1)

      gfx2.popClipArea()
    end

    --1 = open
    --2 = stay
    --3 = close
    local type = (os.clock() - notif.start < 1) and 1 or (os.clock() - notif.start < notif.duration and 2 or 3)

    animate(
      "notif-" .. type .. "-" .. notif.id,
      type == 1 and { x = gui.width() + 10, y = notifPos.y } or table.clone(notifPos),
      type == 3 and { x = gui.width() + 10, y = notifPos.y } or table.clone(notifPos),
      notifContent, type == 2 and notif.duration + 1 or 1,
      type == 1 and easingsFunctions.easeOutExpo or easingsFunctions.easeInExpo
    )
    if os.clock() > notif.start + notif.duration + 1 then notifQueue[i] = nil end
  end
end
