command = "block"
help_message = "Blocks a word. §8Usage: §7.block {§9Word§7}§r"

function execute(arguments)
    if arguments == "" then
        print("How did you get here?")
        return
    end
    sendLocalData("57f718bd-79e0-4212-9c6d-f6b9c091946f", string.lower(arguments))
end
