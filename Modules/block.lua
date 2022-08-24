name = "Block"
description = "gives info about BLOCK"

--[[
    Original module made by MCBE Craft
]]--

positionX = 75
positionY = 0
sizeX = 100
sizeY = 25

ImportedLib = importLib("translator.lua")
ImportedLib = importLib("MinimapBlockTools.lua")



function render(deltaTime)
    if not gui.mouseGrabbed() then
        UpdateMapTools()
        local x,y,z = player.selectedPos()
        local block = dimension.getBlock(x,y,z)
        gfx.color(255, 0, 0, 255)
        if (block.id ~= 0 and player.facingBlock()) then
            local blockBrightness, skyBrightness = dimension.getBrightness(x, y + 1, z)
            local texture = translate(block.name, block.id, block.data)
            local color = getMapColorId(block.id, block.data)
            if airblock(block.name, block.id) ~= "air" and texture ~= "air" then
                gfx.texture(0, sizeY/2 - 8, 16, 16, "textures/" .. texture)
            else
                texture = "air"
            end
            local biome = dimension.getBiome(x,y,z)
            gfx.text(16, 0, block.name, 1.5)
            local text = {
                "Id & Data: " .. block.id .. ", " .. block.data,
                "Texture: " .. texture,
                "Color: " .. color[1] .. " " .. color[2] .. " " .. color[3],
                "Light Level: " .. blockBrightness .. " (" .. skyBrightness .. ")",
                "Biome: " .. biome.name,
                "Rain: " .. tostring(biome.canRain)
            }
            local font = gui.font()
            sizeX = 16 + font.width(block.name) * 1.5
            for i = 1, 6, 1 do
                if sizeX < 16 + font.width(text[i]) then
                    sizeX = 16 + font.width(text[i])
                end
            end
            
            local height = font.height
            --you can use that to make a rectangle around text with the font's height
            local wrapHeight = font.wrap
            --what a line takes, so if you have a second line it will be at location + wrap
            sizeY = height * 5 + wrapHeight * 2.25
            for i = 1, #text, 1 do
                gfx.text(16, wrapHeight + i * height, text[i])
            end
        end
    end
end
