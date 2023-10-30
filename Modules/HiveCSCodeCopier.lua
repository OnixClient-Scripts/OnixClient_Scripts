name = "Hive CS Code Copier"
description = "Copies the custom server code from the Hive to your clipboard."

showChatMessage = client.settings.addNamelessBool("Show Chat Message", true)
includeSlashCS = client.settings.addNamelessBool("Include /cs", true)

copied = false

event.listen("TitleChanged", function(text, titleType)
    if text:find("§eJoin Code: ") then
        local code = text:match("§eJoin Code: §.(.*)")
        if includeSlashCS.value then
            code = "/cs " .. code
        end
        setClipboard(code)
        if showChatMessage.value then
            if copied == false then
                print("§a§l» §rCopied code §e" .. code .. "§f to clipboard!§r")
                copied = true
            end
        end
    end
end)

event.listen("ChatMessageAdded", function(message)
    if message:match(" joined. §.") and message:find(player.name()) then
        copied = false
    end
end)