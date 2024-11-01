name = "Inventory Viewer"
description = "check the item in your inventory."

positionX = 10
positionY = 10
sizeX = 150
sizeY = 50

textColor = { 255, 255, 255, 255 }
inventoryTexture = true
slotAmount = true
slotAmountThreshold = 0

client.settings.addColor("text color", "textColor")
client.settings.addBool("item texture", "inventoryTexture")
client.settings.addBool("item amount", "slotAmount")
client.settings.addInt("Displays the number of items (if set to 0, display all)", "slotAmountThreshold", 0, 64)

function render(deltaTime)
	local inventory = player.inventory()
	local inventorySize = inventory.size

	if not gui.mouseGrabbed() then
		if inventoryTexture then
			gfx.image(0, 0, sizeX, sizeY, "ui/inventory.png")
		end
		
		for slotIndex = 10, inventorySize, 1 do
			local slot = inventory.at(slotIndex)
			
			if slot ~= nil then
				-- 10 * ((math.floor(slotIndex / 9) - 1) + 0.5) + 10 * (math.floor(slotIndex / 9) - 1)
				gfx.item(2 + (16.75 * ((slotIndex - 1) % 9)), 2 + (17 * (math.floor((slotIndex - 1) / 9) - 1)), slot.location, 0.7)
				
				if slotAmount and slot.count > slotAmountThreshold then
					gfx.color(textColor.r, textColor.g, textColor.b, textColor.a)
					
					gfx.text(8 + (16.75 * ((slotIndex - 1) % 9) + (slot.count < 10 and 2.5 or 0)), 10 + (17 * (math.floor((slotIndex - 1) / 9) - 1)), slot.count, 0.5)
				end
			end
		end
	end
end