-- Made By O2Flash20 🙂

vec = {}

function vec:new(...)
    local newVec = {}

    setmetatable(newVec, self)
    self.__index = self

    local args = { ... }
    if type(args[1]) == "table" then
        newVec.components = args[1]
    else
        newVec.components = args
    end

    newVec:updateComponentNames()

    return newVec
end

function vec:random(dimensions, magnitude)
    local components = {}
    for i = 1, dimensions do
        table.insert(components, math.random())
    end

    return vec:new(components):setMag(magnitude)
end

function vec:fromAngle(magnitude, yaw, pitch)
    if pitch then
        newVec = vec:new(magnitude, 0, 0):setDir(yaw, pitch)
    else
        newVec = vec:new(magnitude, 0):setDir(yaw)
    end

    return newVec
end

function vec:magSq()
    local output = 0
    for i = 1, #self.components, 1 do
        output = output + self.components[i] ^ 2
    end

    return output
end

function vec:mag()
    return math.sqrt(self:magSq())
end

function vec:set(...)
    local args = { ... }
    self.components = args
    self:updateComponentNames()

    return self
end

function vec:setMag(magnitude)
    self:normalize():mult(magnitude)

    self:updateComponentNames()
    return self
end

function vec:setComponent(component, value)
    if type(component) == "number" then
        self.components[component] = value
    elseif type(component) == "string" then
        local componentNames = { "xyzw", "rgba", "uv" }

        for i = 1, #componentNames do
            for j = 1, #componentNames[i] do
                if componentNames[i]:sub(j, j) == component then
                    self.components[j] = value
                end
            end
        end
    end

    self:updateComponentNames()
    return self
end

function vec:add(otherVec)
    local leastComponents = math.min(#self.components, #otherVec.components)
    for i = 1, leastComponents, 1 do
        self.components[i] = self.components[i] + otherVec.components[i]
    end

    self:updateComponentNames()
    return self
end

function vec:sub(otherVec)
    local leastComponents = math.min(#self.components, #otherVec.components)
    for i = 1, leastComponents, 1 do
        self.components[i] = self.components[i] - otherVec.components[i]
    end

    self:updateComponentNames()
    return self
end

-- creates a copy of a table, removing the reference to the original
function deepCopy(orig)
    local copy
    if type(orig) == 'table' then
        copy = {}
        for key, value in pairs(orig) do
            copy[deepCopy(key)] = deepCopy(value)
        end
        setmetatable(copy, deepCopy(getmetatable(orig)))
    else
        copy = orig
    end
    return copy
end

function vec:copy()
    local c = deepCopy(self.components)
    newVec = vec:new(c)
    return newVec
end

function vec:updateComponentNames()
    local componentNames = { "xyzw", "rgba", "uv" }

    for i = 1, #componentNames, 1 do
        for j = 1, #componentNames[i], 1 do
            self[componentNames[i]:sub(j, j)] = self.components[j]
        end
    end

    return self
end

function vec:dimensions()
    return #self.components
end

function vec:mult(multiplier)
    if type(multiplier) == "number" then
        for i = 1, #self.components do
            self.components[i] = self.components[i] * multiplier
        end
    else
        local leastComponents = math.min(#self.components, #multiplier.components)
        for i = 1, leastComponents, 1 do
            self.components[i] = self.components[i] * multiplier.components[i]
        end
    end

    self:updateComponentNames()
    return self
end

function vec:div(divisor)
    if type(divisor) == "number" then
        for i = 1, #self.components do
            self.components[i] = self.components[i] / divisor
        end
    else
        local leastComponents = math.min(#self.components, #divisor.components)
        for i = 1, leastComponents, 1 do
            self.components[i] = self.components[i] / divisor.components[i]
        end
    end

    self:updateComponentNames()
    return self
end

function vec:rem(divisor)
    if type(divisor) == "number" then
        for i = 1, #self.components do
            self.components[i] = self.components[i] % divisor
        end
    else
        local leastComponents = math.min(#self.components, #divisor.components)
        for i = 1, leastComponents, 1 do
            self.components[i] = self.components[i] % divisor.components[i]
        end
    end

    self:updateComponentNames()
    return self
end

function vec:dot(otherVec)
    local output = 0
    local leastComponents = math.min(#self.components, #otherVec.components)
    for i = 1, leastComponents do
        output = output + (self.components[i] * otherVec.components[i])
    end

    return output
end

function vec:cross(otherVec)
    if #self.components == 3 and #otherVec.components == 3 then
        local x = self.y * otherVec.z - self.z * otherVec.y
        local y = self.z * otherVec.x - self.x * otherVec.z
        local z = self.x * otherVec.y - self.y * otherVec.x

        return vec:new(x, y, z)
    else
        error("vec:cross() requires 2 3D vectors!")
    end
end

function vec:dist(otherVec)
    local leastComponents = math.min(#self.components, #otherVec.components)
    local output = 0
    for i = 1, leastComponents do
        output = output + (self.components[i] - otherVec.components[i]) ^ 2
    end

    return math.sqrt(output)
end

function vec:normalize()
    local length = self:mag()
    for i = 1, #self.components do
        self.components[i] = self.components[i] / length
    end

    self:updateComponentNames()
    return self
end

function vec:limit(max)
    if self:magSq() > max ^ 2 then
        self:setMag(max)
    end

    self:updateComponentNames()
    return self
end

function vec:dir()
    if self:dimensions() == 2 then
        return math.atan(self.y, self.x)
    end

    if self:dimensions() == 3 then
        local pitch = math.atan(self.y, math.sqrt((self.x ^ 2 + self.z ^ 2)))
        local yaw = math.atan(self.z, self.x)
        return { yaw, pitch }
    end

    return 0
end

function vec:setDir(yaw, pitch)
    local mag = self:mag()

    if self:dimensions() == 2 then
        self:set(mag * math.cos(yaw), mag * math.sin(yaw))
    end

    if self:dimensions() == 3 then
        local y = mag * math.sin(pitch)

        local xzMag = mag * math.cos(pitch)
        local x = xzMag * math.cos(yaw)
        local z = xzMag * math.sin(yaw)

        self:set(x, y, z)
    end

    self:updateComponentNames()
    return self
end

-- might not actually work sometimes, better to use rotatePitch rotateRoll
function vec:rotate(yaw, pitch)
    if self:dimensions() == 2 then
        local previousRot = self:dir()
        self:setDir(previousRot + yaw)
    end

    if self:dimensions() == 3 then
        local previousRot = self:dir()
        if previousRot[1] < 0 then pitch = -pitch end --past "straight up", increasing pitch means going back down
        self:setDir(previousRot[1] + yaw, previousRot[2] + pitch)
    end

    self:updateComponentNames()
    return self
end

function vec:rotatePitch(angle)
    if self:dimensions() == 2 then
        self:set(
            self.x * math.cos(angle) - self.y * math.sin(angle),
            self.x * math.sin(angle) + self.y * math.cos(angle)
        )
    end

    if self:dimensions() == 3 then
        self:set(
            self.x,
            self.y * math.cos(angle) - self.z * math.sin(angle),
            self.y * math.sin(angle) + self.z * math.cos(angle)
        )
    end

    self:updateComponentNames()
    return self
end

function vec:rotateYaw(angle)
    if self:dimensions() == 2 then
        self:set(
            self.x * math.cos(angle) - self.y * math.sin(angle),
            self.x * math.sin(angle) + self.y * math.cos(angle)
        )
    end

    if self:dimensions() == 3 then
        self:set(
            self.x * math.cos(angle) + self.z * math.sin(angle),
            self.y,
            -self.x * math.sin(angle) + self.z * math.cos(angle)
        )
    end

    self:updateComponentNames()
    return self
end

function vec:rotateRoll(angle)
    if self:dimensions() == 2 then
        self:set(
            self.x * math.cos(angle) - self.y * math.sin(angle),
            self.x * math.sin(angle) + self.y * math.cos(angle)
        )
    end

    if self:dimensions() == 3 then
        self:set(
            self.x * math.cos(angle) - self.y * math.sin(angle),
            self.x * math.sin(angle) - self.y * math.cos(angle),
            self.z
        )
    end

    self:updateComponentNames()
    return self
end

function vec:angleBetween(otherVec)
    if self:dimensions() == 2 and otherVec:dimensions() == 2 then
        return self:dir() - otherVec:dir()
    end

    if self:dimensions() == 3 and otherVec:dimensions() == 3 then
        local selfA = self:dir()
        local otherA = otherVec:dir()

        return { selfA[1] - otherA[1], selfA[2] - otherA[2] }
    elseif self:dimensions() == 3 then
        local selfA = self:dir()

        return { selfA[1] - otherVec:dir(), selfA[2] }
    elseif otherVec:dimensions() == 3 then
        local otherA = otherVec:dir()

        return { otherA[1] - self:dir(), -otherA[2] }
    end
end

function vec:lerp(otherVec, amount)
    local newVec = vec:new()
    local components = {}

    local leastComponents = math.min(#self.components, #otherVec.components)
    for i = 1, leastComponents, 1 do
        table.insert(components, self.components[i] * (1-amount) + otherVec.components[i] * amount)
    end

    newVec.components = components
    newVec:updateComponentNames()
    return newVec
end

function vec:equals(otherVec)
    if self:dimensions() == otherVec:dimensions() then
        for i = 1, self:dimensions() do
            if math.abs(self.components[i] - otherVec.components[i]) > 0.0000000001 then return false end
        end
    else
        return false
    end

    return true
end

--[[
DOCUMENTATION:

This library works the same for vectors of all dimensions, whether it's 2d, 3d, or 12039d.
In the documenation, "__" indicates where a user-defined vec object variable should be.

Properties of a Vector:
    __.components  a table containing the components of the vector

    __.x  the first component of a vector
    __.y  the second component of a vector
    __.z  the third component of a vector
    __.w  the fourth component of a vector

    __.r  the first component of a vector
    __.g  the second component of a vector
    __.b  the third component of a vector
    __.a  the fourth component of a vector

    __.u  the first component of a vector
    __.v  the second component of a vector


Creating a Vector:
    vec:new(...) --> vec
        Creates a new vector with any number of dimensions (x, y, z, w, etc.)
        The input can be however many parameters:
            eg. local vectorA = vec:new(1, 10, 32)
        or a table:
            eg. local vectorB = vec:new({1, 10, 32})

    vec:random(dimensions, magnitude) --> vec
        Creates a new vector with random components, this will be different every time.
            eg. local vectorA = vec:random(3, 2)    vectorA.components() --> {0.33287..., 1.9357..., 0.3771...}
        dimensions: the number of dimensions that the vector has (2d, 3d, etc)
        magnitude: the length of the vector

    vec:fromAngle(magnitude, yaw, pitch) --> vec
        Creates a vector, but using magnitude and direction instead of components.
        For a 2d vector, only use magnitude and yaw. For 3d, use all three inputs.

    __:copy() --> vec
        Copies another vector.
        eg. local vectorB = vectorA:copy()


Getting the Properties of a Vector:
    __:mag() --> number
        Gets the magnitude (length) of the vector.

    __:magSq() --> number
        Gets the magnitude (length) of the vector squared. Slightly better for performance that vec:mag() but will obviously return a differnt number.

    __:dimensions() --> number
        Gets the number of dimensions that the vector has (2d, 3d, 4d, etc.)

    __:dir() --> number OR {number, number}
        Gets the direction of the vector. If the vector is 2d, it will return a single angle. Angles are in radians.
        If it is 3d, it will return a pitch and yaw.
            Yaw depends on the x and z dimensions. Pitch is the angle that the y(up) component makes to the x-z plane
            It will return a table {yaw, pitch}
            eg. local vectorA = vec:new(1, 1)     vectorA.dir() --> 0.78539... (45 degrees in radians)
                local vectorB = vec:new(1, 1, 2)  vectorB.dir() --> {1.1071... (yaw), 0.1973... (pitch)}


Basic Math with Vectors
    __:add(otherVec) --> self
        Adds two vectors and sets the first vector to the sum. Vectors can have any number of dimensions.
        eg. local vectorA = vec:new(1, 3, 2)
            local vectorB = vec:new(5, 1, 4)
            vectorA:add(vectorB)
            vectorA.components --> {6, 4, 6}

    __:sub(otherVec) --> self
        Subtracts two vectors and sets the first vector to the difference. Vectors can have any number of dimensions.

    __:mult(multiplier) --> self
        Multiplies a vector by a scalar (a regular number) or another vector.

    __:div(divisor) --> self
        Divides a vector by a scalar (a regular number) or another vector.

    __:rem(divisor) --> self
        Divides a vector by a scalar (a regular number) or another vector, then sets the original vector to the remainder of the division.

    __:equals(otherVec) --> boolean
        Checks if two vectors are identical.


Advanced Math with Vectors:
    __:dot(otherVec) --> number
        Gets the dot product of two vectors. If both vectors are normalized, this will give you a value [-1, 1] for how similar the directions are.

    __:cross(otherVec) --> vec (3d)
        Gets the cross product of two vectors. Returns a 3d vector that is perpendicular to the two inputs.
        Input vectors MUST BE 3D.

    __:dist(otherVec) --> number
        Gets the distance between the ends of two vectors.

    __:angleBetween(otherVec) --> number OR {number, number}
        Gets the angle between two vector.
        Works for two 2d, two 3d, or one 2d and one 3d.
        If it's two 2d, it will return a number.
        If there's a 3d vector in any of the inputs, it will return as {yaw, pitch}

    __:lerp(otherVec, amount) --> vec
        Linearly interpolates between two vectors.
        amount can be [0, 1]
        amount = 0: 100% the first vector (the "self")
        amount = 1: 100% the second vector
        amount = 0.5: halfway between both vectors


Modifying a Vector:
    __:setMag(magnitude) --> self
        Sets the magnitude of a vector.

    __:normalize() --> self
        Sets the magnitude of a vector to 1.

    __:limit(max) --> self
        Gives a vector's length an upper limit.

    __:setDir(yaw, pitch) --> self
        Sets the direction of a vector.
        For a 2d vector, only use the yaw parameter.

    __:rotate(yaw, pitch) --> self
        !IT'S SOMETIMES BUGGY, USE THE ROTATION FUNCTIONS BELOW INSTEAD
        Rotates a vector.
        For a 2d vector, only use the yaw parameter.

    --:rotatePitch(angle) --> self
        Rotates 3d a vector along the x-axis.
        If the vector is 2d, it rotates it on the only axis possible.

     --:rotateYaw(angle) --> self
        Rotates 3d a vector along the y-axis.
        If the vector is 2d, it rotates it on the only axis possible.

    --:rotateRoll(angle) --> self
        Rotates 3d a vector along the z-axis.
        If the vector is 2d, it rotates it on the only axis possible.

    __:setComponent(component, value)
        Sets a component of the vector.
        The component can be defined by its number-
            eg. 1, 2, 4
        or its letter-
            eg. "x", "g", "w"


__:updateComponentNames()
    Updates the letters of the vector (eg. vectorA.x, vectorA.u). This is supposed done automatically every time you change a vector, but if you do something like set vectorA.components manually, you should use this function afterwards.
]]
