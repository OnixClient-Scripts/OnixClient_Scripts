looper = {}

functions = {}

---@param functionToLoop function What function to call every interval
---@param interval number How often to call the function in milliseconds
---@param timesToLoop number How many times to call the function, -1 for infinite
function looper:new(functionToLoop, interval, timesToLoop)
    accumulator = 0
    pause = false
    table.insert(functions, { functionToLoop, interval / 1000, timesToLoop, accumulator, pause })
end

---@param function_ function What function to pause
function looper:pause(function_)
    for i, value in ipairs(functions) do
        if value[1] == function_ then
            value[5] = true
        end
    end
end

---@param function_ function What function to resume
function looper:resume(function_)
    for i, value in ipairs(functions) do
        if value[1] == function_ then
            value[5] = false
        end
    end
end

---@param function_ function What function to destroy
function looper:destroy(function_)
    for i, value in ipairs(functions) do
        if value[1] == function_ then
            table.remove(functions, i)
        end
    end
end

function looper:destroyAll()
    functions = {}
end

renderEverywhere = true
function render2(dt)
    for i, value in ipairs(functions) do
        if value[5] == false then
            value[4] = value[4] + dt
            if value[4] >= value[2] then
                value[1]()
                value[4] = 0
                if value[3] > 0 then
                    value[3] = value[3] - 1
                end
                if value[3] == 0 then
                    table.remove(functions, i)
                end
            end
        end
    end
end
