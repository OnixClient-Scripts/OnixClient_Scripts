command = "video"
help_message = "plays videos if sound pack is on and frames in data folder"

ImportedLib = importLib("readfile.lua")

function execute(arguments)
    if arguments == "reset" then
        writeFile("video.txt", "")
        gui.stopallsound()
        print("Stopped playing")
    elseif arguments == "stop" then
        writeFile("video.txt", "")
        gui.stopallsound()
        print("Stopped playing")
    else
        writeFile("video.txt", arguments)
        gui.sound("record." .. arguments)
        print("Now playing: " .. arguments)
    end
end
