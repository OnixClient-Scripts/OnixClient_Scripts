name = "DeathCoordinates"
description = "Show player death coordinates"

waypoint_style = 1
waypoint_message = false



--[[
    Death Coordinate Module Script

        waypoint_style configs
        0: disable waypoint
        1 (default): make a waypoint 'Death' (overwrites the old waypoint) 
        2: make a waypoint 'Death [Current Time]
        3: make a waypoint '[Current Time]'

        example of [Current Time]: [08/21/21 12:30:45]


    idea from java edition Spigot plugin
    https://www.spigotmc.org/resources/deathcoordinates-1-8-1-17.43318/?__cf_chl_jschl_tk__=pmd_GGv3MB44d330IoCWzR0VJ6jJ0cp2VE.65LIw10oS7jg-1629286446-0-gqNtZGzNAhCjcnBszQi9

    made by Quoty0
]]

check = false

stylefile = io.open("deathcoordstyle.txt","w")
io.output(stylefile)
io.write(waypoint_style)
io.close(stylefile)

function update()

end

function render()
    local player_x,player_y,player_z = player.position()
    local attribs = player.attributes()
    local health = attribs.name("minecraft:health").value
    local current_time = os.date("[%x %X]")
    local worldName = server.worldName()

    if health > 0 then
        check = true
    end

    if health == 0 and check == true then
        print("§cYou died! Your §4death coordinates §care:")
        print("§8(§7" .. player_x .. " " .. player_y .. " " .. player_z .. "§8)")
        check = false
        if waypoint_style > 0 then
            if waypoint_style == 1 then
                datafile = io.open("dc" .. worldName .. ".txt","w")
                io.output(datafile)
                io.write("Death\n" .. player_x .. "\n" .. player_y .. "\n" .. player_z .. "\n")
                io.close(datafile)
                client.execute("waypoint remove Death")
                client.execute("waypoint add Death " .. player_x .. " " .. player_y .. " " .. player_z)
                if waypoint_message == true then
                    print("§eWaypoint §aDeath §eadded")
                end
            elseif waypoint_style == 2 then
                datafile = io.open("dc" .. worldName .. ".txt","a")
                io.output(datafile)
                io.write("Death " .. current_time .. "\n" .. player_x .. "\n" .. player_y .. "\n" .. player_z .. "\n")
                io.close(datafile)
                client.execute("waypoint add \"Death " .. current_time .."\" " .. player_x .. " " .. player_y .. " " .. player_z)
                if waypoint_message == true then
                    print("§eWaypoint §aDeath " .. current_time .. " §eadded")
                end
            elseif waypoint_style == 3 then
                datafile = io.open("dc" .. worldName .. ".txt","a")
                io.output(datafile)
                io.write(current_time .."\n" .. player_x .. "\n" .. player_y .. "\n" .. player_z .. "\n")
                io.close(datafile)
                client.execute("waypoint add \"" .. current_time .."\" " .. player_x .. " " .. player_y .. " " .. player_z)
                if waypoint_message == true then
                    print("§eWaypoint §a" .. current_time .. " §eadded")
                end
            else
                waypoint_style = 1
            end
        end
    end
end
