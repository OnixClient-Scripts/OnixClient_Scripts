name="FPS"
description="Spoofs your fps"

--By MCBE

multiplier = 1
client.settings.addFloat("Fps multiplier", "multiplier", 0, 100)

refresh = 1
client.settings.addFloat("Fps refreshing", "refresh", 0, 5)

background = {0, 0, 0, 127}
client.settings.addColor("Background color", "background")

color = {255, 255, 255}
client.settings.addColor("Color", "color")

positionX = 0
positionY = 0
sizeX = 20
sizeY = 20

text = ""
fps = 0
frames = 1

timer = 0

function update(dt)
    timer = timer + dt
    if timer >= refresh then
        text = math.floor(fps/frames) .. " FPS"
        fps = 0
        frames = 1
        if timer >= 2*refresh then
            timer = 0
        else
            timer = timer - refresh
        end
    end
end

function render(dt)
    fps = fps + ((1/dt) * multiplier)
    frames = frames + 1
    sizeY = gui.font().height + 2
    sizeX = gui.font().width(text) + 2
    gfx.color(background.r, background.g, background.b, background.a)
    gfx.rect(0, 0, sizeX, sizeY)
    gfx.color(color.r, color.g, color.b, color.a)
    gfx.text(1, 1, text)
end