name="Custom Auto GG"
description="Custom auto gg - edit in the lua file"
CustomAutoGG = false
client.settings.addBool("Custom Auto GG", "CustomAutoGG")

function onChat(message, username, type)
    message = string.lower(message)
    
    if CustomAutoGG == true and string.match(message, "§c§l» §r§c§lgame over!") then
        client.execute("say skill issue") -- edit this, keep the "say"
    end
end

event.listen("ChatMessageAdded", onChat)