importLib("charPixel.lua")
importLib("module.lua")


texts = ""
fps = 0
frames = 1

timer = 0
local chromaControlerMod = {}
local intensityPastel, pastelEnabled

function chromaText(x, y, text, opacity)
    chromaControlerMod = getModule("Chroma Controller", true)
    intensityPastel = getSetting(chromaControlerMod, "pastelIntensity").value
    pastelEnabled = getSetting(chromaControlerMod, "pastel").value
    local hue = getSetting(chromaControlerMod, "hue").value
    local hue_shift_speed = getSetting(chromaControlerMod, "hue_shift_speed").value
    opacity = opacity or 255
    local pixels = concatPixLetters(text)
    for i = 0, 127, 1 do
        hue = hue + hue_shift_speed
        if hue > 360 then hue = 0 end
        if hue < 0 then hue = 360 end
        local r, g, b = colorFromHue(hue)
        gfx.color(r, g, b, opacity)
        for j = 0, i, 1 do
            if j < 100 then
                if pixels[j] and pixels[j][i - j] and pixels[j][i - j] == 1 then
                    gfx.rect(i - j + x, j + y, 1, 1)
                end
            end
        end
    end
    for i = 0, 127, 1 do
        hue = hue + hue_shift_speed
        if hue > 360 then hue = 0 end
        if hue < 0 then hue = 360 end
        local r, g, b = colorFromHue(hue)
        gfx.color(r, g, b, opacity)
        for j = 0, 127 - i, 1 do
            if i + j < 100 then
                if pixels[i + j] and pixels[i + j][127 - j] and pixels[i + j][127 - j] == 1 then
                    gfx.rect(127 - j + x, i + j + y, 1, 1)
                end
            end
        end
    end
    hue = hue - hue_shift_speed*128
    while hue < 0 do hue = hue + 360 end
    for i = 127, 254, 1 do
        hue = hue + hue_shift_speed
        if hue > 360 then hue = 0 end
        if hue < 0 then hue = 360 end
        local r, g, b = colorFromHue(hue)
        gfx.color(r, g, b, opacity)
        for j = 0, i, 1 do
            if j < 100 then
                if pixels[j] and pixels[j][i - j] and pixels[j][i - j] == 1 then
                    gfx.rect(i - j + x, j + y, 1, 1)
                end
            end
        end
    end
    for i = 127, 254, 1 do
        hue = hue + hue_shift_speed
        if hue > 360 then hue = 0 end
        if hue < 0 then hue = 360 end
        local r, g, b = colorFromHue(hue)
        gfx.color(r, g, b, opacity)
        for j = 0, 127 - i, 1 do
            if i + j < 100 then
                if pixels[i + j] and pixels[i + j][127 - j] and pixels[i + j][127 - j] == 1 then
                    gfx.rect(127 - j + x, i + j + y, 1, 1)
                end
            end
        end
    end
end

function concatMatrixes(one, two, xoffset, yoffset)
    local result = {}
    for k1, v1 in pairs(one) do
        for k2, v2 in pairs(v1) do
            if not result[k1] then result[k1] ={} end
            result[k1][k2] = v2
        end
    end
    for i1, v1 in pairs(two) do
        for i2, v2 in pairs(v1) do
            if v2 == 1 then
                if not result[i1 + xoffset] then result[i1 + xoffset] ={} end
                result[i1 + xoffset][i2 + yoffset] = 1
            else
                if result[i1 + xoffset] and result[i1 + xoffset][i2 + yoffset] then
                    if result[i1 + xoffset][i2 + yoffset] ~= 1 then
                        result[i1 + xoffset][i2 + yoffset] = 0
                    end
                else
                    if not result[i1 + xoffset] then result[i1 + xoffset] ={} end
                    result[i1 + xoffset][i2 + yoffset] = 0
                end
            end
        end
    end
    return result
end

function chromaTextList(x, y, texts, opacity)
    chromaControlerMod = getModule("Chroma Controller", true)
    intensityPastel = getSetting(chromaControlerMod, "pastelIntensity").value
    pastelEnabled = getSetting(chromaControlerMod, "pastel").value
    local hue = getSetting(chromaControlerMod, "hue").value
    local hue_shift_speed = getSetting(chromaControlerMod, "hue_shift_speed").value
    opacity = opacity or 255
    local pixels = {}
    for i, v in ipairs(texts) do
        pixels = concatMatrixes(pixels, concatPixLetters(v.text), v.y, v.x)
    end
    for i = 0, 127, 1 do
        hue = hue + hue_shift_speed
        if hue > 360 then hue = 0 end
        if hue < 0 then hue = 360 end
        local r, g, b = colorFromHue(hue)
        gfx.color(r, g, b, opacity)
        for j = 0, i, 1 do
            if j < 100 then
                if pixels and pixels[j] and pixels[j][i - j] and pixels[j][i - j] == 1 then
                    gfx.rect(i - j + x, j + y, 1, 1)
                end
            end
        end
    end
    for i = 0, 127, 1 do
        hue = hue + hue_shift_speed
        if hue > 360 then hue = 0 end
        if hue < 0 then hue = 360 end
        local r, g, b = colorFromHue(hue)
        gfx.color(r, g, b, opacity)
        for j = 0, 127 - i, 1 do
            if i + j < 100 then
                if pixels and pixels[i + j] and pixels[i + j][127 - j] and pixels[i + j][127 - j] == 1 then
                    gfx.rect(127 - j + x, i + j + y, 1, 1)
                end
            end
        end
    end
    hue = hue - hue_shift_speed*128
    while hue < 0 do hue = hue + 360 end
    for i = 127, 254, 1 do
        hue = hue + hue_shift_speed
        if hue > 360 then hue = 0 end
        if hue < 0 then hue = 360 end
        local r, g, b = colorFromHue(hue)
        gfx.color(r, g, b, opacity)
        for j = 0, i, 1 do
            if j < 100 then
                if pixels and pixels[j] and pixels[j][i - j] and pixels[j][i - j] == 1 then
                    gfx.rect(i - j + x, j + y, 1, 1)
                end
            end
        end
    end
    for i = 127, 254, 1 do
        hue = hue + hue_shift_speed
        if hue > 360 then hue = 0 end
        if hue < 0 then hue = 360 end
        local r, g, b = colorFromHue(hue)
        gfx.color(r, g, b, opacity)
        for j = 0, 127 - i, 1 do
            if i + j < 100 then
                if pixels and pixels[i + j] and pixels[i + j][127 - j] and pixels[i + j][127 - j] == 1 then
                    gfx.rect(127 - j + x, i + j + y, 1, 1)
                end
            end
        end
    end
end

function colorFromHue(hue)
    local r, g, b = colorFromHue2(hue)
    if pastelEnabled then
        return math.max(intensityPastel, r), math.max(intensityPastel, g), math.max(intensityPastel, b)
    end
    return r, g, b
end

function colorFromHue2(hue)
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
    return 255,255,255
end



