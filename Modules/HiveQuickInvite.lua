name = "Hive Quick Invite"
description = "Quickly invite players to your friends list or party by clicking them while holding the item when in hub."

quickInvite = {
    party = {
        command = "p invite "
    },
    friend = {
        command = "f invite "
    }
}

event.listen("MouseInput", function(button, down)
    local selectedEntity = player.selectedEntity()
    if selectedEntity and selectedEntity.type == "player" then
        if down and button == 1 then
            if selectedEntity.username ~= nil then
                local username = "Unknown Player. :("
                local playerName = string.split(selectedEntity.username, "\n")
                if string.find(playerName[1],"§.") then
                    username = string.gsub(playerName[1],"§.","")
                    if string.find(username,"%[") then username = string.gsub(username," %[.*%]","") end
                else
                    username = string.split(selectedEntity.username, "\n")[1]
                end
                if username ~= "Unknown Player. :(" then
                    if player.inventory().at(player.inventory().selected) then
                        local party = player.inventory().at(player.inventory().selected).name == "hivehub:party"
                        local friend = player.inventory().at(player.inventory().selected).name == "hivehub:friends"
                        if party then
                            client.execute("execute " .. quickInvite.party.command .. username)
                        end
                        if friend then
                            client.execute("execute " .. quickInvite.friend.command .. username)
                        end
                    end
                else
                    print("§cCould not invite player.")
                end
            end
        end
    end
end)