name = "Anti slab Interact"
description = "Prevents players from interacting with slabs."

blocks = {
    "stone_block_slab"
}

event.listen("MouseInput", function(button, down)
    if player.facingBlock() then
        local selectedBlockX, selectedBlockY, selectedBlockZ = player.selectedPos()
        local block = dimension.getBlock(selectedBlockX, selectedBlockY, selectedBlockZ)
        for integer, v in pairs(blocks) do
            if block.name:find(v) then
                return true
            end
        end
    end
end)