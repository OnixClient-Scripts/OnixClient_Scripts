name = "Ping Display"
description = "tries its best to show your ping"

positionX = 6
positionY = 60
sizeX = 35
sizeY = 10
scale = 1.0

color = {255,255,255,255}
background_color = {0,0,0,127}

PingDelay = 250 --in ms, you will need to restart the LuaPingHelper.exe for it to apply

--[[
for this to work you will need to execute the LuaPingHelper.exe file
(so it can do the ping and tell the script of its results)
you can download it here

https://www.mediafire.com/file/37wm885qwyk3bjj/LuaPingHelper.exe/file

]]--
HowMakeWorkInfoText = "for this to work you will need to execute the LuaPingHelper.exe file\
(so it can do the ping and tell the script of its results)\
you can download it here\
\
https://www.mediafire.com/file/37wm885qwyk3bjj/LuaPingHelper.exe/file\n\n"

function ClickCopyButton()
    setClipboard("https://www.mediafire.com/file/37wm885qwyk3bjj/LuaPingHelper.exe/file")
    client.notification("The link is in your clipboard!")
end

-----script-code-----

client.settings.addColor("Text Color", "color")
client.settings.addColor("Background Color", "background_color")
client.settings.addAir(15)
client.settings.addInfo("HowMakeWorkInfoText")
client.settings.addFunction("Copy Download Link", "ClickCopyButton", "Copy")

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

function render()
    if not gui.mouseGrabbed() then
        local text = CurrentPing .. "ms"
        local font = gui.font()

        gfx.color(background_color.r, background_color.g, background_color.b, background_color.a)
        gfx.rect(0,0,sizeX,sizeY)

        gfx.color(color.r, color.g, color.b, color.a)
        gfx.text((sizeX / 2) - (font.width(text) / 2), 5 - (font.height / 2), text, 1)
    end

end
