
local _astar = {}
_astar.INF = 1/0
_astar.cachedPaths = nil

----------------------------------------------------------------
-- local functions
----------------------------------------------------------------

function _astar.dist ( x1, y1, x2, y2 )
	
	return math.sqrt (  (x2 - x1 ) ^ 2 + ( y2 - y1 ) ^2 )
end

function _astar.dist_between ( nodeA, nodeB )

	return _astar.dist ( nodeA.x, nodeA.y, nodeB.x, nodeB.y )
end

function _astar.heuristic_cost_estimate ( nodeA, nodeB )

	return _astar.dist ( nodeA.x, nodeA.y, nodeB.x, nodeB.y )
end

function _astar.is_valid_node ( node, neighbor )

	return true
end

function _astar.lowest_f_score ( set, f_score )

	local lowest, bestNode = _astar.INF, nil
	for _, node in ipairs ( set ) do
		local score = f_score [ node ]
		if score < lowest then
			lowest, bestNode = score, node
		end
	end
	return bestNode
end

function _astar.neighbor_nodes ( theNode, nodes )

	local neighbors = {}
	for _, node in ipairs ( nodes ) do
		if theNode ~= node and _astar.is_valid_node ( theNode, node ) then
			table.insert ( neighbors, node )
		end
	end
	return neighbors
end

function _astar.not_in ( set, theNode )

	for _, node in ipairs ( set ) do
		if node == theNode then return false end
	end
	return true
end

function _astar.remove_node ( set, theNode )

	for i, node in ipairs ( set ) do
		if node == theNode then 
			set [ i ] = set [ #set ]
			set [ #set ] = nil
			break
		end
	end	
end

function _astar.unwind_path ( flat_path, map, current_node )

	if map [ current_node ] then
		table.insert ( flat_path, 1, map [ current_node ] ) 
		return _astar.unwind_path ( flat_path, map, map [ current_node ] )
	else
		return flat_path
	end
end

----------------------------------------------------------------
-- pathfinding functions
----------------------------------------------------------------

function _astar.a_star ( start, goal, nodes, valid_node_func )

	local closedset = {}
	local openset = { start }
	local came_from = {}

	if valid_node_func then _astar.is_valid_node = valid_node_func end

	local g_score, f_score = {}, {}
	g_score [ start ] = 0
	f_score [ start ] = g_score [ start ] + _astar.heuristic_cost_estimate ( start, goal )

	while #openset > 0 do
	
		local current = _astar.lowest_f_score ( openset, f_score )
		if current == goal then
			local path = _astar.unwind_path ( {}, came_from, goal )
			table.insert ( path, goal )
			return path
		end

		_astar.remove_node ( openset, current )		
		table.insert ( closedset, current )
		
		local neighbors = _astar.neighbor_nodes ( current, nodes )
		for _, neighbor in ipairs ( neighbors ) do 
			if _astar.not_in ( closedset, neighbor ) then
			
				local tentative_g_score = g_score [ current ] + _astar.dist_between ( current, neighbor )
				 
				if _astar.not_in ( openset, neighbor ) or tentative_g_score < g_score [ neighbor ] then 
					came_from 	[ neighbor ] = current
					g_score 	[ neighbor ] = tentative_g_score
					f_score 	[ neighbor ] = g_score [ neighbor ] + _astar.heuristic_cost_estimate ( neighbor, goal )
					if _astar.not_in ( openset, neighbor ) then
						table.insert ( openset, neighbor )
					end
				end
			end
		end
	end
	return nil -- no valid path
end

----------------------------------------------------------------
-- exposed functions
----------------------------------------------------------------

function _astar.clear_cached_paths ()

	_astar.cachedPaths = nil
end

function _astar.distance ( x1, y1, x2, y2 )
	
	return _astar.dist ( x1, y1, x2, y2 )
end


function _astar.path ( start, goal, nodes, ignore_cache, valid_node_func )

	if not _astar.cachedPaths then _astar.cachedPaths = {} end
	if not _astar.cachedPaths [ start ] then
		_astar.cachedPaths [ start ] = {}
	elseif _astar.cachedPaths [ start ] [ goal ] and not ignore_cache then
		return _astar.cachedPaths [ start ] [ goal ]
	end

      local resPath = _astar.a_star ( start, goal, nodes, valid_node_func )
      if not _astar.cachedPaths [ start ] [ goal ] and not ignore_cache then
              _astar.cachedPaths [ start ] [ goal ] = resPath
      end

	return resPath
end

function _astar.canWalkTrough(block)
    if block.isSolid == true then return false end
    local material = block.material
    if material == 5 then return false end
    if material == 6 then return false end
    if material == 10 then return false end

    return true
end
function _astar.isValidGroundBlock(block)
    return block.isSolid or block.name == "ladder"
end

function _astar.makePath(startX, startY, startZ, endX, endY, endZ, pathstartPointX, pathstartPointY, pathstartPointZ, pathendPointX, pathendPointY, pathendPointZ)
    local g = {}
    local result_start = nil
    local result_stop = nil
    local index = 0
    
    local blockOnStart = dimension.getBlock(pathstartPointX, pathstartPointY, pathstartPointZ)
    if string.find(blockOnStart.name, "slab") ~= nil then pathstartPointY = pathstartPointY + 1 end
    local blockOnEnd = dimension.getBlock(pathendPointX, pathendPointY, pathendPointZ)
    if string.find(blockOnEnd.name, "slab") ~= nil then pathendPointY = pathendPointY + 1 end

    for x=startX, endX do
        for height=startY,endY do
            for y=startZ,endZ do
                local blockNow = dimension.getBlock(x,height,y)
                if _astar.canWalkTrough(blockNow) == true then --avoid lava and water tho
                    local blockBelow = dimension.getBlock(x,height-1,y)
                    if _astar.isValidGroundBlock(blockBelow) == true then
                        local blockAbove = dimension.getBlock(x,height+1,y)
                        if _astar.canWalkTrough(blockAbove) == true then --avoid lava and water tho
                            index = index + 1
                            local games = {}
                            games.x = x
                            games.y = y
                            games.height = height
                            if pathstartPointX == x and pathstartPointZ == y and pathstartPointY == height then
                                result_start = index
                            elseif pathendPointX == x and pathendPointZ == y and pathendPointY == height then
                                result_stop = index
                            end
                            table.insert(g, games)
                        end
                    end
                end
            end
        end
    end
    return g, result_start, result_stop
end


function _astar.getItemIdentifier(name)
    local item = getItem(name) or {}
    local identifier = item.blockid or item.id
    if identifier == nil then error("Item: " .. name  .. " Does not have an id!") end
    return identifier
end


path = {}
---@class _PATH_ACP_Vector3
---@field x integer
---@field y integer
---@field z integer
local _PATH_ACP_Vector3_C = {}

---Finds a path between two points in a Minecraft: Bedrock Edition world
---@param startX integer Start Position X
---@param startY integer Start Position Y
---@param startZ integer Start Position Z
---@param destinationX integer Objective Position X
---@param destinationY integer Objective Position Y
---@param destinationZ integer Objective Position Z
---@param extraRadius integer How many extra blocks should we search (like behind start/destination in case diagonal line would not work but you can walk to the side)
---@param printInfo boolean Print some statistic information in chat
---@return _PATH_ACP_Vector3[]|nil path 
function path.find(startX, startY, startZ, destinationX, destinationY, destinationZ, extraRadius, printInfo)
    if extraRadius == nil then extraRadius = 20 end
    if printInfo == nil then printInfo = false end
    local areaStart = {x=math.min(startX, destinationX) - extraRadius, y=math.min(startY, destinationY) - extraRadius, z=math.min(startZ, destinationZ) - extraRadius}
    local areaStop = {x=math.max(startX, destinationX) + extraRadius, y=math.max(startY, destinationY) + extraRadius, z=math.max(startZ, destinationZ) + extraRadius}

    local prePath = os.clock()
    local map, startPoint, endPoint = _astar.makePath(areaStart.x, areaStart.y, areaStart.z, areaStop.x, areaStop.y, areaStop.z, startX, startY, startZ, destinationX, destinationY, destinationZ)
    if startPoint == nil or endPoint == nil then
        if printInfo then
            if startPoint == nil then
                print("The starting position is not in the valid blocks we can go")
            end
            if endPoint == nil then
                print("The ending position is not in the valid blocks we can go")
            end
        end
        return nil
    end
    local postPath = os.clock()
    if printInfo == true then
        print("Found all valid routes, there are: " .. #map .. "   and it took: " .. postPath - prePath .. " seconds")
    end
   
    local LADDER_ID = _astar.getItemIdentifier("minecraft:ladder")
    local FARMLAND_ID = _astar.getItemIdentifier("minecraft:farmland")
    local valid_node_func = function ( node, neighbor ) 


        local diffx = node.x - neighbor.x
        local diffy = node.y - neighbor.y
        local diffheight = neighbor.height - node.height
        
        if diffheight < -3 then return false end --fall too high
        if diffheight > 1 then return false end --cant jump two blocks

        if diffheight == 1 then --if we gotta jump
            local blockToJump = dimension.getBlock(neighbor.x, node.height, neighbor.y)
            if string.find(blockToJump.name, "fence") ~= nil or string.find(blockToJump.name, "wall") ~= nil then 
                return false --we cant jump over that
            end
            
            local firstblock = dimension.getBlock(neighbor.x, neighbor.height, neighbor.y)
            if firstblock.id == LADDER_ID then
                if diffx ~= 0 or diffy ~= 0 then
                    local comingFrom = dimension.getBlock(node.x,node.height,node.y)
                    if comingFrom.id == LADDER_ID then
                        if diffx == 1 or diffx == -1 then
                            return diffy == 0
                        elseif diffy == 1 or diffy == -1 then
                            return diffx == 0
                        end
                    end
                    return false
                else
                    return true
                end
            end
        elseif diffheight < 0 then --is this fall valid? (not trough blocks)
            local firstblock = dimension.getBlock(neighbor.x, neighbor.height, neighbor.y)
            if firstblock.id == LADDER_ID and (diffx ~= 0 or diffy ~= 0) then
                return false
            end
            
            for i=node.height+1, neighbor.height, -1 do
                local block = dimension.getBlock(neighbor.x, i, neighbor.y)
                if block.isSolid then return false end
            end
            local blockBelowNeighbor = dimension.getBlock(neighbor.x, neighbor.height-1, neighbor.y)
            if blockBelowNeighbor.id == FARMLAND_ID then return false end
            if firstblock.id == LADDER_ID then return true end --all u need to know if going down a ladder
        end
        


        local didValidMove = false
        if diffx == 1 then
            if diffy == 1 then
                local firstblock = dimension.getBlock(node.x - 1, node.height, node.y)
                local secondblock = dimension.getBlock(node.x, node.height, node.y - 1)
                didValidMove = (firstblock.isSolid or secondblock.isSolid) == false
            elseif diffy == -1 then 
                local firstblock = dimension.getBlock(node.x - 1, node.height, node.y)
                local secondblock = dimension.getBlock(node.x, node.height, node.y + 1)
                didValidMove =  (firstblock.isSolid or secondblock.isSolid) == false
            elseif diffy == 0 then
                didValidMove = true
            end
        elseif diffx == -1 then 
            if diffy == 1 then
                local firstblock = dimension.getBlock(node.x + 1, node.height, node.y)
                local secondblock = dimension.getBlock(node.x, node.height, node.y - 1)
                didValidMove = (firstblock.isSolid or secondblock.isSolid) == false
            elseif diffy == -1 then 
                local firstblock = dimension.getBlock(node.x + 1, node.height, node.y)
                local secondblock = dimension.getBlock(node.x, node.height, node.y + 1)
                didValidMove = (firstblock.isSolid or secondblock.isSolid) == false
            elseif diffy == 0 then
                didValidMove = true
            end
        elseif diffx == 0 then 
            didValidMove = diffy == -1 or diffy == 1
        end

        
        --local neighborBlock = dimension.getBlock(neighbor.x, neighbor.height, neighbor.y)
       return didValidMove
    end

    
    --local node2 = g[tablelen(g)]
    --print(node2.x .. " " .. node2.y)
    prePath = os.clock()
    local resultPath = _astar.path ( map[startPoint], map[endPoint], map, true, valid_node_func )
    postPath = os.clock()
    if printInfo == true then
        print("Finished finding a path, there is : " .. #(resultPath or {}) .. " steps    and it took: " .. postPath - prePath .. " seconds")
    end

    if resultPath == nil then return nil end
    local result = {}
    for _, node in ipairs(resultPath) do
        local step = {}
        step.x = node.x
        step.y = node.height
        step.z = node.y
        table.insert(result, step)
    end
    return result
end

path.movePath = {}
path.resultPath = {}
path.IsMoving = false

---Sets which path will be traversed
---@param pathh _PATH_ACP_Vector3[]
function path.walkPath(pathh)
    if pathh == nil then
        path.resultPath = {}
        path.movePath = {}
        path.IsMoving = false
        return
    end
    path.resultPath = pathh
    path.movePath = {}
    path.IsMoving = true
    for k,v in pairs(pathh) do
        table.insert(path.movePath, v)
    end
end
function path.isFinished()
    return path.IsMoving == false
end



function _astar.isOnGroundEnough()
    local x,y,z = player.position()
    local block = dimension.getBlock(x,y,z)
    if block.name == "ladder" then return true end
    local px,py,pz = player.pposition()
    py = py - 1.62 --magic value trust
    return py - 0.02 < y and py + 0.02 > y 
end
function _astar.isCenteredEnoughToJump()
    local x,y,z = player.position()
    x=x+0.5
    z=z+0.5
    local px,py,pz = player.pposition()
    
    return _astar.dist(x,px,z,pz) < 0.10
end
function _astar.shouldNotSprint(path)
    if #path <= 4 then return true end
    local x,y,z = player.position()
    local blockOnPlayer = dimension.getBlock(x,y,z)
    if string.find(blockOnPlayer.name, "slab") ~= nil then y = y + 1 end
    local p1 = path[1]
    local p2 = path[2]
    local p3 = path[3]
    --if p1.y > y or p2.y > p1.y or p3.y > p2.y then return false end
    if p1.y ~= y then return true end
    if p2.y ~= y then return true end
    if p3.y ~= y then return true end
    return false
end

path.IsTryingToStopSpringingSoFastBecauseItMightBeProblematic = 0
---@param m MoveInput
function path.moveInput(m)
    ::StartOfMovement::
    if path.IsTryingToStopSpringingSoFastBecauseItMightBeProblematic > 0 then
        m.up = false
        m.down = false
        m.right = false
        m.left = false
        m.sprint = false
        m.jump = false
        path.IsTryingToStopSpringingSoFastBecauseItMightBeProblematic = path.IsTryingToStopSpringingSoFastBecauseItMightBeProblematic - 1
        return
    end
    if path.movePath[1] ~= nil then
        path.IsMoving = true
        local p1 = path.movePath[1]

        local x,y,z = player.position()
        local blockOnPlayer = dimension.getBlock(x,y,z)
        if string.find(blockOnPlayer.name, "slab") ~= nil then y = y + 1 end

        if _astar.shouldNotSprint(path.movePath) and player.getFlag(3) == true then
            m.sprint = false
            path.IsTryingToStopSpringingSoFastBecauseItMightBeProblematic = 3
            return
        end


        if x == p1.x and y == p1.y and z == p1.z then
            table.remove(path.movePath, 1)
            goto StartOfMovement
        elseif p1.y > y and _astar.isCenteredEnoughToJump() then 
            m.jump = true
        end

        if x == p1.x and y == p1.y and z == p1.z then
            else
                if x ~= p1.x or z ~= p1.z then
                local apx, apy, apz = p1.x+0.5, p1.y+0.5, p1.z+0.5
                player.lookAt(apx,apy,apz, true)
                local xx,yy,zz = player.position()
                if yy < p1.y then
                    local potentialLadder = dimension.getBlock(xx,yy,zz)
                    if p1.ladderPaused == nil and potentialLadder.name == "ladder" then
                        local dest = dimension.getBlock(p1.x,p1.y,p1.z)
                        if dest.name ~= "ladder" then
                            m.jump = false
                            p1.ladderPaused = true
                            path.IsTryingToStopSpringingSoFastBecauseItMightBeProblematic = 8
                            goto StartOfMovement
                        end
                    else
                        m.jump = true
                    end
                end
            end
        end
        
        if (x ~= p1.x or z ~= p1.z) then
            m.up = true
        else
            m.up = false
        end
        if _astar.shouldNotSprint(path.movePath) == false then
            m.sprint = true
        elseif y < p1.y then
            m.sprint = false
        end
        m.jump = false

        x,y,z = player.position()
        blockOnPlayer = dimension.getBlock(x,y,z)
        if string.find(blockOnPlayer.name, "slab") ~= nil then y = y + 1 end
        if x == p1.x and y == p1.y and z == p1.z then
            table.remove(path.movePath, 1)
            goto StartOfMovement
        elseif p1.y > y then 
            m.jump = true
        end

    elseif path.IsMoving == true then
        m.up = false
        m.down = false
        m.right = false
        m.left = false
        m.sprint = false
        m.jump = false
        path.IsMoving = false
    end




end


function path.render(dt)
   --[[  if path.movePath[1] ~= nil then
        path.IsMoving = true
        local p1 = path.movePath[1]
        local x,y,z = player.position()
        if x == p1.x and y == p1.y and z == p1.z then
        else
            if x ~= p1.x or z ~= p1.z then
                local apx, apy, apz = p1.x+0.5, p1.y+0.5, p1.z+0.5
                player.lookAt(apx,apy,apz, true)
            end
        end

        
    end ]]
end


function path.render3d(dt)

    if path.resultPath == nil or path.resultPath[1] == nil then return end
    local lastPoint = path.resultPath[1]
    for k, node in pairs(path.resultPath) do
        gfx.color(255,0,0,255)
        gfx.line(lastPoint.x+0.50, lastPoint.y + 0.5, lastPoint.z+0.5, node.x+0.5, node.y + 0.5, node.z+0.5)
        
        gfx.color(0,255,255,255)
        gfx.line(node.x+0.5, node.y, node.z+0.5, node.x+0.5, node.y+1.5, node.z+0.5)
        lastPoint = node
    end

end