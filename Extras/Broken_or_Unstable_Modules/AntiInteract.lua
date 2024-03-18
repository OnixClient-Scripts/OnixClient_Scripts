name = "Anti Interact"
description = "Prevents players from interacting with inventory screens when moving."

blockE = client.settings.addNamelessBool("Block Opening Inventory When Moving", true)
blockBlockActors = client.settings.addNamelessBool("Block Opening UIs", true)
blockRightClickWhenHoldingSword = client.settings.addNamelessBool("Block Right Clicking When Holding Sword", true)

blockActors = {
    chest = true,
    trapped_chest = true,
    ender_chest = true,
    dispenser = true,
    dropper = true,
    furnace = true,
    brewing_stand = true,
    hopper = true,
    beacon = true,
    shulker_box = true,
    barrel = true,
    blast_furnace = true,
    smoker = true,
    cartography_table = true,
    crafting_table = true,
    fletching_table = true,
    grindstone = true,
    loom = true,
    stonecutter = true,
    smithing_table = true,
    lectern = true,
}
local moving
keydown = {}
event.listen("KeyboardInput", function(key, down)
    if blockE.value then
        keydown[key] = down
        moving = keydown[0x57] or keydown[0x41] or keydown[0x53] or keydown[0x44]
        if (key == 0x45 and down) and moving then
            return true
        end
    end
end)

event.listen("MouseInput", function(button, down)
    if (button == 2 and down) then
        if blockBlockActors.value and player.facingBlock() then
            local block = dimension.getBlock(player.selectedPos())
            return blockActors[block.name]
        end
        if blockRightClickWhenHoldingSword.value and (button == 2 and down) and player.facingBlock() then
            local selectedItem = player.inventory().at(player.inventory().selected) or {}
            if (selectedItem.name or ""):lower():find("sword") ~= nil then
                return true
            end
        end
    end
end)