--Made by Zeyrox1090 aka Blueberry#5784
--thanks to 02flash20 for the update every second function
--thanks to raspberry for emotional support
name = "Tetrizz"
description = "Tetris in minecraft"
positionX = 100
positionY = 50
sizeX = 100
sizeY = 200

up_key = 38
down_key = 40
left_key = 37
right_key = 39
pause_key = 190
client.settings.addKeybind("Up", "up_key")
client.settings.addKeybind("Down", "down_key")
client.settings.addKeybind("Left", "left_key")
client.settings.addKeybind("Right", "right_key")
client.settings.addKeybind("Pause/Play", "pause_key")
lines_cleared = 0
current_cleared_line = 0
levels = 0
score = 0
pause_text = nil
text_offset = nil
t = 0
canSpeedDown = true
tetromino_x = 4
rot_number = 0
color = 0
paused = false
local tetromino_colors = {
    [0] = { 0, 0, 0 },
    [1] = { 0, 240, 240 },
    [2] = { 0, 0, 240 },
    [3] = { 240, 160, 0 },
    [4] = { 240, 240, 0 },
    [5] = { 0, 240, 0 },
    [6] = { 160, 0, 240 },
    [7] = { 240, 0, 0 },
    [8] = { 0, 240, 240 },
    [9] = { 0, 0, 240 },
    [10] = { 240, 160, 0 },
    [11] = { 240, 240, 0 },
    [12] = { 0, 240, 0 },
    [13] = { 160, 0, 240 },
    [14] = { 240, 0, 0 }
}
lookup_table = { [1] = 8, [2] = 9, [3] = 10, [4] = 11, [5] = 12, [6] = 13, [7] = 14 }
tetromino_shapes = {
    -- I-shape
    { { 1, 1, 1, 1 } },
    -- J-shape
    { { 2, 0, 0 }, { 2, 2, 2 } },
    -- L-shape
    { { 0, 0, 3 }, { 3, 3, 3 } },
    -- O-shape
    { { 4, 4 }, { 4, 4 } },
    -- S-shape
    { { 0, 5, 5 }, { 5, 5, 0 } },
    -- T-shape
    { { 0, 6, 0 }, { 6, 6, 6 } },
    -- Z-shape
    { { 7, 7, 0 }, { 0, 7, 7 } }
}
board = {}
for x = 0, 9 do
    board[x] = {}
    for y = 0, 19 do
        board[x][y] = 0
    end
end
next_board = {}
for x = 0, 4 do
    next_board[x] = {}
    for y = 0, 4 do
        next_board[x][y] = 0
    end
end

function render2()
    if not gui.mouseGrabbed() then
        gfx2.color(128, 128, 128)
        gfx2.fillRoundRect((sizeX / 10) * -1, (sizeY / 20) * -1, sizeX + 20, sizeY + 20, (sizeX / 20))
        gfx2.fillRoundRect((sizeX / 10) * 10, (sizeY / 20) * -1, (sizeX / 2) + 10, sizeY / 2, (sizeX / 20))
        gfx2.color(0, 0, 0)
        gfx2.fillRoundRect((sizeX / 10) * 11, (sizeY / 20) * 0, sizeX / 2 - 10, (sizeY / 2 - 20), (sizeX / 20))
        if not paused then
            for i = 0, #board do
                for j = 0, #board[i] do
                    local color = tetromino_colors[board[i][j]]
                    if color then
                        gfx2.color(table.unpack(color))
                        gfx2.fillRect((sizeX / 10) * i, (sizeY / 20) * j, sizeX / 10, sizeY / 20)
                        gfx2.color(128, 128, 128)
                        gfx2.fillRect((sizeX / 10) * i, (sizeY / 20) * j, sizeX / 10, sizeY / 800)
                        gfx2.fillRect((sizeX / 10) * i, (sizeY / 20) * j, sizeX / 400, sizeY / 20)
                    end
                end
            end
        else
            gfx2.color(0,0,0)
            gfx2.fillRect(0, 0, sizeX, sizeY)
            gfx2.color(255,255,255)
            gfx2.text(text_offset,sizeY/2-7,pause_text,1.5)
            gfx2.text(sizeX/2/2-1,sizeY/2+7,"Press play("..keytostr(pause_key)..") to continue",0.7)
            if pause_text == "You Lose" then
                lose_score = score
                lose_lines_cleared = lines_cleared
                lose_levels = levels
                gfx2.text(sizeX/2/2-1,sizeY/2+13,"Score:"..tostring(lose_score),0.7)
                gfx2.text(sizeX/2/2-1,sizeY/2+19,"Lines Cleared:"..tostring(lose_lines_cleared),0.7)
                gfx2.text(sizeX/2/2-1,sizeY/2+25,"Level:"..tostring(lose_levels),0.7)
            end
        end
        for i = 0, #next_board do
            for j = 0, #next_board[i] do
                local color = tetromino_colors[next_board[i][j]]
                if color then
                    gfx2.color(table.unpack(color))
                    gfx2.fillRect((sizeX / 20) * (i + 23), (sizeY / 40) * j + 11, sizeX / 20, sizeX / 20)
                end
            end
        end
        gfx2.color(255, 255, 255)
        gfx2.text((sizeX / 10) * 11.3, (sizeY / 20) * 0.2, "Next:", 0.7)
        gfx2.text((sizeX / 10) * 11.3, (sizeY / 20) * 4, "Score:\n" .. tostring(score), 0.7)
        gfx2.text((sizeX / 10) * 11.3, (sizeY / 20) * 5.2, "Lines Cleared:\n" .. tostring(lines_cleared), 0.7)
        gfx2.text((sizeX / 10) * 11.3, (sizeY / 20) * 6.4, "Level:\n" .. tostring(levels), 0.7)
    end
end

function postInit()
    next_tetromino = math.random(#tetromino_shapes)
    spawnTetromino()
end

function update()
    if not paused then
        t = (t + 1) % math.floor(8 / (levels / 2 + 0.5))
        if t == 0 then
            moveTetrominoDown()
        end
        if lose then
            board = {}
            for x = 0, 9 do
                board[x] = {}
                for y = 0, 19 do
                    board[x][y] = 0
                end
            end
            
            text_offset = sizeX/2/2+5
            pause_text = "You Lose" 
            spawnTetromino()
            lose = false
            paused = true
        end
        updateCoords()
    end
end

function updateCoords()
    for x = 0, 9 do
        for y = 19, 0, -1 do
            if movable(x, y) then
                tetromino_x= x
                tetromino_y= y
                return
            end
        end
    end
end
event.listen("KeyboardInput", function(key, down)
    if not gui.mouseGrabbed() then
        if not paused then
            if key == left_key and down then --left arrow key
                moveTetrominoLeft()
            end
            if key == right_key and down then --right arrow key
                moveTetrominoRight()
            end
            if key == down_key and down then --down arrow key
                for i = 0, 19 do
                    if canSpeedDown then
                        moveTetrominoDown()
                    end
                    if i == 19 then
                        canSpeedDown = true
                    end
                end
            end
            if key == up_key and down then --up arrow key
                if color == 1 or color == 5 or color == 7 then
                    rot_number = (rot_number + 1) % 2
                    rotateTetromino()
                elseif color == 6 then
                    if not ((tetromino_x == 8 and rot_number == 0) or (tetromino_x == 0 and rot_number == 2)) then
                        rot_number = (rot_number + 1) % 4
                        rotateTetromino()
                    end
                else
                    rotateTetromino()
                end
            end
        end
        if key == pause_key and down then
            if pause_text == "You Lose" then
                score = 0
                lines_cleared = 0
                levels = 0
            end
            text_offset = sizeX/2/2/2+5
            pause_text = "Game Paused"
            paused = not paused
        end
    end
end)

function rotateTetromino()
    local tetromino = {}
    for x = 0, 9 do
        for y = 0, 19 do
            if movable(x, y) then
                -- store the tetromino blocks in an array
                tetromino[#tetromino + 1] = { x = x, y = y }
            end
        end
    end

    local center = { x = 0, y = 0 }
    for i = 1, #tetromino do
        center.x = center.x + tetromino[i].x
        center.y = center.y + tetromino[i].y
    end
    center.x = math.floor(center.x / #tetromino)
    center.y = math.floor(center.y / #tetromino)

    for i = 1, #tetromino do
        local x = tetromino[i].x - center.x
        local y = tetromino[i].y - center.y
        tetromino[i].x = center.x - y
        tetromino[i].y = center.y + x
    end

    local canRotate = true
    for i = 1, #tetromino do
        if color == 2 or color == 3 or color == 4 then
            if tetromino[i].y == -1 then
                canRotate = false
                break
            else
                if tetromino[i].x + 1 < 0 or tetromino[i].x + 1 > 9 or tetromino[i].y + 1 < 0 or tetromino[i].y + 1 > 19
                    or
                    board[tetromino[i].x + 1][tetromino[i].y] >= 8 and board[tetromino[i].x + 1][tetromino[i].y] <= 14 then
                    canRotate = false
                    break
                end
            end
        elseif color == 1 or color == 5 or color == 7 then
            if rot_number == 1 then
                if tetromino[i].x + 1 < 0 or tetromino[i].x + 1 > 9 or tetromino[i].y + 1 < 0 or tetromino[i].y + 1 > 19
                    or
                    board[tetromino[i].x + 1][tetromino[i].y] >= 8 and board[tetromino[i].x + 1][tetromino[i].y] <= 14 then
                    canRotate = false
                    break
                end
            else
                if tetromino[i].x < 0 or tetromino[i].x > 9 or tetromino[i].y < 0 or tetromino[i].y > 19 or
                    board[tetromino[i].x][tetromino[i].y] >= 8 and board[tetromino[i].x][tetromino[i].y] <= 14 then
                    canRotate = false
                    break
                end
            end
        elseif color == 6 then
            if rot_number == 0 or rot_number == 1 or rot_number == 2 then
                if tetromino[i].x + 1 < 0 or tetromino[i].x + 1 > 9 or tetromino[i].y + 1 < 0 or
                    tetromino[i].y + 1 > 19
                    or
                    board[tetromino[i].x + 1][tetromino[i].y + 1] >= 8 and
                    board[tetromino[i].x + 1][tetromino[i].y + 1] <= 14 then
                    canRotate = false
                    break
                end
            else
                if tetromino[i].x < 0 or tetromino[i].x > 9 or tetromino[i].y < 0 or tetromino[i].y > 19 or
                    board[tetromino[i].x][tetromino[i].y] >= 8 and board[tetromino[i].x][tetromino[i].y] <= 14 then
                    canRotate = false
                    break
                end
            end
        end

    end

    if canRotate then
        for x = 0, 9 do
            for y = 0, 19 do
                if movable(x, y) then
                    board[x][y] = 0
                end
            end
        end
        for i = 1, #tetromino do
            if color == 2 or color == 3 or color == 4 then
                board[tetromino[i].x + 1][tetromino[i].y] = color
            elseif color == 1 or color == 5 or color == 7 then
                if rot_number == 0 then
                    board[tetromino[i].x][tetromino[i].y] = color
                elseif rot_number == 1 then
                    board[tetromino[i].x + 1][tetromino[i].y] = color
                end
            elseif color == 6 then
                if rot_number == 1 or rot_number == 2 then
                    if rot_number == 2 then
                        board[tetromino[i].x + 1][tetromino[i].y + 1] = color
                    else
                        board[tetromino[i].x + 1][tetromino[i].y] = color
                    end
                else
                    board[tetromino[i].x][tetromino[i].y] = color
                end
            end
        end
    end
end

function moveTetrominoDown()
    local canMoveDown = true
    for x = 0, 9 do
        for y = 19, 0, -1 do
            if movable(x, y) then
                local new_y = y + 1
                if new_y > 19 or board[x][new_y] >= 8 and board[x][new_y] <= 14 then
                    canMoveDown = false
                    break
                end
            end
        end
    end

    if canMoveDown then
        for x = 0, 9 do
            for y = 19, 0, -1 do
                if movable(x, y) then
                    local new_y = y + 1
                    board[x][new_y] = board[x][y]
                    board[x][y] = 0
                end
            end
        end
    else
        for x = 0, 9 do
            for y = 0, 19 do
                board[x][y] = lookup_table[board[x][y]] or board[x][y]
            end
        end
        current_cleared_line = 0
        for y = 0, 19 do
            if isRowFilled(y) then
                clearRow(y)
                current_cleared_line = current_cleared_line + 1
                lines_cleared = lines_cleared + 1
                if lines_cleared == (levels * 10) + 10 then
                    levels = levels + 1
                end
                if current_cleared_line == 1 then
                    score = score + 40 * (levels + 1)
                elseif current_cleared_line == 2 then
                    score = score + 100 * (levels + 1)
                elseif current_cleared_line == 3 then
                    score = score + 200 * (levels + 1)
                elseif current_cleared_line <= 4 then
                    score = score + 40 * current_cleared_line
                end
            end
        end
        canSpeedDown = false
        spawnTetromino()
    end
end

function clearRow(y)
    for x = 0, #board do
        board[x][y] = 0
    end
    for j = y, 1, -1 do
        for i = 0, #board do
            board[i][j] = board[i][j - 1]
        end
    end
end

function moveTetrominoLeft()
    for x = 0, 9 do
        for y = 0, 19 do
            if movable(x, y) then
                if x == 0 or board[x - 1][y] >= 8 and board[x - 1][y] <= 14 then
                    return
                end
            end
        end
    end
    for x = 1, 9 do
        for y = 0, 19 do
            if movable(x, y) then
                board[x - 1][y] = board[x][y]
                board[x][y] = 0
            end
        end
    end

end

function moveTetrominoRight()
    for x = 1, 9 do
        for y = 0, 19 do
            if movable(x, y) then
                if x == 9 or board[x + 1][y] >= 8 and board[x + 1][y] <= 14 then
                    return
                end
            end
        end
    end
    for x = 9, 0, -1 do
        for y = 19, 0, -1 do
            if movable(x, y) then
                board[x + 1][y] = board[x][y]
                board[x][y] = 0
            end
        end
    end
end

function isRowFilled(y)
    local isFilled = true
    for x = 0, #board do
        if not (board[x][y] >= 8 and board[x][y] <= 14) then
            isFilled = false
            break
        end
    end
    return isFilled
end

next_tetromino = math.random(#tetromino_shapes)
function spawnTetromino()
    rot_number = 0
    current_tetromino = next_tetromino
    next_tetromino = math.random(#tetromino_shapes)
    local shape = tetromino_shapes[current_tetromino]
    local new_shape = tetromino_shapes[next_tetromino]
    color = current_tetromino
    for x = 0, 5 do
        next_board[x] = {}
        for y = 0, 5 do
            next_board[x][y] = 0
        end
    end
    process_shape(new_shape, next_board, 1, 0)
    process_shape(shape, board, 3, 1)
end

function movable(x, y)
    return board[x][y] >= 1 and board[x][y] <= 7
end

function process_shape(shape, board, offset_x, offset_y)
    for x = 1, #shape do
        for y = 1, #shape[x] do
            if shape[x][y] >= 1 and shape[x][y] <= 7 then
                if board[x + offset_x][y - offset_y] == 0 then
                    board[x + offset_x][y - offset_y] = shape[x][y]
                else
                    lose = true
                end
            end
        end
    end
end

local keys = { [8] = "BACK", [9] = "TAB", [13] = "Enter", [16] = "Shift", [17] = "Ctrl", [18] = "Alt", [19] = "Pause/Break", [20] = "Caps Lock", [27] = "Esc", [32] = "SPACE", [33] = "Page Up", [34] = "Page Down", [36] = "HOME", [37] = "Left", [38] = "Up", [39] = "Right", [40] = "Down", [45] = "Insert", [46] = "Delete", [48] = "0 ", [49] = "1 ", [50] = "2 ", [51] = "3 ", [52] = "4 ", [53] = "5 ", [54] = "6 ", [55] = "7 ", [56] = "8 ", [57] = "9 ", [65] = "A ", [66] = "B ", [67] = "C ", [68] = "D ", [69] = "E ", [70] = "F ", [71] = "G ", [72] = "H ", [73] = "I ", [74] = "J ", [75] = "K ", [76] = "L ", [77] = "M ", [78] = "N ", [79] = "O ", [80] = "P ", [81] = "Q ", [82] = "R ", [83] = "S ", [84] = "T ", [85] = "U ", [86] = "V ", [87] = "W ", [88] = "X ", [89] = "Y ", [90] = "Z ", [93] = "Right Click", [96] = "0 (Num Lock)", [97] = "1 (Num Lock)", [98] = "2 (Num Lock)", [99] = "3 (Num Lock)", [100] = "4 (Num Lock)", [101] = "5 (Num Lock)", [102] = "6 (Num Lock)", [103] = "7 (Num Lock)", [104] = "8 (Num Lock)", [105] = "9 (Num Lock)", [106] = "* (Num Lock)", [107] = "+ (Num Lock)", [109] = "- (Num Lock)", [110] = ". (Num Lock)", [111] = "/ (Num Lock)", [112] = "F1", [113] = "F2", [114] = "F3", [115] = "F4", [116] = "F5", [117] = "F6", [118] = "F7", [119] = "F8", [120] = "F9", [121] = "F10", [122] = "F11", [123] = "F12", [144] = "NUMLOCK", [188] = ",", [190] = ".", [191] = "/", [192] = "`", [219] = "[", [220] = "\\", [221] = "]", [222] = "'" }
function keytostr(key) return keys[key]
end