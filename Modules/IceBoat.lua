name = "Ice Boat"
description = "Places ice under you when you're in a boat. You must be holding a splash long mundane potion for it to work (the flag didnt work!!). Made by Naomi."

-- made by naomi. thank you to rosie for helping me with the code <3

radius = client.settings.addNamelessInt("Radius", 1, 20, 5)

function ice(radius)
    local x,y,z = player.position()
    local sx = x - radius
    local sz = z - radius
    local ex = x + radius
    local ez = z + radius

    for px=sx,ex do
        for pz=sz,ez do
            client.execute("execute /setblock " .. px .. " " .. y .. " " .. pz .. " minecraft:blue_ice")
        end
    end
end

function update(dt)
    local selectedItem = player.inventory().selected
    local item = player.inventory().at(selectedItem)
    if item then
        if item.name:find("splash") and item.data == 2 then
            ice(radius.value)
        end
    end
end