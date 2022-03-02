--[[
	reference:
	  https://docs.microsoft.com/en-us/windows/win32/inputdev/virtual-key-codes

]]--
function keytostr(key)
	if key == 0x41 then
		return "A"
	elseif key == 0x42 then
		return "B"
	elseif key == 0x43 then
		return "C"
	elseif key == 0x44 then
		return "D"
	elseif key == 0x45 then
		return "E"
	elseif key == 0x46 then
		return "F"
	elseif key == 0x47 then
		return "G"
	elseif key == 0x48 then
		return "H"
	elseif key == 0x49 then
		return "I"
	elseif key == 0x4A then
		return "J"
	elseif key == 0x4B then
		return "K"
	elseif key == 0x4C then
		return "L"
	elseif key == 0x4D then
		return "M"
	elseif key == 0x4E then
		return "N"
	elseif key == 0x4F then
		return "O"
	elseif key == 0x50 then
		return "P"
	elseif key == 0x51 then
		return "Q"
	elseif key == 0x52 then
		return "R"
	elseif key == 0x53 then
		return "S"
	elseif key == 0x54 then
		return "T"
	elseif key == 0x55 then
		return "U"
	elseif key == 0x56 then
		return "V"
	elseif key == 0x57 then
		return "W"
	elseif key == 0x58 then
		return "X"
	elseif key == 0x59 then
		return "Y"
	elseif key == 0x5A then
		return "Z"
	elseif key == 0x30 then
		return "0"
	elseif key == 0x31 then
		return "1"
	elseif key == 0x32 then
		return "2"
	elseif key == 0x33 then
		return "3"
	elseif key == 0x34 then
		return "4"
	elseif key == 0x35 then
		return "5"
	elseif key == 0x36 then
		return "6"
	elseif key == 0x37 then
		return "7"
	elseif key == 0x38 then
		return "8"
	elseif key == 0x39 then
		return "9"
	elseif key == 0x01 then
		return "LMB"
	elseif key == 0x02 then
		return "RMB"
	elseif key == 0x04 then
		return "MMB"
	elseif key == 0x08 then
		return "BackSpace"
	elseif key == 0x09 then
		return "Tab"
	elseif key == 0x0D then
		return "Enter"
	elseif key == 0x10 then
		return "Shift"
	elseif key == 0x11 then
		return "Ctrl"
	elseif key == 0x12 then
		return "Alt"
	elseif key == 0x13 then
		return "Pause"
	elseif key == 0x14 then
		return "CapsLock"
	elseif key == 0x1B then
		return "Esc"
	elseif key == 0x20 then
		return "Space"
	elseif key == 0x21 then
		return "PageUp"
	elseif key == 0x22 then
		return "PageDown"
	elseif key == 0x23 then
		return "End"
	elseif key == 0x24 then
		return "Home"
	elseif key == 0x25 then
		return "Left"
	elseif key == 0x26 then
		return "Up"
	elseif key == 0x27 then
		return "Right"
	elseif key == 0x28 then
		return "Down"
	elseif key == 0x2D then
		return "Insert"
	elseif key == 0x2E then
		return "Delete"
	elseif key == 0x5B then
		return "LeftWin"
	elseif key == 0x5C then
		return "RightWin"
	elseif key == 0x5D then
		return "Apps"
	elseif key == 0x60 then
		return "Num0"
	elseif key == 0x61 then
		return "Num1"
	elseif key == 0x62 then
		return "Num2"
	elseif key == 0x63 then
		return "Num3"
	elseif key == 0x64 then
		return "Num4"
	elseif key == 0x65 then
		return "Num5"
	elseif key == 0x66 then
		return "Num6"
	elseif key == 0x67 then
		return "Num7"
	elseif key == 0x68 then
		return "Num8"
	elseif key == 0x69 then
		return "Num9"
	elseif key == 0x6A then
		return "*"
	elseif key == 0x6B then
		return "+"
	elseif key == 0x6D then
		return "-"
	elseif key == 0x6E then
		return "."
	elseif key == 0x6F then
		return "/"
	elseif key == 0x70 then
		return "F1"
	elseif key == 0x71 then
		return "F2"
	elseif key == 0x72 then
		return "F3"
	elseif key == 0x73 then
		return "F4"
	elseif key == 0x74 then
		return "F5"
	elseif key == 0x75 then
		return "F6"
	elseif key == 0x76 then
		return "F7"
	elseif key == 0x77 then
		return "F8"
	elseif key == 0x78 then
		return "F9"
	elseif key == 0x79 then
		return "F10"
	elseif key == 0x7A then
		return "F11"
	elseif key == 0x7B then
		return "F12"
	elseif key == 0x7C then
		return "F13"
	elseif key == 0x7D then
		return "F14"
	elseif key == 0x7E then
		return "F15"
	elseif key == 0x7F then
		return "F16"
	elseif key == 0x80 then
		return "F17"
	elseif key == 0x81 then
		return "F18"
	elseif key == 0x82 then
		return "F19"
	elseif key == 0x83 then
		return "F20"
	elseif key == 0x84 then
		return "F21"
	elseif key == 0x85 then
		return "F22"
	elseif key == 0x86 then
		return "F23"
	elseif key == 0x87 then
		return "F24"
	elseif key == 0x90 then
		return "NumLock"
	elseif key == 0x91 then
		return "ScrollLock"
	elseif key == 0xA0 then
		return "LeftShift"
	elseif key == 0xA1 then
		return "RightShift"
	elseif key == 0xA2 then
		return "LeftCtrl"
	elseif key == 0xA3 then
		return "RightCtrl"
	elseif key == 0xA4 then
		return "LeftAlt"
	elseif key == 0xA5 then
		return "RightAlt"
	end
end
--made with copilot <3
