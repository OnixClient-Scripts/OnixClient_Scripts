name = "Kill Ding"
description = "Plays a ding sound when you kill someone on The Hive."

function postInit()
    if not fs.exist("KillDing/ding.mp3") then
        fs.mkdir("KillDing")
        network.fileget("KillDing/ding.mp3","https://github.com/OnixClient-Scripts/OnixClient_Scripts/raw/master/Data/KillDing/ding.mp3", "ding")
    end
end

-- this is only here because it needs to be lol
function onNetworkData(code,id,data)
    if id == "ding" then
        return
    end
end

event.listen("ChatMessageAdded", function(message, username, type, xuid)
    local killMessages = {
        "§r§." .. player.name() .. " §ckilled ",
        "§r§e§lFINAL KILL! §r§." .. player.name() .. " §ckilled"
    }
    for i,v in pairs(killMessages) do
        if message:match(v) then
            playCustomSound("KillDing/ding.mp3")
        end
    end
end)