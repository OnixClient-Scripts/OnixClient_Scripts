name = "Cinematic Black Bar"
description = "Just a random Black Bar that is adjustable"

height = 0
client.settings.addInt('Bar Height','height', 10, 100)

function render(deltaTime)
    screen_width = gui.width()
    screen_height = gui.height()
    posY = screen_height - height

    gfx.color(0,0,0,255)
    gfx.rect(0,0, screen_width,height)
    gfx.rect(0, posY, screen_width, height)

end