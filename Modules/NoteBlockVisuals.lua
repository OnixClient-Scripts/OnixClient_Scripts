name = "Note Block Note Visuals"
description = "Display the note of a note block on a somewhat customizable Display.\n(Only Works In Singleplayer Worlds)"

showText = true
showCurrentText = true
showNextText = false
backColor = {255,255,255,255}
textColor = {0,0,0,255}
roundRadius = 0
roundQuality = 0
numNotNote = false
local currentNoteNum = 0
local nextNoteNum = 1
local currentNoteNote = "F#"
local nextNoteNote = "G"

positionX = 100
positionY = 100
sizeX = 62
sizeY = 12

client.settings.addBool("Show Current Note", "showCurrentText")
client.settings.addBool("Show Next Note", "showNextText")
client.settings.addBool("Show Numbers Instead Of Notes", "numNotNote")
client.settings.addAir(8)
client.settings.addBool("Show 'Current' And 'Next' Text (Recomended)", "showText")
client.settings.addAir(8)
client.settings.addColor("Backround Color", "backColor")
client.settings.addAir(2)
client.settings.addColor("Text Color", "textColor")
client.settings.addAir(8)
client.settings.addFloat("Round Corner Radius", "roundRadius", 0, 20)
client.settings.addAir(2)
client.settings.addInt("Round Corner Quality", "roundQuality", 0, 75)

function render(deltaTime)
    local x,y,z = player.selectedPos()
    local block = dimension.getBlock(math.floor(x),math.floor(y),math.floor(z))
    if block.name == "noteblock" then
        gfx.color(backColor.r,backColor.g,backColor.b,backColor.a)
        gfx.roundRect(0,0,sizeX,sizeY,roundRadius,roundQuality)
        gfx.color(textColor.r,textColor.g,textColor.b)
        if numNotNote == true then
            if showText == false then
                sizeX = 15
                if showCurrentText == true and showNextText == true then
                    gfx.text(3,3,"" .. currentNoteNum)
                    gfx.text(3,12,"" .. nextNoteNum)
                else
                    if showCurrentText == true and showNextText == false then
                        gfx.text(3,3,"" .. currentNoteNum)
                    else
                        if showCurrentText == false and showNextText == true then
                            gfx.text(3,3,"" .. nextNoteNum)
                        else
                        end
                    end
                end              
            else
                sizeX = 67
                if showCurrentText == true and showNextText == true then
                    gfx.text(3,3,"Current Note: " .. currentNoteNum)
                    gfx.text(3,12,"Next Note: " .. nextNoteNum)
                else
                    if showCurrentText == true and showNextText == false then
                        gfx.text(3,3,"Current Note: " .. currentNoteNum)
                    else
                        if showCurrentText == false and showNextText == true then
                            gfx.text(3,3,"Next Note: " .. nextNoteNum)
                        else
                        end
                    end
                end 
            end
        else
            notes = {"F#", "G", "G#", "A", "A#", "B", "C", "C#", "D", "D#", "E", "F","F#", "G", "G#", "A", "A#", "B", "C", "C#", "D", "D#", "E", "F", "F#"}
            currentNoteNote = notes[currentNoteNum]
            if currentNoteNum ~= 25 then
                nextNoteNote = notes[currentNoteNum + 1]
            else        
                nextNoteNote = "F#"
            end
            if showText == false then
                sizeX = 17
                if showCurrentText == true and showNextText == true then
                    gfx.text(3,3,"" .. currentNoteNote)
                    gfx.text(3,12,"" .. nextNoteNote)
                else
                    if showCurrentText == true and showNextText == false then
                        gfx.text(3,3,"" .. currentNoteNote)
                    else
                        if showCurrentText == false and showNextText == true then
                            gfx.text(3,3,"" .. nextNoteNote)
                        else
                        end
                    end
                end              
            else
                sizeX = 69
                if showCurrentText == true and showNextText == true then
                    gfx.text(3,3,"Current Note: " .. currentNoteNote)
                    gfx.text(3,12,"Next Note: " .. nextNoteNote)
                else
                    if showCurrentText == true and showNextText == false then
                        gfx.text(3,3,"Current Note: " .. currentNoteNote)
                    else
                        if showCurrentText == false and showNextText == true then
                            gfx.text(3,3,"Next Note: " .. nextNoteNote)
                        else
                        end
                    end
                end 
            end
        end
        if showCurrentText == true and showNextText == true then
            sizeY = 22
        else
            if showCurrentText == true and showNextText == false then
                sizeY = 12
            else
                if showCurrentText == false and showNextText == true then
                    sizeY = 12
                else
                    sizeY = 0
                end
            end
        end
    end
end

event.listen("LocalServerUpdate", function()
    local x,y,z = player.selectedPos()
    local block = dimension.getBlock(math.floor(x),math.floor(y),math.floor(z))
    if block.name == "noteblock" then
        local serverBlock = dimension.getBlockEntity(x,y,z, true)
        local note = serverBlock["note"]
        if note ~= nil then
            if note ~= 24 then
                currentNoteNum = note + 1
                nextNoteNum = currentNoteNum + 1
            else
                currentNoteNum = note + 1
                nextNoteNum = 1
            end
        end
    end
end)