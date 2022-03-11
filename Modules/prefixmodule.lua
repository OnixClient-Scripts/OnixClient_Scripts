name = 'Prefix module'
description = 'Module needed for the prefix command to work'


event.listen("ChatMessageAdded", function(message, username, type, xuid)
    f = io.open('prefix.txt', 'r')
    local prefix = f:read('*a')
    f:close()--
    s = string.sub(message, 1, #prefix)
    if s == prefix then
        client.execute(string.sub(message, #prefix+1))
        return true
    end
end)