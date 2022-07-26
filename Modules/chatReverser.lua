name = "Chat Reverser"
description = "Reverses chat (works properly in singleplayer and hive)"

ip = server.ip()

function update()
    ip = server.ip()
end

function onChat(message,username,type)
    if string.find(ip, "hive") then
        if string.find(message, " §7§l» ") then
            username = tostring(string.sub(message, 1, string.find(message, "» ") - 1))
            local messageSub = string.gsub(message, "§r", "")
            messageSub = string.reverse(messageSub)
            print(username .. "» §r" .. messageSub)
            return true
        else
            return
        end
    else
        print("<" .. username .. "> " .. string.reverse(message))
        return true
    end
end
event.listen("ChatMessageAdded", onChat)



