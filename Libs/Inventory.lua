inv = {}

inv.z_InventorySlots = {}

function inv.performMouseClick(button, down, x, y) end
function inv.performKeyClick(button, down) end

function inv.z_click(x, y, button)
    x = math.floor(x)
    y = math.floor(y)
    if button == nil then button = 1 end
    for i = 0,x do
        inv.performMouseClick(0, false, i, 0)
    end
    for i = 0,y do
        inv.performMouseClick(0, false, x, i)
    end
    
    inv.performMouseClick(button, true, x, y)
    inv.performMouseClick(button, false, x, y)
end

function inv.z_clickInvSlot(x,y, button)
    inv.z_click(gui.width() / 2 + x, gui.height() / 2 + y, button)
end


function inv.z_AddInventorySlot(screen, container, slot, x,y)
    local screentable = inv.z_InventorySlots[screen]
    if screentable == nil then
        inv.z_InventorySlots[screen] = {}
        screentable = inv.z_InventorySlots[screen]
    end

    local containertable = screentable[container]
    if containertable == nil then
        screentable[container] = {}
        containertable = screentable[container]
    end
    containertable[slot] = {x=x,y=y}
end

function inv.z_InitInventorySlots()
    inv.z_InventorySlots = {}
    
    local function belowInventory(screen)

        inv.z_AddInventorySlot(screen, "inventory", 01, -73.0 , 69.5)
        inv.z_AddInventorySlot(screen, "inventory", 02, -56.5 , 69.5)
        inv.z_AddInventorySlot(screen, "inventory", 03, -35.5 , 69.5)
        inv.z_AddInventorySlot(screen, "inventory", 04, -17.5 , 69.5)
        inv.z_AddInventorySlot(screen, "inventory", 05, 0.0   , 69.5)
        inv.z_AddInventorySlot(screen, "inventory", 06, 17.5  , 69.5)
        inv.z_AddInventorySlot(screen, "inventory", 07, 36.0  , 69.5)
        inv.z_AddInventorySlot(screen, "inventory", 08, 54.0  , 69.5)
        inv.z_AddInventorySlot(screen, "inventory", 09, 72.75 , 69.5)
        
        inv.z_AddInventorySlot(screen, "inventory", 10, -73.0 , 12.0)
        inv.z_AddInventorySlot(screen, "inventory", 11, -56.5 , 12.0)
        inv.z_AddInventorySlot(screen, "inventory", 12, -35.5 , 12.0)
        inv.z_AddInventorySlot(screen, "inventory", 13, -17.5 , 12.0)
        inv.z_AddInventorySlot(screen, "inventory", 14, 0.0   , 12.0)
        inv.z_AddInventorySlot(screen, "inventory", 15, 17.5  , 12.0)
        inv.z_AddInventorySlot(screen, "inventory", 16, 36.0  , 12.0)
        inv.z_AddInventorySlot(screen, "inventory", 17, 54.0  , 12.0)
        inv.z_AddInventorySlot(screen, "inventory", 18, 72.75 , 12.0)
    
        inv.z_AddInventorySlot(screen, "inventory", 19, -73.0 , 31.25)
        inv.z_AddInventorySlot(screen, "inventory", 20, -56.5 , 31.25)
        inv.z_AddInventorySlot(screen, "inventory", 21, -35.5 , 31.25)
        inv.z_AddInventorySlot(screen, "inventory", 22, -17.5 , 31.25)
        inv.z_AddInventorySlot(screen, "inventory", 23, 0.0   , 31.25)
        inv.z_AddInventorySlot(screen, "inventory", 24, 17.5  , 31.25)
        inv.z_AddInventorySlot(screen, "inventory", 25, 36.0  , 31.25)
        inv.z_AddInventorySlot(screen, "inventory", 26, 54.0  , 31.25)
        inv.z_AddInventorySlot(screen, "inventory", 27, 72.75 , 31.25)
    
        inv.z_AddInventorySlot(screen, "inventory", 28, -73.0 , 48.5)
        inv.z_AddInventorySlot(screen, "inventory", 29, -56.5 , 48.5)
        inv.z_AddInventorySlot(screen, "inventory", 30, -35.5 , 48.5)
        inv.z_AddInventorySlot(screen, "inventory", 31, -17.5 , 48.5)
        inv.z_AddInventorySlot(screen, "inventory", 32, 0.0   , 48.5)
        inv.z_AddInventorySlot(screen, "inventory", 33, 17.5  , 48.5)
        inv.z_AddInventorySlot(screen, "inventory", 34, 36.0  , 48.5)
        inv.z_AddInventorySlot(screen, "inventory", 35, 54.0  , 48.5)
        inv.z_AddInventorySlot(screen, "inventory", 36, 72.75 , 48.5)
    
        
        inv.z_AddInventorySlot(screen, "hotbar", 01, -73.0 , 69.5)
        inv.z_AddInventorySlot(screen, "hotbar", 02, -56.5 , 69.5)
        inv.z_AddInventorySlot(screen, "hotbar", 03, -35.5 , 69.5)
        inv.z_AddInventorySlot(screen, "hotbar", 04, -17.5 , 69.5)
        inv.z_AddInventorySlot(screen, "hotbar", 05, 0.0   , 69.5)
        inv.z_AddInventorySlot(screen, "hotbar", 06, 17.5  , 69.5)
        inv.z_AddInventorySlot(screen, "hotbar", 07, 36.0  , 69.5)
        inv.z_AddInventorySlot(screen, "hotbar", 08, 54.0  , 69.5)
        inv.z_AddInventorySlot(screen, "hotbar", 09, 72.75 , 69.5)
    end

    belowInventory("inventory_screen")
    inv.z_AddInventorySlot("inventory_screen", "offhand", 1, -0.75, -13.25)

    inv.z_AddInventorySlot("inventory_screen", "armor", 1, -73.25, -67.25)
    inv.z_AddInventorySlot("inventory_screen", "armor", 2, -72.5, -48.75)
    inv.z_AddInventorySlot("inventory_screen", "armor", 3, -72.0, -31.75)
    inv.z_AddInventorySlot("inventory_screen", "armor", 4, -72.5, -15.0)
    
    inv.z_AddInventorySlot("inventory_screen", "helmet", 1, -73.25, -67.25)
    inv.z_AddInventorySlot("inventory_screen", "chestplate", 1, -72.5, -48.75)
    inv.z_AddInventorySlot("inventory_screen", "leggings", 1, -72.0, -31.75)
    inv.z_AddInventorySlot("inventory_screen", "boots", 1, -72.5, -15.0)

    inv.z_AddInventorySlot("inventory_screen", "craft", 1, 16.0, -57.75)
    inv.z_AddInventorySlot("inventory_screen", "craft", 2, 36.0, -56.25)
    inv.z_AddInventorySlot("inventory_screen", "craft", 3, 15.75, -38.75)
    inv.z_AddInventorySlot("inventory_screen", "craft", 4, 35.5, -39.25)

    inv.z_AddInventorySlot("inventory_screen", "craft_1_1", 1, 16.0, -57.75)
    inv.z_AddInventorySlot("inventory_screen", "craft_2_1", 1, 36.0, -56.25)
    inv.z_AddInventorySlot("inventory_screen", "craft_1_2", 1, 15.75, -38.75)
    inv.z_AddInventorySlot("inventory_screen", "craft_2_2", 1, 35.5, -39.25)

    inv.z_AddInventorySlot("inventory_screen", "craft_result", 0, 72.0, -47.5)
    
    local small_chest_containers = {"small_chest_screen", "shulker_box_screen", "ender_chest_screen", "barrel_screen"}
    for _, container in pairs(small_chest_containers) do
        belowInventory(container)
        
        inv.z_AddInventorySlot(container, "container", 01, -73.0 , -53.75)
        inv.z_AddInventorySlot(container, "container", 02, -56.5 , -53.75)
        inv.z_AddInventorySlot(container, "container", 03, -35.5 , -53.75)
        inv.z_AddInventorySlot(container, "container", 04, -17.5 , -53.75)
        inv.z_AddInventorySlot(container, "container", 05, 0.0   , -53.75)
        inv.z_AddInventorySlot(container, "container", 06, 17.5  , -53.75)
        inv.z_AddInventorySlot(container, "container", 07, 36.0  , -53.75)
        inv.z_AddInventorySlot(container, "container", 08, 54.0  , -53.75)
        inv.z_AddInventorySlot(container, "container", 09, 72.75 , -53.75)
        
        inv.z_AddInventorySlot(container, "container", 10, -73.0 , -34.75)
        inv.z_AddInventorySlot(container, "container", 11, -56.5 , -34.75)
        inv.z_AddInventorySlot(container, "container", 12, -35.5 , -34.75)
        inv.z_AddInventorySlot(container, "container", 13, -17.5 , -34.75)
        inv.z_AddInventorySlot(container, "container", 14, 0.0   , -34.75)
        inv.z_AddInventorySlot(container, "container", 15, 17.5  , -34.75)
        inv.z_AddInventorySlot(container, "container", 16, 36.0  , -34.75)
        inv.z_AddInventorySlot(container, "container", 17, 54.0  , -34.75)
        inv.z_AddInventorySlot(container, "container", 18, 72.75 , -34.75)
        
        inv.z_AddInventorySlot(container, "container", 19, -73.0 , -17.0)
        inv.z_AddInventorySlot(container, "container", 20, -56.5 , -17.0)
        inv.z_AddInventorySlot(container, "container", 21, -35.5 , -17.0)
        inv.z_AddInventorySlot(container, "container", 22, -17.5 , -17.0)
        inv.z_AddInventorySlot(container, "container", 23, 0.0   , -17.0)
        inv.z_AddInventorySlot(container, "container", 24, 17.5  , -17.0)
        inv.z_AddInventorySlot(container, "container", 25, 36.0  , -17.0)
        inv.z_AddInventorySlot(container, "container", 26, 54.0  , -17.0)
        inv.z_AddInventorySlot(container, "container", 27, 72.75 , -17.0)
    end
    

    belowInventory("large_chest_screen")
    for k, container in pairs(inv.z_InventorySlots["large_chest_screen"]) do
        for _, slot in pairs(container) do
            slot.y = slot.y + 28
        end
    end

    inv.z_AddInventorySlot("large_chest_screen", "container", 01, -73.0 , -79.25)
    inv.z_AddInventorySlot("large_chest_screen", "container", 02, -56.5 , -79.25)
    inv.z_AddInventorySlot("large_chest_screen", "container", 03, -35.5 , -79.25)
    inv.z_AddInventorySlot("large_chest_screen", "container", 04, -17.5 , -79.25)
    inv.z_AddInventorySlot("large_chest_screen", "container", 05, 0.0   , -79.25)
    inv.z_AddInventorySlot("large_chest_screen", "container", 06, 17.5  , -79.25)
    inv.z_AddInventorySlot("large_chest_screen", "container", 07, 36.0  , -79.25)
    inv.z_AddInventorySlot("large_chest_screen", "container", 08, 54.0  , -79.25)
    inv.z_AddInventorySlot("large_chest_screen", "container", 09, 72.75 , -79.25)
    
    inv.z_AddInventorySlot("large_chest_screen", "container", 10, -73.0 , -62.5)
    inv.z_AddInventorySlot("large_chest_screen", "container", 11, -56.5 , -62.5)
    inv.z_AddInventorySlot("large_chest_screen", "container", 12, -35.5 , -62.5)
    inv.z_AddInventorySlot("large_chest_screen", "container", 13, -17.5 , -62.5)
    inv.z_AddInventorySlot("large_chest_screen", "container", 14, 0.0   , -62.5)
    inv.z_AddInventorySlot("large_chest_screen", "container", 15, 17.5  , -62.5)
    inv.z_AddInventorySlot("large_chest_screen", "container", 16, 36.0  , -62.5)
    inv.z_AddInventorySlot("large_chest_screen", "container", 17, 54.0  , -62.5)
    inv.z_AddInventorySlot("large_chest_screen", "container", 18, 72.75 , -62.5)
        
    inv.z_AddInventorySlot("large_chest_screen", "container", 19, -73.0 , -62.5)
    inv.z_AddInventorySlot("large_chest_screen", "container", 20, -56.5 , -62.5)
    inv.z_AddInventorySlot("large_chest_screen", "container", 21, -35.5 , -62.5)
    inv.z_AddInventorySlot("large_chest_screen", "container", 22, -17.5 , -62.5)
    inv.z_AddInventorySlot("large_chest_screen", "container", 23, 0.0   , -62.5)
    inv.z_AddInventorySlot("large_chest_screen", "container", 24, 17.5  , -62.5)
    inv.z_AddInventorySlot("large_chest_screen", "container", 25, 36.0  , -62.5)
    inv.z_AddInventorySlot("large_chest_screen", "container", 26, 54.0  , -62.5)
    inv.z_AddInventorySlot("large_chest_screen", "container", 27, 72.75 , -62.5)
    
    inv.z_AddInventorySlot("large_chest_screen", "container", 28, -73.0 , -25.5)
    inv.z_AddInventorySlot("large_chest_screen", "container", 29, -56.5 , -25.5)
    inv.z_AddInventorySlot("large_chest_screen", "container", 30, -35.5 , -25.5)
    inv.z_AddInventorySlot("large_chest_screen", "container", 31, -17.5 , -25.5)
    inv.z_AddInventorySlot("large_chest_screen", "container", 32, 0.0   , -25.5)
    inv.z_AddInventorySlot("large_chest_screen", "container", 33, 17.5  , -25.5)
    inv.z_AddInventorySlot("large_chest_screen", "container", 34, 36.0  , -25.5)
    inv.z_AddInventorySlot("large_chest_screen", "container", 35, 54.0  , -25.5)
    inv.z_AddInventorySlot("large_chest_screen", "container", 36, 72.75 , -25.5)
    
    inv.z_AddInventorySlot("large_chest_screen", "container", 37, -73.0 , -6.75)
    inv.z_AddInventorySlot("large_chest_screen", "container", 38, -56.5 , -6.75)
    inv.z_AddInventorySlot("large_chest_screen", "container", 39, -35.5 , -6.75)
    inv.z_AddInventorySlot("large_chest_screen", "container", 40, -17.5 , -6.75)
    inv.z_AddInventorySlot("large_chest_screen", "container", 41, 0.0   , -6.75)
    inv.z_AddInventorySlot("large_chest_screen", "container", 42, 17.5  , -6.75)
    inv.z_AddInventorySlot("large_chest_screen", "container", 43, 36.0  , -6.75)
    inv.z_AddInventorySlot("large_chest_screen", "container", 44, 54.0  , -6.75)
    inv.z_AddInventorySlot("large_chest_screen", "container", 45, 72.75 , -6.75)
    
    inv.z_AddInventorySlot("large_chest_screen", "container", 46, -73.0 , 10.0)
    inv.z_AddInventorySlot("large_chest_screen", "container", 47, -56.5 , 10.0)
    inv.z_AddInventorySlot("large_chest_screen", "container", 48, -35.5 , 10.0)
    inv.z_AddInventorySlot("large_chest_screen", "container", 49, -17.5 , 10.0)
    inv.z_AddInventorySlot("large_chest_screen", "container", 50, 0.0   , 10.0)
    inv.z_AddInventorySlot("large_chest_screen", "container", 51, 17.5  , 10.0)
    inv.z_AddInventorySlot("large_chest_screen", "container", 52, 36.0  , 10.0)
    inv.z_AddInventorySlot("large_chest_screen", "container", 53, 54.0  , 10.0)
    inv.z_AddInventorySlot("large_chest_screen", "container", 54, 72.75 , 10.0)



    belowInventory("crafting_screen")
    inv.z_AddInventorySlot("crafting_screen", "craft", 1,  24.7, -59.4)
    inv.z_AddInventorySlot("crafting_screen", "craft", 2, 42.0, -58.25)
    inv.z_AddInventorySlot("crafting_screen", "craft", 3, 60.25, -59.0)
    inv.z_AddInventorySlot("crafting_screen", "craft", 4, 23.5, -40.5)
    inv.z_AddInventorySlot("crafting_screen", "craft", 5, 42.25, -40.5)
    inv.z_AddInventorySlot("crafting_screen", "craft", 6, 60.0, -39.25)
    inv.z_AddInventorySlot("crafting_screen", "craft", 7, 23.25, -23.0)
    inv.z_AddInventorySlot("crafting_screen", "craft", 8, 43.25, -23.0)
    inv.z_AddInventorySlot("crafting_screen", "craft", 9, 59.0, -23.25)
    
    inv.z_AddInventorySlot("crafting_screen", "craft_1_1", 1,  24.7, -59.4)
    inv.z_AddInventorySlot("crafting_screen", "craft_2_1", 1, 42.0, -58.25)
    inv.z_AddInventorySlot("crafting_screen", "craft_3_1", 1, 60.25, -59.0)
    inv.z_AddInventorySlot("crafting_screen", "craft_1_2", 1, 23.5, -40.5)
    inv.z_AddInventorySlot("crafting_screen", "craft_2_2", 1, 42.25, -40.5)
    inv.z_AddInventorySlot("crafting_screen", "craft_3_2", 1, 60.0, -39.25)
    inv.z_AddInventorySlot("crafting_screen", "craft_1_3", 1, 23.25, -23.0)
    inv.z_AddInventorySlot("crafting_screen", "craft_2_3", 1, 43.25, -23.0)
    inv.z_AddInventorySlot("crafting_screen", "craft_3_3", 1, 59.0, -23.25)
    
    inv.z_AddInventorySlot("crafting_screen", "craft_result", 0, 121.75, -36.25)


    local furnace_containers = {"smoker_screen", "blast_furnace_screen", "furnace_screen"}
    for _, container in pairs(furnace_containers) do
        belowInventory(container)

        inv.z_AddInventorySlot(container, "container", 1, -29.5, -61.5)
        inv.z_AddInventorySlot(container, "container", 2, -30.5, -21.0)
        inv.z_AddInventorySlot(container, "container", 3, 31.75, -39.75)
        inv.z_AddInventorySlot(container, "furnace_item", 1, -29.5, -61.5)
        inv.z_AddInventorySlot(container, "furnace_fuel", 1, -30.5, -21.0)
        inv.z_AddInventorySlot(container, "furnace_result", 1, 31.75, -39.75)
    end


    belowInventory("anvil_screen")
    inv.z_AddInventorySlot("anvil_screen", "container", 1, -55.75, -27.0)
    inv.z_AddInventorySlot("anvil_screen", "container", 2, -2.5, -27.75)
    inv.z_AddInventorySlot("anvil_screen", "container", 3, 53.0, -27.75)

    inv.z_AddInventorySlot("anvil_screen", "anvil_item", 1, -55.75, -27.0)
    inv.z_AddInventorySlot("anvil_screen", "anvil_item", 2, -2.5, -27.75)
    inv.z_AddInventorySlot("anvil_screen", "anvil_result", 1, 53.0, -27.75)
    
    belowInventory("smithing_table_screen")
    inv.z_AddInventorySlot("smithing_table_screen", "container", 1, -55.75, -27.0)
    inv.z_AddInventorySlot("smithing_table_screen", "container", 2, -2.5, -27.75)
    inv.z_AddInventorySlot("smithing_table_screen", "container", 3, 53.0, -27.75)

    inv.z_AddInventorySlot("smithing_table_screen", "smithing_item", 1, -55.75, -27.0)
    inv.z_AddInventorySlot("smithing_table_screen", "smithing_item", 2, -2.5, -27.75)
    inv.z_AddInventorySlot("smithing_table_screen", "smithing_result", 1, 53.0, -27.75)


    
    belowInventory("enchanting_screen")
    inv.z_AddInventorySlot("enchanting_screen", "container", 1, -67.25, -27.5)
    inv.z_AddInventorySlot("enchanting_screen", "container", 2, -46.5, -27.25)
    inv.z_AddInventorySlot("enchanting_screen", "enchant_result", 1, -67.25, -27.5)
    inv.z_AddInventorySlot("enchanting_screen", "enchant_lapis", 1, -46.5, -27.25)
    inv.z_AddInventorySlot("enchanting_screen", "enchant", 1, 23.0, -58.5)
    inv.z_AddInventorySlot("enchanting_screen", "enchant", 2, 19.75, -39.5)
    inv.z_AddInventorySlot("enchanting_screen", "enchant", 3, 23.5, -17.25)



    belowInventory("brewing_stand_screen")
    inv.z_AddInventorySlot("brewing_stand_screen", "container", 1, -72.0, -58.5)
    inv.z_AddInventorySlot("brewing_stand_screen", "container", 2, 0.0, -58.75)
    inv.z_AddInventorySlot("brewing_stand_screen", "container", 3, -23.25, -23.5)
    inv.z_AddInventorySlot("brewing_stand_screen", "container", 4, 0.0, -17.5)
    inv.z_AddInventorySlot("brewing_stand_screen", "container", 5, 22.75, -25.0)
    
    inv.z_AddInventorySlot("brewing_stand_screen", "brewing_fuel", 1, -72.0, -58.5)
    inv.z_AddInventorySlot("brewing_stand_screen", "brewing_ingredient", 1, 0.0, -58.75)
    inv.z_AddInventorySlot("brewing_stand_screen", "brewing_result", 1, -23.25, -23.5)
    inv.z_AddInventorySlot("brewing_stand_screen", "brewing_result", 2, 0.0, -17.5)
    inv.z_AddInventorySlot("brewing_stand_screen", "brewing_result", 3, 22.75, -25.0)



    belowInventory("cartography_screen")
    inv.z_AddInventorySlot("cartography_screen", "container", 1, -73.5, -43.0)
    inv.z_AddInventorySlot("cartography_screen", "container", 2, -73.0, -4.25)
    inv.z_AddInventorySlot("cartography_screen", "container", 3, 67.25, -23.5)
    inv.z_AddInventorySlot("cartography_screen", "cartography_item", 1, -73.5, -43.0)
    inv.z_AddInventorySlot("cartography_screen", "cartography_item", 2, -73.0, -4.25)
    inv.z_AddInventorySlot("cartography_screen", "cartography_result", 1, 67.25, -23.5)



    belowInventory("hopper_scren")
    inv.z_AddInventorySlot("hopper_scren", "container", 1, -36.0, -39.25)
    inv.z_AddInventorySlot("hopper_scren", "container", 2, -18.75, -39.0)
    inv.z_AddInventorySlot("hopper_scren", "container", 3 -0.75, -40.75)
    inv.z_AddInventorySlot("hopper_scren", "container", 4, 17.0, -38.75)
    inv.z_AddInventorySlot("hopper_scren", "container", 5, 35.25, -40.0)



    local dispensing_containers = {"dispenser_screen", "dropper_screen"}
    for _, container in pairs(dispensing_containers) do
        belowInventory(container)

        inv.z_AddInventorySlot(container, "container", 1, -18.5, -57.75)
        inv.z_AddInventorySlot(container, "container", 2, -0.75, -58.0)
        inv.z_AddInventorySlot(container, "container", 3, 17.25, -58.25)
        inv.z_AddInventorySlot(container, "container", 4, -19.5, -40.75)
        inv.z_AddInventorySlot(container, "container", 5, 0.0, -40.25)
        inv.z_AddInventorySlot(container, "container", 6, 17.5, -40.25)
        inv.z_AddInventorySlot(container, "container", 7, -18.0, -23.25)
        inv.z_AddInventorySlot(container, "container", 8, -0.75, -22.5)
        inv.z_AddInventorySlot(container, "container", 9, 18.0, -22.75)
    end




    belowInventory("grindstone_screen")
    inv.z_AddInventorySlot("grindstone_screen", "container", 1, -37.5, -46.25)
    inv.z_AddInventorySlot("grindstone_screen", "container", 2, -37.5, -25.25)
    inv.z_AddInventorySlot("grindstone_screen", "container", 3, 35.25, -35.0)
    inv.z_AddInventorySlot("grindstone_screen", "grindstone_item", 1, -37.5, -46.25)
    inv.z_AddInventorySlot("grindstone_screen", "grindstone_item", 2, -37.5, -25.25)
    inv.z_AddInventorySlot("grindstone_screen", "grindstone_result", 1, 35.25, -35.0)
end
inv.z_InitInventorySlots()

inv.z_LastSetScreenMode = ""
function inv.z_setInventoryMode()
    if inv.z_LastSetScreenMode ~= gui.screen() then
        inv.z_LastSetScreenMode = gui.screen()
        if gui.screen() == "inventory_screen" or gui.screen() == "crafting_screen" then
            inv.z_click(gui.width() / 2 +110.75, gui.height() / 2 + -93.75)
        end
    end
end









---You must call in update or smth like that
function inv.tick()
    inv.z_setInventoryMode()
end


---Opens the inventory, your keybind must be E tho
---@return boolean isOpen
function inv.openInventory()
    local KEY_ESCAPE = 	0x1B
    local KEY_E = 0x45

    if gui.screen() ~= "inventory_screen" then
        if gui.screen() ~= "hud_screen" then
            inv.performKeyClick(KEY_ESCAPE, true)
            inv.performKeyClick(KEY_ESCAPE, false)
        else
            inv.performKeyClick(KEY_E, true)
            inv.performKeyClick(KEY_E, false)
        end
        return false
    end
    inv.z_setInventoryMode()
    return true
end


---Clicks an inventory slot
---@param container string The container to access
---@param slot integer The slot in the container to access
---@param button integer The mouse button to click (if not specified is left click or 1)
---@return boolean success not success means that no slot/container/screen corespond
function inv.clickSlot(container, slot, button)
    local screenContainer = inv.z_InventorySlots[gui.screen()]
    if screenContainer == nil then return false end
    local containerSlots = screenContainer[container]
    if containerSlots == nil then return false end
    local slot = containerSlots[slot]
    if slot == nil then return false end
    inv.z_clickInvSlot(slot.x, slot.y, button)
end


---Gives you the name of the containers for the current screen
---@return string[] containers List of containers
function inv.getContainers()
    local containers = inv.z_InventorySlots[gui.screen()]
    if containers == nil then return {} end
    local retval = {}
    for container, slots in pairs(containers) do
        table.insert(retval, container)
    end
    return retval
end

---Gets how many slots are in the container (0 means no slots)
---@param container string The container
---@return integer amountOfSlots 0 means no slots
function inv.getMaxSlot(container)
    local containers = inv.z_InventorySlots[gui.screen()]
    if containers == nil then return 0 end
    local slots = containers[container]
    if slots == nil then return 0 end

    local maxSlot = 1
    for slot, position in pairs(slots) do
        maxSlot = math.max(maxSlot, slot)
    end
    return maxSlot
end