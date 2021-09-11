command = "ts"
help_message = "changes toggle sprint indicator data (text or color)"

--[[
    sprint command for sprint.lua module
    needs tsData.txt and sprint.lua module to work
    more infos in sprint.lua module

    by MCBE Craft
]]--

function execute(arguments)
    local args = {}
    for word in string.gmatch(arguments, "[^%s]+") do
        table.insert(args, word)
    end
    ImportedLib = importLib("readfile.lua")
    tsData = readFile("tsData.txt")
    
    if args[1] == "text" then
        arguments = string.gsub(arguments, "text ", "")
        tsData[1] = arguments
    elseif args[1] == "color" then
        tsData[2] = args[2]
        tsData[3] = args[3]
        tsData[4] = args[4]
        tsData[5] = args[5]
    end
    result = ""
    for i = 1, 5, 1 do
        result = result .. tsData[i] .. "\n"
    end

    writeFile("tsData.txt", result)
    print("successfully changed toggle sprint data")

end
