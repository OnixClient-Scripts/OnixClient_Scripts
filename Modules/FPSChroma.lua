name="FPS Chroma"
description="boosts your fps"

--By MCBE

multiplier = 1
client.settings.addFloat("Fps booster ratio", "multiplier", 0, 100)

refresh = 1
client.settings.addFloat("Fps refreshing", "refresh", 0, 5)

client.settings.addAir(10)

infoAutoSetting = "Goes to the position of original fps display and takes its color"
autoSetting = true
client.settings.addBool("Auto settings", "autoSetting")
client.settings.addInfo("infoAutoSetting")

client.settings.addAir(10)

background = {0, 0, 0, 127}
client.settings.addColor("Background color", "background")

color = {255, 255, 255}
client.settings.addColor("Color", "color")

positionX = 0
positionY = 0
sizeX = 20
sizeY = 20
importLib("module.lua")
importLib("chroma.lua")

text = ""
fps = 0
frames = 1

timer = 0

function update(dt)
    timer = timer + dt
    if timer >= tonumber(refresh) then
        text = math.floor(fps/frames) .. " FPS"
        fps = 0
        frames = 1
        if timer >= 2*tonumber(refresh) then
            timer = 0
        else
            timer = timer - tonumber(refresh)
        end
    end
end

function render(dt)
    fps = fps + ((1/dt) * tonumber(multiplier)) + math.random(0, math.floor(tonumber(multiplier)))
    frames = frames + 1
    sizeY = gui.font().height + 2
    sizeX = gui.font().width(text) + 2
    if not gui.mouseGrabbed() then
        if autoSetting then
            mod = getModule("FPS Counter")
            mod.enabled = false
            positionX = mod.pos["x"]
            positionY = mod.pos["y"]
            c = getSetting(mod, "backColor").value
            gfx.color(c.r*255, c.g*255, c.b*255, c.a*255)
            gfx.rect(0, 0, gui.font().width(text) + 6, mod.size["y"])
            c = getSetting(mod, "textColor").value
            gfx.color(c.r*255, c.g*255, c.b*255, c.a*255)
            chromaText(3, 2, text)
        else
            gfx.color(background.r, background.g, background.b, background.a)
            gfx.rect(0, 0, sizeX, sizeY)
            gfx.color(color.r, color.g, color.b, color.a)
            chromaText(1, 1, text)
        end
    end
end