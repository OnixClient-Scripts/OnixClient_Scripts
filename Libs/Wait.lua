

z_lib_waitlist = {}


---To call inside of a delayedFunction(yourFunction) function
---@param miliseconds integer How many ms to wait
function wait(miliseconds)
    coroutine.yield(miliseconds)
end

---This will create a delayed function which can use wait inside, do it once per function
---@param funcc function
function delayedFunction(funcc)
    table.insert(z_lib_waitlist, {delay=0, func = coroutine.create(funcc)})
end

---Call this in render
---@param dt number The delta time, which is given to you by render
function updateTimes(dt)
    dt = dt * 1000 --convert seconds to ms

    local newList = {}
    for _, func in pairs(z_lib_waitlist) do
        func.delay = func.delay - dt
        if func.delay <= 0 then
            local worked, delay = coroutine.resume(func.func)

            if delay == nil then delay = 0 end
            if worked == false then
                --finished calling, removing
            else
                table.insert(newList, func)
                func.delay = delay
            end
        else
            table.insert(newList, func)
        end
    end
    z_waitlist = newList
end