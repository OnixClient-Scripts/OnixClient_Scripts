name = "DeathCoordinates"
description = "Show player death coordinates"

--[[
    Death Coordinate Module Script

    idea from java edition Spigot plugin
    https://www.spigotmc.org/resources/deathcoordinates-1-8-1-17.43318/?__cf_chl_jschl_tk__=pmd_GGv3MB44d330IoCWzR0VJ6jJ0cp2VE.65LIw10oS7jg-1629286446-0-gqNtZGzNAhCjcnBszQi9

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
