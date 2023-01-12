name = "Better Coordinates"
description = "A customizable coordinates module"
--[[Better Coordinates Credits:
Shige - Creator of Nether Translator Module (Which I may or may not have stolen (please don't sue me))
Onix - Helped Shige with Nether Translator Module and supported dOGbone (and made Onix Client (also please give me scripting role))
Jams - For calling out dOGbone on his stupidity (But in a positive and helpful way)
dOGbone - For making objectively decent code]]

--Module Settings
sameLine = true
position = true
showXYZ = false
colored = false
universal = false
translator = false
positionX = 20
positionY = 80
sizeX = 40
sizeY = 30
scale = 1
color = {255,255,255,255}
background_color = {0,0,0,128}
client.settings.addAir(2.5)
client.settings.addTitle("Vanilla Features")
client.settings.addBool("Display on same line?", "sameLine")
client.settings.addBool("Show position text?", "position")
client.settings.addAir(2.5)
client.settings.addTitle("XYZ Settings")
client.settings.addBool("Show XYZ?", "showXYZ")
client.settings.addBool("Colored XYZ?", "colored")
client.settings.addAir(2.5)
client.settings.addTitle("Dimension Settings")
client.settings.addBool("Universal coordinates?", "universal")
client.settings.addBool("Translate coordinates?", "translator")
client.settings.addAir(2.5)
client.settings.addTitle("Theme Settings")
client.settings.addColor("Text Color", "color")
client.settings.addColor("Background Color", "background_color")
client.settings.addAir(2.5)
--Dimension Settings (Dimension 1 is the Nether)
function render(deltaTime)
   local player_x, player_y, player_z = player.position()
	if (dimension.id() == 1) and universal == true then
        player_x = math.floor(player_x * 8)
        player_z = math.floor(player_z * 8)
	end
	if (dimension.id() == 1) and translator == true then
		player_x = math.floor(player_x / 8)
        player_z = math.floor(player_z / 8)
	end
	if (dimension.id() ~= 1) and translator == true then
		player_x = math.floor(player_x * 8)
		player_z = math.floor(player_z * 8)
	end
--Module Display
   if showXYZ == true and colored == true and position == true then 
		textP = "Position:"
		textX = "§aX§r: "
		textY = "§cY§r: "
		textZ = "§bZ§r: "
end
   if showXYZ == true and colored == false and position == false then 
  		textX = "X: "
		textY = "Y: "
		textZ = "Z: "
end
   if showXYZ == true and colored == true and position == false then 
		textX = "§aX§r: "
		textY = "§cY§r: "
		textZ = "§bZ§r: "
end
   if showXYZ == true and colored == false and position == true then 
		textP = "Position:"
  		textX = "X: "
		textY = "Y: "
		textZ = "Z: "
end
   if showXYZ == false and position == false then 
  		textX = ""
		textY = ""
		textZ = ""
end
   if showXYZ == false and position == true then 
		textP = "Position:"
  		textX = ""
		textY = ""
		textZ = ""
end
   if sameLine == true and position == false then
		sizeX = 20
		sizeY = 8
		local text = textX .. player_x .. " " .. textY .. player_y .. " " .. textZ .. player_z
		local font = gui.font()
		gfx.color(background_color.r, background_color.g, background_color.b, background_color.a)
		sizeX = font.width(text, 1) + 3
		gfx.rect(0, 0, sizeX, 8)
		gfx.color(color.r, color.g, color.b, color.a)
		gfx.text(1, 0, text)
end
   if sameLine == true and position == true then
		sizeX = 20
		sizeY = 8
		local text = textP .. " " .. textX .. player_x .. " " .. textY .. player_y .. " " .. textZ .. player_z
		local font = gui.font()
		gfx.color(background_color.r, background_color.g, background_color.b, background_color.a)
		sizeX = font.width(text, 1) + 3
		gfx.rect(0, 0, sizeX, 8)
		gfx.color(color.r, color.g, color.b, color.a)
		gfx.text(1, 0, text)
end
   if sameLine == false and position == false then
		sizeX = 61
		sizeY = 30
		gfx.color(background_color.r, background_color.g, background_color.b, background_color.a)
		gfx.rect(0, 0, 61, 30)
		gfx.color(color.r, color.g, color.b, color.a)		
		gfx.text(1,3, textX .. player_x)
		gfx.text(1,11, textY .. player_y) 
		gfx.text(1,19, textZ .. player_z)
end
   if sameLine == false and position == true then
		sizeX = 61
		sizeY = 35
		gfx.color(background_color.r, background_color.g, background_color.b, background_color.a)
		gfx.rect(0, 0, 61, 35)
		gfx.color(color.r, color.g, color.b, color.a)
		gfx.text(1,3, textP)	
		gfx.text(1,11, textX .. player_x)
		gfx.text(1,19, textY .. player_y) 
		gfx.text(1,27, textZ .. player_z)
end
end