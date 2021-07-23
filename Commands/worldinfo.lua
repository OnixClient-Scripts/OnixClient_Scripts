command = "worldinfo"
help_message = "World Info"

function execute(arguments)
	local dimensionId = dimension.id()
	local dimensionName = dimension.name()
	local time = dimension.time()
	local worldName = server.worldName()
	
	print("World Name: " .. worldName)
	print("Dimension: " .. dimensionName .. " (" .. dimensionId .. ")")
	print("Dimension Time: " .. time)
end