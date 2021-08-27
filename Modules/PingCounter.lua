name = "Ping Display"
description = "tries its best to show your ping"

hide = false

TextColor = { r=255, g=255, b=255, a=255 }
BackColor = { r=0, g=0, b=0, a=0 }

positionX = 926
positionY = 1
sizeX = 35
sizeY = 10

PingDelay = 2000

DelayFile = io.open("PingCounterDelay.txt", "w")
io.output(DelayFile)
io.write(PingDelay)
io.close(DelayFile)

CurrentPing = -1

PingState = 0
function update()
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
    if(hide == false) then
        local text = CurrentPing .. "ms"
        local font = gui.font()

        gfx.color(BackColor.r, BackColor.g, BackColor.b, BackColor.a)
        gfx.rect(0,0,sizeX,sizeY)

        gfx.color(TextColor.r, TextColor.g, TextColor.b, TextColor.a)
        gfx.text((sizeX / 2) - (font.width(text) / 2), 5 - (font.height / 2), text, 1)
    end
end