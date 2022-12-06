name = "Keyboard Displayer"
description = "Show what Keyboard keys you have pressed"

positionX = 0
positionY = 0

sizeX = 270
sizeY = 108

backgroundColor = { 0, 0, 0, 82 }
client.settings.addColor("Background color", "backgroundColor")

keyColor = { 0, 0, 0, 49 }
client.settings.addColor("Key color", "keyColor")

pressedKeyColor = { 255, 18, 18, 77 }
client.settings.addColor("Pressed key color", "pressedKeyColor")

reservedColor = { 255, 120, 0, 74 }
client.settings.addColor("Reserved key color", "reservedColor")

textColor = { 255, 255, 255, 100 }
client.settings.addColor("Text color", "textColor")

keyboardSizeX = 270
keyboardSizeY = 108

keyboard = {
	[0x08] = { translation = "BackSpace" , x = 233, y = 18, sizeX = 37, sizeY = 16, reserved = false, pressed = false },
	[0x09] = { translation = "Tab"       , x = 0  , y = 36, sizeX = 24, sizeY = 16, reserved = false, pressed = false },
	[0x0D] = { translation = "Enter"     , x = 227, y = 54, sizeX = 43, sizeY = 16, reserved = false, pressed = false },
	[0x10] = { translation = "Shift"     , x = 0  , y = 72, sizeX = 36, sizeY = 16, reserved = false, pressed = false },
	[0x11] = { translation = "Ctrl"      , x = 0  , y = 90, sizeX = 16, sizeY = 16, reserved = false, pressed = false },
	[0x12] = { translation = "Alt"       , x = 164, y = 90, sizeX = 16, sizeY = 16, reserved = false, pressed = false },
	[0x14] = { translation = "CapsLock"  , x = 0  , y = 54, sizeX = 27, sizeY = 16, reserved = false, pressed = false },
	[0x1B] = { translation = "Esc"       , x = 0  , y = 2 , sizeX = 14, sizeY = 14, reserved = false, pressed = false },
	[0x20] = { translation = "Space"     , x = 74 , y = 90, sizeX = 88, sizeY = 16, reserved = false, pressed = false },
	[0x25] = { translation = "Left"      , x = 218, y = 90, sizeX = 16, sizeY = 16, reserved = false, pressed = false },
	[0x26] = { translation = "Up"        , x = 236, y = 72, sizeX = 16, sizeY = 16, reserved = false, pressed = false },
	[0x27] = { translation = "Right"     , x = 254, y = 90, sizeX = 16, sizeY = 16, reserved = false, pressed = false },
	[0x28] = { translation = "Down"      , x = 236, y = 90, sizeX = 16, sizeY = 16, reserved = false, pressed = false },
	[0x30] = { translation = "0"         , x = 179, y = 18, sizeX = 16, sizeY = 16, reserved = false, pressed = false },
	[0x31] = { translation = "1"         , x = 17 , y = 18, sizeX = 16, sizeY = 16, reserved = false, pressed = false },
	[0x32] = { translation = "2"         , x = 35 , y = 18, sizeX = 16, sizeY = 16, reserved = false, pressed = false },
	[0x33] = { translation = "3"         , x = 53 , y = 18, sizeX = 16, sizeY = 16, reserved = false, pressed = false },
	[0x34] = { translation = "4"         , x = 71 , y = 18, sizeX = 16, sizeY = 16, reserved = false, pressed = false },
	[0x35] = { translation = "5"         , x = 89 , y = 18, sizeX = 16, sizeY = 16, reserved = false, pressed = false },
	[0x36] = { translation = "6"         , x = 107, y = 18, sizeX = 16, sizeY = 16, reserved = false, pressed = false },
	[0x37] = { translation = "7"         , x = 125, y = 18, sizeX = 16, sizeY = 16, reserved = false, pressed = false },
	[0x38] = { translation = "8"         , x = 143, y = 18, sizeX = 16, sizeY = 16, reserved = false, pressed = false },
	[0x39] = { translation = "9"         , x = 161, y = 18, sizeX = 16, sizeY = 16, reserved = false, pressed = false },
	[0x41] = { translation = "A"         , x = 29 , y = 54, sizeX = 16, sizeY = 16, reserved = false, pressed = false },
	[0x42] = { translation = "B"         , x = 110, y = 72, sizeX = 16, sizeY = 16, reserved = false, pressed = false },
	[0x43] = { translation = "C"         , x = 74 , y = 72, sizeX = 16, sizeY = 16, reserved = false, pressed = false },
	[0x44] = { translation = "D"         , x = 65 , y = 54, sizeX = 16, sizeY = 16, reserved = false, pressed = false },
	[0x45] = { translation = "E"         , x = 62 , y = 36, sizeX = 16, sizeY = 16, reserved = false, pressed = false },
	[0x46] = { translation = "F"         , x = 83 , y = 54, sizeX = 16, sizeY = 16, reserved = false, pressed = false },
	[0x47] = { translation = "G"         , x = 101, y = 54, sizeX = 16, sizeY = 16, reserved = false, pressed = false },
	[0x48] = { translation = "H"         , x = 119, y = 54, sizeX = 16, sizeY = 16, reserved = false, pressed = false },
	[0x49] = { translation = "I"         , x = 152, y = 36, sizeX = 16, sizeY = 16, reserved = false, pressed = false },
	[0x4A] = { translation = "J"         , x = 137, y = 54, sizeX = 16, sizeY = 16, reserved = false, pressed = false },
	[0x4B] = { translation = "K"         , x = 155, y = 54, sizeX = 16, sizeY = 16, reserved = false, pressed = false },
	[0x4C] = { translation = "L"         , x = 173, y = 54, sizeX = 16, sizeY = 16, reserved = false, pressed = false },
	[0x4D] = { translation = "M"         , x = 146, y = 72, sizeX = 16, sizeY = 16, reserved = false, pressed = false },
	[0x4E] = { translation = "N"         , x = 128, y = 72, sizeX = 16, sizeY = 16, reserved = false, pressed = false },
	[0x4F] = { translation = "O"         , x = 170, y = 36, sizeX = 16, sizeY = 16, reserved = false, pressed = false },
	[0x50] = { translation = "P"         , x = 188, y = 36, sizeX = 16, sizeY = 16, reserved = false, pressed = false },
	[0x51] = { translation = "Q"         , x = 26 , y = 36, sizeX = 16, sizeY = 16, reserved = false, pressed = false },
	[0x52] = { translation = "R"         , x = 80 , y = 36, sizeX = 16, sizeY = 16, reserved = false, pressed = false },
	[0x53] = { translation = "S"         , x = 47 , y = 54, sizeX = 16, sizeY = 16, reserved = false, pressed = false },
	[0x54] = { translation = "T"         , x = 98 , y = 36, sizeX = 16, sizeY = 16, reserved = false, pressed = false },
	[0x55] = { translation = "U"         , x = 134, y = 36, sizeX = 16, sizeY = 16, reserved = false, pressed = false },
	[0x56] = { translation = "V"         , x = 92 , y = 72, sizeX = 16, sizeY = 16, reserved = false, pressed = false },
	[0x57] = { translation = "W"         , x = 44 , y = 36, sizeX = 16, sizeY = 16, reserved = false, pressed = false },
	[0x58] = { translation = "X"         , x = 56 , y = 72, sizeX = 16, sizeY = 16, reserved = false, pressed = false },
	[0x59] = { translation = "Y"         , x = 116, y = 36, sizeX = 16, sizeY = 16, reserved = false, pressed = false },
	[0x5A] = { translation = "Z"         , x = 38 , y = 72, sizeX = 16, sizeY = 16, reserved = false, pressed = false },
	[0x70] = { translation = "F1"        , x = 18 , y = 2 , sizeX = 14, sizeY = 14, reserved = false, pressed = false },
	[0x71] = { translation = "F2"        , x = 34 , y = 2 , sizeX = 14, sizeY = 14, reserved = false, pressed = false },
	[0x72] = { translation = "F3"        , x = 50 , y = 2 , sizeX = 14, sizeY = 14, reserved = false, pressed = false },
	[0x73] = { translation = "F4"        , x = 66 , y = 2 , sizeX = 14, sizeY = 14, reserved = false, pressed = false },
	[0x74] = { translation = "F5"        , x = 82 , y = 2 , sizeX = 14, sizeY = 14, reserved = false, pressed = false },
	[0x75] = { translation = "F6"        , x = 98 , y = 2 , sizeX = 14, sizeY = 14, reserved = false, pressed = false },
	[0x76] = { translation = "F7"        , x = 114, y = 2 , sizeX = 14, sizeY = 14, reserved = false, pressed = false },
	[0x77] = { translation = "F8"        , x = 130, y = 2 , sizeX = 14, sizeY = 14, reserved = false, pressed = false },
	[0x78] = { translation = "F9"        , x = 146, y = 2 , sizeX = 14, sizeY = 14, reserved = false, pressed = false },
	[0x79] = { translation = "F10"       , x = 162, y = 2 , sizeX = 14, sizeY = 14, reserved = false, pressed = false },
	[0x7A] = { translation = "F11"       , x = 178, y = 2 , sizeX = 14, sizeY = 14, reserved = false, pressed = false },
	[0x7B] = { translation = "F12"       , x = 194, y = 2 , sizeX = 14, sizeY = 14, reserved = false, pressed = false },
	[0xBC] = { translation = ", <"       , x = 164, y = 72, sizeX = 16, sizeY = 16, reserved = false, pressed = false },
	[0xBE] = { translation = ". >"       , x = 182, y = 72, sizeX = 16, sizeY = 16, reserved = false, pressed = false },
	[0xBF] = { translation = "? /"       , x = 200, y = 72, sizeX = 16, sizeY = 16, reserved = false, pressed = false },
	[0xBA] = { translation = ": ;"       , x = 191, y = 54, sizeX = 16, sizeY = 16, reserved = false, pressed = false },
  [0xDE] = { translation = "\" '"      , x = 209, y = 54, sizeX = 16, sizeY = 16, reserved = false, pressed = false },
	[0xDB] = { translation = "{ ["       , x = 206, y = 36, sizeX = 16, sizeY = 16, reserved = false, pressed = false },
	[0xDD] = { translation = "} ]"       , x = 224, y = 36, sizeX = 16, sizeY = 16, reserved = false, pressed = false },
  [0xDC] = { translation = "| \\"      , x = 242, y = 36, sizeX = 28, sizeY = 16, reserved = false, pressed = false },
	[0xBD] = { translation = "- _"       , x = 197, y = 18, sizeX = 16, sizeY = 16, reserved = false, pressed = false },
	[0xBB] = { translation = "+ ="       , x = 215, y = 18, sizeX = 16, sizeY = 16, reserved = false, pressed = false },
	[0xC0] = { translation = "~ `"       , x = 0  , y = 18, sizeX = 15, sizeY = 16, reserved = false, pressed = false },
	--- Reserved keys --- 
	[0x07] = { translation = ""          , x = 18 , y = 90, sizeX = 54, sizeY = 16, reserved = true , pressed = false },
	[0x0E] = { translation = ""          , x = 212, y = 2 , sizeX = 58, sizeY = 14, reserved = true , pressed = false },
	[0x3A] = { translation = ""          , x = 182, y = 90, sizeX = 34, sizeY = 16, reserved = true , pressed = false },
	[0x88] = { translation = ""          , x = 218, y = 72, sizeX = 16, sizeY = 16, reserved = true , pressed = false },
	[0x97] = { translation = ""          , x = 254, y = 72, sizeX = 16, sizeY = 16, reserved = true , pressed = false }
}

event.listen("KeyboardInput", function(key, isDown)
  local data = keyboard[key]
  if data then 
    data.pressed = isDown
  end
end)

function render(deltaTime) 
  gfx.color(backgroundColor.r, backgroundColor.g, backgroundColor.b, backgroundColor.a)
  gfx.roundRect(0, 0, keyboardSizeX, keyboardSizeY, 2, 10)
    
  local color = nil;
  
  for code, data in pairs(keyboard) do 
    if data.pressed then
      color = pressedKeyColor
    else
      if data.reserved then
        color = reservedColor
      else 
        color = keyColor
      end 
    end 
    
    gfx.color(color.r, color.g, color.b, color.a)
    gfx.roundRect(data.x, data.y, data.sizeX, data.sizeY, 2, 10)
 	
    gfx.color(textColor.r, textColor.g, textColor.b, textColor.a)
    gfx.text(data.x + 4, data.y + 5, data.translation, 0.5)
  end
end

