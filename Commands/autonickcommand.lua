command = "autonick"
help_message = "Sets the autonick. §8Usage: §7.autonick {§9Nickname§7}§r"

--[[
    auto nick script
    by VastraKai#0001 ;D
]]--

function execute(arguments)
    if arguments == "" then
        sendLocalData("4bc36f30-fb14-4c94-b935-73fe271503c0", arguments)
        return
    end
    sendLocalData("1b0944f1-d18f-4fbb-9e8f-6ac940735ff7", arguments)
end
