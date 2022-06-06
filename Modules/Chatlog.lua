name="ChatLogger"
description="Saves in Chatlogger.txt"

local lastLine

function onChat(message, username, type)
    if lastLine ~= message then
        local file = io.open("Chatlogger.txt", 'a')
        local toWrite = message
        if username and username ~= "" then
            toWrite = "<" .. username .. "> " .. toWrite
        end
        file:write(toWrite .. "\n")
        io.close(file)
        lastLine = message
    end
end

event.listen("ChatMessageAdded", onChat)