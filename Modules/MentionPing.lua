-- This script was originally written in TypeScript.
-- Lua Library inline imports
local function __TS__StringIncludes(self, searchString, position)
    if not position then
        position = 1
    else
        position = position + 1
    end
    local index = string.find(self, searchString, position, true)
    return index ~= nil
end
-- End of Lua Library inline imports
name = "Mention Ping"
description = "Plays a sound when you are mentioned in chat."
workingDir = "RoamingState/OnixClient/Scripts/Data/Sounds"
discordMode = client.settings.addNamelessBool("Use Discord Ping", false)
respondToHere = client.settings.addNamelessBool("Respond to @here", false)
event.listen(
    "ChatMessageAdded",
    function(message, username, ____type)
        if respondToHere.value and __TS__StringIncludes(message, "@here") or __TS__StringIncludes(
            message,
            "@" .. player.name()
        ) then
            if discordMode.value then
                playCustomSound("discord.mp3")
            else
                playCustomSound("ding.mp3")
            end
        end
    end
)
