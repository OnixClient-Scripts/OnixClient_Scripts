name = "Video player"
description = "can play videos"

--[[
    Video player
    
    made by MCBE Craft
]]

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
extensionName = extensions[extension]

--pos stuff
positionX = 400
positionY = 50
sizeX = 200
sizeY = 100

--file stuff
importLib("readfile.lua")
writeFile("video.txt", "")
file = 000000
oVideo = ""

firstUpdate = true

function update(deltaTime)
    extensionName = extensions[extension]
end


function render(deltaTime)
    time = time + deltaTime
    video = readFile("video.txt")
    if video == nil then
        video = {oVideo}
    end
    if video[1] ~= nil and video[1] ~= "" and video[1] ~= "\n" then
        if oVideo ~= video[1] then
            file = "000000"
            time = 0
            oVideo = video[1]
        end
        if firstUpdate == true then
            file = "000000"
            time = 0
            firstUpdate = false
        end
        while time >= 1/fps do
            file = numToStr(file + 1)
            time = time - 1/fps
        end
        for i = 1, 10, 1 do
            file2 = numToStr(tonumber(file) + i)
            gfx.image(0, 0, sizeX, sizeY, video[1] .. "\\" .. file2 .. extensionName)
        end
        gfx.image(0, 0, sizeX, sizeY, video[1] .. "\\" .. file .. extensionName)
    else
        firstUpdate = true
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
