-- string functions
function string.startsWith(string, start)
	return string.sub(string, 1, string.len(start)) == start
end

function string.endsWith(string, ending)
	return ending == "" or string.sub(string, -string.len(ending)) == ending
end

function string.trim(string)
	return (string:gsub("^%s*(.-)%s*$", "%1"))
end

function string.replaceFirst(string, what, with)
	return string:gsub("^" .. what, with, 1)
end

function string.replaceLast(string, what, with)
	return string:gsub(what .. "$", with, 1)
end

function string.doubleQuote(string)
	return '"' .. string .. '"'
end

function string.singleQuote(string)
	return "'" .. string .. "'"
end

function string.unquote(string)
	return string:gsub("^['\"](.-)['\"]$", "%1")
end

function string.addSlashes(string)
	return string:gsub("(['\"\\])", "\\%1")
end

function string.stripSlashes(string)
	return string:gsub("\\(['\"\\])", "%1")
end

function string.pad(string, length, direction, char)
	local result = string
	if direction == "left" then
		while string.len(result) < length do
			result = char .. result
		end
	elseif direction == "right" then
		while string.len(result) < length do
			result = result .. char
		end
	end
	return result
end

function string.addArrows(string)
	return ">> " .. string .. " <<"
end

function string.addSpaces(string)
	return "  " .. string .. "  "
end

function string.addDashes(string)
	return "-- " .. string .. " --"
end

function string.addStars(string)
	return "** " .. string .. " **"
end

function string.addEquals(string)
	return "== " .. string .. " =="
end

function string.addUnderscores(string)
	return "__ " .. string .. " __"
end

function string.addDots(string)
	return ".. " .. string .. " .."
end

function string.addCommas(string)
	return ",, " .. string .. " ,,"
end

function string.addColons(string)
	return ":: " .. string .. " ::"
end

function string.addSemicolons(string)
	return ";; " .. string .. " ;;"
end

function string.addPipes(string)
	return "|| " .. string .. " ||"
end

function string.addBackslashes(string)
	return "\\\\ " .. string .. " \\\\"
end

function string.contains(string, substring)
	return string.find(string, substring) ~= nil
end

function string.among(string, ...)
	for i = 1, select("#", ...) do
		if string == select(i, ...) then
			return true
		end
	end
	return false
end

function string.useless(string)
	return string
end

function string.size(string)
	return #string
end

function string.hasNumber(String)
	return string.match(String, "[-0123456789.]+") ~= nil
end

function string.getNumber(String)
	return tonumber(string.match(String, "[-0123456789.]+"))
end

function string.hasLetter(String)
	return string.match(String, "[abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ]") ~= nil
end

function string.getLetter(String)
	return string.match(String, "[abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ]")
end

function string.findLetter(string, letter)
	local result = {}
	for i = 1, string.len(string) do
		if string.sub(string, i, i) == letter then
			table.insert(result, i)
		end
	end
	return result
end

function string.findNumber(string, num)
	local result = {}
	for i = 1, string.len(string) do
		if string.sub(string, i, i) == num then
			table.insert(result, i)
		end
	end
	return result
end

function string.sillyText(string)
	local result = ""
	for i = 1, string.len(string) do
		if i % 2 == 0 then
			result = result .. string.upper(string.sub(string, i, i))
		else
			result = result .. string.lower(string.sub(string, i, i))
		end
	end
	return result
end

function string.sillyTextOpposite(string)
	local result = ""
	for i = 1, string.len(string) do
		if i % 2 == 0 then
			result = result .. string.lower(string.sub(string, i, i))
		else
			result = result .. string.upper(string.sub(string, i, i))
		end
	end
	return result
end

function string.sillyTextRandom(string)
	local result = ""
	for i = 1, string.len(string) do
		if math.random(0, 1) == 0 then
			result = result .. string.upper(string.sub(string, i, i))
		else
			result = result .. string.lower(string.sub(string, i, i))
		end
	end
	return result
end

function string.leet(string)
	local result = ""
	for i = 1, string.len(string) do
		local char = string.sub(string, i, i)
		if char == "a" then
			result = result .. "4"
		elseif char == "e" then
			result = result .. "3"
		elseif char == "i" then
			result = result .. "1"
		elseif char == "o" then
			result = result .. "0"
		elseif char == "s" then
			result = result .. "5"
		elseif char == "t" then
			result = result .. "7"
		else
			result = result .. char
		end
	end
	return result
end

function string.toGzip(string)
	local result = ""
	for i = 1, string.len(string) do
		local char = string.sub(string, i, i)
		if char == "a" then
			result = result .. "4"
		elseif char == "e" then
			result = result .. "3"
		elseif char == "i" then
			result = result .. "1"
		elseif char == "o" then
			result = result .. "0"
		elseif char == "s" then
			result = result .. "5"
		elseif char == "t" then
			result = result .. "7"
		elseif char == "4" then
			result = result .. "a"
		elseif char == "3" then
			result = result .. "e"
		elseif char == "1" then
			result = result .. "i"
		elseif char == "0" then
			result = result .. "o"
		elseif char == "5" then
			result = result .. "s"
		elseif char == "7" then
			result = result .. "t"
		else
			result = result .. char
		end
	end
	return result
end

function string.fromGzip(string)
	local result = ""
	for i = 1, string.len(string) do
		local char = string.sub(string, i, i)
		if char == "a" then
			result = result .. "4"
		elseif char == "e" then
			result = result .. "3"
		elseif char == "i" then
			result = result .. "1"
		elseif char == "o" then
			result = result .. "0"
		elseif char == "s" then
			result = result .. "5"
		elseif char == "t" then
			result = result .. "7"
		elseif char == "4" then
			result = result .. "a"
		elseif char == "3" then
			result = result .. "e"
		elseif char == "1" then
			result = result .. "i"
		elseif char == "0" then
			result = result .. "o"
		elseif char == "5" then
			result = result .. "s"
		elseif char == "7" then
			result = result .. "t"
		else
			result = result .. char
		end
	end
	return result
end

function string.firstToUpper(string)
	return string.upper(string.sub(string, 1, 1)) .. string.sub(string, 2)
end

function string.firstToLower(string)
	return string.lower(string.sub(string, 1, 1)) .. string.sub(string, 2)
end

function string.lastToUpper(string)
	return string.sub(string, 1, string.len(string) - 1) .. string.upper(string.sub(string, string.len(string)))
end

function string.lastToLower(string)
	return string.sub(string, 1, string.len(string) - 1) .. string.lower(string.sub(string, string.len(string)))
end

function string.addAmongUsCharacters(string)
	local result = ""
	for i = 1, string.len(string) do
		local char = string.sub(string, i, i)
		if char == "a" then
			result = result .. "a"
		elseif char == "b" then
			result = result .. "b"
		elseif char == "c" then
			result = result .. "c"
		elseif char == "d" then
			result = result .. "d"
		elseif char == "e" then
			result = result .. "e"
		elseif char == "f" then
			result = result .. "f"
		elseif char == "g" then
			result = result .. "g"
		elseif char == "h" then
			result = result .. "h"
		elseif char == "i" then
			result = result .. "i"
		elseif char == "j" then
			result = result .. "j"
		elseif char == "k" then
			result = result .. "k"
		elseif char == "l" then
			result = result .. "l"
		elseif char == "m" then
			result = result .. "m"
		elseif char == "n" then
			result = result .. "n"
		elseif char == "o" then
			result = result .. "o"
		elseif char == "p" then
			result = result .. "p"
		elseif char == "q" then
			result = result .. "q"
		elseif char == "r" then
			result = result .. "r"
		elseif char == "s" then
			result = result .. "s"
		elseif char == "t" then
			result = result .. "t"
		elseif char == "u" then
			result = result .. "u"
		elseif char == "v" then
			result = result .. "v"
		elseif char == "w" then
			result = result .. "w"
		elseif char == "x" then
			result = result .. "x"
		elseif char == "y" then
			result = result .. "y"
		elseif char == "z" then
			result = result .. "z"
		elseif char == "A" then
			result = result .. "A"
		elseif char == "B" then
			result = result .. "B"
		elseif char == "C" then
			result = result .. "C"
		elseif char == "D" then
			result = result .. "D"
		elseif char == "E" then
			result = result .. "E"
		elseif char == "F" then
			result = result .. "F"
		elseif char == "G" then
			result = result .. "G"
		elseif char == "H" then
			result = result .. "H"
		elseif char == "I" then
			result = result .. "I"
		elseif char == "J" then
			result = result .. "J"
		elseif char == "K" then
			result = result .. "K"
		elseif char == "L" then
			result = result .. "L"
		elseif char == "M" then
			result = result .. "M"
		elseif char == "N" then
			result = result .. "N"
		elseif char == "O" then
			result = result .. "O"
		elseif char == "P" then
			result = result .. "P"
		elseif char == "Q" then
			result = result .. "Q"
		elseif char == "R" then
			result = result .. "R"
		elseif char == "S" then
			result = result .. "S"
		elseif char == "T" then
			result = result .. "T"
		elseif char == "U" then
			result = result .. "U"
		elseif char == "V" then
			result = result .. "V"
		elseif char == "W" then
			result = result .. "W"
		elseif char == "X" then
			result = result .. "X"
		elseif char == "Y" then
			result = result .. "Y"
		elseif char == "Z" then
			result = result .. "Z"
		elseif char == " " then
			result = result .. " "
		elseif char == "0" then
			result = result .. "0"
		elseif char == "1" then
			result = result .. "1"
		elseif char == "2" then
			result = result .. "2"
		elseif char == "3" then
			result = result .. "3"
		elseif char == "4" then
			result = result .. "4"
		elseif char == "5" then
			result = result .. "5"
		elseif char == "6" then
			result = result .. "6"
		elseif char == "7" then
			result = result .. "7"
		elseif char == "8" then
			result = result .. "8"
		elseif char == "9" then
			result = result .. "9"
		elseif char == "!" then
			result = result .. "!"
		elseif char == "?" then
			result = result .. "?"
		elseif char == "." then
			result = result .. "."
		elseif char == "," then
			result = result .. ","
		elseif char == "'" then
			result = result .. "'"
		elseif char == '"' then
			result = result .. '"'
		elseif char == "@" then
			result = result .. "@"
		elseif char == "#" then
			result = result .. "#"
		elseif char == "$" then
			result = result .. "$"
		elseif char == "%" then
			result = result .. "%"
		elseif char == "^" then
			result = result .. "^"
		elseif char == "&" then
			result = result .. "&"
		elseif char == "*" then
			result = result .. "*"
		elseif char == "(" then
			result = result .. "("
		elseif char == ")" then
			result = result .. ")"
		elseif char == "-" then
			result = result .. "-"
		elseif char == "_" then
			result = result .. "_"
		elseif char == "=" then
			result = result .. "="
		elseif char == "+" then
			result = result .. "+"
		elseif char == "[" then
			result = result .. "["
		elseif char == "]" then
			result = result .. "]"
		elseif char == "{" then
			result = result .. "{"
		elseif char == "}" then
			result = result .. "}"
		elseif char == ";" then
			result = result .. ";"
		elseif char == ":" then
			result = result .. ":"
		elseif char == "/" then
			result = result .. "/"
		elseif char == "\\" then
			result = result .. "\\"
		elseif char == "|" then
			result = result .. "|"
		elseif char == "`" then
			result = result .. "`"
		elseif char == "~" then
			result = result .. "~"
		elseif char == "<" then
			result = result .. "<"
		elseif char == ">" then
			result = result .. ">"
		elseif char == " " then
			result = result .. " "
		end
	end
	return result
end


function string.toMorseCode(string)
	local result = ""
	for i = 1, string.len(string) do
		local char = string.sub(string, i, i)
		if char == "a" then
			result = result .. ".-"
		elseif char == "b" then
			result = result .. "-..."
		elseif char == "c" then
			result = result .. "-.-."
		elseif char == "d" then
			result = result .. "-.."
		elseif char == "e" then
			result = result .. "."
		elseif char == "f" then
			result = result .. "..-."
		elseif char == "g" then
			result = result .. "--."
		elseif char == "h" then
			result = result .. "...."
		elseif char == "i" then
			result = result .. ".."
		elseif char == "j" then
			result = result .. ".---"
		elseif char == "k" then
			result = result .. "-.-"
		elseif char == "l" then
			result = result .. ".-.."
		elseif char == "m" then
			result = result .. "--"
		elseif char == "n" then
			result = result .. "-."
		elseif char == "o" then
			result = result .. "---"
		elseif char == "p" then
			result = result .. ".--."
		elseif char == "q" then
			result = result .. "--.-"
		elseif char == "r" then
			result = result .. ".-."
		elseif char == "s" then
			result = result .. "..."
		elseif char == "t" then
			result = result .. "-"
		elseif char == "u" then
			result = result .. "..-"
		elseif char == "v" then
			result = result .. "...-"
		elseif char == "w" then
			result = result .. ".--"
		elseif char == "x" then
			result = result .. "-..-"
		elseif char == "y" then
			result = result .. "-.--"
		elseif char == "z" then
			result = result .. "--.."
		elseif char == "1" then
			result = result .. ".----"
		elseif char == "2" then
			result = result .. "..---"
		elseif char == "3" then
			result = result .. "...--"
		elseif char == "4" then
			result = result .. "....-"
		elseif char == "5" then
			result = result .. "....."
		elseif char == "6" then
			result = result .. "-...."
		elseif char == "7" then
			result = result .. "--..."
		elseif char == "8" then
			result = result .. "---.."
		elseif char == "9" then
			result = result .. "----."
		elseif char == "0" then
			result = result .. "-----"
		elseif char == " " then
			result = result .. " "
		end
	end
	return result
end

function string.fromMorse(string)
	local result = ""
	local morse = ""
	for i = 1, string.len(string) do
		local char = string.sub(string, i, i)
		if char == " " then
			if morse == ".-" then
				result = result .. "a"
			elseif morse == "-..." then
				result = result .. "b"
			elseif morse == "-.-." then
				result = result .. "c"
			elseif morse == "-.." then
				result = result .. "d"
			elseif morse == "." then
				result = result .. "e"
			elseif morse == "..-." then
				result = result .. "f"
			elseif morse == "--." then
				result = result .. "g"
			elseif morse == "...." then
				result = result .. "h"
			elseif morse == ".." then
				result = result .. "i"
			elseif morse == ".---" then
				result = result .. "j"
			elseif morse == "-.-" then
				result = result .. "k"
			elseif morse == ".-.." then
				result = result .. "l"
			elseif morse == "--" then
				result = result .. "m"
			elseif morse == "-." then
				result = result .. "n"
			elseif morse == "---" then
				result = result .. "o"
			elseif morse == ".--." then
				result = result .. "p"
			elseif morse == "--.-" then
				result = result .. "q"
			elseif morse == ".-." then
				result = result .. "r"
			elseif morse == "..." then
				result = result .. "s"
			elseif morse == "-" then
				result = result .. "t"
			elseif morse == "..-" then
				result = result .. "u"
			elseif morse == "...-" then
				result = result .. "v"
			elseif morse == ".--" then
				result = result .. "w"
			elseif morse == "-..-" then
				result = result .. "x"
			elseif morse == "-.--" then
				result = result .. "y"
			elseif morse == "--.." then
				result = result .. "z"
			elseif morse == ".----" then
				result = result .. "1"
			elseif morse == "..---" then
				result = result .. "2"
			elseif morse == "...--" then
				result = result .. "3"
			elseif morse == "....-" then
				result = result .. "4"
			elseif morse == "....." then
				result = result .. "5"
			elseif morse == "-...." then
				result = result .. "6"
			elseif morse == "--..." then
				result = result .. "7"
			elseif morse == "---.." then
				result = result .. "8"
			elseif morse == "----." then
				result = result .. "9"
			elseif morse == "-----" then
				result = result .. "0"
			end
			morse = ""
		else
			morse = morse .. char
		end
	end
	return result
end

function string.base64Encode(string)
	local result = ""
	local base64 = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
	for i = 1, string.len(string), 3 do
		local char1 = string.byte(string, i)
		local char2 = string.byte(string, i + 1)
		local char3 = string.byte(string, i + 2)
		local char4 = 0
		if char2 == nil then
			char2 = 0
			char3 = 0
			char4 = 64
		elseif char3 == nil then
			char3 = 0
			char4 = 64
		end
		local char1_1 = math.floor(char1 / 4)
		local char1_2 = char1 % 4
		local char2_1 = math.floor(char2 / 16)
		local char2_2 = math.floor((char2 % 16) / 4)
		local char2_3 = char2 % 4
		local char3_1 = math.floor(char3 / 64)
		local char3_2 = math.floor((char3 % 64) / 16)
		local char3_3 = math.floor((char3 % 16) / 4)
		local char3_4 = char3 % 4
		result = result .. string.sub(base64, char1_1 + 1, char1_1 + 1)
		result = result .. string.sub(base64, char1_2 * 16 + char2_1 + 1, char1_2 * 16 + char2_1 + 1)
		result = result .. string.sub(base64, char2_2 * 4 + char2_3 * 16 + char3_1 + 1, char2_2 * 4 + char2_3 * 16 + char3_1 + 1)
		result = result .. string.sub(base64, char3_2 * 4 + char3_3 * 16 + char3_4 * 64 + 1, char3_2 * 4 + char3_3 * 16 + char3_4 * 64 + 1)
		if char4 == 64 then
			result = result .. "="
		end
	end
	return result
end

function string.base64Decode(string)
	local result = ""
	local base64 = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
	for i = 1, string.len(string), 4 do
		local char1 = string.find(base64, string.sub(string, i, i)) - 1
		local char2 = string.find(base64, string.sub(string, i + 1, i + 1)) - 1
		local char3 = string.find(base64, string.sub(string, i + 2, i + 2)) - 1
		local char4 = string.find(base64, string.sub(string, i + 3, i + 3)) - 1
		local char1_1 = math.floor(char1 / 16)
		local char1_2 = char1 % 16
		local char2_1 = math.floor(char2 / 4)
		local char2_2 = char2 % 4
		local char3_1 = math.floor(char3 / 16)
		local char3_2 = math.floor((char3 % 16) / 4)
		local char3_3 = char3 % 4
		local char4_1 = math.floor(char4 / 64)
		local char4_2 = math.floor((char4 % 64) / 16)
		local char4_3 = math.floor((char4 % 16) / 4)
		local char4_4 = char4 % 4
		result = result .. string.char(char1_1 * 64 + char1_2 * 16 + char2_1 * 4 + char2_2)
		if char3 ~= 64 then
			result = result .. string.char(char2_2 * 64 + char3_1 * 16 + char3_2 * 4 + char3_3)
		end
		if char4 ~= 64 then
			result = result .. string.char(char3_3 * 64 + char4_1 * 16 + char4_2 * 4 + char4_3)
		end
	end
	return result
end

function string.toHex(string)
	local result = ""
	local hex = "0123456789ABCDEF"
	for i = 1, string.len(string) do
		local char = string.byte(string, i)
		local char1 = math.floor(char / 16)
		local char2 = char % 16
		result = result .. string.sub(hex, char1 + 1, char1 + 1) .. string.sub(hex, char2 + 1, char2 + 1)
	end
	return result
end

function string.fromHex(string)
	local result = ""
	local hex = "0123456789ABCDEF"
	for i = 1, string.len(string), 2 do
		local char1 = string.find(hex, string.sub(string, i, i)) - 1
		local char2 = string.find(hex, string.sub(string, i + 1, i + 1)) - 1
		result = result .. string.char(char1 * 16 + char2)
	end
	return result
end

function string.toBinary(string)
	local result = ""
	for i = 1, string.len(string) do
		local char = string.byte(string, i)
		local char1 = math.floor(char / 128)
		local char2 = math.floor((char % 128) / 64)
		local char3 = math.floor((char % 64) / 32)
		local char4 = math.floor((char % 32) / 16)
		local char5 = math.floor((char % 16) / 8)
		local char6 = math.floor((char % 8) / 4)
		local char7 = math.floor((char % 4) / 2)
		local char8 = char % 2
		result = result .. char1 .. char2 .. char3 .. char4 .. char5 .. char6 .. char7 .. char8
	end
	return result
end

function string.fromBinary(string)
	local result = ""
	for i = 1, string.len(string), 8 do
		local char1 = string.sub(string, i, i)
		local char2 = string.sub(string, i + 1, i + 1)
		local char3 = string.sub(string, i + 2, i + 2)
		local char4 = string.sub(string, i + 3, i + 3)
		local char5 = string.sub(string, i + 4, i + 4)
		local char6 = string.sub(string, i + 5, i + 5)
		local char7 = string.sub(string, i + 6, i + 6)
		local char8 = string.sub(string, i + 7, i + 7)
		result = result .. string.char(char1 * 128 + char2 * 64 + char3 * 32 + char4 * 16 + char5 * 8 + char6 * 4 + char7 * 2 + char8)
	end
	return result
end

function string.toUnicode(string)
	local result = ""
	for i = 1, string.len(string) do
		local char = string.byte(string, i)
		local char1 = math.floor(char / 16)
		local char2 = char % 16
		result = result .. "U+" .. char1 .. char2
	end
	return result
end

function string.fromUnicode(string)
	local result = ""
	for i = 1, string.len(string), 4 do
		local char1 = string.sub(string, i + 2, i + 2)
		local char2 = string.sub(string, i + 3, i + 3)
		result = result .. string.char(char1 * 16 + char2)
	end
	return result
end

function string.toOctal(string)
	local result = ""
	for i = 1, string.len(string) do
		local char = string.byte(string, i)
		local char1 = math.floor(char / 64)
		local char2 = math.floor((char % 64) / 8)
		local char3 = char % 8
		result = result .. char1 .. char2 .. char3
	end
	return result
end

function string.fromOctal(string)
	local result = ""
	for i = 1, string.len(string), 3 do
		local char1 = string.sub(string, i, i)
		local char2 = string.sub(string, i + 1, i + 1)
		local char3 = string.sub(string, i + 2, i + 2)
		result = result .. string.char(char1 * 64 + char2 * 8 + char3)
	end
	return result
end

-- table functions
function table.contains(table, element)
	for _, value in pairs(table) do
		if value == element then
			return true
		end
	end
	return false
end

function table.find(table, element)
	for i, value in pairs(table) do
		if value == element then
			return i
		end
	end
	return nil
end

function table.toString(table)
	local result = "{"
	for key, value in pairs(table) do
		result = result .. "[" .. key .. "] = " .. value .. ", "
	end
	return result .. "}"
end


function table.merge(table1, table2)
	local result = table.clone(table1)
	local result2 = table.clone(table2)
	for key, value in pairs(result2) do
		result[key] = value
	end
	return result
end

function table.sortByValue(table, descending)
	local result = {}
	for key, value in pairs(table) do
		table.insert(result, {key = key, value = value})
	end
	table.sort(result, function(a, b)
		if descending then
			return a.value > b.value
		else
			return a.value < b.value
		end
	end)
	return result
end

function table.sortByFunction(table, func)
	local result = {}
	for key, value in pairs(table) do
		table.insert(result, {key = key, value = value})
	end
	table.sort(result, func)
	return result
end

function table.random(table)
	return table[math.random(#table)]
end

function table.pop(table)
	local result = table[1]
	table.remove(table, 1)
	return result
end

function table.push(table, element)
	table.insert(table, element)
end

function table.reverse(table)
	local result = {}
	for i = #table, 1, -1 do
		table.insert(result, table[i])
	end
	return result
end

function table.unique(table)
	local result = {}
	for _, value in pairs(table) do
		if not table.contains(result, value) then
			table.insert(result, value)
		end
	end
	return result
end

function table.shuffle(table)
	local result = {}
	for _, value in pairs(table) do
		table.insert(result, math.random(#result + 1), value)
	end
	return result
end

function table.slice(table, start, stop)
	local result = {}
	for i = start, stop do
		table.insert(result, table[i])
	end
	return result
end

function table.join(table, glue)
	local result = ""
	for _, value in pairs(table) do
		result = result .. glue .. value
	end
	return result
end

function table.count(table)
	local result = 0
	for _, _ in pairs(table) do
		result = result + 1
	end
	return result
end

function table.sum(table)
	local result = 0
	for _, value in pairs(table) do
		result = result + value
	end
	return result
end

function table.average(table)
	return table.sum(table) / table.count(table)
end

function table.min(table)
	local result = nil
	for _, value in pairs(table) do
		if result == nil or value < result then
			result = value
		end
	end
	return result
end

function table.max(table)
	local result = nil
	for _, value in pairs(table) do
		if result == nil or value > result then
			result = value
		end
	end
	return result
end

function table.flip(table)
	local result = {}
	for key, value in pairs(table) do
		result[value] = key
	end
	return result
end

function table.map(table, func)
	local result = {}
	for key, value in pairs(table) do
		result[key] = func(value)
	end
	return result
end

function table.filter(table, func)
	local result = {}
	for key, value in pairs(table) do
		if func(value) then
			result[key] = value
		end
	end
	return result
end

function table.reduce(table, func, initial)
	local result = initial
	for _, value in pairs(table) do
		result = func(result, value)
	end
	return result
end

function table.clear(Table)
	while #Table > 0 do
		table.remove(Table, 1)
	end
end

function table.forEach(table, func)
	for key, value in pairs(table) do
		func(key, value)
	end
end

function table.swap(table, index1, index2)
	local temp = table[index1]
	table[index1] = table[index2]
	table[index2] = temp
end

function table.front(table)
	for k, v in pairs(table) do
		return v
	end
	return nil
end

function table.back(table)
	local back = nil
	for k, v in pairs(table) do
		back = v
	end
	return back
end

function table.multiSort(table, ...)
	local args = {...}
	local result = table.clone(table)
	table.sort(result, function(a, b)
		for _, arg in pairs(args) do
			if a[arg] ~= b[arg] then
				return a[arg] < b[arg]
			end
		end
		return false
	end)
	return result
end

-- integer functions

function math.round(number)
	return math.floor(number + 0.5)
end

function math.lerp(a, b, t)
	return a + (b - a) * t
end

function math.inverseLerp(a, b, value)
	return (value - a) / (b - a)
end

function math.map(value, a1, a2, b1, b2)
	return b1 + (value - a1) * (b2 - b1) / (a2 - a1)
end

function math.randomChoice(...)
	local args = {...}
	return args[math.random(#args)]
end

function math.randomWeighted(...)
	local args = {...}
	local total = 0
	for _, weight in pairs(args) do
		total = total + weight
	end
	local random = math.random() * total
	for i, weight in pairs(args) do
		random = random - weight
		if random <= 0 then
			return i
		end
	end
end

function math.randomNormal(mean, standardDeviation)
	local u1 = math.random()
	local u2 = math.random()
	local z0 = math.sqrt(-2 * math.log(u1)) * math.cos(2 * math.pi * u2)
	return z0 * standardDeviation + mean
end

function math.randomNormalInt(mean, standardDeviation)
	return math.round(math.randomNormal(mean, standardDeviation))
end

function math.randomNormalClamped(mean, standardDeviation)
	return math.clamp(math.randomNormal(mean, standardDeviation), 0, 1)
end

function math.toMorseCode(number)
	local morseCode = {
		[0] = "-----",
		[1] = ".----",
		[2] = "..---",
		[3] = "...--",
		[4] = "....-",
		[5] = ".....",
		[6] = "-....",
		[7] = "--...",
		[8] = "---..",
		[9] = "----.",
	}
	local result = ""
	for digit in tostring(number):gmatch("%d") do
		result = result .. morseCode[tonumber(digit)] .. " "
	end
	return result
end

function math.fromMorseCode(morseCode)
	local morseCode = {
		["-----"] = 0,
		[".----"] = 1,
		["..---"] = 2,
		["...--"] = 3,
		["....-"] = 4,
		["....."] = 5,
		["-...."] = 6,
		["--..."] = 7,
		["---.."] = 8,
		["----."] = 9,
	}
	local result = ""
	for digit in morseCode:gmatch("%S+") do
		result = result .. morseCode[digit]
	end
	return tonumber(result)
end


function math.toRomanNumeral(number)
	local romanNumerals = {
		[1] = "I",
		[4] = "IV",
		[5] = "V",
		[9] = "IX",
		[10] = "X",
		[40] = "XL",
		[50] = "L",
		[90] = "XC",
		[100] = "C",
		[400] = "CD",
		[500] = "D",
		[900] = "CM",
		[1000] = "M",
	}
	local result = ""
	for i = #romanNumerals, 1, -1 do
		while number >= romanNumerals[i] do
			result = result .. romanNumerals[i]
			number = number - romanNumerals[i]
		end
	end
	return result
end

function math.fromRomanNumeral(romanNumeral)
	local romanNumerals = {
		["I"] = 1,
		["V"] = 5,
		["X"] = 10,
		["L"] = 50,
		["C"] = 100,
		["D"] = 500,
		["M"] = 1000,
	}
	local result = 0
	for i = 1, #romanNumeral do
		local current = romanNumerals[romanNumeral:sub(i, i)]
		local next = romanNumerals[romanNumeral:sub(i + 1, i + 1)]
		if next and next > current then
			result = result + next - current
			i = i + 1
		else
			result = result + current
		end
	end
	return result
end

function math.toBase(number, base)
	local base = {
		[0] = "0",
		[1] = "1",
		[2] = "2",
		[3] = "3",
		[4] = "4",
		[5] = "5",
		[6] = "6",
		[7] = "7",
		[8] = "8",
		[9] = "9",
		[10] = "A",
		[11] = "B",
		[12] = "C",
		[13] = "D",
		[14] = "E",
		[15] = "F",
		[16] = "G",
		[17] = "H",
		[18] = "I",
		[19] = "J",
		[20] = "K",
		[21] = "L",
		[22] = "M",
		[23] = "N",
		[24] = "O",
		[25] = "P",
		[26] = "Q",
		[27] = "R",
		[28] = "S",
		[29] = "T",
		[30] = "U",
		[31] = "V",
		[32] = "W",
		[33] = "X",
		[34] = "Y",
		[35] = "Z",
	}
	local result = ""
	while number > 0 do
		result = base[number % base] .. result
		number = math.floor(number / base)
	end
	return result
end

function math.fromBase(base, number)
	local base = {
		["0"] = 0,
		["1"] = 1,
		["2"] = 2,
		["3"] = 3,
		["4"] = 4,
		["5"] = 5,
		["6"] = 6,
		["7"] = 7,
		["8"] = 8,
		["9"] = 9,
		["A"] = 10,
		["B"] = 11,
		["C"] = 12,
		["D"] = 13,
		["E"] = 14,
		["F"] = 15,
		["G"] = 16,
		["H"] = 17,
		["I"] = 18,
		["J"] = 19,
		["K"] = 20,
		["L"] = 21,
		["M"] = 22,
		["N"] = 23,
		["O"] = 24,
		["P"] = 25,
		["Q"] = 26,
		["R"] = 27,
		["S"] = 28,
		["T"] = 29,
		["U"] = 30,
		["V"] = 31,
		["W"] = 32,
		["X"] = 33,
		["Y"] = 34,
		["Z"] = 35,
	}
	local result = 0
	for digit in number:gmatch("%S") do
		result = result * base + base[digit]
	end
	return result
end

function math.toOctal(number)
	return math.toBase(number, 8)
end

function math.fromOctal(number)
	return math.fromBase(8, number)
end

function math.toHex(number)
	return math.toBase(number, 16)
end

function math.fromHex(number)
	return math.fromBase(16, number)
end

function math.toBinary(number)
	return math.toBase(number, 2)
end

function math.fromBinary(number)
	return math.fromBase(2, number)
end

function math.circleArea(radius)
	return math.pi * radius ^ 2
end

function math.circleCircumference(radius)
	return 2 * math.pi * radius
end

function math.circleDiameter(radius)
	return 2 * radius
end

function math.circleRadius(diameter)
	return diameter / 2
end

function math.area(width, height)
	return width * height
end

function math.perimeter(width, height)
	return 2 * (width + height)
end

function math.distance(x1, y1, x2, y2)
	return math.sqrt((x2 - x1) ^ 2 + (y2 - y1) ^ 2)
end

function math.threeDimensionalDistance(x1, y1, z1, x2, y2, z2)
	return math.sqrt((x2 - x1) ^ 2 + (y2 - y1) ^ 2 + (z2 - z1) ^ 2)
end

function math.vector(x1, y1, x2, y2)
	return x2 - x1, y2 - y1
end

function math.angle(x1, y1, x2, y2)
	return math.atan(y2 - y1, x2 - x1)
end

function math.angleDifference(angle1, angle2)
	return math.atan(math.sin(angle2 - angle1), math.cos(angle2 - angle1))
end

function math.angleBetween(x1, y1, x2, y2)
	return math.angleDifference(math.angle(x1, y1, x2, y2), math.angle(x1, y1, x1 + 1, y1))
end

function math.angleToDirection(angle)
	return math.cos(angle), math.sin(angle)
end

function math.directionToAngle(x, y)
	return math.atan(y, x)
end

function math.directionToVector(x, y)
	local length = math.sqrt(x ^ 2 + y ^ 2)
	return x / length, y / length
end

function math.vectorToDirection(x, y)
	return x, y
end

function math.vectorToAngle(x, y)
	return math.directionToAngle(math.vectorToDirection(x, y))
end

function math.vectorLength(x, y)
	return math.sqrt(x ^ 2 + y ^ 2)
end

function math.vectorAngle(x, y)
	return math.atan(y, x)
end

function math.vectorAngleDifference(x1, y1, x2, y2)
	return math.atan(math.sin(math.vectorAngle(x2, y2) - math.vectorAngle(x1, y1)), math.cos(math.vectorAngle(x2, y2) - math.vectorAngle(x1, y1)))
end

function math.vectorAngleBetween(x1, y1, x2, y2)
	return math.vectorAngleDifference(x1, y1, x2, y2), math.vectorAngleDifference(x1, y1, x1 + 1, y1)
end

function math.vectorAdd(x1, y1, x2, y2)
	return x1 + x2, y1 + y2
end

function math.vectorSubtract(x1, y1, x2, y2)
	return x1 - x2, y1 - y2
end

function math.vectorMultiply(x, y, scalar)
	return x * scalar, y * scalar
end

function math.vectorDivide(x, y, scalar)
	return x / scalar, y / scalar
end

function math.vectorDotProduct(x1, y1, x2, y2)
	return x1 * x2 + y1 * y2
end

function math.vectorCrossProduct(x1, y1, x2, y2)
	return x1 * y2 - y1 * x2
end

function math.vectorProject(x1, y1, x2, y2)
	local dotProduct = math.vectorDotProduct(x1, y1, x2, y2)
	local length = math.vectorLength(x2, y2)
	return math.vectorMultiply(x2, y2, dotProduct / length ^ 2)
end

function math.vectorReflect(x1, y1, x2, y2)
	local dotProduct = math.vectorDotProduct(x1, y1, x2, y2)
	local length = math.vectorLength(x2, y2)
	return math.vectorMultiply(x2, y2, 2 * dotProduct / length ^ 2 - 1)
end

function math.vectorRotate(x, y, angle)
	return x * math.cos(angle) - y * math.sin(angle), x * math.sin(angle) + y * math.cos(angle)
end

function math.reflection(angle, angleOfIncidence)
	return math.atan(math.sin(angle - angleOfIncidence), math.cos(angle - angleOfIncidence))
end

function math.refraction(angle, angleOfIncidence, index1, index2)
	return math.atan(math.sin(angle - angleOfIncidence) * index1 / index2, math.cos(angle - angleOfIncidence))
end

function math.bloom(x, y, radius, intensity)
	local distance = math.distance(0, 0, x, y)
	if distance > radius then
		return 0
	else
		return intensity * (1 - distance / radius)
	end
end

function math.quad(a, b, c)
	local discriminant = b ^ 2 - 4 * a * c
	if discriminant < 0 then
		return nil
	elseif discriminant == 0 then
		return -b / (2 * a)
	else
		return (-b + math.sqrt(discriminant)) / (2 * a), (-b - math.sqrt(discriminant)) / (2 * a)
	end
end

function math.cubic(a, b, c, d)
	local discriminant = 18 * a * b * c * d - 4 * b ^ 3 * d + b ^ 2 * c ^ 2 - 4 * a * c ^ 3 - 27 * a ^ 2 * d ^ 2
	if discriminant == 0 then
		return -b / (3 * a)
	else
		local s = math.cbrt((2 * b ^ 3 - 9 * a * b * c + 27 * a ^ 2 * d + math.sqrt(-4 * b ^ 2 * c ^ 2 + 18 * a * b * c * d - 27 * a ^ 2 * d ^ 2 + 4 * discriminant ^ 2)) / 2)
		local t = math.cbrt((2 * b ^ 3 - 9 * a * b * c + 27 * a ^ 2 * d - math.sqrt(-4 * b ^ 2 * c ^ 2 + 18 * a * b * c * d - 27 * a ^ 2 * d ^ 2 + 4 * discriminant ^ 2)) / 2)
		return (-b - s - t) / (3 * a)
	end
end

function math.quartic(a, b, c, d, e)
	local discriminant = 256 * e ^ 3 * a ^ 2 - 192 * e ^ 2 * d * a ^ 3 - 128 * e ^ 2 * c ^ 2 * a ^ 2 + 144 * e * d ^ 2 * a ^ 3 + 27 * d ^ 4 * a ^ 4 + 144 * e ^ 2 * b * c * a ^ 3 - 6 * e * c ^ 3 * a ^ 2 - 80 * e * d * c * a ^ 3 - 18 * d ^ 3 * c * a ^ 4 - 27 * c ^ 4 * a ^ 2 + 18 * e * b * d ^ 2 * a ^ 3 + 18 * b * d ^ 3 * a ^ 4 - 4 * e * b * c ^ 2 * a ^ 3 - 4 * b * c ^ 3 * a ^ 2
	if discriminant == 0 then
		return -b / (4 * a)
	else
		local s = math.cbrt((8 * e * a * c - 2 * b ^ 3 - 8 * d * a ^ 2) / 2 + math.sqrt(-2 * b ^ 3 - 27 * a ^ 2 * d ^ 2 + 18 * a * b * c - 4 * c ^ 3 + 144 * e ^ 2 * a ^ 2 - 4 * b ^ 2 * c ^ 2 + 18 * e * b * d * a ^ 2 - 4 * e * c ^ 2 * a ^ 2 + 256 * e ^ 3 * a ^ 2 + 144 * e ^ 2 * b * c * a ^ 2 - 80 * e * d * c * a ^ 2 - 6 * e * b * d ^ 2 * a ^ 2 + 27 * c ^ 4 * a + 18 * b * d ^ 3 * a ^ 3 - 4 * b * c ^ 3 * a + 144 * e * d ^ 2 * a ^ 3 - 4
		* e * b * c ^ 2 * a ^ 2 - 192 * e ^ 2 * d * a ^ 2 - 128 * e ^ 2 * c ^ 2 * a + 18 * e * b * d * c * a ^ 2 - 18 * b * d ^ 2 * c * a ^ 2 - 27 * d ^ 4 * a ^ 3))
		local t = math.cbrt((8 * e * a * c - 2 * b ^ 3 - 8 * d * a ^ 2) / 2 - math.sqrt(-2 * b ^ 3 - 27 * a ^ 2 * d ^ 2 + 18 * a * b * c - 4 * c ^ 3 + 144 * e ^ 2 * a ^ 2 - 4 * b ^ 2 * c ^ 2 + 18 * e * b * d * a ^ 2 - 4 * e * c ^ 2 * a ^ 2 + 256 * e ^ 3 * a ^ 2 + 144 * e ^ 2 * b * c * a ^ 2 - 80 * e * d * c * a ^ 2 - 6 * e * b * d ^ 2 * a ^ 2 + 27 * c ^ 4 * a + 18 * b * d ^ 3 * a ^ 3 - 4 * b * c ^ 3 * a + 144 * e * d ^ 2 * a ^ 3 - 4
		* e * b * c ^ 2 * a ^ 2 - 192 * e ^ 2 * d * a ^ 2 - 128 * e ^ 2 * c ^ 2 * a + 18 * e * b * d * c * a ^ 2 - 18 * b * d ^ 2 * c * a ^ 2 - 27 * d ^ 4 * a ^ 3))
		return (-b - s - t) / (4 * a)
	end
end

function math.cbrt(x)
	return x ^ (1 / 3)
end

function math.gravity(x, y, mass, x2, y2, mass2)
	local distance = math.distance(x, y, x2, y2)
	return (mass * mass2) / distance ^ 2
end

function math.rotateCube(x, y, z, angleX, angleY, angleZ)
	local x2 = x * math.cos(angleY) - z * math.sin(angleY)
	local y2 = y * math.cos(angleX) - z * math.sin(angleX)
	local z2 = z * math.cos(angleX) - y * math.sin(angleX)
	local x3 = x2 * math.cos(angleZ) - y2 * math.sin(angleZ)
	local y3 = y2 * math.cos(angleZ) - x2 * math.sin(angleZ)
	return x3, y3, z2
end

function math.rotatePoint(x, y, angle)
	local x2 = x * math.cos(angle) - y * math.sin(angle)
	local y2 = y * math.cos(angle) - x * math.sin(angle)
	return x2, y2
end

function math.easing(x, y, t)
	return x + (y - x) * t
end

function math.pythagorean(x, y)
	return math.sqrt(x ^ 2 + y ^ 2)
end

function math.euclidianAlgorithm(x, y)
	if y == 0 then
		return x
	else
		return math.euclidianAlgorithm(y, x % y)
	end
end

function math.extended_gcd(a, b)
	if a == 0 then
		return b, 0, 1
	else
		local g, y, x = math.extended_gcd(b % a, a)
		return g, x - math.floor(b / a) * y, y
	end
end
function math.modularInverse(a, m)
	local g, x, y = math.extended_gcd(a, m)
	if g ~= 1 then
		return nil
	else
		return x % m
	end
end
function math.modularExponentiation(a, b, m)
	local result = 1
	while b > 0 do
		if b % 2 == 1 then
			result = (result * a) % m
		end
		b = math.floor(b / 2)
		a = (a * a) % m
	end
	return result
end
function math.nonEuclidianAlgorithm(a, b)
	local x, y, u, v = 0, 1, 1, 0
	while a ~= 0 do
		local q, r = math.floor(b / a), b % a
		local m, n = x - u * q, y - v * q
		b, a, x, y, u, v = a, r, u, v, m, n
	end
	return b, x, y
end

---@param blockName string The block name (e.g. "minecraft:stone")
---@param x number The x coordinate
---@param y number The y coordinate
---@param z number The z coordinate
---@param data number The block data (e.g. 0)
function placeBlockAtXYZ(blockName,x,y,z,data)
	if data == nil then
		data = 0
	end
	if blockName ~= ("" or nil) then
		client.execute("execute setblock "..x.." "..y.." "..z.." "..blockName.." "..data)
	else
		print("Please specify a block!")
	end
end

meth = math