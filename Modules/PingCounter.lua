name = "Ping Display"
description = "tries its best to show your ping"

positionX = 6
positionY = 60
sizeX = 35
sizeY = 10
scale = 1.0

PingDelay = 250 --in ms, you will need to restart the LuaPingHelper.exe for it to apply

--[[
for this to work you will need to execute the LuaPingHelper.exe file
(so it can do the ping and tell the script of its results)
you can download it here

https://www.mediafire.com/file/37wm885qwyk3bjj/LuaPingHelper.exe/file

]]--

function downloadExe()
    workingDir = "RoamingState/OnixClient/Scripts/Extras"
    network.fileget("LuaPingHelper.exe","https://github.com/OnixClient-Scripts/OnixClient_Scripts/blob/master/Extras/LuaPingHelper.exe?raw=true", "LuaPingHelper")
    workingDir = "RoamingState/OnixClient/Scripts/Data"
end
downloadExe()
function onNetworkData(code)
    if code == 0 then
        return
    end
end
function openFolder() workingDir = "RoamingState/OnixClient/Scripts";fs.showFolder("Extras") workingDir = "RoamingState/OnixClient/Scripts/Data" end

client.settings.addFunction("Open Exe Folder", "openFolder", "Open")
client.settings.addAir(2)
-----script-code-----
brackets = client.settings.addNamelessBool("Brackets",false)
textColor = client.settings.addNamelessColor("Text Color", {255,255,255,255})
backColor = client.settings.addNamelessColor("Background Color", {0,0,0,127})
backRadius = client.settings.addNamelessFloat("Background Radius", 0, 20, 0)

DelayFile = io.open("PingCounterDelay.txt", "w")
io.output(DelayFile)
io.write(PingDelay)
io.close(DelayFile)

CurrentPing = -69

PingState = 0
function update()
	if (server.ipConnected() == "") then
		PingState = 0
		CurrentPing = -1
		return nil
	end
	
    if (PingState == 0) then
        file = 0
        while (file == 0) do file = io.open("PingCounterInfo.txt", "w") end
        io.output(file)
        io.write(server.ipConnected())
        io.close(file)
        file = io.open("PingCounterRead.txt", "w")
        io.output(file)
        io.write("")
        io.close(file)
        PingState = PingState + 1
    elseif (PingState == 1) then
        file = 0
        while (file == 0) do file = io.open("PingCounterRead.txt", "r") end
        if (file == nil) then PingState = 0 return nil end
        io.input(file)
        if (io.read("l") == "1") then
            io.close(file)
            file = io.open("PingCounterPing.txt", "r")
            io.input(file)
            CurrentPing = math.floor(tonumber(io.read("*all")))
            io.close(file)
            PingState = 0
        else
            io.close(file)
        end
    end
end

function render2()
    if brackets.value == false then
        text = CurrentPing .. "ms"
    else
        text = "[" .. CurrentPing .. "ms]"
    end
    local textWidth, textHeight = gfx2.textSize(text)
    sizeX = textWidth * 1.75
    sizeY = textHeight + 2

    gfx2.color(backColor)
    gfx2.fillRoundRect(0,0,sizeX,sizeY, backRadius.value)

    gfx2.color(textColor)
    gfx2.text((sizeX / 2) - (textWidth / 2), (sizeY / 2) - (textHeight / 2), text, 1)
end
