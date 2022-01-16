command = "worldinfo"
help_message = "World Info"

function execute(arguments)	
	print("World Name: " .. server.worldName())
	print("World Version: " .. client.mcversion)
	print("Dimension: " .. dimension.name() .. " (" .. dimension.id() .. ")")
	print("Dimension Time: " .. dimension.time())
end
