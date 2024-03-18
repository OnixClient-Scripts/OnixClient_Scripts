name="Custom Message"
description="Send any message - works like auto GG. edit in the lua file"

CustomAutoGG = false
PinkGlitch = false
Ratio = false
client.settings.addBool("Custom Auto GG", "CustomAutoGG")
client.settings.addBool("We love pink glitch", "PinkGlitch")
client.settings.addBool("Ratio", "Ratio")
function onChat(message, username, type)
    message = string.lower(message)
    
    if CustomAutoGG == true and string.match(message, "§c§l» §r§c§lgame over!") then
        client.execute("say lol gg")
    end

    if string.match(message, "bruh") then
        client.execute("say moment")
    end

    if Ratio == true and string.match(message, "ratio") then
        client.execute("say + ratio")
    end

    if PinkGlitch == true and string.match(message, "we love") then
        client.execute("say pink glitch :')")
    end

    local file = io.open("Chatlog.txt", 'a')
    file:write(message .. "\n")
    io.close(file)
end

event.listen("ChatMessageAdded", onChat)