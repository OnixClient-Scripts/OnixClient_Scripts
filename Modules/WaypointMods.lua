name = "Waypoint Mods"
description = "Mods for waypoints"

showBeams = client.settings.addNamelessBool("Show Beams", true)
showTracers = client.settings.addNamelessBool("Show Tracers", true)

client.settings.addAir(5)
maxRender = client.settings.addNamelessInt("Maximum Render Distance", 5, 5000, 2000)
minRender = client.settings.addNamelessInt("Minimum Render Distance", 0, 50, 7)
client.settings.addAir(5)
client.settings.addTitle("Color Settings")
color = client.settings.addNamelessColor("Default Color", { 255, 255, 255, 255 })
defaultDeathColor = client.settings.addNamelessColor("Default Death Color", {180,25,25,255})
client.settings.addAir(2)
function hextorgb(hex)
	hex = hex:gsub("#", "")
	return tonumber("0x" .. hex:sub(1, 2)), tonumber("0x" .. hex:sub(3, 4)), tonumber("0x" .. hex:sub(5, 6))
end

function rgbtohex(r, g, b)
	return string.format("#%02x%02x%02x", r, g, b)
end

waypointColors = {}

---use to render a cube in a world at predermined position and size
---@param x number x position of the cube
---@param y number y position of the cube
---@param z number z position of the cube
---@param sx number x size of the cube
---@param sy number y size of the cube
---@param sz number z size of the cube
---@return nil
function gfx.cubexyz(x, y, z, sx, sy, sz)
	gfx.quad(x, y, z, x + sx, y, z, x + sx, y + sy, z, x, y + sy, z, true)
	gfx.quad(x, y, z + sz, x + sx, y, z + sz, x + sx, y + sy, z + sz, x, y + sy, z + sz, true)
	gfx.quad(x, y, z, x, y, z + sz, x, y + sy, z + sz, x, y + sy, z, true)
	gfx.quad(x + sx, y, z, x + sx, y, z + sz, x + sx, y + sy, z + sz, x + sx, y + sy, z, true)
	gfx.quad(x, y, z, x + sx, y, z, x + sx, y, z + sz, x, y, z + sz, true)
	gfx.quad(x, y + sy, z, x + sx, y + sy, z, x + sx, y + sy, z + sz, x, y + sy, z + sz, true)
end

function updateWaypointColors()
	local waypoints = client.waypoints()
	local waypointLookup = {}
	local pendingColor = {}
	for k, waypoint in pairs(waypoints.get()) do
		waypointLookup[waypoint.name] = true
		if waypointColors[waypoint.name] == nil then
			table.insert(pendingColor, waypoint)
		end
	end
	local newColors = {}
	local pendingRemoval = {}
	for name, v in pairs(waypointColors) do
		if waypointLookup[name] == nil then
			table.insert(pendingRemoval, v)
		else
			newColors[name] = v
		end
	end
	waypointColors = newColors
	for k, v in pairs(pendingRemoval) do
		v.parent.removeSetting(v)
	end
	for k, v in pairs(pendingColor) do
		if v.name == "Last Death" then
			local clr = {math.floor(defaultDeathColor.value.r*255), math.floor(defaultDeathColor.value.g*255), math.floor(defaultDeathColor.value.b*255), math.floor(defaultDeathColor.value.a*255)}
			waypointColors[v.name] = client.settings.addNamelessColor(v.name, clr)
		else
			local clr = {math.floor(color.value.r*255), math.floor(color.value.g*255), math.floor(color.value.b*255), math.floor(color.value.a*255)}
			waypointColors[v.name] = client.settings.addNamelessColor(v.name, clr)
		end
	end
end -- blushes and runs away from the code
updateWaypointColors()

function update(dt)
	updateWaypointColors()
end

function render3d()
	local waypoints = client.waypoints()
	local getWaypoints = waypoints.get()

	local a, b, c = gfx.origin()

	for i, waypoint in ipairs(getWaypoints) do
		local waypointX, watpointY, waypointZ = waypoint.x, waypoint.y, waypoint.z
		local size = 0.5
		local x, y, z = player.position()
		local distance = math.sqrt((x - waypointX) ^ 2 + (z - waypointZ) ^ 2)
		if (distance < maxRender.value) and (distance > minRender.value) then
			if showBeams.value == true then
				local c = waypointColors[waypoint.name] or color
				gfx.color(c)
				gfx.pushTransformation(
					{ 2, -(size / 2), 0, -(size / 2) },
					{ 3, os.clock() * 2, 0, 0, 1 },
					{ 2, waypointX + size / 2, -64, waypointZ + size / 2 }
				)
				gfx.cubexyz(0, 0, 0, size, 384, size)
				gfx.color(69, 45, 87, 0)
				gfx.popTransformation(69)
			end
		end
		if showTracers.value == true then
			local forwardPosX, forwardPosY, forwardPosZ = player.forwardPosition(1)
			local c = waypointColors[waypoint.name] or color
			gfx.renderBehind(true)
			gfx.color(c)
			gfx.line(forwardPosX, forwardPosY, forwardPosZ, waypoint.x+0.5, waypoint.y+0.5, waypoint.z+0.5)
			gfx.color(69, 45, 87, 0)
			gfx.renderBehind(false)
		end
	end
end
