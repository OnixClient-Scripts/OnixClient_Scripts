-- Made by OrangeCash

function isArray(t)
    if type(t) ~= "table" then return false end
    local count = 0
    for k, _ in pairs(t) do
        if type(k) ~= "number" or k % 1 ~= 0 or k < 1 then return false end
        count = count + 1
    end
    for i = 1, count do
        if t[i] == nil then return false end
    end
    return true
end

local typeOrder = {
    number = 1,
    string = 2,
    boolean = 3,
    table = 4,
    ["function"] = 5,
    thread = 6,
    userdata = 7
}

local bracketColors = {"§6", "§u", "§8"}

local function typeRank(v)
    return typeOrder[type(v)] or 99
end

local function isOneDimensionalArray(tbl)
    for _, v in ipairs(tbl) do
        if type(v) == "table" then
            return false
        end
    end
    return true
end

local function stringify(value, depth)
    local maxValues = 8
    depth = depth or 1

    local bracketColor = bracketColors[(depth - 1) % #bracketColors + 1]

    local function applyColor(val, color)
        return color .. val .. "§r"
    end

    local function indentLine(level)
        return string.rep("  ", level)
    end

    local t = type(value)

    if t == "nil" then
        return applyColor("nil", "§t")
    elseif t == "number" then
        return applyColor(tostring(value), "§a")
    elseif t == "string" then
        return applyColor('"' .. value .. '"', "§n")
    elseif t == "boolean" then
        return applyColor(tostring(value), "§t")
    elseif t == "function" then
        return applyColor("<function>", "§m")
    elseif t == "thread" then
        return applyColor("<thread>", "§m")
    elseif t == "userdata" then
        return applyColor("<userdata>", "§m")
    elseif t == "table" then
        if getmetatable(value) and getmetatable(value).__tostring then
            return getmetatable(value).__tostring(value)
        end

        local result = {}
        local count = 0
        local is_array = isArray(value)
        local oneDim = is_array and isOneDimensionalArray(value)
        local shouldIndent = not oneDim

        if is_array then
            for _, v in ipairs(value) do
                count = count + 1
                if count >= maxValues then
                    table.insert(result, shouldIndent and indentLine(depth) .. "..." or "...")
                    break
                end
                local valStr = stringify(v, depth + 1)
                table.insert(result, shouldIndent and indentLine(depth) .. valStr or valStr)
            end
            if shouldIndent then
                return bracketColor .. "[\n" .. table.concat(result, ",\n") .. "\n" .. indentLine(depth - 1) .. bracketColor .. "]§r"
            else
                return bracketColor .. "[" .. "§r" .. table.concat(result, ", ") .. bracketColor .. "]§r"
            end
        else
            local keys = {}
            for k in pairs(value) do
                table.insert(keys, k)
            end

            table.sort(keys, function(a, b)
                local ta, tb = typeRank(a), typeRank(b)
                if ta ~= tb then return ta < tb end
                return tostring(a) < tostring(b)
            end)

            for _, k in ipairs(keys) do
                count = count + 1
                if count >= maxValues then
                    table.insert(result, shouldIndent and indentLine(depth) .. "..." or "...")
                    break
                end

                local keyStr = applyColor(stringify(k), "§q")
                local valStr = stringify(value[k], depth + 1)
                local line = keyStr .. " = " .. valStr
                table.insert(result, shouldIndent and indentLine(depth) .. line or line)
            end

            if shouldIndent then
                return bracketColor .. "{\n" .. table.concat(result, ",\n") .. "\n" .. indentLine(depth - 1) .. bracketColor .. "}§r"
            else
                return bracketColor .. "{" .. "§r" .. table.concat(result, ", ") .. bracketColor .. "}§r"
            end
        end
    end
end

---Prints a string with formatting, accepts multiple arguments.
---@param ... unknown
function brint(...)
    local args = { ... }

    if #args == 1 or args[1] == nil then
        print(stringify(args[1]))
    else
        print(stringify(args))
    end
end