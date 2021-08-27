command = "."
help_message = "dot"

function execute(arguments)
    client.execute("say ." .. arguments)
end
