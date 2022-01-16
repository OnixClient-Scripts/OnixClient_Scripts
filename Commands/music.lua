command = "music"
help_message = "plays music"

--you can put in
--11, 13, blocks, chirp, far, mall, mellohi, pigstep, stal, strad, wait, ward

function execute(arguments)
    if arguments == "" or arguments == "help" then
        print("Default records: 11, 13, blocks, chirp, far, mall, mellohi, pigstep, stal, strad, wait, ward")
    end
    gui.sound("record." .. arguments)
    print("Now playing: " .. arguments)
end
