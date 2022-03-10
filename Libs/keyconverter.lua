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

-- Returns the keycode of a key
function strtokey(key)
	if key == "A" then
		return 0x41
	elseif key == "B" then
		return 0x42
	elseif key == "C" then
		return 0x43
	elseif key == "D" then
		return 0x44
	elseif key == "E" then
		return 0x45
	elseif key == "F" then
		return 0x46
	elseif key == "G" then
		return 0x47
	elseif key == "H" then
		return 0x48
	elseif key == "I" then
		return 0x49
	elseif key == "J" then
		return 0x4A
	elseif key == "K" then
		return 0x4B
	elseif key == "L" then
		return 0x4C
	elseif key == "M" then
		return 0x4D
	elseif key == "N" then
		return 0x4E
	elseif key == "O" then
		return 0x4F
	elseif key == "P" then
		return 0x50
	elseif key == "Q" then
		return 0x51
	elseif key == "R" then
		return 0x52
	elseif key == "S" then
		return 0x53
	elseif key == "T" then
		return 0x54
	elseif key == "U" then
		return 0x55
	elseif key == "V" then
		return 0x56
	elseif key == "W" then
		return 0x57
	elseif key == "X" then
		return 0x58
	elseif key == "Y" then
		return 0x59
	elseif key == "Z" then
		return 0x5A
	elseif key == "0" then
		return 0x30
	elseif key == "1" then
		return 0x31
	elseif key == "2" then
		return 0x32
	elseif key == "3" then
		return 0x33
	elseif key == "4" then
		return 0x34
	elseif key == "5" then
		return 0x35
	elseif key == "6" then
		return 0x36
	elseif key == "7" then
		return 0x37
	elseif key == "8" then
		return 0x38
	elseif key == "9" then
		return 0x39
	elseif key == "F1" then
		return 0x70
	elseif key == "F2" then
		return 0x71
	elseif key == "F3" then
		return 0x72
	elseif key == "F4" then
		return 0x73
	elseif key == "F5" then
		return 0x74
	elseif key == "F6" then
		return 0x75
	elseif key == "F7" then
		return 0x76
	elseif key == "F8" then
		return 0x77
	elseif key == "F9" then
		return 0x78
	elseif key == "F10" then
		return 0x79
	elseif key == "F11" then
		return 0x7A
	elseif key == "F12" then
		return 0x7B
	elseif key == "F13" then
		return 0x7C
	elseif key == "F14" then
		return 0x7D
	elseif key == "F15" then
		return 0x7E
	elseif key == "F16" then
		return 0x7F
	elseif key == "F17" then
		return 0x80
	elseif key == "F18" then
		return 0x81
	elseif key == "F19" then
		return 0x82
	elseif key == "F20" then
		return 0x83
	elseif key == "F21" then
		return 0x84
	elseif key == "F22" then
		return 0x85
	elseif key == "F23" then
		return 0x86
	elseif key == "F24" then
		return 0x87
	elseif key == "NumLock" then
		return 0x90
	elseif key == "ScrollLock" then
		return 0x91
	elseif key == "LeftShift" then
		return 0xA0
	elseif key == "RightShift" then
		return 0xA1
	elseif key == "LeftCtrl" then
		return 0xA2
	elseif key == "RightCtrl" then
		return 0xA3
	elseif key == "LeftAlt" then
		return 0xA4
	elseif key == "RightAlt" then
		return 0xA5
	elseif key == 'LMB' then
		return 0x01
	elseif key == 'RMB' then
		return 0x02
	elseif key == 'MMB' then
		return 0x04
	elseif key == 'BackSpace' then
		return 0x08
	elseif key == 'Tab' then
		return 0x09
	elseif key == 'Enter' then
		return 0x0D
	elseif key == 'Shift' then
		return 0x10
	elseif key == 'Ctrl' then
		return 0x11
	elseif key == 'Alt' then
		return 0x12
	elseif key == 'Pause' then
		return 0x13
	elseif key == 'CapsLock' then
		return 0x14
	elseif key == 'Escape' then
		return 0x1B
	elseif key == 'Space' then
		return 0x20
	elseif key == 'PageUp' then
		return 0x21
	elseif key == 'PageDown' then
		return 0x22
	elseif key == 'End' then
		return 0x23
	elseif key == 'Home' then
		return 0x24
	elseif key == 'Left' then
		return 0x25
	elseif key == 'Up' then
		return 0x26
	elseif key == 'Right' then
		return 0x27
	elseif key == 'Down' then
		return 0x28
	elseif key == 'Insert' then
		return 0x2D	
	elseif key == 'Delete' then
		return 0x2E
	elseif key == 'LeftWin' then
		return 0x5B
	elseif key == 'RightWin' then
		return 0x5C
	elseif key == 'Apps' then
		return 0x5D
	elseif key == 'Num0' then
		return 0x60
	elseif key == 'Num1' then
		return 0x61
	elseif key == 'Num2' then
		return 0x62
	elseif key == 'Num3' then
		return 0x63
	elseif key == 'Num4' then
		return 0x64
	elseif key == 'Num5' then
		return 0x65
	elseif key == 'Num6' then
		return 0x66
	elseif key == 'Num7' then
		return 0x67
	elseif key == 'Num8' then
		return 0x68
	elseif key == 'Num9' then
		return 0x69
	elseif key == '*' then
		return 0x6A
	elseif key == '+' then
		return 0x6B
	elseif key == '-' then
		return 0x6D
	elseif key == '.' then
		return 0x6E
	elseif key == '/' then
		return 0x6F
	end
end

--made with copilot <3
