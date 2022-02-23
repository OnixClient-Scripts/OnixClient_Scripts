name = "More Keystrokes"
description = "More keystrokes by raspberry :)"
--variables
positionX = 6
positionY = 60
sizeX = 22
sizeY = 110
--imports
importLib('keytostring.lua')
--colors
text = {255,255,255,255}
background = {0,0,0,128}
pressed = {255,255,255,255}
kbcolorpressed1 = {0,0,0,0}
kbcolorpressed2 = {0,0,0,0}
kbcolorpressed3 = {0,0,0,0}
kbcolorpressed4 = {0,0,0,0}
kbcolorpressed5 = {0,0,0,0}
kbcolorpressed6 = {0,0,0,0}
kbcolorpressed7 = {0,0,0,0}
kbcolorpressed8 = {0,0,0,0}
kbcolorpressed9 = {0,0,0,0}
kbcolorpressed10 = {0,0,0,0}
client.settings.addColor("Text Color", "text")
client.settings.addColor("Background Color", "background")
client.settings.addColor("Pressed Color", "pressed")
--keybinds
keybind1 = 0x30
keybind2 = 0x31
keybind3 = 0x32
keybind4 = 0x33
keybind5 = 0x34
keybind6 = 0x35
keybind7 = 0x36
keybind8 = 0x37
keybind9 = 0x38
keybind10 = 0x39
client.settings.addKeybind("Keybind 1","keybind1")
client.settings.addKeybind("Keybind 2","keybind2")
client.settings.addKeybind("Keybind 3","keybind3")
client.settings.addKeybind("Keybind 4","keybind4")
client.settings.addKeybind("Keybind 5","keybind5")
client.settings.addKeybind("Keybind 6","keybind6")
client.settings.addKeybind("Keybind 7","keybind7")
client.settings.addKeybind("Keybind 8","keybind8")
client.settings.addKeybind("Keybind 9","keybind9")
client.settings.addKeybind("Keybind 10","keybind10")
--extra things to be used
pressedkey=0x30
function kbpress(key, isDown)
    if isDown then
        if key == keybind1 then
            kbcolorpressed1 = pressed
        elseif key == keybind2 then
            kbcolorpressed2 = pressed
        elseif key == keybind3 then
            kbcolorpressed3 = pressed
        elseif key == keybind4 then
            kbcolorpressed4 = pressed
        elseif key == keybind5 then
            kbcolorpressed5 = pressed
        elseif key == keybind6 then
            kbcolorpressed6 = pressed
        elseif key == keybind7 then
            kbcolorpressed7 = pressed
        elseif key == keybind8 then
            kbcolorpressed8 = pressed
        elseif key == keybind9 then
            kbcolorpressed9 = pressed
        elseif key == keybind10 then
            kbcolorpressed10 = pressed
        end
    else
        if key == keybind1 then
            kbcolorpressed1 = {0,0,0,0}
        end
        if key == keybind2 then
            kbcolorpressed2 = {0,0,0,0}
        end
        if key == keybind3 then
            kbcolorpressed3 = {0,0,0,0}
        end
        if key == keybind4 then
            kbcolorpressed4 = {0,0,0,0}
        end
        if key == keybind5 then
            kbcolorpressed5 = {0,0,0,0}
        end
        if key == keybind6 then
            kbcolorpressed6 = {0,0,0,0}
        end
        if key == keybind7 then
            kbcolorpressed7 = {0,0,0,0}
        end
        if key == keybind8 then
            kbcolorpressed8 = {0,0,0,0}
        end
        if key == keybind9 then
            kbcolorpressed9 = {0,0,0,0}
        end
        if key == keybind10 then
            kbcolorpressed10 = {0,0,0,0}
        end
        
    end
end
event.listen("KeyboardInput", kbpress)
function update(deltaTime)
    
end

function render(deltaTime)
    local font = gui.font()
    --key1
    gfx.color(background.r,background.g,background.b,background.a)
    gfx.rect(0,0,22,10)
    gfx.color(kbcolorpressed1.r,kbcolorpressed1.g,kbcolorpressed1.b,kbcolorpressed1.a)
    gfx.rect(0,0,22,10)
    gfx.color(text.r,text.g,text.b,text.a)
    gfx.text(9,2,keytostr(keybind1))
    --key2
    gfx.color(background.r,background.g,background.b,background.a)
    gfx.rect(0,11,22,10)
    gfx.color(kbcolorpressed2.r,kbcolorpressed2.g,kbcolorpressed2.b,kbcolorpressed2.a)
    gfx.rect(0,11,22,10)
    gfx.color(text.r,text.g,text.b,text.a)
    gfx.text(9,13,keytostr(keybind2))
    --key3
    gfx.color(background.r,background.g,background.b,background.a)
    gfx.rect(0,22,22,10)
    gfx.color(kbcolorpressed3.r,kbcolorpressed3.g,kbcolorpressed3.b,kbcolorpressed3.a)
    gfx.rect(0,22,22,10)
    gfx.color(text.r,text.g,text.b,text.a)
    gfx.text(9,24,keytostr(keybind3))
    --key4
    gfx.color(background.r,background.g,background.b,background.a)
    gfx.rect(0,33,22,10)
    gfx.color(kbcolorpressed4.r,kbcolorpressed4.g,kbcolorpressed4.b,kbcolorpressed4.a)
    gfx.rect(0,33,22,10)
    gfx.color(text.r,text.g,text.b,text.a)
    gfx.text(9,35,keytostr(keybind4))
    --key5
    gfx.color(background.r,background.g,background.b,background.a)
    gfx.rect(0,44,22,10)
    gfx.color(kbcolorpressed5.r,kbcolorpressed5.g,kbcolorpressed5.b,kbcolorpressed5.a)
    gfx.rect(0,44,22,10)
    gfx.color(text.r,text.g,text.b,text.a)
    gfx.text(9,46,keytostr(keybind5))
    --key6
    gfx.color(background.r,background.g,background.b,background.a)
    gfx.rect(0,55,22,10)
    gfx.color(kbcolorpressed6.r,kbcolorpressed6.g,kbcolorpressed6.b,kbcolorpressed6.a)
    gfx.rect(0,55,22,10)
    gfx.color(text.r,text.g,text.b,text.a)
    gfx.text(9,57,keytostr(keybind6))
    --key7
    gfx.color(background.r,background.g,background.b,background.a)
    gfx.rect(0,66,22,10)
    gfx.color(kbcolorpressed7.r,kbcolorpressed7.g,kbcolorpressed7.b,kbcolorpressed7.a)
    gfx.rect(0,66,22,10)
    gfx.color(text.r,text.g,text.b,text.a)
    gfx.text(9,68,keytostr(keybind7))
    --key8
    gfx.color(background.r,background.g,background.b,background.a)
    gfx.rect(0,77,22,10)
    gfx.color(kbcolorpressed8.r,kbcolorpressed8.g,kbcolorpressed8.b,kbcolorpressed8.a)
    gfx.rect(0,77,22,10)
    gfx.color(text.r,text.g,text.b,text.a)
    gfx.text(9,79,keytostr(keybind8))
    --key9
    gfx.color(background.r,background.g,background.b,background.a)
    gfx.rect(0,88,22,10)
    gfx.color(kbcolorpressed9.r,kbcolorpressed9.g,kbcolorpressed9.b,kbcolorpressed9.a)
    gfx.rect(0,88,22,10)
    gfx.color(text.r,text.g,text.b,text.a)
    gfx.text(9,90,keytostr(keybind9))
    --key10
    gfx.color(background.r,background.g,background.b,background.a)
    gfx.rect(0,99,22,10)
    gfx.color(kbcolorpressed10.r,kbcolorpressed10.g,kbcolorpressed10.b,kbcolorpressed10.a)
    gfx.rect(0,99,22,10)
    gfx.color(text.r,text.g,text.b,text.a)
    gfx.text(9,101,keytostr(keybind10))



end