--made by O2Flash20
function getTable(table)
    local output = ""
    output = "{"
    for i = 1, #table, 1 do
        output = output .. toString(table[i])
        if i ~= #table then
            output = output .. ", "
        end
    end
    output = output .. "}"
    return output
end

function toString(input)
    if type(input) == "string" then
        return [["]] .. input .. [["]]
    end
    if type(input) == "table" then
        return getTable(input)
    end
    if type(input) == "function" then
        return "FUNCTION"
    end
    return tostring(input)
end

function log(...)
    local message = toString({ ... })
    sendLocalData("logMessage", string.sub(message, 2, #message - 1))
end
