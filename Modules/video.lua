name = "Video player"
description = "can play videos"

--[[
    Video player
    
    made by MCBE Craft
    how to use: https://youtu.be/ibfWOKq_TWY
]]



--pos stuff
positionX = 400
positionY = 50
sizeX = 200
sizeY = 100

--file stuff
importLib("fileUtility.lua")
local file = 000001

--timing stuff
fps = 25
client.settings.addAir(5)
fpsText = "fps of the video"
client.settings.addInfo("fpsText")
client.settings.addInt("", "fps", 5, 100)
time = 0

--extension
extension = 2
client.settings.addAir(5)
extInfo = "file extension:\n1: png\n2: jpg\n3: gif"
client.settings.addInfo("extInfo")
client.settings.addInt("", "extension", 1, 3)
extensions = {".png", ".jpg", ".gif"}
local extensionName = extensions[extension]

--loop
loopVideo = true
client.settings.addAir(5)
client.settings.addBool("Loop the video", "loopVideo")

--debug
debugOpt = false
client.settings.addAir(5)
client.settings.addBool("Debug: shows frame and latency", "debugOpt")


registerCommand("video", function(arguments)
    if arguments == "reset" then
        resetVid()
        gui.stopallsound()
        print("Now playing: " .. video)
    elseif arguments == "stop" then
        resetVid()
        video = nil
        gui.stopallsound()
        print("Stopped playing")
    else
        resetVid()
        if os.rename(arguments .. "\\" .. file .. extensionName, arguments .. "\\" .. file .. extensionName) then
            video = arguments
            gui.sound("record." .. video)
            print("Now playing: " .. video)
        else
            video = nil
            gui.stopallsound()
            print("Video not found\nStopped playing")
        end
    end
end)



function update(deltaTime)
    extensionName = extensions[extension]
end


function render(deltaTime)
    time = time + deltaTime
    if video ~= nil then
        if not os.rename(video .. "\\" .. file .. extensionName, video .. "\\" .. file .. extensionName) then
            if loopVideo then
                resetVid()
                gui.sound("record." .. video)
                print("Now playing: " .. video)
            else
                resetVid()
                video = nil
                gui.stopallsound()
                print("Stopped playing")
                return
            end
        end
        while time >= 1/fps do
            file = numToStr(file + 1)
            time = time - 1/fps
        end
        for i = 1, 10, 1 do
            file2 = numToStr(tonumber(file) + i)
            gfx.image(gui.width()*2, 0, sizeX, sizeY, video .. "\\" .. file2 .. extensionName)
        end
        gfx.image(0, 0, sizeX, sizeY, video .. "\\" .. file .. extensionName)
        if tonumber(file) > 1 then
            if gfx.unloadimage == nil then
                print("Unloading feature not supported!")
            else
                gfx.unloadimage(video .. "\\" .. numToStr(file - 1) .. extensionName)
            end
        end
        if debugOpt then
            gfx.text(0, 0, file .. ", " .. time)
        end
    end
end

function numToStr(num)
    if num < 10 then
        num = "00000" .. num
    elseif num < 100 then
        num = "0000" .. num
    elseif num < 1000 then
        num = "000" .. num
    elseif num < 10000 then
        num = "00" .. num
    elseif num < 100000 then
        num = "0" .. num
    end
    return tostring(num)
end

function resetVid()
    file = "000001"
    time = 0
end
