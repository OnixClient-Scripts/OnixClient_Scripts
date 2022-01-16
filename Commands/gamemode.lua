command = "gamemode"
help_message = "Check Gamemode"

function execute(arguments)
	local gamemode = player.gamemode()
	
	local gamemode_string = "Unknown"
	if gamemode == 0 then
		gamemode_string = "Survival"
	elseif gamemode == 1 then
		gamemode_string = "Creative"
	elseif gamemode == 2 then
		gamemode_string = "Adventure"
	elseif gamemode == 3 then
		gamemode_string = "Survival Spectator"
	elseif gamemode == 4 then
		gamemode_string = "Creative Spectator"
	elseif gamemode == 5 then
		gamemode_string = "Default"
	end
	
	print("Gamemode: " .. gamemode_string .. " (" .. gamemode .. ")")
end