name = "Kill Ding"
description = "Plays a ding sound when you kill someone on The Hive."

importLib("SoundDownloader")


function postInit()
    downloadSound("https://github.com/OnixClient-Scripts/OnixClient_Scripts/raw/master/Data/Sounds/ding.mp3")
end
workingDir = "RoamingState/OnixClient/Scripts/Data/Sounds/"

event.listen("ChatMessageAdded", function(message, username, type, xuid)
    local killMessages = {
        "§r§." .. player.name() .. " §ckilled ",
        "§r§e§lFINAL KILL! §r§." .. player.name() .. " §ckilled"
    }
    for i,v in pairs(killMessages) do
        if message:match(v) then
            playCustomSound("ding.mp3")
        end
    end
end)