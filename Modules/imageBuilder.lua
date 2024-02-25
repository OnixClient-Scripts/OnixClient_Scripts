name = "Image Generator"
description = "Change the image file \"toBuild.png\" to the image and then change the size settings"

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
imageWidth = 600
-- client.settings.addInfo("Image width (updates when you close and reopen)")
-- abc = client.settings.addInfo("imageWidth")


-- client.settings.addKeybind("Build key","buildKey")

imgg = gfx2.loadImage("toBuild.png")

registerCommand("build",function ()
    


    local img = gfx2.loadImage("toBuild.png") -- loads the img

    if img == nil then print("Your image doesn't exist"); return end -- checsks it exist

    heightStep = img.height/imageHeight
    widthStep = img.width/imageWidth


    for i = 1, img.height, heightStep do--for i = 1, 200, heightStep do
        for j = 1, img.width, widthStep do--for j = 1, 200, widthStep do -- loops thru the img
            --print("i"..i,"j"..j)
            local curColour2 = img:getPixel(math.floor(j),math.floor(i))
            if curColour2 == nil then print("Done!"); return end
            --print("r"..curColour2.r,"g"..curColour2.g,"b"..curColour2.b)
            curBlock2 = RGBtoBlock(curColour2.r,curColour2.g,curColour2.b)
            -- print("setblock ~" .. i .. " ~ ~" .. j)
            --print("execute setblock " .. i .. " 0 ".. j .. " " .. curBlock2)
            client.execute("execute setblock " .. xStartCoord+math.floor(i/heightStep) .. " " .. yStartCoord .. " ".. zStartCoord +imageWidth-math.floor(j/widthStep) .. " " .. curBlock2)
        end
    end

       
    

end)



registerCommand("buildCoords",function()
    xStartCoord, yStartCoord, zStartCoord = player.position()
end)

function render(dt)
        
    imageScale = imageHeight/imgg.height
    imageWidth = imageScale * imgg.width
    
    client.settings.reload()
end