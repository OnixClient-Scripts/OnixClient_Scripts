command = "music"
help_message = "plays music"

--you can put in
--11, 13, blocks, chirp, far, mall, mellohi, pigstep, stal, strad, wait, ward

function execute(arguments)
    gui.sound("record." .. arguments)
    print("Now playing: " .. arguments)
end
