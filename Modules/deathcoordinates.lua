name = "DeathCoordinates"
description = "Show player death coordinates"

--[[
    Death Coordinate Module Script
    
    made by Quoty0
]]

check = false

function update()
    
end

function render()
    local player_x,player_y,player_z = player.position()
	local attribs = player.attributes()
	local health = attribs.id(7).value
	
	if health > 0 then
	    check = true
	end
	
	if health == 0 and check == true then
	    print("§cYou died! Your §4death coordinates §care:")
	    print("§8(§7" .. player_x .. " " .. player_y .. " " .. player_z .. "§8)")
		check = false
    end
end