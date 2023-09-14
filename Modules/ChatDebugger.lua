name="Chat Debugger"
description="Shows every chat info in chat"

copy = true
client.settings.addBool("Log and copy chat", "copy")

count = 1

chatlog = {}

function onChat(message, username, type)
    if username == nil or username == "" then username = "undefined" end

    print("\n" .. message)
    print("Username: " .. username)
    print("Type: " .. type)
    if copy == true then
        chatlog[count] = message
        print("Use §e.copy " .. count .. " §rto copy this message")
        count = count + 1
    end
    return true
end
event.listen("ChatMessageAdded", onChat)

registerCommand("copy", function(arg)
    if copy == true then
        if tonumber(arg) then
            if count <= tonumber(arg) then
                print("Couldn't copy message " .. arg)
            else
                if chatlog[tonumber(arg)] ~= nil then
                    setClipboard(chatlog[tonumber(arg)])
                    print("Copied to Clipboard!")
                else
                    error("I got nil value for some reason, contact developer")
                end
            end
        else
            print(arg .. " is not number!")
        end
    else
        print("Log and copy chat is currently disabled")
    end
end)
