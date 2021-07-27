command = "worldinfo"
help_message = "World Info"

function execute(arguments)
	local dimensionId = dimension.id()
	local dimensionName = dimension.name()
	local time = dimension.time()
	local worldName = server.worldName()
	local worldVersion = game.version
	
	print("World Name: " .. worldName)
	print("World Version: " .. worldVersion)
	print("Dimension: " .. dimensionName .. " (" .. dimensionId .. ")")
	print("Dimension Time: " .. time)
end
