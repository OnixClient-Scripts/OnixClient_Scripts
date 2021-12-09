name="Arraylist"
description="Shows what module is enabled"

--[[
    Arraylist Module Script
    
    made by Onix86
]]

function colorFromHue(hue)
    while (hue > 360) do hue = hue - 360 end

    if (hue < 60) then
      return 255, hue*255/60, 0
    elseif (hue < 120.1) then
        return 255 - (hue-60)*255/60, 255, 0
    elseif (hue < 180.1) then
        return 0, 255, (hue-120)*255/60
    elseif (hue < 240.1) then
        return 0, 255 - (hue-180)*255/60, 255
    elseif (hue < 300.1) then
        return (hue-240)*255/60, 0, 255
    elseif (hue < 360.1)  then
        return 255, 0, 255 - (hue-300)*255/60
    end
    return 255,255,255;
end

function update(dt)
    local mods = client.modules()
    local settings = mods[1].settings

end

hue = 0

function render(dt)
    hue = hue + dt * 25
    if hue > 360 then hue = 0 end

    texts = {}

    local font = gui.font()
    local mods = client.modules()
    for k,mod in pairs(mods) do
        if mod.enabled == true then
            table.insert(texts, {length = font.width(mod.name), text = mod.name, tx = 0, ty = 0, x = 0, y = 0, w = 0, h = 0, r = 0, g = 0, b = 0})
        end
    end
    if (texts[1] == nil) then return nil end
    table.sort(texts, function(a,b) return a.length > b.length end)
   
    local txthue = hue
    local y = 0
    for k, t in pairs(texts) do
        local r,g,b = colorFromHue(txthue)
        t.r = r
        t.g = g
        t.b = b
        
        t.x = gui.width() - (t.length + 5)
        t.y = y
        t.w = t.length + 5
        t.h = font.height + 2

        t.tx = t.x + 3
        t.ty = y + 1

        txthue = txthue + 5
        y = y + font.height + 2
    end
    
    --doing them split allows batch rendering which results in better performance
    gfx.color(35, 35, 50)
    for k, t in pairs(texts) do
        gfx.rect(t.x+2, t.y, t.w-2, t.h)
    end
    gfx.color(69,69,69)

    for k, t in pairs(texts) do --texts & rects
        gfx.color(t.r, t.g, t.b)
        gfx.rect(t.x, t.y, 2, t.h)
        gfx.text(t.tx, t.ty, t.text)
    end
end