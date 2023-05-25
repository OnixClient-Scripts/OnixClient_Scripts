name = "Mention Ping"
description = "Makes it so when you get pinged in chat, it will play a sound."

workingDir = "RoamingState/OnixClient/Scripts/Data/Sounds/"

discordMode = client.settings.addNamelessBool("Use Discord Ping", false)
respondToHere = client.settings.addNamelessBool("Respond to @here", false)

function postInit()
    workingDir = "RoamingState/OnixClient/Scripts/Data"
    if not fs.exist("Sounds") then
        fs.mkdir("Sounds")
    end
    workingDir = "RoamingState/OnixClient/Scripts/Data/Sounds/"
    if not fs.exist("ding.mp3") then
        network.fileget("ding.mp3","https://github.com/OnixClient-Scripts/OnixClient_Scripts/raw/master/Data/Sounds/ding.mp3", "ding")
    end
    if not fs.exist("discord.mp3") then
        network.fileget("discord.mp3","https://github.com/OnixClient-Scripts/OnixClient_Scripts/raw/master/Data/Sounds/discord.mp3", "discord")
    end
end

-- this is only here because it has to be lol
function onNetworkData(code,id,data)
    if id == "ding" or id == "discord" then
        return
    end
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
    return
end)