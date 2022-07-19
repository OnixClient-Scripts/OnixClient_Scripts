name = "reply"
description = "allows you to reply to /msg"

local replying

event.listen("ChatMessageAdded", function(message, username)
    if string.find(message, " whispers to you: ") then
        replying = "\"" .. username .. "\""
        print("§e§l" .. string.sub(message, 7, -1))
        return true
    end
end)

function reply(args)
    if replying then
        if args and args ~= "" then
            client.execute("execute /msg " .. replying .. " " .. args)
        else
            print("Currently replying to " .. replying)
        end
    else
        print("There's no one to reply too!")
    end
end

registerCommand("r", reply)

registerCommand("reply", reply)