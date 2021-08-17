name = "Stopwatch"
description = "Count time for whatever reason..."

START_STOP_KEY = 0x55 --or 'U'
--[[
    if you wish to change the key you can take the key code from here
https://docs.microsoft.com/en-us/windows/win32/inputdev/virtual-key-codes
]]--

-------------script-code-------------

state = 0
startTime = 0
stopTime  = 0

function keyboard(key, isDown)
    if (isDown == true) then
        if (key == START_STOP_KEY) then
            if (state == 0) then
                state = 1
                startTime = os.time()
            elseif (state == 1) then
                state = 2
                stopTime = os.time()
            elseif (state == 2) then
                state = 0
            end
        end
    end
end

TimerText = "00:00"
TextColor = {r=30,g=255,b=30,a=255}
function doubleDigit(number)
    if (number < 10) then
        return "0" .. math.floor(number)
    else
        return math.floor(number)
    end
end
function timeText(time)
    local result = ""
    local days = 0
    while (time > 86399) do 
        days = days + 1 
        time = time - 86400 
    end

    local hours = 0
    while (time > 3599) do 
        hours = hours + 1 
        time = time - 86400 
    end
    
    local minutes = 0
    while (time > 59) do 
        minutes = minutes + 1 
        time = time - 60 
    end

    if (days == 0) then
        if (hours == 0) then
            return doubleDigit(minutes) .. ":" .. doubleDigit(time)
        else
            return math.floor(hours) .. " : " .. doubleDigit(minutes) .. ":" ..doubleDigit(time)
        end  
    else
        return math.floor(days) .. " : " .. doubleDigit(hours) .. " : " .. doubleDigit(minutes) .. ":" .. doubleDigit(time)  
    end
end

function update()
    if (state == 0) then
        TextColor = {r=30,g=255,b=30,a=255}
        TimerText = "00:00"
    elseif (state == 1) then
        TimerText = timeText(os.time() - startTime)
        TextColor = {r=30,g=255,b=30,a=255}
    elseif (state == 2) then
        TimerText = timeText(stopTime - startTime)
        TextColor = {r=30,g=30,b=255,a=255}
    end
end

function render()
    local font = gui.font()
    local tw = font.width(TimerText)

    gfx.color(0,0,0,255)
    gfx.rect(gui.width() - (tw + 4), gui.height() - 10, tw + 4, 10)

    gfx.color(TextColor.r, TextColor.g, TextColor.b, TextColor.a)
    gfx.text(gui.width() - (tw + 2), (gui.height()) - (10 - (font.height / 2)), TimerText)
end