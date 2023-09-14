---Clamp
---@param x number
---@param low number
---@param high number
---@return number
local function clamp(x, low, high) return (x < low) and low or (x > high) and high or x end

---Interpolate between two values
---@param a number
---@param b number
---@param t number
---@param func fun(x: number): number
---@return number
local function interpolate(a, b, t, func) return a + (b - a) * func(t) end

local startTimes = {}

---Animate GFX things.
animate = {}

---Animate the translation of GFX things. Use inside `render2`. Provide the start time yourself.
---@param startTime number The time the animation started. (`os.clock()`)
---@param startPos { x: number, y: number } The initial position of the rectangle
---@param endPos { x: number, y: number } The final position of the rectangle
---@param content fun(x: number, y: number):nil Content to animate. x and y are absolute position, 0, 0 is relative top left.
---@param duration? number Duration of the animation in seconds (default is 1 second)
---@param easeFunc? fun(x: number):number Ease in/out function for the animation (default is linear)
function animate.translate(startTime, startPos, endPos, content, duration, easeFunc)
  duration = duration or 1
  easeFunc = easeFunc or function (x) return x end
  if os.clock() - startTime > duration then return end

  local t = clamp((os.clock() - startTime) / duration, 0, 1)
  local x = interpolate(startPos.x, endPos.x, t, easeFunc)
  local y = interpolate(startPos.y, endPos.y, t, easeFunc)

  gfx2.pushTransformation({ 2, x, y })

  content(x, y)

  gfx2.popTransformation()
end

---Animate the translation of GFX things. Use inside `render2`.
---@param name string A unique ID to identify the rectangle
---@param startPos { x: number, y: number } The initial position of the rectangle
---@param endPos { x: number, y: number } The final position of the rectangle
---@param content fun(x: number, y: number):nil Content to animate. x and y are absolute position, 0, 0 is relative top left.
---@param duration? number Duration of the animation in seconds (default is 1 second)
---@param easeFunc? fun(x: number):number Ease in/out function for the animation (default is linear)
---@deprecated Use animate.translate as it is better
function animate.translateNamed(name, startPos, endPos, content, duration, easeFunc)
  -- 1 second by default
  if not duration then duration = 1 end
  -- linear by default
  if not easeFunc then easeFunc = function (x) return x end end

  -- Specific ID
  name = "translate-" .. name

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

---Animate the scale of GFX things. Use inside `render2`.
---@param startTime number The time the animation started. (`os.clock()`)
---@param startScale { x: number, y: number } The initial scale of the area.
---@param endScale { x: number, y: number } The final scale of the area.
---@param origin { x: number, y: number } The origin point from which to scale.
---@param content fun(x: number, y: number): nil Content to animate. x and y are the origin.
---@param duration? number Duration of the animation in seconds (default is 1 second)
---@param easeFunc? fun(x: number): number Ease in/out function for the animation (default is linear)
function animate.scale(startTime, startScale, endScale, origin, content, duration, easeFunc)
  duration = duration or 1
  easeFunc = easeFunc or function (x) return x end
  if os.clock() - startTime > duration then return end

  local t = clamp((os.clock() - startTime) / duration, 0, 1)
  local x = interpolate(startScale.x, endScale.x, t, easeFunc)
  local y = interpolate(startScale.y, endScale.y, t, easeFunc)

  gfx2.pushTransformation({ 4, x, y, origin.x, origin.y })

  content(origin.x, origin.y)

  gfx2.popTransformation()
end

---Animate the scale of GFX things. Use inside `render2`.
---@param name string A unique ID to indentify the area.
---@param startScale { x: number, y: number } The initial scale of the area.
---@param endScale { x: number, y: number } The final scale of the area.
---@param origin { x: number, y: number } The origin point from which to scale.
---@param content fun(x: number, y: number): nil Content to animate. x and y are the origin.
---@param duration? number Duration of the animation in seconds (default is 1 second)
---@param easeFunc? fun(x: number): number Ease in/out function for the animation (default is linear)
---@deprecated Use animateScale as it is better
function animate.scaleNamed(name, startScale, endScale, origin, content, duration, easeFunc)
  duration = duration or 1
  easeFunc = easeFunc or function (x) return x end

  name = "scale-" .. name

  if not startTimes[name] then startTimes[name] = os.clock() end

  if os.clock() - startTimes[name] > duration then return end

  local t = clamp((os.clock() - startTimes[name]) / duration, 0, 1)
  local x = interpolate(startScale.x, endScale.x, t, easeFunc)
  local y = interpolate(startScale.y, endScale.y, t, easeFunc)

  gfx2.pushTransformation({ 4, x, y, origin.x, origin.y })

  content(origin.x, origin.y)

  gfx2.popTransformation()
end

---Animate the rotation of GFX things. Use inside `render2`.
---@param startTime number The time the animation started. (`os.clock()`)
---@param startAngle number The initial angle of the area.
---@param endAngle number The final angle of the area.
---@param origin { x: number, y: number } The origin point around which to rotate.
---@param content fun(x: number, y: number): nil Content to rotate. x and y are the origin.
---@param duration? number Duration of the animation in seconds (default is 1 second)
---@param easeFunc? fun(x: number): number Ease in/out function for the animation (default is linear)
function animate.rotate(startTime, startAngle, endAngle, origin, content, duration, easeFunc)
  duration = duration or 1
  easeFunc = easeFunc or function (x) return x end
  if os.clock() - startTime > duration then return end

  local t = clamp((os.clock() - startTime) / duration, 0, 1)
  local angle = interpolate(startAngle, endAngle, t, easeFunc)

  gfx2.pushTransformation({ 3, angle, origin.x, origin.y })

  content(origin.x, origin.y)

  gfx2.popTransformation()
end
