name = "Mention Ping"
description = "Makes it so when you get pinged in chat, it will play a sound."

importLib("SoundDownloader")

workingDir = "RoamingState/OnixClient/Scripts/Data/Sounds/"

discordMode = client.settings.addNamelessBool("Use Discord Ping", false)
respondToHere = client.settings.addNamelessBool("Respond to @here", false)

function postInit()
    downloadSound("https://github.com/OnixClient-Scripts/OnixClient_Scripts/raw/master/Data/Sounds/ding.mp3")
    downloadSound("https://github.com/OnixClient-Scripts/OnixClient_Scripts/raw/master/Data/Sounds/discord.mp3")
end

shouldPing = false

event.listen("ChatMessageAdded", function(message, username, type, xuid)
    if respondToHere.value then
        if message:find("@here") then
            shouldPing = true
        end
    end
    if message:find("@" .. player.name()) then
        shouldPing = true
    end

    if shouldPing then
        if discordMode.value then
            playCustomSound("discord.mp3")
        else
            playCustomSound("ding.mp3")
        end
        shouldPing = false
    end
end)