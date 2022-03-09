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
function cubeframe(x,y,z,s,t)
    
    cubexyz(x,y,z,s/16/(t/16/16)*(t/5.30),s/16/(t/16),s/16/(t/16)) --base x
    cubexyz(x,y,z,s/16/(t/16),s/16/(t/16),s/16/(t/16/16)*(t/5.30)) --base z
    cubexyz(x,y,z,s/16/(t/16),s/16/(t/16/16)*(t/5.30),s/16/(t/16)) --base y
    cubexyz(x,y,z+s*3,s/16/(t/16/16)*(t/5.30),s/16/(t/16),s/16/(t/16)) --pillar 1
    cubexyz(x+s*3,y,z,s/16/(t/16),s/16/(t/16),s/16/(t/16/16)*(t/5.30)) --pillar 2
    cubexyz(x+s*3,y,z,s/16/(t/16),s/16/(t/16/16)*(t/5.30),s/16/(t/16)) --pillar 3
    cubexyz(x,y,z+s*3,s/16/(t/16),s/16/(t/16/16)*(t/5.30),s/16/(t/16)) --bottom x
    cubexyz(x+s*3,y,z+s*3,s/16/(t/16),s/16/(t/16/16)*(t/5.30),s/16/(t/16)) --bottom z
    cubexyz(x,y+s*3,z,s/16/(t/16/16)*(t/5.30),s/16/(t/16),s/16/(t/16)) --top x
    cubexyz(x,y+s*3,z,s/16/(t/16),s/16/(t/16),s/16/(t/16/16)*(t/5.30)) --top z
    cubexyz(x,y+s*3,z+s*3,s/16/(t/16/16)*(t/5.30),s/16/(t/16),s/16/(t/16)) --top x 2
    cubexyz(x+s*3,y+s*3,z,s/16/(t/16),s/16/(t/16),s/16/(t/16/16)*(t/5.30)) --top z 2
end
