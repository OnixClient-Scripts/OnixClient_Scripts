name="Arraylist"
description="Shows what module is enabled"

--[[
    Arraylist Module Script
    
    made by Onix86
]]

hue_shift_speed = 5
client.settings.addFloat("Hue Shift Speed", "hue_shift_speed", 0.2, 35)

rainbow_speed = 25
client.settings.addFloat("Rainbow Update Speed", "rainbow_speed", 1, 500)

slow_update = false
client.settings.addBool("Slow Updates (FPS+)", "slow_update")

connect_lines = true
client.settings.addBool("ConnectLines", "connect_lines")

function colorFromHue(hue)
    while (hue > 360) do hue = hue - 360 end
    while (hue < 0  ) do hue = hue + 360 end

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

texts = {}

function _update(dt)
    hue = hue + dt * rainbow_speed
    if hue > 360 then hue = 0 end
    if hue < 0 then hue = 360 end

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

        txthue = txthue - hue_shift_speed
        y = y + font.height + 2
    end
end



function update(dt)
    if (slow_update == true) then
        _update(dt)
    end
end

hue = 0

function render(dt)
    if (slow_update == false) then
        _update(dt)
    end
    
    --doing them split allows batch rendering which results in better performance
    gfx.color(35, 35, 50)
    for k, t in pairs(texts) do
        gfx.rect(t.x+2, t.y, t.w-2, t.h)
    end
    local lastConnection = texts[1].x
    for k, t in pairs(texts) do --texts & rects
        gfx.color(255 - t.r, 255 - t.g, 255 - t.b)
        gfx.rect(t.x, t.y, 2, t.h)
        gfx.text(t.tx, t.ty, t.text)

        if connect_lines == true then
            gfx.rect(lastConnection, t.y, t.x - lastConnection, 2)
            lastConnection = t.x
        end
    end
end
