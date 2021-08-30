--library used to read color file, check .color command

function readFile(path)
    local lines = io.lines(path)
    local result = {}
    
    for line in lines do 
        table.insert(result, line)
    end
    return result
end
