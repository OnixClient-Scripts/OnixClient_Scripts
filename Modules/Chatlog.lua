name="ChatLogger"
description="Saves in Chatlogger.txt"

local lastLine

function onChat(message, username, type)
    if lastLine ~= message then
        local toWrite = message
        if username and username ~= "" then
            toWrite = "<" .. username .. "> " .. toWrite
        end
        local file = io.open("Chatlogger.txt", 'a')
        if file then
            file:write(toWrite .. "\n")
        end
        io.close(file)
        lastLine = message
    end
end
event.listen("ChatMessageAdded", onChat)

