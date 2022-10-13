name="Copy Last Message"
description="Allows you to copy the last messsage sent in chat"
copyMessageKey = client.settings.addNamelessKeybind("Copy Message Key",0x00)

globalMessage = ""
event.listen("ChatMessageAdded", function(message, username, type, xuid)
    globalMessage = message
end)

event.listen("KeyboardInput", function(key, down)
    if copyMessageKey.value == key and down and gui.mouseGrabbed() == false and globalMessage ~= "" then
        setClipboard(globalMessage)
        client.notification("Copied last chat message to clipboard!")
    end
end)