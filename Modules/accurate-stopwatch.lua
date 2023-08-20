-- This script was originally written in TypeScript.
name = "Accurate stopwatch"
description = "A simple stopwatch, millisecond-precise, for timing things."
positionX = 0
positionY = 0
sizeX = 0
sizeY = 0
modSettings = {
    startKey = client.settings.addNamelessKeybind("Start", 0),
    stopKey = client.settings.addNamelessKeybind("Pause/Stop", 0),
    resetKey = client.settings.addNamelessKeybind("Reset", 0),
    showNotifs = client.settings.addNamelessBool("Show notifications", true),
    bgColour = client.settings.addNamelessColor("Background colour", { 0, 0, 0, 128 }),
    textColour = client.settings.addNamelessColor("Text colour", { 255, 255, 255 }),
    bgPadding = client.settings.addNamelessInt("Padding", 0, 20, 2)
}
timerRunning = false
timerStartedAt = 0
currentTime = 0
event.listen(
    "KeyboardInput",
    function(key, down)
        if gui.screen() ~= "hud_screen" then
            return
        end
        if key == modSettings.startKey.value and down then
            if timerRunning then
                return
            end
            timerRunning = true
            if modSettings.showNotifs.value then
                client.notification("Stopwatch started.")
            end
            return true
        end
        if key == modSettings.stopKey.value and down then
            if not timerRunning then
                return
            end
            timerRunning = false
            if modSettings.showNotifs.value then
                client.notification("Stopwatch paused.")
            end
            return true
        end
        if key == modSettings.resetKey.value and down then
            currentTime = 0
            timerStartedAt = os.clock()
            if modSettings.showNotifs.value then
                client.notification("Stopwatch reset.")
            end
            return true
        end
    end
)
---
-- @noSelf
timerText = function(time)
    local hours = math.floor(time / 3600)
    local minutes = math.floor(time / 60)
    local seconds = math.floor(time - math.floor(time / 60) * 60 - math.floor(time / 3600) * 3600)
    local milliseconds = math.floor((time - math.floor(time)) * 1000)
    local text =
        (
            (
                (time > 3600 and tostring(hours < 10 and "0" .. tostring(hours) or hours) .. "." or "")
                .. (time > 60 and tostring(minutes < 10 and "0" .. tostring(minutes) or minutes) .. "." or "")
            ) .. tostring(seconds < 10 and "0" .. tostring(seconds) or seconds) .. "."
        ) .. tostring(milliseconds == 0 and "000" or milliseconds)
    return text
end
render2 = function()
    if timerRunning then
        currentTime = os.clock() - timerStartedAt
    else
        timerStartedAt = os.clock() - currentTime
    end
    local pad = modSettings.bgPadding.value
    local text = timerText(currentTime)
    sizeX, sizeY = gfx2.textSize(text)
    sizeX = sizeX + pad * 2
    sizeY = sizeY + pad * 2
    gfx2.color(modSettings.bgColour.value)
    gfx2.fillRect(0, 0, sizeX, sizeY)
    gfx2.color(modSettings.textColour.value)
    gfx2.text(pad, pad, text)
end
