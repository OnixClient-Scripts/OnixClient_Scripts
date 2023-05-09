name = "Sudoku"
description = "Sudoku in minecraft"

positionX = 0
positionY = 0
sizeX = 100
sizeY = 100

show_mouse_key = client.settings.addNamelessKeybind("Show Mouse", 220)
puz_grid = {}
for i = 0, 8 do
    puz_grid[i] = {}
    for j = 0, 8 do
        puz_grid[i][j] = ""
    end
end
lives = 3
function render2()
    gfx2.color(255, 255, 255, 255)
    gfx2.fillRect(0, 0, sizeX, sizeY)
    for i = 0, 8 do
        for j = 0, 8 do
            gfx2.color(136, 136, 136)
            gfx2.drawRect(i * 11.1, j * 11.1, 11.1, 11.1, 0.5)
            gfx2.color(0, 0, 0)
            if original_grid[i][j] ~= "" then
                gfx2.color(38, 97, 156)
            end
            gfx2.text(i * 11.1 + 3.5, j * 11.1 + 1.5, puz_grid[i][j])
        end
    end
    for i = 0, 8 do
        for j = 0, 8 do
            if i % 3 + j % 3 == 0 then
                gfx2.color(0, 0, 0)
                gfx2.drawRect(i * 11.1, j * 11.1, 33.3, 33.3, 0.5)
            end
            if selected ~= nil and selected[1] == i and selected[2] == j then
                gfx2.color(0, 255, 0)
                gfx2.drawRect(i * 11.1, j * 11.1, 11.1, 11.1, 1)
            end
        end
    end
end

event.listen("KeyboardInput", function(key, down)
    if key == show_mouse_key.value and down then
        gui.setGrab(not gui.mouseGrabbed())
        return true
    end
    if key >= 49 and key <= 57 and down and selected ~= nil then
        if isValid(puz_grid, selected[1], selected[2], key - 48) then
            puz_grid[selected[1]][selected[2]] = key - 48
            if isSolved() then
                print("You win!")
                puz_grid = generateSudokuPuzzle()
            end
        else
            print("Invalid move")
            lives = lives - 1
            if lives == 0 then
                print("Game over")
                puz_grid = generateSudokuPuzzle()
                lives = 3
            end
        end
        return true
    end
end)

function isSolved()
    for i = 0, 8 do
        for j = 0, 8 do
            if puz_grid[i][j] == "" then
                return false
            end
        end
    end
    return true
end

event.listen("MouseInput", function(button, down)
    if (button == 1 and down and gui.mouseGrabbed() == true and gui.screen() == "hud_screen") then
        local x, y = gui.mousex() - positionX, gui.mousey() - positionY
        local x = math.floor(x / 11.1)
        local y = math.floor(y / 11.1)
        if x >= 0 and x <= 8 and y >= 0 and y <= 8 then
            if original_grid[x][y] == "" then
                selected = { x, y }
            end
        end
        return true
    end
end)

function postInit()
    puz_grid = generateSudokuPuzzle()
end

function isValid(board, row, column, num)
    local pos = { row, column }
    for i = 0, 8 do
        if board[i][pos[2]] == num and { i, pos[2] } ~= pos then
            return false
        end
    end
    for j = 0, 8 do
        if board[pos[1]][j] == num and { pos[1], j } ~= pos then
            return false
        end
    end

    local start_i = pos[1] - (pos[1] % 3)
    local start_j = pos[2] - (pos[2] % 3)

    for i = 0, 2 do
        for j = 0, 2 do
            if board[start_i + i][start_j + j] == num and { start_i + i, start_j + j } ~= pos then
                return false
            end
        end
    end

    return true
end

function solveSudoku(grid)
    for row = 0, 8 do
        for col = 0, 8 do
            if grid[row][col] == "" then
                for num = 1, 9 do
                    if isValid(grid, row, col, num) then
                        grid[row][col] = num
                        if solveSudoku(grid) then
                            return true
                        end
                        grid[row][col] = ""
                    end
                end
                return false
            end
        end
    end

    return true
end

function generateSudokuPuzzle()
    local grid = {}
    for i = 0, 8 do
        grid[i] = {}
        for j = 0, 8 do
            grid[i][j] = ""
        end
    end

    solveSudoku(grid)

    local numDigitsToRemove = math.random(40, 50)

    while numDigitsToRemove > 0 do
        local row = math.random(0, 8)
        local col = math.random(0, 8)

        if grid[row][col] ~= "" then
            grid[row][col] = ""
            numDigitsToRemove = numDigitsToRemove - 1
        end
    end
    original_grid = deepCopy(grid)
    return grid
end

function deepCopy(orig)
    local copy
    if type(orig) == "table" then
        copy = {}
        for origKey, origValue in next, orig, nil do
            copy[deepCopy(origKey)] = deepCopy(origValue)
        end
        setmetatable(copy, deepCopy(getmetatable(orig)))
    else
        copy = orig
    end
    return copy
end
