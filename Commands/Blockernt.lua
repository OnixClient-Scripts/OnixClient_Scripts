command = "unblock"
help_message = "Unblocks a word. §8Usage: §7.unblock {§9Word§7}§r"

function execute(arguments)
    if arguments == "" then
        print("How did you get here?")
        return
    end
    sendLocalData("7772437c-671c-4682-8728-238bc46efd7a", string.lower(arguments))
end
