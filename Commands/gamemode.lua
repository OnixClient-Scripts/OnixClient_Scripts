command = "gamemode"
help_message = "Check Gamemode"

function execute(arguments)
	local gamemode = player.gamemode()
	
	if gamemode == 0 then
		gamemode_string = "Survival"

	elseif gamemode == 1 then
		gamemode_string = "Creative"
	elseif gamemode == 2 then
		gamemode_string = "Adventure"
	elseif gamemode == 0 then
		gamemode_string = "Survival"
	else
		gamemode_string = "Unknown"
	end
	
	print("Gamemode: " .. gamemode_string .. " (" .. gamemode .. ")")
end