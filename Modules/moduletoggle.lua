name = "Module hotkeys"
description = "Toggles specific modules and shows toggled message using a hotkey"

DebugMenu_Hotkey = 0x72 -- F3
Hitboxes_Hotkey = 0x73 -- F4
ChunkBorder_Hotkey = 0x77 -- F8


client.settings.addKeybind("Debug Menu", "DebugMenu_Hotkey")
client.settings.addKeybind("Hitboxes Hotkey", "Hitboxes_Hotkey")
client.settings.addKeybind("Chunk Borders", "ChunkBorder_Hotkey")

function keyboard(key, isDown)
    if (isDown == false) then return false end

    if (key == DebugMenu_Hotkey) then
        client.execute("toggle Java Debug Menu")
        print("§l[§1Onix§fClient]§r Debug Menu Toggled")
    elseif (key == Hitboxes_Hotkey) then
        client.execute("toggle Hitboxes")
        print("§l[§1Onix§fClient]§r Hitboxes Toggled")
    elseif (key == ChunkBorder_Hotkey) then
        client.execute("toggle Chunk Border")
        print("§l[§1Onix§fClient]§r Chunk Border Toggled")
    end
end