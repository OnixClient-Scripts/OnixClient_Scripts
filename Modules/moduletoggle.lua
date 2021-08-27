name = "Module hotkeys"
description = "Toggles specific modules and shows toggled message using a hotkey"

DebugMenu_Hotkey = 0x72 -- F3
Hitboxes_Hotkey = 0x73 -- F4
ChunkBorder_Hotkey = 0x76 -- F7

function keyboard(key, isDown)
    if (isDown == true) then
        if (key == DebugMenu_Hotkey) then
            client.execute("toggle Java Debug Menu")
            print("§l[§1Onix§fClient]§r Debug Menu Toggled")
        else if (key == Hitboxes_Hotkey) then
            client.execute("toggle Hitboxes")
            print("§l[§1Onix§fClient]§r Hitboxes Toggled")
        else if (key == ChunkBorder_Hotkey) then
            client.execute("toggle Chunk Border")
            print("§l[§1Onix§fClient]§r Chunk Border Toggled")
        end
        end
        end
    end
end