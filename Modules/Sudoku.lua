name = "Sudoku"
description = "Sudoku in minecraft"

positionX = 0
positionY = 0
sizeX = 100
sizeY = 100
difficulties = { { 1, "Easy" }, { 2, "Medium" }, { 3, "Hard" }, { 4, "Random" } }
show_mouse_key = client.settings.addNamelessKeybind("Show Mouse", 220)
--n key
new_game_key = client.settings.addNamelessKeybind("New Game", 49)
difficulty = client.settings.addNamelessEnum("Difficulty", 1, difficulties)
loading_text = "Loading..."
wrong = {}

function render2()
    gfx2.color(255, 255, 255, 255)
    gfx2.fillRect(0, 0, sizeX, sizeY)
    if doneLoading then
        for i = 0, 8 do
            for j = 0, 8 do
                gfx2.color(136, 136, 136)
                gfx2.drawRect(i * 11.1, j * 11.1, 11.1, 11.1, 0.5)
                gfx2.color(0, 0, 0)
                if original_grid[i][j] ~= "" then
                    gfx2.color(38, 97, 156)
                end
                for k = 1, #wrong do
                    if wrong[k][1] == i and wrong[k][2] == j then
                        gfx2.color(255, 0, 0)
                    end
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
    else
        gfx2.color(0, 0, 0)
        gfx2.text(37, 45, loading_text)
    end
end

event.listen("KeyboardInput", function(key, down)
    if key == new_game_key.value and down then
        newGame()
        return true
    end
    if key == show_mouse_key.value and down then
        gui.setGrab(not gui.mouseGrabbed())
        return true
    end
    if gui.mouseGrabbed() == true and gui.screen() == "hud_screen" then
        if key == 8 and down and selected ~= nil then
            puz_grid[selected[1]][selected[2]] = ""
        end
        if key >= 49 and key <= 57 and down and selected ~= nil then
            puz_grid[selected[1]][selected[2]] = key - 48
            if isValid(selected[1], selected[2], key - 48) then
                if isSolved() then
                    loading_text = "You win!"
                    newGame()
                end
            else
                table.insert(wrong, { selected[1], selected[2] })
                lives = lives - 1
                if lives == 0 then
                    loading_text = "You lose!"
                    newGame()
                end
            end
            
        end
        return true
    end
end)

event.listen("MouseInput", function(button, down)
    if gui.mouseGrabbed() == true and gui.screen() == "hud_screen" then
        if (button == 1 and down) then
            local x, y = gui.mousex() - positionX, gui.mousey() - positionY
            local x = math.floor(x / 11.1)
            local y = math.floor(y / 11.1)
            if x >= 0 and x <= 8 and y >= 0 and y <= 8 then
                if original_grid[x][y] == "" then
                    selected = { x, y }
                end
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

function postInit()
    newGame()
end

function newGame()
    if difficulty.value == 1 then
        diff = "easy"
    elseif difficulty.value == 2 then
        diff = "medium"
    elseif difficulty.value == 3 then
        diff = "hard"
    else
        diff = "random"
    end
    url = "https://sugoku.onrender.com/board?difficulty=" .. diff
    network.get(url, "Sudoku")
    lives = 3
    doneLoading = false
end

function onNetworkData(code, id, data)
    if id == "Sudoku" then
        jsonString = data
        network.post("https://sugoku.onrender.com/solve", "Sudoku_solved", data)
        puz_grid = generateSudokuPuzzle()
    end
    if id == "Sudoku_solved" then
        solved_board = jsonToTable(data).solution
        local grid = {}
        for i = 0, 8 do
            grid[i] = {}
            for j = 0, 8 do
                if solved_board[i + 1][j + 1] == 0 then
                    grid[i][j] = ""
                else
                    grid[i][j] = solved_board[i + 1][j + 1]
                end
            end
        end
        solved_grid = grid
        doneLoading = true
    end
end

function generateSudokuPuzzle()
    local data = jsonToTable(jsonString)
    local boardArray = data.board
    local grid = {}
    for i = 0, 8 do
        grid[i] = {}
        for j = 0, 8 do
            if boardArray[i + 1][j + 1] == 0 then
                grid[i][j] = ""
            else
                grid[i][j] = boardArray[i + 1][j + 1]
            end
        end
    end
    original_grid = deepCopy(grid)
    return grid
end

function isValid(row, col, num)
    if solved_grid[row][col] ~= num then
        return false
    end
    return true
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
