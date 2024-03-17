name = "nethercoordinatetranslator"
description = "convert overworld coords to nether coords and vice versa"

--[[
    nethercoordinatetranslator

	made by shige with massive help from onix (thank u!)
]]

showXYZ = true
sameLine = false

positionX = 20
positionY = 80
sizeX = 40
sizeY = 30
scale = 1

client.settings.addBool("Show X: Y: Z:", "showXYZ")
client.settings.addBool("Display on the Same Line", "sameLine")
client.settings.addAir(15)
color = client.settings.addNamelessColor("Text Color", { 255, 255, 255, 255 })
background_color = client.settings.addNamelessColor("Background Color", { 0, 0, 0, 128 })

function render(deltaTime)
    local player_x, player_y, player_z = player.position()


    if (dimension.id() == 1) then -- one is the nether
        player_x = math.floor(player_x * 8)
        player_z = math.floor(player_z * 8)
    else
        player_x = math.floor(player_x / 8)
        player_z = math.floor(player_z / 8)
    end

    -- the display part of this script

    if showXYZ == true then
        textX = "X: "
        textY = "Y: "
        textZ = "Z: "
    else
        textX = ""
        textY = ""
        textZ = ""
    end

    if sameLine == true then
        sizeX = 20
        sizeY = 8
        local text = textX .. player_x .. " " .. textY .. player_y .. " " .. textZ .. player_z
        local font = gui.font()

        gfx.color(background_color.value.r, background_color.value.g, background_color.value.b, background_color.value.a)
        sizeX = font.width(text, 1) + 3
        gfx.rect(0, 0, sizeX, 8)

        gfx.color(color.value.r, color.value.g, color.value.b, color.value.a)
        gfx.text(1, 0, text)
    else
        sizeX = 35
        sizeY = 30
        gfx.color(background_color.value.r, background_color.value.g, background_color.value.b, background_color.value.a)
        gfx.rect(0, 0, 35, 30)

        gfx.color(color.value.r, color.value.g, color.value.b, color.value.a)
        gfx.text(1, 3, textX .. player_x)
        gfx.text(1, 11, textY .. player_y)
        gfx.text(1, 19, textZ .. player_z)
    end
end
