function cross_product(v1, v2)
    return {x = v1.y * v2.z - v1.z * v2.y, y = v1.z * v2.x - v1.x * v2.z, z = v1.x * v2.y - v1.y * v2.x}
end

function dot_product(v1, v2)
    return v1.x * v2.x + v1.y * v2.y + v1.z * v2.z
end

function l2norm(v)
    return math.sqrt(v.x * v.x + v.y * v.y + v.z * v.z)
end

function subtract_vectors(v1, v2)
    if v1.z == nil and v2.z==nil then
        return {x = v1.x - v2.x, y = v1.y - v2.y}
    else 
        return {x= v1.x - v2.x,  y=v1.y - v2.y,  z=v1.z - v2.z}
    end
end

function add_vectors(v1, v2)
    if v1.z == nil and v2.z==nil then
        return { x = v1.x + v2.x, y = v1.y + v2.y}
    else
        return { x = v1.x + v2.x, y = v1.y + v2.y, z = v1.z + v2.z }
    end
end

function scale_vector(v, scale)
    if v.z == nil then 
        return { x = v.x * scale, y = v.y * scale}
    else
        return { x = v.x * scale, y = v.y * scale, z = v.z * scale }
    end
end

function get_triangle_edges(triangle)
    local edges = {}
    table.insert(edges, {x = triangle.v2.x - triangle.v1.x, y = triangle.v2.y - triangle.v1.y, z = triangle.v2.z - triangle.v1.z})
    table.insert(edges, {x = triangle.v3.x - triangle.v2.x, y = triangle.v3.y - triangle.v2.y, z = triangle.v3.z - triangle.v2.z})
    table.insert(edges, {x = triangle.v1.x - triangle.v3.x, y = triangle.v1.y - triangle.v3.y, z = triangle.v1.z - triangle.v3.z})
    return edges
end

local function get_triangle_normals(triangle)
    local triangle_edges = get_triangle_edges(triangle)
    return {cross_product(triangle_edges[1], triangle_edges[2])}
end


function scale_and_move_verts(verts, minBound, modelToVoxelRatio)
    local x,y,z
    local uniqueVoxels = {}
    local uniqueCount = 0

    -- for each vert in the model
    for i, vert in ipairs(verts) do
        -- we don't want negative values, so translate the vert so that the smallest value on each axis is at 0,0,0
        x = vert.x + -minBound.x
        y = vert.y + -minBound.y
        z = vert.z + -minBound.z

        -- scale the vert position so that the largest value on the largest axis fits within our desired voxel model size
        x = x * modelToVoxelRatio
        y = y * modelToVoxelRatio
        z = z * modelToVoxelRatio
        verts[i] = {x=x, y=y, z=z}
        --print("verts["..i.."] x: ", x, "y: ", y, "z: ", z)
    end
    return verts
end


local function printTable(t)
    if type(t) ~= "table" then
        print(t)
        return
    end
    for key, value in pairs(t) do
        if type(value) == "table" then
            print(key .. ":")
            printTable(value)
        else
            print(key .. " = " .. tostring(value))
        end
    end
end


function test_AABB_triangle_intersection(triangle, AABB_min)
    local function separating_axis_theorem(AABB_min, AABB_max, triangle)
        local function get_AABB_axis()
            local x_axis = {x = 1, y = 0, z = 0}
            local y_axis = {x = 0, y = 1, z = 0}
            local z_axis = {x = 0, y = 0, z = 1}
            return {x_axis, y_axis, z_axis}
        end

        local function get_cross_products(axes1, axes2)
            local cross_products = {}
            for i, axis1 in ipairs(axes1) do
                for j, axis2 in ipairs(axes2) do
                    table.insert(cross_products, cross_product(axis1, axis2))
                end
            end
            return cross_products
        end

        local function project_points(points, axis)
            local ret = {}
            for i = 1, #points do
                ret[i] = dot_product(points[i], axis)
            end
            return ret
        end
        
        local function overlap_intervals(interval1, interval2)
            return interval1[1] <= interval2[2] and interval2[1] <= interval1[2]    
        end

        local AABB_axes = get_AABB_axis()
        local triangle_edges = get_triangle_edges(triangle)
        local triangle_normals = get_triangle_normals(triangle)
        local cross_products = get_cross_products(AABB_axes, triangle_edges)

        local axes_to_test = {}
        for _, axes in pairs(AABB_axes) do
            table.insert(axes_to_test, axes)
        end
        for _, axes in pairs(triangle_normals) do
            table.insert(axes_to_test, axes)
        end
        for _, axes in pairs(cross_products) do
            table.insert(axes_to_test, axes)
        end

        AABB_points = {
            {x = AABB_min.x, y = AABB_min.y, z = AABB_min.z},--0
            {x = AABB_max.x, y = AABB_min.y, z = AABB_min.z},--1
            {x = AABB_min.x, y = AABB_max.y, z = AABB_min.z},--2
            {x = AABB_min.x, y = AABB_min.y, z = AABB_max.z},--3
            {x = AABB_max.x, y = AABB_max.y, z = AABB_min.z},--4
            {x = AABB_max.x, y = AABB_min.y, z = AABB_max.z},--5
            {x = AABB_min.x, y = AABB_max.y, z = AABB_max.z},--6
            {x = AABB_max.x, y = AABB_max.y, z = AABB_max.z}--7
        }

        for i, axis in ipairs(axes_to_test) do
            local mag = l2norm(axis)
            if mag < 1e-6 then
                --print("Axis is zero")
            else
                local scaled_axis = {x=axis.x/mag , y=axis.y / mag, z=axis.z/mag}

                local AABB_proj = project_points(AABB_points, scaled_axis)

                local triangle_proj = project_points({triangle.v1, triangle.v2, triangle.v3}, scaled_axis)

                local AABB_interval = {math.min(table.unpack(AABB_proj)), math.max(table.unpack(AABB_proj))}
                local triangle_interval = {math.min(table.unpack(triangle_proj)), math.max(table.unpack(triangle_proj))}
                if not overlap_intervals(AABB_interval, triangle_interval) then
                    return false
                end
            end
        end

        return true
    end

    local AABB_max = {x = AABB_min.x + 1, y = AABB_min.y + 1, z = AABB_min.z + 1}
    --print("AABB_min: ", AABB_min.x, AABB_min.y, AABB_min.z)
    --print("AABB_max: ", AABB_max.x, AABB_max.y, AABB_max.z)
    return separating_axis_theorem(AABB_min, AABB_max, triangle)
    
end

function barycentric_positions(triangle, point)
    -- see https://www.geogebra.org/m/ZuvmPjmy
    local v2 = subtract_vectors(point, triangle.v1) 
    -- printTable(v2)
    local triangle_edges = {}
    triangle_edges[1] = subtract_vectors(triangle.v3, triangle.v1)
    triangle_edges[2] = subtract_vectors(triangle.v2, triangle.v1)
    -- Compute dot products
    local d00 = dot_product(triangle_edges[1], triangle_edges[1])
    local d01 = dot_product(triangle_edges[1], triangle_edges[2])
    local d11 = dot_product(triangle_edges[2], triangle_edges[2])
    local d20 = dot_product(v2, triangle_edges[1])
    local d21 = dot_product(v2, triangle_edges[2])
    -- print("d00: " .. d00)
    -- print("d01: " .. d01)
    -- print("d11: " .. d11)
    -- print("d20: " .. d20)
    -- print("d21: " .. d21)    
    -- Compute barycentric coordinates
    local denom = d00 * d11 - d01 * d01
    -- print(denom)
    -- print("Denom: ", denom)
    if denom == 0 then
        do return false end  -- Degenerate triangle
    end
    local gamma  = (d11 * d20 - d01 * d21) / denom
    local beta  = (d00 * d21 - d01 * d20) / denom
    local alpha  = 1 - gamma - beta
    return {alpha=alpha, beta=beta, gamma=gamma}
end

function closest_point_in_triangle_3d(triangle, P)
    local A, B, C = triangle.v1, triangle.v2, triangle.v3
    local function project_point_on_line_segment(P, A, B)
        local AB = subtract_vectors(B, A)
        local AP = subtract_vectors(P, A)
        local t = dot_product(AP, AB) / dot_product(AB, AB)
        t = math.max(0, math.min(1, t))
        return {x=A.x + t * AB.x, y=A.y + t * AB.y, z = A.z + t * AB.z}
    end

    local function is_point_in_triangle_3d (triangle, P)
        local bry_pos = barycentric_positions(triangle, P)
        -- check in alpha, beta and gamma are all positive
        if not bry_pos then
            do return false end
        end
        local u, v, w = bry_pos.alpha, bry_pos.beta, bry_pos.gamma
        return u >= 0 and v >= 0 and w >= 0
    end

    local function closest_point_on_triangle_face(triangle, P)
        local normal = get_triangle_normals(triangle)[1]
        normal = scale_vector(normal, 1/l2norm(normal))
        local AP = subtract_vectors(P, triangle.v1)
        -- printTable(normal)
        local distance_to_plane = dot_product(AP, normal)
        -- print(distance_to_plane)
        -- printTable(P)
        local projection = subtract_vectors(P, scale_vector(normal, distance_to_plane))
        if is_point_in_triangle_3d(triangle, projection) then
            do return projection end
        end
        return nil
    end

    -- Check if projection of P onto the triangle's plane is inside the triangle
    local point_on_face = closest_point_on_triangle_face(triangle, P)
    -- printTable(point_on_face)
    if point_on_face  ==  nil then else
        -- print("Closest point is on face")
        return point_on_face
    end
    local closest_on_AB = project_point_on_line_segment(P, triangle.v1, triangle.v2)
    local closest_on_BC = project_point_on_line_segment(P, triangle.v2, triangle.v3)
    local closest_on_CA = project_point_on_line_segment(P, triangle.v3, triangle.v1)

    local closest_points = {closest_on_AB, closest_on_BC, closest_on_CA}
    local distances = {}
    for pointCount = 1, #closest_points do
        local point = closest_points[pointCount]
        distances[#distances+1] = l2norm(subtract_vectors(P, point))
    end

    local minDistance = math.huge 
    local minDistanceIndex = nil
    for i = 1, #closest_points do 
        if distances[i] < minDistance then
            minDistance = distances[i]
            minDistanceIndex = i
        end
    end
    return closest_points[minDistanceIndex]
end

function getUVFromPoint(point, triVerts, triUVs)
    local vertA, vertB, vertC = triVerts["v1"], triVerts["v2"], triVerts["v3"]  -- Get the three corners of the triangle
    local uvA, uvB, uvC = triUVs["v1"], triUVs["v2"], triUVs["v3"]             -- Get the UV coordinates at each corner

    local bry_pos = barycentric_positions(triVerts, point)

    assert(bry_pos, "Point is not in triangle")
    -- print("alpha = " .. bry_pos.alpha, "beta = " .. bry_pos.beta, "gamma = " .. bry_pos.gamma, "sum = " .. bry_pos.alpha + bry_pos.beta + bry_pos.gamma)

    local uvAlpha = scale_vector(uvA, bry_pos.alpha)
    local uvBeta = scale_vector(uvB, bry_pos.beta)
    local uvGamma = scale_vector(uvC, bry_pos.gamma)
    -- print("uvAlpha: ", uvAlpha.x, uvAlpha.y, uvAlpha.z)
    -- print("uvBeta: ", uvBeta.x, uvBeta.y, uvBeta.z)
    -- print("uvGamma: ", uvGamma.x, uvGamma.y, uvGamma.z)
    --printTable(add_vectors(add_vectors(uvAlpha, uvBeta), uvGamma))
    return add_vectors(add_vectors(uvAlpha, uvBeta), uvGamma)
end

function getTextureColor(x, y, r_channel, g_channel, b_channel)
    -- print(x,y)
    x = math.min(math.floor(x * #r_channel[1])+1, #r_channel[1])
    y = math.min(math.floor(y * #r_channel[1])+1, #r_channel[1])
    -- print(x,y)
    local r = r_channel[y][x]
    local g = g_channel[y][x]
    local b = b_channel[y][x]
    return {r=r, g=g, b=b}
end


function coloured_voxelise_obj(verts, vertexTextures, faces, r_channel, g_channel, b_channel) 
    -- helper function to make a unique key from x,y,z input
    local function makeVertexKey(x, y, z)
        return string.format("%d,%d,%d", x, y, z)
    end
    -- helper function to round a number
    local function rd(num)
        return math.floor(num)
    end
    local function ru(num)
        return math.ceil(num)
    end

    local uniqueVoxels = {}
    local repeatVoxelsCount = 0
    local uniqueVoxelColors = {}
    local uniqueCount = 0

    for  i, face in ipairs(faces) do
        local v = face.v
        local t = face.t
        local n = face.n
        local triangle = {}
        triangle["v1"] = {x=verts[v[1]].x,y=verts[v[1]].y,z=verts[v[1]].z}
        triangle["v2"] = {x=verts[v[2]].x,y=verts[v[2]].y,z=verts[v[2]].z}
        triangle["v3"] = {x=verts[v[3]].x,y=verts[v[3]].y,z=verts[v[3]].z}
        --print("triangle ", i, "v1: ", triangle["v1"].x, triangle["v1"].y, triangle["v1"].z)
        --print("triangle ", i, "v2: ", triangle["v2"].x, triangle["v2"].y, triangle["v2"].z)
        --print("triangle ", i, "v3: ", triangle["v3"].x, triangle["v3"].y, triangle["v3"].z)
        -- round down to get the min vertex of the triangle
        local facemin = {x=math.max(0, rd(math.min(triangle["v1"].x, triangle["v2"].x, triangle["v3"].x))), 
                         y=math.max(0, rd(math.min(triangle["v1"].y, triangle["v2"].y, triangle["v3"].y))),
                         z=math.max(0, rd(math.min(triangle["v1"].z, triangle["v2"].z, triangle["v3"].z)))}
        -- round up to get the max vertex of the triangle and make sure it is at least 1
        local facemax = {x=math.max(facemin.x+1, ru(math.max(triangle["v1"].x, triangle["v2"].x, triangle["v3"].x))),
                         y=math.max(facemin.y+1, ru(math.max(triangle["v1"].y, triangle["v2"].y, triangle["v3"].y))),
                         z=math.max(facemin.z+1, ru(math.max(triangle["v1"].z, triangle["v2"].z, triangle["v3"].z)))}
        --print("facemin x: ", facemin.x, "y: ", facemin.y, "z: ", facemin.z)
        --print("facemax x: ", facemax.x, "y: ", facemax.y, "z: ", facemax.z)
        -- print("verts ", v[1], v[2], v[3])
        -- print("texture verts ", t[1], t[2], t[3])
        local uvTriangle = {}
        uvTriangle["v1"] = {x=vertexTextures[t[1]].x, y=vertexTextures[t[1]].y}
        uvTriangle["v2"] = {x=vertexTextures[t[2]].x, y=vertexTextures[t[2]].y}
        uvTriangle["v3"] = {x=vertexTextures[t[3]].x, y=vertexTextures[t[3]].y}
        -- print("vt[1]=", vertexTextures[t[1]].x, vertexTextures[t[1]].y)
        -- print("vt[2]=", vertexTextures[t[2]].x, vertexTextures[t[2]].y)
        -- print("vt[3]=", vertexTextures[t[3]].x, vertexTextures[t[3]].y)
        
        for x = facemin.x, facemax.x do
            for y = facemin.y, facemax.y do
                for z = facemin.z, facemax.z do
                AABB_min = {x = x, y = y, z = z}
                    local result = test_AABB_triangle_intersection(triangle, AABB_min)  
                    if result then
                        -- make a unique key for this vert
                        local key = makeVertexKey(x,y,z)
                        -- if we haven't seen this vert before, add it to our output set
                        -- keep track of how many voxel positions we have just for debugging purposes
                        if not uniqueVoxels[key] then
                            --print("unique voxel x: ", x, "y: ", y, "z: ", z)
                            uniqueVoxels[key] = {x=x, y=y, z=z}
                            uniqueCount = uniqueCount + 1
                            local voxel_center = {x = x + 0.5, y = y + 0.5, z = z + 0.5}
                            -- print("voxel center x: ", voxel_center.x, "y: ", voxel_center.y, "z: ", voxel_center.z)
                            local closest_point = closest_point_in_triangle_3d(triangle, voxel_center)
                            local uv = getUVFromPoint(closest_point, triangle, uvTriangle)
                            -- print("UV ---->", uv.x, uv.y)
                            uniqueVoxelColors[key] = getTextureColor(uv.x, 1-uv.y, r_channel, g_channel, b_channel)
                            -- print(uniqueVoxelColors[key].r .. " " .. uniqueVoxelColors[key].g .. " " .. uniqueVoxelColors[key].b)
                        else
                            -- if we have seen this vert before, increment the count
                            -- this is useful for debugging purposes
                            repeatVoxelsCount = repeatVoxelsCount + 1
                            --print("repeat voxel x: ", x, "y: ", y, "z: ", z)
                        end
                    end
                end
            end
        end 
    end   
    return uniqueVoxels, uniqueVoxelColors, uniqueCount
end
