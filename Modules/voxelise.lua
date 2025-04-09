name = "Voxeliser"
description = "Has the command 'load model' which takes in a .obj file with one texture file (no materials) and places it in minecraft"

importLib("BlockRGB.lua")
importLib("geometryLib.lua")
importLib("onDemandRendering.lua")
importLib("key-codes.lua")

function clearVisualisation()
    client.execute("lua reload")
end

voxelModelSize = 100
client.settings.addInt("Model size","voxelModelSize",10,1000)

flipYandZ = true
client.settings.addBool("Flip Y and Z","flipYandZ")


client.settings.addCategory("Voxeliser")

visual = true
client.settings.addBool("Visualise once voxelised","visual")

snapRotations =false
client.settings.addBool("Snap rotations to grid (cubes can't be half way between two blocks)","snapRotations")

client.settings.addFunction("Clear visualisation", "clearVisualisation", "Clear")

amVisualisingKey = KeyCodes.KeyV
client.settings.addKeybind("Toggle visuals","amVisualisingKey")
amVisualising = true

clearVisualisationKey = KeyCodes.Delete
client.settings.addKeybind("Clear visualisation","clearVisualisationKey")

placeVisualisationKey = KeyCodes.Home
client.settings.addKeybind("Place visualisation","placeVisualisationKey")

moveVisualPosX = KeyCodes.UpArrow
client.settings.addKeybind("Move visual +x","moveVisualPosX")

moveVisualNegX = KeyCodes.DownArrow
client.settings.addKeybind("Move visual -x","moveVisualNegX")

moveVisualPosY = KeyCodes.PageUp
client.settings.addKeybind("Move visual +y","moveVisualPosY")

moveVisualNegY = KeyCodes.PageDown
client.settings.addKeybind("Move visual -y","moveVisualNegY")

moveVisualPosZ = KeyCodes.UpArrow
client.settings.addKeybind("Move visual +z","moveVisualPosZ")

moveVisualNegZ = KeyCodes.DownArrow
client.settings.addKeybind("Move visual -z","moveVisualNegZ")

rotVisualPosY = KeyCodes.KeyO
client.settings.addKeybind("Rotate visual +yaw","rotVisualPosY")

rotVisualNegY = KeyCodes.KeyP
client.settings.addKeybind("Rotate visual -yaw","rotVisualNegY")

rotVisualPosP = KeyCodes.KeyI
client.settings.addKeybind("Rotate visual +pitch","rotVisualPosP")

rotVisualNegP = KeyCodes.KeyK
client.settings.addKeybind("Rotate visual -pitch","rotVisualNegP")

rotVisualPosR = KeyCodes.KeyU
client.settings.addKeybind("Rotate visual +roll","rotVisualPosR")

rotVisualNegR = KeyCodes.KeyJ
client.settings.addKeybind("Rotate visual -roll","rotVisualNegR")

someText = "You can rotate the visual by 90 degrees by holding shift"
client.settings.addInfo("someText")


client.settings.stopCategory()

workingDir = "RoamingState\\OnixClient\\Scripts\\Data"

local function printTable(t)
    for key, value in pairs(t) do
        if type(value) == "table" then
            print(key .. ":")
            printTable(value)
        else
            print(key .. " = " .. tostring(value))
        end
    end
end

function round(num)
    return math.floor(num + 0.5)
end

local function mysplit(inputstr, sep)
    if sep == nil then
      sep = "%s"
    end
    local t = {}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
      table.insert(t, tonumber(str))
    end
    return t
end


function moveRenderQueue (x,y,z)
    for i = 1, #renderQueueVar do
        local curCube = renderQueueVar[i]
        if curCube == nil then else
            curCube.x = curCube.x + x
            curCube.y = curCube.y + y
            curCube.z = curCube.z + z
        end
    end
end

function moveQueueToOrigin()
    local minX, minY, minZ = math.huge, math.huge, math.huge
    local maxX, maxY, maxZ = -math.huge, -math.huge, -math.huge

    for i = 1, #renderQueueVar do
        local curCube = renderQueueVar[i]
        if curCube then
            local x, y, z = curCube.x, curCube.y, curCube.z
            if x < minX then minX = x end
            if y < minY then minY = y end
            if z < minZ then minZ = z end
            if x > maxX then maxX = x end
            if y > maxY then maxY = y end
            if z > maxZ then maxZ = z end
        end
    end

    local centreX = (minX + maxX) / 2
    local centreY = (minY + maxY) / 2
    local centreZ = (minZ + maxZ) / 2
    
    local distX = 0 - centreX
    local distY = 0 - centreY
    local distZ = 0 - centreZ

    local renderQueueAtZero = renderQueueVar

    for i = 1, #renderQueueAtZero do
        local curCube = renderQueueAtZero[i]
        if curCube == nil then else
            curCube.x = curCube.x + distX
            curCube.y = curCube.y + distY
            curCube.z = curCube.z + distZ
        end
    end

    return renderQueueAtZero, distX, distY, distZ
end


function transformRenderQueue (Matrix)

    renderQueueAtZero, distX, distY, distZ = moveQueueToOrigin()

    for i = 1, #renderQueueAtZero do
        local curCube = renderQueueAtZero[i]
        if curCube == nil then else
            local cubeAsVec = Vector:new(curCube.x,curCube.y,curCube.z)
            newPos = Matrix:apply(curCube)
            curCube.x = newPos.x
            curCube.y = newPos.y
            curCube.z = newPos.z
        end
    end
    renderQueueVar = renderQueueAtZero
    moveRenderQueue(-distX,-distY,-distZ)
end

function snapQueueToGrid ()
    for i = 1, #renderQueueVar do
        local curCube = renderQueueVar[i]
        if curCube == nil then else
            curCube.x = round(curCube.x)
            curCube.y = round(curCube.y)
            curCube.z = round(curCube.z)
        end
    end
end

function render(dt)
    if moveVisualPosXtime ~= nil then
        if os.clock() - moveVisualPosXtime > 0.3 then
            if posXLastMoved == nil or os.clock() - posXLastMoved > 0.05 then
                moveRenderQueue(1, 0, 0)
                posXLastMoved = os.clock()
            end
        end
    end

    if moveVisualNegXtime ~= nil then
        if os.clock() - moveVisualNegXtime > 0.3 then
            if negXLastMoved == nil or os.clock() - negXLastMoved > 0.05 then
                moveRenderQueue(-1, 0, 0)
                negXLastMoved = os.clock()
            end
        end
    end

    if moveVisualPosYtime ~= nil then
        if os.clock() - moveVisualPosYtime > 0.3 then
            if posYLastMoved == nil or os.clock() - posYLastMoved > 0.05 then
                moveRenderQueue(0, 1, 0)
                posYLastMoved = os.clock()
            end
        end
    end

    if moveVisualNegYtime ~= nil then
        if os.clock() - moveVisualNegYtime > 0.3 then
            if negYLastMoved == nil or os.clock() - negYLastMoved > 0.05 then
                moveRenderQueue(0, -1, 0)
                negYLastMoved = os.clock()
            end
        end
    end

    if moveVisualPosZtime ~= nil then
        if os.clock() - moveVisualPosZtime > 0.3 then
            if posZLastMoved == nil or os.clock() - posZLastMoved > 0.05 then
                moveRenderQueue(0, 0, 1)
                posZLastMoved = os.clock()
            end
        end
    end

    if moveVisualNegZtime ~= nil then
        if os.clock() - moveVisualNegZtime > 0.3 then
            if negZLastMoved == nil or os.clock() - negZLastMoved > 0.05 then
                moveRenderQueue(0, 0, -1)
                negZLastMoved = os.clock()
            end
        end
    end

    if rosVisualPosY then
        if RotPosYTime == nil or os.clock() - RotPosYTime > 0.1 then
            transformRenderQueue(Matrix:newFromRot("y", math.rad(3)))
            RotPosYTime = os.clock()
        end
    end

    if rosVisualNegY then
        if RotNegYTime == nil or os.clock() - RotNegYTime > 0.1 then
            transformRenderQueue(Matrix:newFromRot("y", math.rad(-3)))
            RotNegYTime = os.clock()
        end
    end

    if rosVisualPosP then
        if RotPosPTime == nil or os.clock() - RotPosPTime > 0.1 then
            transformRenderQueue(Matrix:newFromRot("x", math.rad(3)))
            RotPosPTime = os.clock()
        end
    end

    if rosVisualNegP then
        if RotNegPTime == nil or os.clock() - RotNegPTime > 0.1 then
            transformRenderQueue(Matrix:newFromRot("x", math.rad(-3)))
            RotNegPTime = os.clock()
        end
    end

    if rosVisualPosR then
        if RotPosRTime == nil or os.clock() - RotPosRTime > 0.1 then
            transformRenderQueue(Matrix:newFromRot("z", math.rad(3)))
            RotPosRTime = os.clock()
        end
    end

    if rosVisualNegR then
        if RotNegRTime == nil or os.clock() - RotNegRTime > 0.1 then
            transformRenderQueue(Matrix:newFromRot("z", math.rad(-3)))
            RotNegRTime = os.clock()
        end
    end
end

event.listen("KeyboardInput", function(key, down)
    if gui.mouseGrabbed() then return end
    if key == amVisualisingKey then
        if down then
            amVisualising = not amVisualising
            print("Toggled")
        end
        return true
    end

    if key == placeVisualisationKey then
        for i = 1, #renderQueueVar do
            local curCube = renderQueueVar[i]
            if curCube == nil then else
                
                    -- print(curCube.colour.a)
                gfx.color( curCube.colour.r, curCube.colour.g, curCube.colour.b, curCube.colour.a)
                client.execute("execute setblock " .. curCube.x .. " " .. curCube.y .. " " .. curCube.z .. " " .. RGBtoBlock(curCube.colour.r,curCube.colour.g,curCube.colour.b))
            
            end
        end
    end


    if key == clearVisualisationKey then
        if down then
            clearVisualisation()
        end
    end

    if key == moveVisualPosX then
        if down then
            moveRenderQueue(1, 0, 0)
            moveVisualPosXtime = os.clock()
        else
            moveVisualPosXtime = nil
            posXLastMoved = nil
        end

    elseif key == moveVisualNegX then
        if down then
            moveRenderQueue(-1, 0, 0)
            moveVisualNegXtime = os.clock()
        else
            moveVisualNegXtime = nil
            negXLastMoved = nil
        end

    elseif key == moveVisualPosY then
        if down then
            moveRenderQueue(0, 1, 0)
            moveVisualPosYtime = os.clock()
        else
            moveVisualPosYtime = nil
            posYLastMoved = nil
        end

    elseif key == moveVisualNegY then
        if down then
            moveRenderQueue(0, -1, 0)
            moveVisualNegYtime = os.clock()
        else
            moveVisualNegYtime = nil
            negYLastMoved = nil
        end

    elseif key == moveVisualPosZ then
        if down then
            moveRenderQueue(0, 0, 1)
            moveVisualPosZtime = os.clock()
        else
            moveVisualPosZtime = nil
            posZLastMoved = nil
        end

    elseif key == moveVisualNegZ then
        if down then
            moveRenderQueue(0, 0, -1)
            moveVisualNegZtime = os.clock()
        else
            moveVisualNegZtime = nil
            negZLastMoved = nil
        end

    elseif key == rotVisualPosY then
        if SHIFT then
            if down then
                transformRenderQueue(Matrix:newFromRot("y", math.rad(90)))
                if snapRotations then
                    snapQueueToGrid()
                end
            end
        else
            rosVisualPosY = down
            if not down then
                if snapRotations then
                    snapQueueToGrid()
                end
            end
        end

    elseif key == rotVisualNegY then
        if SHIFT then
            if down then
                transformRenderQueue(Matrix:newFromRot("y", math.rad(-90)))
                if snapRotations then
                    snapQueueToGrid()
                end
            end
        else
            rosVisualNegY = down
            if not down then
                if snapRotations then
                    snapQueueToGrid()
                end
            end
        end

    elseif key == rotVisualPosP then
        if SHIFT then
            if down then
                transformRenderQueue(Matrix:newFromRot("x", math.rad(90)))
                if snapRotations then
                    snapQueueToGrid()
                end
            end
        else
            rosVisualPosP = down
            if not down then
                if snapRotations then
                    snapQueueToGrid()
                end
            end
        end

    elseif key == rotVisualNegP then
        if SHIFT then
            if down then
                transformRenderQueue(Matrix:newFromRot("x", math.rad(-90)))
                if snapRotations then
                    snapQueueToGrid()
                end
            end
        else
            rosVisualNegP = down
            if not down then
                if snapRotations then
                    snapQueueToGrid()
                end
            end
        end

    elseif key == rotVisualPosR then
        if SHIFT then
            if down then
                transformRenderQueue(Matrix:newFromRot("z", math.rad(90)))
                if snapRotations then
                    snapQueueToGrid()
                end
            end
        else
            rosVisualPosR = down
            if not down then
                if snapRotations then
                    snapQueueToGrid()
                end
            end
        end

    elseif key == rotVisualNegR then
        if SHIFT then
            if down then
                transformRenderQueue(Matrix:newFromRot("z", math.rad(-90)))
                if snapRotations then
                    snapQueueToGrid()
                end
            end
        else
            rosVisualNegR = down
            if not down then
                if snapRotations then
                    snapQueueToGrid()
                end
            end
        end
    end

    if key == KeyCodes.Shift then
        SHIFT = down
    end
end)

registerCommand("loadModel", function (arguments)
    local intellisenseHelper = MakeIntellisenseHelper(arguments)
    local parser = intellisenseHelper:addOverload()


    local modelPath = parser:matchString("model",false)
    if modelPath == nil then
        print("§cModel path is required!")
        return
    end

    local texturePath = parser:matchString("texture")
    if texturePath == nil or texturePath == "" then
        print("§cNo texture, with assume blank texture")
        texturePath = "blank.png"
    end

    loadModel(modelPath,texturePath)
end, 

function (intellisense)
    local overload = intellisense:addOverload()
    overload:matchString("model",false)
    overload:matchString("texture", true)
end, "Loads in a 3d model")


blankIntellisense = function (intellisense)
end

registerCommand("buildFromVis", function (arguments)
    snapQueueToGrid()


    for i = 1, #renderQueueVar do
        local curCube = renderQueueVar[i]
        if curCube == nil then else
            
                -- print(curCube.colour.a)
            gfx.color( curCube.colour.r, curCube.colour.g, curCube.colour.b, curCube.colour.a)
            client.execute("execute setblock " .. curCube.x .. " " .. curCube.y .. " " .. curCube.z .. " " .. RGBtoBlock(curCube.colour.r,curCube.colour.g,curCube.colour.b))
        
        end
    end
    
end, blankIntellisense, "Builds the visualisation in the world")



function loadModel(objPath,texPath)
    local objFile = io.open(objPath)

    local startTime = os.clock()
    
    local texture = gfx2.loadImage(texPath)

    if objFile == nil then
        error(objPath .. " is non-existant make sure you end the filename in .obj")
    end
    if texture == nil then
       error(texPath .. " is non-existant make sure you end the filename in .obj") 
    end

    

    local verts = {}
    local vertexTextures = {}
    local faces = {}

    local minBound = {x=0, y=0, z=0}
    local maxBound = {x=0, y=0, z=0}
    local size = {x=0, y=0, z=0}

    -- iterate over the obj file
    --         find the x,y,z values
    --         convert them to numbers
    --         maintain a min and max bound we'll use later to move the model to the origin
    --         add each processed vert to an array we'll use later
    for line in objFile:lines() do

        local lineType = line:sub(1,2)

        local lineIsVT = lineType == "vt"
        local lineIsVert = lineType == "v "
        local lineIsFace = lineType == "f "

        if lineIsVert then
            -- find the x,y,z values
            local x, y, z = string.match(line, "v%s+([-%d.]+[eE]?[-%d]*)%s+([-%d.]+[eE]?[-%d]*)%s+([-%d.]+[eE]?[-%d]*)") -- added support for scientific notation eg. v -0.246974 -1.025859E-05 0.175563


            if x == nil or y == nil or z == nil then print("failed on vertex line " .. line) end

            -- convert them to numbers from strings
            x = tonumber(x)
            y = tonumber(y)
            z = tonumber(z)

            -- maintain a min and max bound we'll use later to move the model to the origin
            if (x > maxBound.x) then maxBound.x = x end
            if (y > maxBound.y) then maxBound.y = y end
            if (z > maxBound.z) then maxBound.z = z end

            if (x < minBound.x) then minBound.x = x end
            if (y < minBound.y) then minBound.y = y end
            if (z < minBound.z) then minBound.z = z end

            -- add each vert to an array we'll use later
            verts[#verts+1] = {x=x, y=y, z=z}

        elseif lineIsVT then
            -- TODO: we need to make this deal with 3 element vertexes textures too
            local x, y, z = string.match(line, "vt%s+([-%d.]+[eE]?[-%d]*)%s+([-%d.]+[eE]?[-%d]*)") -- made this support scientific notation
            --print("x: ", x, "y: ", y)
            -- convert them to numbers from strings
            x = tonumber(x)
            y = tonumber(y)
            vertexTextures[#vertexTextures+1] = {x=x,y=y}
            --print("vertexTextures["..#vertexTextures.."] x: ", x, "y: ", y)
        
        
        elseif lineIsFace then
            local v, t, normToDo = {}, {}, {}
            local counter = 0
            for vertex, tex, norm in line:gmatch("(-?%d+)/(-?%d+)/?(-?%d*)") do
                counter = counter + 1
                
                -- Convert to numbers
                local vIndex = tonumber(vertex)
                local tIndex = tonumber(tex)
                local nIndex = tonumber(norm)
                
                -- Convert negative indices to positive indices.
                -- Negative numbers in faces reference things from the back of verts

                if nIndex == nil then nIndex = 0 end

                if vIndex < 0 then
                    vIndex = #verts + vIndex + 1
                end
                if tIndex < 0 then
                    tIndex = #vertexTextures + tIndex + 1
                end
        
                table.insert(v, vIndex)
                table.insert(t, tIndex)
                table.insert(normToDo, nIndex)
            end
            if #v == 3 then
                faces[#faces+1] = {v=v, t=t, n=normToDo}
            elseif #v == 4 then -- if the face is a quad, split it into two triangles and add to the faces array
                faces[#faces+1] = {v={v[1], v[2], v[3]}, t={t[1], t[2], t[3]}, n={normToDo[1], normToDo[2], normToDo[3]}}
                faces[#faces+1] = {v={v[1], v[3], v[4]}, t={t[1], t[3], t[4]}, n={normToDo[1], normToDo[3], normToDo[4]}}
            elseif #v >4 or #v < 3 then
                print("make sure your model is made of tris or quads") 
            end
        end
    end



    -- compute the size of the model on each axis
    size.x = maxBound.x - minBound.x
    size.y = maxBound.y - minBound.y
    size.z = maxBound.z - minBound.z

    -- find the largest axis, we'll use this to scale the model to fit the desired voxel model size
    local largestAxis = math.max(size.x, size.y, size.z)

    -- target voxel model output size
    

    -- compute a naumber that scales the model verts to desired
    -- voxel model size
    local modelToVoxelRatio = voxelModelSize/largestAxis

    
    verts = scale_and_move_verts(verts, minBound, modelToVoxelRatio)

    local r_channel = {}
    local g_channel = {}
    local b_channel = {}

    for y = 1, texture.height do
        r_channel[y] = {}
        g_channel[y] = {}
        b_channel[y] = {}
        for x = 1, texture.width do 
            r_channel[y][x] = texture:getPixel(x,y).r
            g_channel[y][x] = texture:getPixel(x,y).g
            b_channel[y][x] = texture:getPixel(x,y).b
        end
    end

    print("§aRead object and texture files in §f" .. os.clock() - startTime .. "§a seconds")
    print("§aFound §f" .. #verts .. "§a vertexes and §f" .. #vertexTextures .. "§a vertex textures and §f" .. #faces .. "§a faces")


    local uniqueVoxels, uniqueVoxelColors, uniqueCount = coloured_voxelise_obj(verts, vertexTextures, faces, r_channel, g_channel, b_channel)

    print("§aVoxelised model in §f" .. os.clock() - startTime .. "§a seconds")

    if uniqueVoxels == nil then error("uniqueVoxels = nil") end
    if uniqueVoxelColors == nil then error("uniqueVoxelColors = nil") end
    
    -- print("length uniqueVoxelColors = ".. #uniqueVoxelColors)
    for key, voxelCol in pairs(uniqueVoxelColors) do
        local x = uniqueVoxels[key].x   
        local y = uniqueVoxels[key].y
        local z = uniqueVoxels[key].z
        local r = voxelCol.r
        local g = voxelCol.g
        local b = voxelCol.b
        local block = RGBtoBlock(r,g,b)

        pX, pY, pZ = player.position()
        
        if dimension.getBlock(x + pX,y+pY,z+pZ).name == block then else
            if flipYandZ then
                if visual then
                    addCube(x + pX, z + pY, y + pZ, {r=r,g=g,b=b,a=125}, math.huge)
                else
                    client.execute("execute setblock " .. x + pX  .. " " .. z + pY.. " " .. y+pZ.. " " .. block)
                end
            else
                if visual then 
                    addCube(x + pX, y + pY, z + pZ, {r=r,g=g,b=b,a=125}, math.huge)
                else
                    client.execute("execute setblock " .. x + pX  .. " " .. y + pY.. " " .. z+pZ.. " " .. block)
                end
                
            end
            
            if y +pY < -64 then print("§cModel below world")  end
        end

        
    end

    print("§aBulit in §f" .. os.clock() - startTime .. "§a seconds")

    if visual then
        client.notification("Visualisation is enabled, press the configured key to toggle it, or do .buildFromVis, to place it")
    end
    texture:unload()
    objFile:close()
end

function render3d (dt)
    if amVisualising then
        renderQueue(dt)
    end
end
