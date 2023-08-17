name = "Block Info"
description = "Tells you what block you are looking at, displays the texture and gives you the block ID"

TextColor = {255,255,255,255}
BackColor = {0,0,0,128}
client.settings.addAir(3)
client.settings.addTitle("Colour Configuration")
client.settings.addColor("Text Color", "TextColor")
client.settings.addColor("Background Color", "BackColor")
client.settings.addInfo("If you find any textures have been missed, contact daniel_ryan")

function render()
    local x, y, z = player.selectedPos()
    local block = dimension.getBlock(x, y, z)
    
    local name = block.name
    local id = tostring(block.id)
    
    local formattedName = name:gsub("_", " ")
    formattedName = formattedName:gsub("(%w)(%w*)", function(first, rest)
        return first:upper()..rest:lower()
    end)
    local display = formattedName .. "\nID:" .. id
    
    gfx.color(BackColor.r, BackColor.g, BackColor.b, BackColor.a)
    gfx.rect(0, 0, 100, 20)
    gfx.color(TextColor.r, TextColor.g, TextColor.b, TextColor.a)
    gfx.text(0, 0, display)

    local fileFormat = ".png"
    local filepath = "blocks/" .. name .. fileFormat  -- Adding "blocks/" to the filepath
    gfx.loadImage(filepath)
    gfx.image(0, 20, 30, 30, filepath)
end
