command = "inv"
help_message = "sends current inventory"

function execute(arguments)
    if (arguments == "") then
        local inventory = player.inventory()
        local armor = inventory.armor()
        if (armor.helmet ~= nil) then
            print("1 " .. armor.helmet.name .. " " .. armor.helmet.data .. " " .. armor.helmet.id)
        end
        if (armor.chestplate ~= nil) then
            print("1 " .. armor.chestplate.name .. " " .. armor.chestplate.data .. " " .. armor.chestplate.id)
        end
        if (armor.leggings ~= nil) then
            print("1 " .. armor.leggings.name .. " " .. armor.leggings.data .. " " .. armor.leggings.id)
        end
        if (armor.boots ~= nil) then
            print("1 " .. armor.boots.name .. " " .. armor.boots.data .. " " .. armor.boots.id)
        end
        if (inventory.offhand() ~= nil) then
            print(inventory.offhand().count .. " " .. inventory.offhand().name .. " " .. inventory.offhand().maxData - inventory.offhand().data .. " " .. inventory.offhand().id)
        end
        for i=1,inventory.size do
            local slot = inventory.at(i)
            if (slot ~= nil) then
                print(slot.count .. " " .. slot.name .. " " .. slot.maxData - slot.data .. " " .. slot.id)
            end
        end
    else
        local total = 0
        local inventory = player.inventory()
        for i=1,inventory.size do
            local slot = inventory.at(i)
            if (slot ~= nil) then
                if (slot.name == arguments) then
                    total = total + slot.count
                end
            end
        end
        if (inventory.offhand() ~= nil) then
            if (inventory.offhand().name == arguments) then
                total = total + inventory.offhand().count
            end
        end
        print(arguments .. ": " .. total)
    end
end
