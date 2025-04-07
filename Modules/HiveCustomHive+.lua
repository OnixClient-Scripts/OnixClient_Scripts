
name = "CustomHivePlus"
description = "Allow you to do .hive+"

info = "Known Issues :\nIf you have and Hub Title the script will not work\n\nIf you're using the module nickname disable it before using the command\nYOU CANNOT USE THE SCRIPT AGAIN IF YOU USE NICKNAME (except if you restart Onix)"
client.settings.addInfo(info)

local file = io.open("hive+.clr", "r")

if file then
    currentColor = file:read("*all")
    file:close()
else
    local file = io.open("hive+.clr", "w")
    file:write("a")
    file:close()
    currentColor = "a"
end

registerCommand("hive+", function(arg)
    local function cleanString(str)
        return str:gsub("\n", ""):gsub("%s+", "")  
    end

    local nametag = player.nametag()
    nametag = cleanString(nametag)

    if string.match(nametag, "+") then
        print("Your original nametag: " .. player.nametag())

        local function replaceColorCode(str, replacement)
            return str:gsub("§" .. currentColor, replacement)
        end

        if arg:match("^[a-v0-9]+$") then
            local result = replaceColorCode(nametag, "§" .. arg)
            player.nametag(result)
            currentColor = arg  -- Update currentColor to the new color
            -- Save the new color to the file
            local file = io.open("hive+.h", "w")
            file:write(currentColor)
            file:close()

            print("Updated nametag: " .. player.nametag())
        else
            print("Invalid input! Only letters (a-v) and numbers (0-9) are allowed.")
        end
    else
        print("You need to have Hive+ to use this script.")
    end
end)