function readFile(file)
    local lines = io.lines(file)
    local result = {}
    
    for line in lines do 
        table.insert(result, line)
    end
    return result
end

function writeFile(file, text)
    wrFile = io.open(file, "w")
    io.output(wrFile)
    io.write(text)
    io.close(wrFile)
end
