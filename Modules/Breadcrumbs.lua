name = "Breadcrumbs"
description = "Adds a breadcrumb trail behind you."

r,g,b,a = 255,100,100,255
limit = client.settings.addNamelessInt("Limit", 1, 100000, 1000)
client.settings.addAir(5)

hideInFirstPerson = client.settings.addNamelessBool("Hide in first person", false)
followCursor = client.settings.addNamelessBool("Follow cursor", false)
howFar = client.settings.addNamelessFloat("Distance (Literally)", 0.1, 100, 1.5)

function update()
    if followCursor.value then
        howFar.visible = true
    else
        howFar.visible = false
    end
end

positions = {}
headPositions = {}

function renderDaLine()
    for i, v in ipairs(positions) do
        local x1, y1, z1 = v[1], v[2], v[3]
        local x2, y2, z2 = positions[i+1] and positions[i+1][1] or x1, positions[i+1] and positions[i+1][2] or y1, positions[i+1] and positions[i+1][3] or z1
        gfx.line(x1, y1, z1, x2, y2, z2)
    end
end

function followCursora()
    if followCursor.value then
        local hx,hy,hz = player.forwardPosition(howFar.value)
        for i,v in pairs(headPositions) do
            if v[1] == hx and v[2] == hy and v[3] == hz then
                table.remove(headPositions, i)
            end
        end
        table.insert(headPositions, {hx, hy, hz})
        if #headPositions > limit.value then
            table.remove(headPositions, 1)
        end
        for i, v in ipairs(headPositions) do
            local x1, y1, z1 = v[1], v[2], v[3]
            local x2, y2, z2 = headPositions[i+1] and headPositions[i+1][1] or x1, headPositions[i+1] and headPositions[i+1][2] or y1, headPositions[i+1] and headPositions[i+1][3] or z1
            gfx.line(x1, y1, z1, x2, y2, z2)
        end
    end
end

function render3d()
    gfx.color(r,g,b,a)
    followCursora()
    local x, y, z = player.pposition()
    for i,v in pairs(positions) do
        if v[1] == x and v[2] == y and v[3] == z then
            table.remove(positions, i)
        end
    end
    table.insert(positions, {x, y-1.5, z})
    if #positions > limit.value then
        table.remove(positions, 1)
    end
    if hideInFirstPerson.value == false then
        renderDaLine()
    else
        if player.perspective() == 0 then
            return
        else
            renderDaLine()
        end
    end

end