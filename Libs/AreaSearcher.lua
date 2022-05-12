--Made by Onix86

area = {
    ChunkSize = 5,
    DoCloserFirst = true,
    CurrentTask = nil,
    WorldHeightMin = -64,
    WorldHeightMax = 320
}
oldversions = "1.16.40 1.16.100 1.16.200 1.16.201 1.16.220 1.16.221 1.17.0 1.17.1 1.17.10 1.17.11 1.17.30 1.17.32 1.17.34 1.17.40 1.17.41"
if string.find(oldversions, client.mcversion) then
    area.WorldHeightMin = 0
    area.WorldHeightMax = 256
end


---Call this in your update function
---@param dt number The delta time (the first parameter of the update function)
---@return nil
function area.update(dt)
    if area.CurrentTask ~= nil then
        local status = coroutine.status(area.CurrentTask)
        if status ~= "running" and status ~= "dead" then
            local success, status = coroutine.resume(area.CurrentTask)
            if success == false then
                print("could not resume")
                coroutine.close(area.CurrentTask)
                area.CurrentTask = nil
            end
            if status ~= nil then
                print(status) --DEBUG
            end
        elseif status == "dead" then
            area.CurrentTask = nil
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

    local ChunkSize = area.ChunkSize
    local WorldHeightMin = area.WorldHeightMin
    local WorldHeightMax = area.WorldHeightMax
    local TaskPerChunk = math.ceil((radius * 2) / ChunkSize)
    local TotalTaskChunkBlock = ChunkSize * TaskPerChunk
    print(x .. " " .. y .. " " .. z)

    --prepare tasks
    for xx=0,TotalTaskChunkBlock,ChunkSize do
        for yy=0,TotalTaskChunkBlock,ChunkSize do        
            for zz=0,TotalTaskChunkBlock,ChunkSize do
                local task = {startX=xx+x,startY=yy+y,startZ=zz+z,endX=xx+x+ChunkSize,endY=yy+y+ChunkSize,endZ=zz+z+ChunkSize}
                --if the task is within world height add it, this reduces the amount of "waste" blocks to scan
                if (task.startY > WorldHeightMin and task.endY < WorldHeightMax) then
                    table.insert(tasks, task)
                end
            end
        end
    end

    coroutine.yield("Tasks prepared.")

    local HalfChunkSize = ChunkSize / 2
    if area.DoCloserFirst == true then
        table.sort(tasks, function(a,b)
            local ax,ay,az, bx,by,bz
            --get the middle of both area
            ax = a.startX - HalfChunkSize
            ay = a.startY - HalfChunkSize
            az = a.startZ - HalfChunkSize
            bx = b.startX - HalfChunkSize
            by = b.startY - HalfChunkSize
            bz = b.startZ - HalfChunkSize
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
        print("could not resume")
        coroutine.close(area.CurrentTask)
        area.CurrentTask = nil
    end
    if status ~= nil then
        print(status) --DEBUG
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

    local ChunkSize = area.ChunkSize
    local WorldHeightMin = area.WorldHeightMin
    local WorldHeightMax = area.WorldHeightMax
    local TaskPerChunk = math.ceil((radius * 2) / ChunkSize)
    local TotalTaskChunkBlock = ChunkSize * TaskPerChunk

    --prepare tasks
    for xx=0,TotalTaskChunkBlock,ChunkSize do
        for yy=0,TotalTaskChunkBlock,ChunkSize do        
            for zz=0,TotalTaskChunkBlock,ChunkSize do
                local task = {startX=xx+x,startY=yy+y,startZ=zz+z,endX=xx+x+ChunkSize,endY=yy+y+ChunkSize,endZ=zz+z+ChunkSize}
                --if the task is within world height add it, this reduces the amount of "waste" blocks to scan
                if (task.startY > WorldHeightMin and task.endY < WorldHeightMax) then
                    table.insert(tasks, task)
                end
            end
        end
    end

    coroutine.yield("Tasks prepared.")

    local HalfChunkSize = ChunkSize / 2
    if area.DoCloserFirst == true then
        table.sort(tasks, function(a,b)
            local ax,ay,az, bx,by,bz
            --get the middle of both area
            ax = a.startX - HalfChunkSize
            ay = a.startY - HalfChunkSize
            az = a.startZ - HalfChunkSize
            bx = b.startX - HalfChunkSize
            by = b.startY - HalfChunkSize
            bz = b.startZ - HalfChunkSize
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
        print("could not resume")
        coroutine.close(area.CurrentTask)
        area.CurrentTask = nil
    end
    if status ~= nil then
        print(status) --DEBUG
    end
end




function area.cancel()
    if area.CurrentTask ~= nil then
        coroutine.close(area.CurrentTask)
        area.CurrentTask = nil
    end
end
