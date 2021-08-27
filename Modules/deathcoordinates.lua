name = "DeathCoordinates"
description = "Show player death coordinates"

waypoint_style = 1

check = false

function update()
    
end

function render()
    local player_x,player_y,player_z = player.position()
	local attribs = player.attributes()
	local health = attribs.id(7).value
	local current_time = os.date("[%x %X]")
	
	if health > 0 then
	    check = true
	end
	
	if health == 0 and check == true then
	    print("§cYou died! Your §4death coordinates §care:")
	    print("§8(§7" .. player_x .. " " .. player_y .. " " .. player_z .. "§8)")
		check = false
        if waypoint_style > 0 then
	    if waypoint_style == 1 then
	        client.execute("waypoint remove Death")
	        client.execute("waypoint add Death " .. player_x .. " " .. player_y .. " " .. player_z)
            elseif waypoint_style == 2 then
                client.execute("waypoint add \"Death " .. current_time .. "\" " .. player_x .. " " .. player_y .. " " .. player_z)
            elseif waypoint_style == 3 then
                client.execute("waypoint add \"" .. current_time .."\" " .. player_x .. " " .. player_y .. " " .. player_z)
            else
                waypoint_style = 1
            end
        end
    end
end
