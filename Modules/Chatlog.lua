name="ChatLogger"
description="Saves in Chatlogger.txt"

local initlog = io.open("Chatlog.txt", 'w')
io.close(initlog)

function onChat(message, username, type)

local file = io.open("Chatlogger.txt", 'a')
file:write(message .. "\n")
io.close(file)

end

event.listen("ChatMessageAdded", onChat)

