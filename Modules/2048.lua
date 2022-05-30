name="game 2048"
description="2048 game by MCBE"

positionX = 100
positionY = 50
sizeX = 150
sizeY = 150

leftKey = 37
upKey = 38
rightKey = 39
downKey = 40
resetKey = 82

client.settings.addAir(5)
client.settings.addKeybind("Left key", "leftKey")
client.settings.addAir(5)
client.settings.addKeybind("Up key", "upKey")
client.settings.addAir(5)
client.settings.addKeybind("right key", "rightKey")
client.settings.addAir(5)
client.settings.addKeybind("Down key", "downKey")
client.settings.addAir(5)
client.settings.addKeybind("Reset key", "resetKey")

local board = {{0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}}
local boardColors = {{238, 228, 218}, {238, 225, 201}, {243, 178, 122}, {246, 150, 100}, {247, 124, 95}, {247, 95, 59}, {237, 208, 115}, {237, 204, 98}, {236, 200, 90}, {231, 194, 87}, {232, 190, 78}}
local textColors = {{119, 110, 101}, {249, 246, 242}}
local font

local function powerOfTwo(n)
    local result = 1
    for i = 1, n, 1 do
        result = result * 2
    end
    return result .. ""
end

local function emptySpots()
    local result = {}
    for i = 1, 4, 1 do
        for j = 1, 4, 1 do
            if board[i][j] == 0 then
                table.insert(result, {i, j})
            end
        end
    end
    return result
end

local function add()
    local empty = emptySpots()
    if #empty ~= 0 then
        local chosen = empty[math.random(1, #empty)]
        board[chosen[1]][chosen[2]] = 1
        if math.random(1, 10) == 5 then
            board[chosen[1]][chosen[2]] = 2
        end
    end
end

local function left()
    local result = false
    for j = 1, 4, 1 do
        for a = 1, 10, 1 do
            for i = 2, 4, 1 do
                if  board[i][j] ~= 0 then
                    if board[i-1][j] == 0 then
                        board[i-1][j] = board[i][j]
                        board[i][j] = 0
                        result = true
                    end
                    if board[i-1][j] == board[i][j] then
                        board[i-1][j] = board[i][j] + 1
                        board[i][j] = 0
                        result = true
                    end
                end
            end
        end
    end
    return result
end

local function top()
    local result = false
    for i = 1, 4, 1 do
        for a = 1, 10, 1 do
            for j = 2, 4, 1 do
                if  board[i][j] ~= 0 then
                    if board[i][j-1] == 0 then
                        board[i][j-1] = board[i][j]
                        board[i][j] = 0
                        result = true
                    end
                    if board[i][j-1] == board[i][j] then
                        board[i][j-1] = board[i][j] + 1
                        board[i][j] = 0
                        result = true
                    end
                end
            end
        end
    end
    return result
end

local function right()
    local result = false
    for j = 4, 1, -1 do
        for a = 1, 10, 1 do
            for i = 3, 1, -1 do
                if  board[i][j] ~= 0 then
                    if board[i+1][j] == 0 then
                        board[i+1][j] = board[i][j]
                        board[i][j] = 0
                        result = true
                    end
                    if board[i+1][j] == board[i][j] then
                        board[i+1][j] = board[i][j] + 1
                        board[i][j] = 0
                        result = true
                    end
                end
            end
        end
    end
    return result
end

local function bottom()
    local result = false
    for i = 4, 1, -1 do
        for a = 1, 10, 1 do
            for j = 3, 1, -1 do
                if  board[i][j] ~= 0 then
                    if board[i][j+1] == 0 then
                        board[i][j+1] = board[i][j]
                        board[i][j] = 0
                        result = true
                    end
                    if board[i][j+1] == board[i][j] then
                        board[i][j+1] = board[i][j] + 1
                        board[i][j] = 0
                        result = true
                    end
                end
            end
        end
    end
    return result
end

local function start()
    for i = 1, 4, 1 do
        for j = 1, 4, 1 do
            board[i][j] = 0
        end
    end
    add()
    add()
end

local function win()
    for k, v in pairs(board) do
        for k2, v2 in pairs(v) do
            if v2 == 11 then
                return true
            end
        end
    end
    return false
end

start()

function render(dt)
    if not gui.mouseGrabbed() then
        gfx.color(187, 173, 160)
        gfx.roundRect(0, 0, sizeX, sizeY, 3, 3)
        for i = 0, 3, 1 do
            for j = 0, 3, 1 do
                local square = board[i + 1][j + 1]
                if square == 0 then
                    gfx.color(205, 193, 180)
                    gfx.roundRect(((sizeX - 4) / 4)*i + 4, ((sizeY - 4) / 4)*j + 4, (sizeX - 4) / 4 - 4, (sizeY - 4) / 4 - 4, 2, 2)
                else
                    gfx.color(boardColors[square][1], boardColors[square][2], boardColors[square][3])
                    gfx.roundRect(((sizeX - 4) / 4)*i + 4, ((sizeY - 4) / 4)*j + 4, (sizeX - 4) / 4 - 4, (sizeY - 4) / 4 - 4, 2, 2)
                    if square <= 2 then
                        gfx.color(textColors[1][1], textColors[1][2], textColors[1][3])
                    else
                        gfx.color(textColors[2][1], textColors[2][2], textColors[2][3])
                    end
                    local scale = 1
                    if square <= 6 then
                        scale = 2
                    end
                    gfx.text(((sizeX - 4) / 4)*i + (sizeX - 4) / 8 + 2 - gui.font().width(powerOfTwo(square), scale) / 2, ((sizeY - 4) / 4)*j + (sizeY - 4) / 8 + 2 - gui.font().height/(2/scale), powerOfTwo(square), scale)
                end
            end
        end
    end
end

event.listen("KeyboardInput", function(key, down)
    if down and not gui.mouseGrabbed() then
        if key == leftKey then
            if left() then
                add()
            end
        end
        if key == upKey then
            if top() then
                add()
            end
        end
        if key == rightKey then
            if right() then
                add()
            end
        end
        if key == downKey then
            if bottom() then
                add()
            end
        end
        if win() then
            print("win")
            start()
        elseif #emptySpots() == 0 or key == resetKey then
            print("Game over")
            start()
        end
    end
end)
