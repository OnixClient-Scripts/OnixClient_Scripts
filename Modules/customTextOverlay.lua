-- Made By O2Flash20 🙂
name = "Custom Text Overlay"
description = "Displays the text of your choice to the screen."

positionX = 10
positionY = 100
sizeX = 60
sizeY = 7

textSetting = client.settings.addNamelessTextbox("Text", "hello there")
textColorSetting = client.settings.addNamelessColor("Text Color", { 255, 255, 255, 255 })
bgColorSetting = client.settings.addNamelessColor("Background Color", { 51, 51, 51, 100 })
paddingSetting = client.settings.addNamelessFloat("Padding", 0, 10, 1)

function render()
    local font = gui.font()
    sizeX = font.width(textSetting.value) + 0.2 + paddingSetting.value * 2
    sizeY = font.height * 1.2 + paddingSetting.value * 2

    gfx.color(bgColorSetting.value.r, bgColorSetting.value.g, bgColorSetting.value.b, bgColorSetting.value.a)
    gfx.rect(
        0, 0,
        font.width(textSetting.value) + 0.2 + paddingSetting.value * 2,
        font.height * 1.2 + paddingSetting.value * 2
    )

    gfx.color(textColorSetting.value.r, textColorSetting.value.g, textColorSetting.value.b, textColorSetting.value.a)
    gfx.text(paddingSetting.value, paddingSetting.value, textSetting.value)
end
