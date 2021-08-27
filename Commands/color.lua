command = "color"
help_message = "change color"

function execute(arguments)
    local result = ""
    for word in string.gmatch(arguments, "[^%s]+") do
        result = result .. word .. "\n"
    end
    
    DelayFile = io.open("color.txt", "w")
    io.output(DelayFile)
    io.write(result)
    io.close(DelayFile)
    print("successfully changed color")

end