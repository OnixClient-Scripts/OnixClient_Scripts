-- 𝗧𝗼𝘅𝗶𝗰𝗛𝗲𝗹𝗽𝗲𝗿
-- Made by RubyDevil#6666

name = "ToxicHelper"
description = "Help yourself not be toxic in chat"

Mute = { x = false, e = false, f = true, s = "" }
event.listen("KeyboardInput", function(key, down)
   if Mute.s ~= "chat_screen" and Mute.e and key == 13 or key == 84 then
      return true
   elseif Mute.s == "chat_screen" and Mute.f then
      if key == 8 then
         Mute.x = true
      elseif key > 27 and key ~= 111 and key ~= 191 then
         Mute.f = false
      end
   end
end)

function update()
   if Mute.x then print("§c§lSTOP DONT SEND -> BE NICE") end
   if Mute.s ~= gui.screen() and gui.screen() == "chat_screen" then
      Mute.e = false Mute.f = true Mute.x = false
   end
   if Mute.s == "chat_screen" and gui.screen() ~= "chat_screen" then
      Mute.e = true Mute.f = true Mute.x = false
   end
   Mute.s = gui.screen()
end