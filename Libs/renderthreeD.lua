---Use to render a cube in a world at predermined position and size
---@param x number x position of the cube
---@param y number y position of the cube
---@param z number z position of the cube
---@param s number size of the cube
---@return nil
function cube(x,y,z,s)

    gfx.quad(x,y,z,x+s,y,z,x+s,y+s,z,x,y+s,z,true)
    gfx.quad(x,y,z+s,x+s,y,z+s,x+s,y+s,z+s,x,y+s,z+s,true)
    gfx.quad(x,y,z,x,y,z+s,x,y+s,z+s,x,y+s,z,true)
    gfx.quad(x+s,y,z,x+s,y,z+s,x+s,y+s,z+s,x+s,y+s,z,true)
    gfx.quad(x,y,z,x+s,y,z,x+s,y,z+s,x,y,z+s,true)
    gfx.quad(x,y+s,z,x+s,y+s,z,x+s,y+s,z+s,x,y+s,z+s,true)
end
---use to render a cube in a world at predermined position and size
---@param x number x position of the cube
---@param y number y position of the cube
---@param z number z position of the cube
---@param sx number x size of the cube
---@param sy number y size of the cube
---@param sz number z size of the cube
---@return nil
function cubexyz(x,y,z,sx,sy,sz)

    gfx.quad(x,y,z,x+sx,y,z,x+sx,y+sy,z,x,y+sy,z,true)
    gfx.quad(x,y,z+sz,x+sx,y,z+sz,x+sx,y+sy,z+sz,x,y+sy,z+sz,true)
    gfx.quad(x,y,z,x,y,z+sz,x,y+sy,z+sz,x,y+sy,z,true)
    gfx.quad(x+sx,y,z,x+sx,y,z+sz,x+sx,y+sy,z+sz,x+sx,y+sy,z,true)
    gfx.quad(x,y,z,x+sx,y,z,x+sx,y,z+sz,x,y,z+sz,true)
    gfx.quad(x,y+sy,z,x+sx,y+sy,z,x+sx,y+sy,z+sz,x,y+sy,z+sz,true)
end
---use to render a cube's frame in a world at predermined position and size
---@param x number x position of the cube
---@param y number y position of the cube
---@param z number z position of the cube
---@param s number size of the cube
---@param t number thickness of the frame
---@return nil
function cubeframe(x, y, z, s, t)
    x = x - (s-1) /2
    y = y - (s-1) /2
    z = z - (s-1) /2
    cubexyz(x + s - t, y, z, t, s, t)-- right front edge
    cubexyz(x + s - t, y, z + s - t, t, s, t) -- right back edge

    cubexyz(x, y, z, t, s, t)-- left front edge
    cubexyz(x, y, z + s - t, t, s, t)-- left back edge

    cubexyz(x, y + s - t, z, s, t, t)-- top front edge
    cubexyz(x, y + s - t, z + s - t, s, t, t)-- top back edge
    cubexyz(x, y + s - t, z, t, t, s)-- top left edge
    cubexyz(x + s - t, y + s - t, z, t, t, s)-- top right edge

    cubexyz(x, y, z, s, t, t) -- bottom front edge
    cubexyz(x, y, z + s - t, s, t, t) -- bottom back edge
    cubexyz(x, y, z, t, t, s)-- bottom left edge
    cubexyz(x + s - t, y, z, t, t, s)-- bottom right edge
end
