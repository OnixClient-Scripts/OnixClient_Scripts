name="Waila"
description="What Am I Looking At mod, ported to Onix Client."

importLib("translator.lua")

isBreaking = false

blockName = ""



function render(deltaTime)
    local playerposX,playerposY,playerposZ = player.selectedPos()
    local block = dimension.getBlock(playerposX,playerposY,playerposZ)

    blockName = string.gsub(block.name, "_", " ")
    blockName = string.gsub(blockName, "^%l", string.upper)
    local x = gui.width() / 2 - #blockName * 4

    if block.name and player.facingBlock() == true then
        local blockTexture = translate(block.name, block.id, block.data)
        local font = gui.font()
        
        gfx.color(15,0,20,150)
        gfx.roundRect(x - 2, 1, font.width(blockName) +26, font.height + 16, 1,1)

        gfx.color(255,255,255)
        gfx.text(x+22,8,blockName)

        gfx.color(255,255,255)
        gfx.unloadimage(blockTexture)
        gfx.texture(x,3,20,20,"textures/" .. blockTexture)
        if isBreaking == true then
            gfx.rect(x,23.5,font.width(blockName) + 22,1)
        end
    end
end
event.listen("MouseInput", function(button, down)
    if not gui.mouseGrabbed() then
        if button == 1 and player.facingBlock() == true then
            if down == true then
                isBreaking = true
            else
                isBreaking = false
            end
        end
    end
end)





-- support coming in the future for the following items (replace mainzz with hard):
-- signs
-- candles
-- coral fans
-- candle cakes
-- buttons
-- muddy mangrove roots
-- glow frame
-- sculk catalyst
-- brown mushroom
-- sign
-- mangrove wood
-- red flower
-- bamboo
-- redstone
-- mangrove stairs
-- daylight detector
-- mangrove fence gate
-- frosted ice
-- cave vines
-- melon stem
-- beet root
-- potatot
-- carrot
-- skulls
-- mud brick stairs
-- stone block slabs
-- reinforced deepslate
-- sweet berry bush
-- big dripleaf
-- cave vines body with berries
-- mangrove roots
-- mainzz stained glass
-- double stone block slabs
-- froglights
-- mangrove door
-- buttons
-- pumpkin stem
-- cocoa
-- banners
-- pointed dripstone
-- turtle egg
-- mainzz stained glass pane
-- redstone torch
-- torch