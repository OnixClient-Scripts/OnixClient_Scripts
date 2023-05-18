name = "Ice Boat"
description = "Places ice under you when you're in a boat. You must be holding a splash long mundane potion for it to work (the flag didnt work!!). Made by Naomi."

-- made by naomi. thank you to rosie for helping me with the code <3

function ice()
    local x,y,z = player.position()
    -- get a 5x5 x and y area
    local sx = x - 2
    local sz = z - 2
    local ex = x + 2
    local ez = z + 2

    for px=sx,ex do
        for pz=sz,ez do
            client.execute("execute /setblock " .. px .. " " .. y .. " " .. pz .. " minecraft:blue_ice")
        end
    end
end

function render(dt)
    local selectedItem = player.inventory().selected
    local item = player.inventory().at(selectedItem)
    if item then
        if item.name:find("splash") and item.data == 2 then
            ice()
        end
    end
end