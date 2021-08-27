command = "music"
help_message = "plays music"

function execute(arguments)
    gui.sound("record." .. arguments)
    print("Now playing: " .. arguments)
end