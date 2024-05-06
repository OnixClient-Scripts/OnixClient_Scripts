
name = "Image Generator"
description = "Change the image file \"toBuild.png\" to the image and then change the size settings"

-- added: making it vertical


-- ty jqms and flash for adding the preview andmaking it do it in the center and loading stuff at the right points.

importLib("BlockRGB.lua")


-- imgHeight = 100
-- imgHeightSet = client.settings.addInt("Height","imgHeight",1,500)
-- imgWidth = 132
-- client.settings.addInt("Width","imgWidth",1,500)
-- preserveRatios = true
-- client.settings.addBool("Preserve ratios","preserveRatios")
client.settings.addInfo("Make an image file called toBuild.png of whatever you want to build, then do .buildCoords \nto set where it will build, then set how tall you want it to be, it will automatically find \nout the width. Run .build and it will Make it!")
imageHeight = 600
imageHeightSet = client.settings.addInt("Image Height","imageHeight",1,500)
buildVertical = false
client.settings.addBool("Build vertical","buildVertical")
imageWidth = 600
zWall = true
fixZSet = client.settings.addBool("Fixed Z","zWall")
-- client.settings.addInfo("Image width (updates when you close and reopen)")
-- abc = client.settings.addInfo("imageWidth")
-- img = gfx2.loadImage("toBuild.png") -- loads the img

-- client.settings.addKeybind("Build key","buildKey")
img = nil
-- client.settings.addKeybind("Build key","buildKey")



registerCommand("build", function ()
    if img == nil then
        print("Your image doesn't exist")
        return
    end

    local heightStep = img.height / imageHeight
    local widthStep = img.width / imageWidth

    
    client.execute("execute gamerule sendcommandfeedback false")

    for i = 1, img.height, heightStep do
        for j = 1, img.width, widthStep do
            local curColour2 = img:getPixel(math.floor(j), math.floor(i))
            if curColour2.a ~= 0 then
                local curBlock2 = RGBtoBlock(curColour2.r, curColour2.g, curColour2.b)
                local offsetX = math.floor((j - img.width / 2) / widthStep)
                local offsetZ = math.floor((i - img.height / 2) / heightStep)
                local x, y, z = player.position()
                if buildVertical == false then
                    
                    client.execute("execute setblock " .. (xStartCoord + offsetX) .. " " .. (yStartCoord) .. " " .. (zStartCoord + offsetZ) .. " " .. curBlock2)
                elseif zWall == true then
                    client.execute("execute setblock " .. (xStartCoord - offsetX) .. " " .. (yStartCoord - offsetZ) .. " " .. (zStartCoord) .. " " .. curBlock2)
                else
                    client.execute("execute setblock " .. (xStartCoord) .. " " .. (yStartCoord - offsetZ) .. " " .. (zStartCoord - offsetX) .. " " .. curBlock2)
                end
            end
        end
    end

    client.execute("execute gamerule sendcommandfeedback true")
end)

needsUnload = false
renderEverywhere = true
registerCommand("buildCoords", function ()
    img = gfx2.loadImage("toBuild.png")
    if img == nil then
        print("Your image doesn't exist, put an image named toBuild.png in your data folder")
        return
    end
    needsUnload = true
    imageScale = imageHeight/img.height
    imageWidth = imageScale * img.width
    xStartCoord, yStartCoord, zStartCoord = player.position()
end)

function render()
    if needsUnload then
        needsUnload = false
        gfx.unloadimage("toBuild")
    end
end

function render3d()
    gfx.tcolor(255, 255, 255, 200)
    if buildVertical == false then
        if xStartCoord then
            local offsetX = (img.width / 2) * imageScale
            local offsetZ = (img.height / 2) * imageScale
            gfx.tquad( 
                xStartCoord - offsetX, yStartCoord, zStartCoord + offsetZ,
                0, 1,
                xStartCoord + offsetX, yStartCoord, zStartCoord + offsetZ,
                1, 1,
                xStartCoord + offsetX, yStartCoord, zStartCoord - offsetZ,
                1, 0,
                xStartCoord - offsetX, yStartCoord, zStartCoord - offsetZ,
                0, 0,
                "toBuild"
            )
        end
    elseif zWall == true then
        if xStartCoord then
            local offsetX = (img.width / 2) * imageScale
            local offsetZ = (img.height / 2) * imageScale
            gfx.tquad(
                xStartCoord + offsetX, yStartCoord - offsetZ, zStartCoord,
                0, 1,
                xStartCoord - offsetX, yStartCoord - offsetZ, zStartCoord,
                1, 1,
                xStartCoord - offsetX, yStartCoord + offsetZ, zStartCoord,
                1, 0,
                xStartCoord + offsetX, yStartCoord + offsetZ, zStartCoord,
                0, 0,
                "toBuild"
            )
        end
    else
        if xStartCoord then
            local offsetX = (img.width / 2) * imageScale
            local offsetZ = (img.height / 2) * imageScale
            gfx.tquad(
                xStartCoord, yStartCoord - offsetZ, zStartCoord + offsetX,
                0, 1,
                xStartCoord, yStartCoord - offsetZ, zStartCoord - offsetX,
                1, 1,
                xStartCoord, yStartCoord + offsetZ, zStartCoord - offsetX,
                1, 0,
                xStartCoord, yStartCoord + offsetZ, zStartCoord + offsetX,
                0, 0,
                "toBuild"
            )
        end
    end
end

function update()
    if buildVertical then
        fixZSet.visible = true
    else
        fixZSet.visible = false
    end
end