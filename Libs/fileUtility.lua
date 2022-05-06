--simple file managing library by MCBE Craft

function readFile(file)
    if os.rename(file, file) then
        local lines = io.lines(file)
        local result = {}
        for line in lines do 
            table.insert(result, line)
        end
        return result
    else
        return {}
    end
end

function readWholeFile(file)
    if os.rename(file, file) then
        local f = assert(io.open(file, "rb"))
        local content = f:read("*all")
        f:close()
        return content
    else
        return nil
    end
end

function writeFile(file, text)
    wrFile = io.open(file, "w")
    io.output(wrFile)
    io.write(text)
    io.close(wrFile)
end

function jsonLoad(file)
    local content = readWholeFile(file)
    return jsonToTable(content)
end

function jsonDump(json, file)
    writeFile(file, tableToJson(json))
end

function split(str, splitter)
    local result = {}
    for s in string.gmatch(str, "([^" .. splitter .. "]+)") do
        table.insert(result, s)
    end
    return result
end

function fileExists(file)
    return os.rename(file, file)
end
