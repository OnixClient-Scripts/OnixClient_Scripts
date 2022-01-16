command = "inv"
help_message = "sends current inventory, or count an item"


local function printItem(item)
    if item ~= nil then
        print(item.count .. " " .. item.name .. " " .. item.chestplate.data .. " (" .. item.id .. ")")
    end
end


function execute(arguments)
    if (arguments == "") then
        local inventory = player.inventory()
        local armor = inventory.armor()
        printItem(armor.helmet)
        printItem(armor.chestplate)
        printItem(armor.leggings)
        printItem(armor.boots)
        printItem(inventory.offhand())
        for i=1,inventory.size do
            printItem(inventory.at(i))
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
