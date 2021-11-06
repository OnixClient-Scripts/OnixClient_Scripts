name = "Gamemode Hotkey"
description = "Press hotkey to switch between Gamemode 0 and 1"
keybind = 0x47
client.settings.addKeybind("Key", "keybind")
function keyboard(key, isDown)
   local isMouseGrabbed = gui.mouseGrabbed()
   local gamemode = player.gamemode()
   if (gamemode == 5) then
       gamemode = 1
   end
   if isMouseGrabbed == false and key == keybind and isDown == true then
       if gamemode == 1 then
           client.execute("execute /gamemode s") 
       elseif gamemode == 0 then
           client.execute("execute /gamemode c")
       end
   end
end
