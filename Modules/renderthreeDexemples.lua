name = 'RenderThreeD library exemples'
description = 'Contains all the exemples from RenderThreeD library'

--[[
    Note: cube() and cubeframe() has different scaling, if the scale of cube() was 3, the scale of cubeframe() would be 1
    Basically, 3 scale in cube() is the same as 1 scale in cubeframe()
]]--
--IMPORT
importLib('renderthreeD.lua')

function render3d(dt)
    
    --render a cube on coordinates (0,0,0) with size 3
    gfx.color(255,255,255,64)
    cube(0,0,0,3)
    --render a cube on coordinates (0,0,5) with size 5,6,7
    gfx.color(255,255,0,128)
    cubexyz(0,7,5,5,6,7)
    --render a cube's frame on coordinates (0,0,10) with size 2 and thickness 3
    gfx.color(255,0,255,255)
    cubeframe(0,0,10,2,3)
    --render a cube with it's outline higlighted on coordinates (0,0,20) with size 3, thickness 10 and outline color (255,0,255,255)
    gfx.color(255,0,255,255)
    cube(0,0,20,3)
    gfx.color(255,0,0,255)
    cubeframe(0,0,20,1,10)
    --the

end