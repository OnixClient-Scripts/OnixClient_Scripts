name = "Voxeliser"
description = "Has the command 'load model' which takes in a .obj file with one texture file (no materials) and places it in minecraft"

importLib("BlockRGB.lua")
importLib("geometryLib.lua")

voxelModelSize = 100
client.settings.addInt("Model size","voxelModelSize",10,1000)

flipYandZ = true
client.settings.addBool("Flip Y and Z","flipYandZ")



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


registerCommand("loadModel", function (arguments)
    local intellisenseHelper = MakeIntellisenseHelper(arguments)
    local parser = intellisenseHelper:addOverload()


    local modelPath = parser:matchString("model",false)
    if modelPath == nil then
        print("§cModel number is required!")
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




function loadModel(objPath,texPath)
    local objFile = io.open(objPath)

   
    
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

    print("Found " .. #verts .. " vertexes and " .. #vertexTextures .. " vertex textures and " .. #faces .. " faces")


    local uniqueVoxels, uniqueVoxelColors, uniqueCount = coloured_voxelise_obj(verts, vertexTextures, faces, r_channel, g_channel, b_channel)


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
                client.execute("execute setblock " .. x + pX  .. " " .. z + pY.. " " .. y+pZ.. " " .. block)        
            else
                client.execute("execute setblock " .. x + pX  .. " " .. y + pY.. " " .. z+pZ.. " " .. block)
            end
            
            if y +pY < -64 then print("Model below world") end
        end

        
    end



    texture:unload()
    objFile:close()
end
