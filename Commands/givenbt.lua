command = "givnbt"
help_message = "Gives an item with nbt"

function execute(argv)
    local argl = string.split(argv, " ")
    client.execute("give " .. argl[1])
    if #argl > 1 then
        client.execute("nbt write {" .. string.sub(argv, #argl[1] + 6, -1) .. "}")
    else
        client.execute("nbt paste")
    end
end