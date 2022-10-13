
--[[
    made by onix with annoyance
]]

local zzzz_gfx2Colors_lib_internal_colorCodes = {
    c0={0,0,0},
    c1={0,0,170},
    c2={0,170,0},
    c3={0,170,170},
    c4={170,0,0},
    c5={170,0,170},
    c6={255,170,0},
    c7={170,170,170},
    c8={85,85,85},
    c9={85,85,255},
    ca={85,255,85},
    cb={85,255,255},
    cc={255,85,85},
    cd={255,85,255},
    ce={255,255,85},
    cf={255,255,255},
}


function zzzz_gfx2Colors_lib_internal_getColorForCode(code)
    local c = zzzz_gfx2Colors_lib_internal_colorCodes["c"..code]
    if c ~= nil then return table.clone(c) end
    return {255,255,255}
end

function getGfx2Mesh(text, scale)
    local mesh = {}

    local meshParts = {}
    local currentColor = nil

    local textPart = text
    local foundStart = string.find(textPart, "§")
    while foundStart ~= nil do
        local prePart = string.sub(textPart, 1, foundStart-1)
        textPart = string.sub(textPart, foundStart+2)
        if prePart ~= "" then
            table.insert(meshParts, {text=prePart,color=table.clone(currentColor)})
        end
        currentColor = zzzz_gfx2Colors_lib_internal_getColorForCode(string.sub(textPart, 1, 1))
        textPart = string.sub(textPart, 2)
        foundStart = string.find(textPart, "§")
    end

    if textPart ~= "" then table.insert(meshParts, {text=textPart,color=table.clone(currentColor)}) end

    local currX = 0
    for _, part in pairs(meshParts) do
        local width, height = gfx2.textSize(part.text, scale)
        table.insert(mesh, {color=part.color, text=part.text, x=currX})
        currX = currX + width
        mesh.height = height
    end
    mesh.width = currX

    mesh.scale = scale
    function mesh:render(x, y)
        for k, part in pairs(self) do
            if type(part) == "table" then
                if part.color ~= nil then
                    gfx2.color(part.color[1], part.color[2], part.color[3])
                end
                gfx2.text(part.x + x, y, part.text, self.scale)
            end
        end
    end
    return mesh
end


function ImStupidForUsingThis_renderGfx2ColorText(x, y, text, scale)
    local mesh = getGfx2Mesh(text, scale)
    mesh:render(x, y)
end
function ImStupidForUsingThis_renderGfx2ColorTextSize(text, scale)
    local mesh = getGfx2Mesh(text, scale)
    return mesh.width
end
