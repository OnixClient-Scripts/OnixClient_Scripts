name = "Galaxite Tweaks"
description = "Allows players to tweak Galaxite's chat system to reduce bloat"
--[[Galaxite Tweaks Credits:
dOGbone - IDK what this guy did
Rosie - Totally not a ripoff of Rosie's Hive Debloater Module
Flash - Helped with Nameless Bools
Lanerdros - Suggested Miner Melvin setting]]
notice = true
warn = true
join = true
miner = true
client.settings.addBool("Hide Notices?", "notice")
client.settings.addBool("Hide Warnings?", "warn")
client.settings.addBool("Hide Player Joins?", "join")
client.settings.addBool("Hide Miner Melvin?", "miner")
function onChat(message, username, type)
    if notice and message:find("") then
        return true
        end
    if warn and message:find("") then
        return true
        end
    if join and message:find("") then
        return true
        end
    if miner and message:find("§l§6Miner") then
        return true
    end
end
event.listen("ChatMessageAdded", onChat)