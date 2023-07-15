name = "Zeqa Autoqueue"
description = "Automatically queues for you when you win/lose a game."

gamemode = nil

ranked = false

function requeue(gamemode, shouldPrint)
    if gamemode then
        if ranked == true then
            client.execute("execute /q " .. gamemode .. " ranked")
        else
            client.execute("execute /q " .. gamemode .. " unranked")
        end
        if shouldPrint then
            print("§7Requeued for §e" .. gamemode .. "§7.")
        end
    else
        print("§cYou must have played a game first to requeue.")
    end
end

event.listen("ChatMessageAdded", function(message, username, type, xuid)
    if message:match("§eZEQA§8 » §r§7Found a §f(.-)§7 match against §c.-") then
        gamemode = message:match("§eZEQA§8 » §r§7Found a §f(.-)§7 match against §c.-")
        if gamemode then
            if gamemode:find("Ranked") then
                ranked = true
            else
                ranked = false
            end
            gamemode = gamemode:gsub("Ranked ", ""):gsub("Unranked ", "")
        end
    end
    if message:find(" ") then
        requeue(gamemode)
    end
    if message:find("§eZEQA§8 » §rYou must be in hub to execute this command") then
        return true
    end
end)

event.listen("TitleChanged", function(text, titleType)
    if text:find("§f§aYou won the game!") or text:find("§f§cYou lost the game!") then
        requeue(gamemode)
    end
end)

registerCommand("req", function()
    requeue(gamemode, true)
end)