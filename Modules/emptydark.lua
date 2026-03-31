name = "Emptydark"
description = "Makes the surrounding environment darker. Allows you to see less clearly in The End, Nether, and at night."

client.settings.addNamelessCategory("Render Settings", 1)
client.settings.addNamelessFloat("Ammag", 0, 25, 10)

function render2()
  gfx2.fillRect(0, 0, gui.width(), gui.height())
end
