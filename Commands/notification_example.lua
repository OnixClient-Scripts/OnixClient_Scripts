command = "notification"
help_message = "Sends a notification of your choice"


function execute(arguments)
    if string.len(arguments) > 0 then
        client.notification(arguments)
    else
        client.notification("Empty notification, ." .. command .. " <Message>")
    end
end
