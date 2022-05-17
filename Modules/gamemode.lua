name="Gamemode Switcher"
description = "Gamemode Switcher by MCBE Craft allows you to switch gamemode\nlike on java"

client.settings.addAir(5)
holdKey = 0x72 --F3
client.settings.addKeybind("Hold key to open menu", "holdKey")

client.settings.addAir(5)
nextKey = 0x73 --F4
client.settings.addKeybind("Hold key to change gamemode", "nextKey")

client.settings.addAir(5)
backgroundColor = {0, 0, 0, 127}
client.settings.addColor("Background color", "backgroundColor")

library = importLib("keyconverter.lua")

local keyHeld = false
local atlasPath = "textures/gui/gui2.png"
local posX = 100
local posY = 100
local gamemodes = {"Survival Mode", "Creative Mode", "Adventure Mode"}
local gamemodeIcons = {"textures/items/iron_sword.png", "textures/blocks/grass_side_carried.png", "textures/items/map_empty.png"}
local gamemodeCommands = {"execute /gamemode s", "execute /gamemode c", "execute /gamemode a"}
local gamemode = 0

function render(dt)
    if keyHeld then
        posX = gui.width() / 2 - 41
        posY = gui.height() / 2 - 52
        gfx.color(backgroundColor.r, backgroundColor.g, backgroundColor.b, backgroundColor.a)
        gfx.roundRect(posX, posY, 82, 74, 5, 5)
        gfx.roundRect(posX, posY, 82, 20, 5, 5)
        --gfx.color(backgroundColor.r, backgroundColor.g, backgroundColor.b, backgroundColor.a * 2)
        for i = 0, 2, 1 do
            gfx.ctexture(posX + 4 + i*26, posY + 28, 11, 22, atlasPath, 0, 0, 0.04296874999, 0.08593749999)
            gfx.ctexture(posX + 15 + i*26, posY + 28, 11, 22, atlasPath, 0.66796875, 0, 0.04296874999, 0.08593749999)
        end
        gfx.fimage()
        gfx.ctexture(posX + 4 + gamemode*26, posY + 28, 11, 22, atlasPath, 0, 0, 0.04296874999, 0.08593749999)
        gfx.ctexture(posX + 15 + gamemode*26, posY + 28, 11, 22, atlasPath, 0.66796875, 0, 0.04296874999, 0.08593749999)
        gfx.cfimage(255, 255, 0, 255)
        for i = 0, 2, 1 do
            gfx.texture(posX + 8 + i*26, posY + 32, 14, 14, gamemodeIcons[i + 1])
        end
        gfx.color(255, 255, 255, 255)
        local text = gamemodes[gamemode + 1]
        local font = gui.font()
        local sizeX = font.width(text)
        gfx.text(gui.width() / 2 - sizeX / 2, posY + 5, text)
        text = " [ " .. keytostr(nextKey) .. " ] Next"
        sizeX = font.width(text)
        gfx.text(gui.width() / 2 - sizeX / 2, posY + 70 - font.height, "§b[ " .. keytostr(nextKey) .. " ]§r Next")
    end
end


event.listen("KeyboardInput", function(key, down)
    if key == holdKey then
        keyHeld = down
        if not down and gamemode ~= mcToGamemode(player.gamemode())  then
            client.execute(gamemodeCommands[gamemode + 1])
        end
        gamemode = mcToGamemode(player.gamemode())
        return true
    end
    if key == nextKey and down and keyHeld then
        gamemode = gamemode + 1
        if gamemode > 2 then
            gamemode = 0
        end
        return true
    end
end)

function mcToGamemode(gm)
    if gm == 3 then
        return 0
    elseif gm == 4 then
        return 1
    elseif gm == 5 then
        return 0
    else
        return gm
    end
end

