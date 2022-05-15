--Made by Onix86
_Z__AreaSearcher_LIB_GlobalVariables_InformationSetting = "Settings about the Chunk Scanning"
_Z__AreaSearcher_LIB_GlobalVariables_ChunkSize = 5
_Z__AreaSearcher_LIB_GlobalVariables_DoCloserFirst = true
_Z__AreaSearcher_LIB_GlobalVariables_SearchIntervalMS = 50
local _Z__AreaSearcher_LIB_LocalVariables_DONT_TOUCH_currentMS = 0
area = {
    CurrentTask = nil,
    WorldHeightMin = -64,
    WorldHeightMax = 320
}
function area.setChunkSize(size)
     if type(size) ~= "number" then
             error("Size must be a number (setChunkSize)") 
         else
             _Z__AreaSearcher_LIB_GlobalVariables_ChunkSize = math.ceil(size) 
     end
end
function area.setDoCloserFirst(doCloserFirst)
    if type(doCloserFirst) ~= "boolean" then
            error("doCloserFirst must be a number (setDoCloserFirst)") 
        else
            _Z__AreaSearcher_LIB_GlobalVariables_DoCloserFirst = doCloserFirst
    end
end
function area.setSearchInterval(searchInterval)
    if type(searchInterval) ~= "number" then
            error("searchInterval must be a number (setSearchInterval)") 
        else
            _Z__AreaSearcher_LIB_GlobalVariables_SearchIntervalMS = searchInterval - 0.01
    end
end


oldversions = "1.16.401.16.1001.16.2001.16.2011.16.2201.16.2211.17.01.17.11.17.101.17.111.17.301.17.321.17.341.17.401.17.41"
if string.find(oldversions, client.mcversion) then
    area.WorldHeightMin = 0
    area.WorldHeightMax = 256
end



---Call this in your update function or render function
---@param dt number The delta time (the first parameter of the update function)
---@return nil
function area.update(dt)
    _Z__AreaSearcher_LIB_LocalVariables_DONT_TOUCH_currentMS = _Z__AreaSearcher_LIB_LocalVariables_DONT_TOUCH_currentMS + dt
    if (_Z__AreaSearcher_LIB_LocalVariables_DONT_TOUCH_currentMS >= (_Z__AreaSearcher_LIB_GlobalVariables_SearchIntervalMS / 1000.0)) then
        _Z__AreaSearcher_LIB_LocalVariables_DONT_TOUCH_currentMS = 0
        if area.CurrentTask ~= nil then
            local status = coroutine.status(area.CurrentTask)
            if status ~= "running" and status ~= "dead" then
                local success, status = coroutine.resume(area.CurrentTask)
                if success == false then
                    coroutine.close(area.CurrentTask)
                    area.CurrentTask = nil
                end
            elseif status == "dead" then
                area.CurrentTask = nil
            end
        end
    end
end



function area._scan(x,y,z, radius, BlockCallback, DoneCallback)
    local tasks = {}
    local ox = x
    local oy = y
    local oz = z
    x = x - radius
    y = y - radius
    z = z - radius

    local ChunkSize = _Z__AreaSearcher_LIB_GlobalVariables_ChunkSize
    local WorldHeightMin = area.WorldHeightMin
    local WorldHeightMax = area.WorldHeightMax
    local TaskPerChunk = math.ceil((radius * 2) / ChunkSize)
    local TotalTaskChunkBlock = ChunkSize * TaskPerChunk

    --prepare tasks
    for xx=0,TotalTaskChunkBlock,ChunkSize do
        for yy=0,TotalTaskChunkBlock,ChunkSize do        
            for zz=0,TotalTaskChunkBlock,ChunkSize do
                local task = {startX=xx+x,startY=yy+y,startZ=zz+z,endX=xx+x+ChunkSize-1,endY=yy+y+ChunkSize-1,endZ=zz+z+ChunkSize-1}
                --if the task is within world height add it, this reduces the amount of "waste" blocks to scan
                if (task.startY > WorldHeightMin and task.endY < WorldHeightMax) then
                    table.insert(tasks, task)
                end
            end
        end
    end
    coroutine.yield("Tasks prepared.")

    local HalfChunkSize = ChunkSize / 2
    if _Z__AreaSearcher_LIB_GlobalVariables_DoCloserFirst == true then
        table.sort(tasks, function(a,b)
            local ax,ay,az, bx,by,bz
            --get the middle of both area
            if a.startX > 0 then ax = a.startX + HalfChunkSize else ax = a.startX - HalfChunkSize end
            if a.startY > 0 then ay = a.startY + HalfChunkSize else ay = a.startY - HalfChunkSize end
            if a.startZ > 0 then az = a.startZ + HalfChunkSize else az = a.startZ - HalfChunkSize end
            if b.startX > 0 then bx = b.startX + HalfChunkSize else bx = b.startX - HalfChunkSize end
            if b.startY > 0 then by = b.startY + HalfChunkSize else by = b.startY - HalfChunkSize end
            if b.startZ > 0 then bz = b.startZ + HalfChunkSize else bz = b.startZ - HalfChunkSize end
            local distanceA = math.sqrt((ax - ox)^2 + (ay - oy)^2 + (az - oz)^2) 
            local distanceB = math.sqrt((bx - ox)^2 + (by - oy)^2 + (bz - oz)^2)
            
            return distanceA < distanceB 
        end)
        coroutine.yield("Tasks sorted.")
    end

    for _, task in pairs(tasks) do
        for xx=task.startX,task.endX do
            for yy=task.startY,task.endY do
                for zz=task.startZ,task.endZ do
                    local blocc = dimension.getBlock(xx,yy,zz)
                    if blocc.id ~= 0 then
                        BlockCallback(blocc, xx,yy,zz)
                    end
                end
            end
        end
        coroutine.yield()
    end
    
    if (type(DoneCallback) == "function") then
        DoneCallback()
    end
end

---Scan an area slowly
---@param x number
---@param y number
---@param z number
---@param radius number
---@param BlockCallback fun(block:Block, x:number, y:number, z:number):nil --Called for every single block
---@param DoneCallback fun():nil --Called when the area finished scanning
function area.scan(x,y,z, radius, BlockCallback, DoneCallback)
    if (area.CurrentTask) then
        coroutine.close(area.CurrentTask)
        area.CurrentTask = nil
    end
    if type(BlockCallback) ~= "function" then
        error("BlockCallback must be a function!")
    end
    if radius < 2 then
        error("Radius is too small!")
    end

    area.CurrentTask = coroutine.create(area._scan)
    local success, status = coroutine.resume(area.CurrentTask, x,y,z,radius,BlockCallback, DoneCallback)
    if success == false then
        coroutine.close(area.CurrentTask)
        area.CurrentTask = nil
    end
end





function area._scanAir(x,y,z, radius, BlockCallback, DoneCallback)
    local tasks = {}
    local ox = x
    local oy = y
    local oz = z
    x = x - radius
    y = y - radius
    z = z - radius

    local ChunkSize = _Z__AreaSearcher_LIB_GlobalVariables_ChunkSize
    local WorldHeightMin = area.WorldHeightMin
    local WorldHeightMax = area.WorldHeightMax
    local TaskPerChunk = math.ceil((radius * 2) / ChunkSize)
    local TotalTaskChunkBlock = ChunkSize * TaskPerChunk

    --prepare tasks
    for xx=0,TotalTaskChunkBlock,ChunkSize do
        for yy=0,TotalTaskChunkBlock,ChunkSize do        
            for zz=0,TotalTaskChunkBlock,ChunkSize do
                local task = {startX=xx+x,startY=yy+y,startZ=zz+z,endX=xx+x+ChunkSize-1,endY=yy+y+ChunkSize-1,endZ=zz+z+ChunkSize-1}
                --if the task is within world height add it, this reduces the amount of "waste" blocks to scan
                if (task.startY > WorldHeightMin and task.endY < WorldHeightMax) then
                    table.insert(tasks, task)
                end
            end
        end
    end

    coroutine.yield("Tasks prepared.")

    local HalfChunkSize = ChunkSize / 2
    if _Z__AreaSearcher_LIB_GlobalVariables_DoCloserFirst == true then
        table.sort(tasks, function(a,b)
            local ax,ay,az, bx,by,bz
            --get the middle of both area
            if a.startX > 0 then ax = a.startX - HalfChunkSize else ax = a.startX + HalfChunkSize end
            if a.startY > 0 then ay = a.startY - HalfChunkSize else ay = a.startY + HalfChunkSize end
            if a.startZ > 0 then az = a.startZ - HalfChunkSize else az = a.startZ + HalfChunkSize end
            if b.startX > 0 then bx = b.startX - HalfChunkSize else bx = b.startX + HalfChunkSize end
            if b.startY > 0 then by = b.startY - HalfChunkSize else by = b.startY + HalfChunkSize end
            if b.startZ > 0 then bz = b.startZ - HalfChunkSize else bz = b.startZ + HalfChunkSize end
            local distanceA = math.sqrt((ax - ox)^2 + (ay - oy)^2 + (az - oz)^2) 
            local distanceB = math.sqrt((bx - ox)^2 + (by - oy)^2 + (bz - oz)^2)
            return distanceA < distanceB 
        end)
        coroutine.yield("Tasks sorted.")
    end

    for _, task in pairs(tasks) do
        for xx=task.startX,task.endX do
            for yy=task.startY,task.endY do
                for zz=task.startZ,task.endZ do
                    local blocc = dimension.getBlock(xx,yy,zz)
                    BlockCallback(blocc, xx,yy,zz)
                end
            end
        end
        coroutine.yield()
    end
    
    if (type(DoneCallback) == "function") then
        DoneCallback()
    end
end

---Scan an area slowly
---@param x number
---@param y number
---@param z number
---@param radius number
---@param BlockCallback fun(block:Block, x:number, y:number, z:number):nil --Called for every single block
---@param DoneCallback fun():nil --Called when the area finished scanning


---Scan an area but includes air blocks
---@param x number
---@param y number
---@param z number
---@param radius number
---@param BlockCallback fun(block:Block, x:number, y:number, z:number):nil --Called for every single block
---@param DoneCallback fun():nil --Called when the area finished scanning
function area.scanAir(x,y,z, radius, BlockCallback, DoneCallback)
    if (area.CurrentTask) then
        coroutine.close(area.CurrentTask)
        area.CurrentTask = nil
    end
    if type(BlockCallback) ~= "function" then
        error("BlockCallback must be a function!")
    end
    if radius < 2 then
        error("Radius is too small!")
    end
   
    area.CurrentTask = coroutine.create(area._scan)
    local success, status = coroutine.resume(area.CurrentTask, x,y,z,radius,BlockCallback, DoneCallback)
    if success == false then
        coroutine.close(area.CurrentTask)
        area.CurrentTask = nil
    end
end


function area.addSettings()
    client.settings.addAir(5)
    client.settings.addInfo("_Z__AreaSearcher_LIB_GlobalVariables_InformationSetting")
    client.settings.addInt("Chunk Size", "_Z__AreaSearcher_LIB_GlobalVariables_ChunkSize", 2, 50)
    client.settings.addBool("Do Closer First", "_Z__AreaSearcher_LIB_GlobalVariables_DoCloserFirst")
    client.settings.addFloat("Search Interval (MS)", "_Z__AreaSearcher_LIB_GlobalVariables_SearchIntervalMS", 0.0001, 500)
end

function area.cancel()
    if area.CurrentTask ~= nil then
        coroutine.close(area.CurrentTask)
        area.CurrentTask = nil
    end
end
