importLib("renderThreeD.lua")

Cube = {}
Cube.__index = Cube

function Cube:create(x, y, z, colour, lifespan, uuid)
    local self = setmetatable({}, Cube)
    self.x = x
    self.y = y
    self.z = z
    self.colour = colour
    self.lifespan = lifespan
    self.uuid = uuid
    return self
end

function Cube:remove()
    for i = 1, #renderQueueVar do
        if renderQueueVar[i].uuid == self.uuid then
            table.remove(renderQueueVar, i)
            break
        end
    end
end

function removeCube(uuid)
    for i = 1, #renderQueueVar do
        if renderQueueVar[i].uuid == uuid then
            table.remove(renderQueueVar, i)
            break
        end
    end
end

renderQueueVar = {}

function addCube (x,y,z,colour,lifespan)
    table.insert(renderQueueVar, Cube:create(x,y,z,colour,lifespan,math.random(1,100000)))
    return renderQueueVar[#renderQueueVar]
end

function  renderQueue (dt) -- This function will be called by the render3d function
    for i = 1, #renderQueueVar do
        local curCube = renderQueueVar[i]
        if curCube == nil then else
            if curCube.lifespan > 0 then
                -- print(curCube.colour.a)
                gfx.color( curCube.colour.r, curCube.colour.g, curCube.colour.b, curCube.colour.a)
                curCube.lifespan = curCube.lifespan - dt
                cube(curCube.x, curCube.y, curCube.z, 1)
            else
                
                curCube:remove()
                
            end
        end
    end
   
end