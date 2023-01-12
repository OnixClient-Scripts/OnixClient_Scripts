name = "Keyboard Displayer"
description = "Show what Keyboard keys you have pressed"

--[[
	If you want to add extra keys:
	- https://github.com/OnixClient-Scripts/OnixClient_Scripts/blob/master/Libs/keyconverter.lua or 
	- https://learn.microsoft.com/en-us/windows/win32/inputdev/virtual-key-codes
]]--

positionX = 0
positionY = 0

sizeX = 270
sizeY = 108

backgroundColor = client.settings.addNamelessColor("Background color", { 0, 0, 0, 82 })
keyColor = client.settings.addNamelessColor("Key color", { 0, 0, 0, 49 })
pressedKeyColor = client.settings.addNamelessColor("Pressed key color", { 255, 18, 18, 77 })
reservedColor = client.settings.addNamelessColor("Reserved key color", { 255, 120, 0, 74 })
textColor = client.settings.addNamelessColor("Text color", { 255, 255, 255, 100 })

keyboardSizeX = 270
keyboardSizeY = 108

function createKeyboard(name)
	local keyboard = { id = name, keys = { } }
	
	keyboard.createKey = function(id, _translation, _x, _y, _sizeX, _sizeY, _reserved, _pressed, _toggleable)
		if keyboard then 
			keyboard.keys[id] = { translation = _translation, x = _x, y = _y, sizeX = _sizeX, sizeY = _sizeY, reserved = _reserved , pressed = _pressed, toggleable = _toggleable }
		end 
	end 
	
	keyboards[name] = keyboard
	
	return keyboard
end

keyboards = { }
selectedKeyboard = "english"

keyboard = createKeyboard(selectedKeyboard);
keyboard.createKey(0x07, ""         , 18 , 90, 54, 16, true , false, false)
keyboard.createKey(0x08, "BackSpace", 233, 18, 37, 16, false, false, false)
keyboard.createKey(0x09, "Tab"      , 0  , 36, 24, 16, false, false, false)
keyboard.createKey(0x0D, "Enter"    , 227, 54, 43, 16, false, false, false)
keyboard.createKey(0x0E, ""         , 212, 2 , 58, 14, true , false, false)
keyboard.createKey(0x10, "Shift"    , 0  , 72, 36, 16, false, false, false)
keyboard.createKey(0x11, "Ctrl"     , 0  , 90, 16, 16, false, false, false)
keyboard.createKey(0x12, "Alt"      , 164, 90, 16, 16, false, false, false)
keyboard.createKey(0x14, "CapsLock" , 0  , 54, 27, 16, false, false, true )
keyboard.createKey(0x97, ""         , 254, 72, 16, 16, true , false, false)
keyboard.createKey(0x1B, "Esc"      , 0  , 2 , 14, 14, false, false, false)
keyboard.createKey(0x20, "Space"    , 74 , 90, 88, 16, false, false, false)
keyboard.createKey(0x25, "Left"     , 218, 90, 16, 16, false, false, false)
keyboard.createKey(0x26, "Up"       , 236, 72, 16, 16, false, false, false)
keyboard.createKey(0x27, "Right"    , 254, 90, 16, 16, false, false, false)
keyboard.createKey(0x28, "Down"     , 236, 90, 16, 16, false, false, false)
keyboard.createKey(0x30, "0"        , 179, 18, 16, 16, false, false, false)
keyboard.createKey(0x31, "1"        , 17 , 18, 16, 16, false, false, false)
keyboard.createKey(0x32, "2"        , 35 , 18, 16, 16, false, false, false)
keyboard.createKey(0x33, "3"        , 53 , 18, 16, 16, false, false, false)
keyboard.createKey(0x34, "4"        , 71 , 18, 16, 16, false, false, false)
keyboard.createKey(0x35, "5"        , 89 , 18, 16, 16, false, false, false)
keyboard.createKey(0x36, "6"        , 107, 18, 16, 16, false, false, false)
keyboard.createKey(0x37, "7"        , 125, 18, 16, 16, false, false, false)
keyboard.createKey(0x38, "8"        , 143, 18, 16, 16, false, false, false)
keyboard.createKey(0x39, "9"        , 161, 18, 16, 16, false, false, false)
keyboard.createKey(0xBA, ": ;"      , 191, 54, 16, 16, false, false, false)
keyboard.createKey(0xBB, "+ ="      , 215, 18, 16, 16, false, false, false)
keyboard.createKey(0xBC, ", <"      , 164, 72, 16, 16, false, false, false)
keyboard.createKey(0xBD, "- _"      , 197, 18, 16, 16, false, false, false)
keyboard.createKey(0xBE, ". >"      , 182, 72, 16, 16, false, false, false)
keyboard.createKey(0xBF, "? /"      , 200, 72, 16, 16, false, false, false)
keyboard.createKey(0xC0, "~ `"      , 0  , 18, 15, 16, false, false, false)
keyboard.createKey(0x41, "A"        , 29 , 54, 16, 16, false, false, false)
keyboard.createKey(0x42, "B"        , 110, 72, 16, 16, false, false, false)
keyboard.createKey(0x43, "C"        , 74 , 72, 16, 16, false, false, false)
keyboard.createKey(0x44, "D"        , 65 , 54, 16, 16, false, false, false)
keyboard.createKey(0x45, "E"        , 62 , 36, 16, 16, false, false, false)
keyboard.createKey(0x46, "F"        , 83 , 54, 16, 16, false, false, false)
keyboard.createKey(0x47, "G"        , 101, 54, 16, 16, false, false, false)
keyboard.createKey(0x48, "H"        , 119, 54, 16, 16, false, false, false)
keyboard.createKey(0x49, "I"        , 152, 36, 16, 16, false, false, false)
keyboard.createKey(0x4A, "J"        , 137, 54, 16, 16, false, false, false)
keyboard.createKey(0x4B, "K"        , 155, 54, 16, 16, false, false, false)
keyboard.createKey(0x4C, "L"        , 173, 54, 16, 16, false, false, false)
keyboard.createKey(0x4D, "M"        , 146, 72, 16, 16, false, false, false)
keyboard.createKey(0x4E, "N"        , 128, 72, 16, 16, false, false, false)
keyboard.createKey(0x4F, "O"        , 170, 36, 16, 16, false, false, false)
keyboard.createKey(0x50, "P"        , 188, 36, 16, 16, false, false, false)
keyboard.createKey(0x51, "Q"        , 26 , 36, 16, 16, false, false, false)
keyboard.createKey(0x52, "R"        , 80 , 36, 16, 16, false, false, false)
keyboard.createKey(0x53, "S"        , 47 , 54, 16, 16, false, false, false)
keyboard.createKey(0x54, "T"        , 98 , 36, 16, 16, false, false, false)
keyboard.createKey(0x55, "U"        , 134, 36, 16, 16, false, false, false)
keyboard.createKey(0x56, "V"        , 92 , 72, 16, 16, false, false, false)
keyboard.createKey(0x57, "W"        , 44 , 36, 16, 16, false, false, false)
keyboard.createKey(0x58, "X"        , 56 , 72, 16, 16, false, false, false)
keyboard.createKey(0x59, "Y"        , 116, 36, 16, 16, false, false, false)
keyboard.createKey(0x5A, "Z"        , 38 , 72, 16, 16, false, false, false)
keyboard.createKey(0xDB, "{ ["      , 206, 36, 16, 16, false, false, false)
keyboard.createKey(0xDC, "| \\"     , 242, 36, 28, 16, false, false, false)
keyboard.createKey(0xDD, "} ]"      , 224, 36, 16, 16, false, false, false)
keyboard.createKey(0xDE, "\" '"     , 209, 54, 16, 16, false, false, false)
keyboard.createKey(0x70, "F1"       , 18 , 2 , 14, 14, false, false, false)
keyboard.createKey(0x71, "F2"       , 34 , 2 , 14, 14, false, false, false)
keyboard.createKey(0x72, "F3"       , 50 , 2 , 14, 14, false, false, false)
keyboard.createKey(0x73, "F4"       , 66 , 2 , 14, 14, false, false, false)
keyboard.createKey(0x74, "F5"       , 82 , 2 , 14, 14, false, false, false)
keyboard.createKey(0x75, "F6"       , 98 , 2 , 14, 14, false, false, false)
keyboard.createKey(0x76, "F7"       , 114, 2 , 14, 14, false, false, false)
keyboard.createKey(0x77, "F8"       , 130, 2 , 14, 14, false, false, false)
keyboard.createKey(0x78, "F9"       , 146, 2 , 14, 14, false, false, false)
keyboard.createKey(0x79, "F10"      , 162, 2 , 14, 14, false, false, false)
keyboard.createKey(0x7A, "F11"      , 178, 2 , 14, 14, false, false, false)
keyboard.createKey(0x7B, "F12"      , 194, 2 , 14, 14, false, false, false)
keyboard.createKey(0x88, ""         , 218, 72, 16, 16, true , false, false)
keyboard.createKey(0x3A, ""         , 182, 90, 34, 16, true , false, false)

event.listen("KeyboardInput", function(key, isDown)
  local data = keyboards[selectedKeyboard]
  if data then 
	local key = data.keys[key]
	if key then 
		if key.toggleable then 
			if isDown == false then
				return
			end 
			key.pressed = key.pressed == false
		else key.pressed = isDown end 
	end
  end
end)

function render2(deltaTime) 
	local keyboard = keyboards[selectedKeyboard];
	
	if keyboard == nil then
		return
	end 
	
	gfx2.color(backgroundColor)
	gfx2.fillRect(0, 0, keyboardSizeX, keyboardSizeY, 10)
    
	local color = nil
  
	for code, data in pairs(keyboard.keys) do 
		if data.pressed then
			color = pressedKeyColor
		else
			if data.reserved then
				color = reservedColor
			else 
				color = keyColor
			end 
		end 
    
		gfx2.color(color)
		gfx2.fillRect(data.x, data.y, data.sizeX, data.sizeY, 2)
 	
		gfx2.color(textColor)
		gfx2.text(data.x + 4, data.y + 5, data.translation, 0.5)
	end
end

