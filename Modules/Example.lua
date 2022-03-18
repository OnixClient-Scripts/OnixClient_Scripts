name = "Example"
description = "A Simple \"Hello World\""


function update(deltaTime) --about 10 times per second, DON'T USE GFX inside

end


function render(deltaTime) --every frame, you can use gfx inside
    gfx.color(255,0,50, 150)

    local font = gui.font()
    gfx.rect(50, 25, font.width("Hello world!"), font.height)
    gfx.color(255, 255, 255)
    gfx.text(50, 25, "Hello world!")
end
