name="Middle Click Tools"
description="Allows you to use the middle mouse button to perform various actions."

party = client.settings.addNamelessBool("Party Invite",true)
friend = client.settings.addNamelessBool("Friend Invite",false)
doSkinsteal = client.settings.addNamelessBool("Steal Skin",false)

event.listen("MouseInput", function(button, down)
	if player.facingEntity()then
		if button == 3 and down then
            local p = player.selectedEntity()
            if p.username ~= nil then
                local playerName = string.split(p.username, "\n")
                if string.find(playerName[1],"§.") then
                    username = string.gsub(playerName[1],"§.","")
                    if string.find(username,"%[") then username = string.gsub(username," %[.*%]","") end
					if string.find(username, " ") then
						username = "\"" .. username .. "\""
					end
					if party.value == true and doSkinsteal.value == false and friend.value == false then
						inviteToParty(username)
					end
					if friend.value == true and doSkinsteal.value == false and party.value == false then
						inviteToFriends(username)
					end
                else
                    username = p.username
                end
            else
                playerName = p.type
            end
		end
	end
	if gui.mouseGrabbed() == true then return end
    if button == 3 and down and doSkinsteal.value == true and party.value == false and friend.value == false then
        skinsteal()
    end
end)

function inviteToParty(user)
	client.execute("execute /p invite " .. user)
end

function inviteToFriends(user)
	client.execute("execute /f invite " .. user)
end

function skinsteal()
    if player.facingEntity() then
        if (player.selectedEntity().type ~= "player" or player.selectedEntity().nametag == "") then
            print("§cCould not steal skin.\nThis could be because it's not a player, or the player is crouching.")
        else
            local p = player.selectedEntity()
            if p.username ~= nil then
                local playerName = string.split(p.username, "\n")
                if string.find(playerName[1],"§.") then
                    username = string.gsub(playerName[1],"§.","")
                    if string.find(username,"%[") then username = string.gsub(username," %[.*%]","") end
                else
                    username = p.username
                end
            else
                playerName = p.type
            end
            if p.skin == nil then return end
            local skin = p.skin()
            if skin ~= nil then
                fs.mkdir("Skinstealer/" .. username)
                if username ~= usernameTest then print("§aStole " .. username .. "'s skin!") usernameTest = username end
                skin.save("Skinstealer/" .. username .. "/" .. username .. "_skin.png")
                if skin.hasCape() then
                    skin.saveCape("Skinstealer/" .. username .. "/" .. username .. "_cape.png")
                end
                local file = io.open("Skinstealer/" .. username .. "/" .. username .. "_geometry.json","w")
                file:write(skin.geometry())
                file:close()
            end
        end
    end
end
