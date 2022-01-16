command = "."
help_message = "shortcut for .say ., ex: .._."

function execute(arguments)
    client.execute("say ." .. arguments)
end
