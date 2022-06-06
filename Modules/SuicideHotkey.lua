name = "Suicide Hotkey"
description = "Allows you to kill yourself!"

-- made by rosie + mcbe <3
-- keep yourselves safe guys

Suicide_Key = 0
ChangeGamemode = false

client.settings.addKeybind("Kill yourself", "Suicide_Key")
client.settings.addBool("Change gamemode?", "ChangeGamemode")

local function kill()
    if ChangeGamemode then
        local gmd = player.gamemode()
        client.execute("execute /gamemode s")
        client.execute("execute /kill @s")
        client.execute("execute /gamemode " .. gmd)
    else
        client.execute("execute /kill @s")
    end
end

function keyboard(key, isDown)
    if key == Suicide_Key and isDown == true and not gui.mouseGrabbed() then
        kill()
    end
end

function onChat(message, username, type)
    if ChangeGamemode == true and (string.find(message, "Your game mode has been updated to ") or string.find(message, "Set own game mode to ")) then
        return true
    end
end

event.listen("KeyboardInput", keyboard)
event.listen("ChatMessageAdded", onChat)