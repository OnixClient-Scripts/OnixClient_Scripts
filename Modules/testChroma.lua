name="Chroma"
description="AAAAAAA"

importLib("chroma.lua")


positionX = 100
positionY = 100
sizeX = 100
sizeY = 100
function render(dt)
    chromaText(0, 0, "Hello")
    chromaText(0, 10, "Onix Client people")
    chromaText(0, 20, "How are you doing?")
    chromaText(0, 30, "abcdefghijklmnopqr")

    
    local texts = {
        {text="Hello", x=0, y=0},
        {text="Onix Client people", x=9, y=10},
        {text="How are you doing?", x=0, y=20},
        {text="abcdefghijklmnopqr", x=0, y=30}
    }
    chromaTextList(100, 100, texts)
end









