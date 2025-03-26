---@diagnostic disable: param-type-mismatch
name = "Zeqa Utils"
description = "Utilities for Zeqa"

function onEnable()
    client.notification("§a§lZeqa Utils enabled.")
end

-- Settings
local spamfilter = client.settings.addNamelessBool("Disable promo, join and leave messages", false)
local autogg = client.settings.addNamelessBool("AutoGG", false)
local queue = client.settings.addNamelessTextbox("Requeue to what game", "Type the game name here")
client.settings.addInfo("Type .zhelp to find out gamemode names.")
local ranked = client.settings.addNamelessBool("Ranked?", false)

function matchnames()
    print("§a§lGamemode Names§r\n-----------------------\nArcher, BattleRush, BedFight, Boxing, \nBridge, BuildUHC, CaveUHC, Classic, Combo, CrystalPvP, Debuff, FinalUHC, FireballFight, \nFireballMace, Fist, Gapple, Invaded, MLGRush, MidFight, NetherUHC, NoDebuff, Parkour, \nPearlFight, SG, Skywars, SnowballSumo, Soup, Spleef, StickFight, Sumo, TopFight, Wrath")
end

registerCommand("zhelp", matchnames, {"zh"}, "Displays available Zeqa game modes")

function win()
    if ranked.value then
        client.execute("execute /q " .. queue.value .. " ranked")
    else
        client.execute("execute /q " .. queue.value .. " unranked")
    end
end

-- Block Join Leave and promo messages
event.listen("ChatMessageAdded", function(message, username, type, xuid)
    if message:find(" ") then
        client.execute("say gg")
        win()
    end
    if spamfilter.value then
        if string.find(message, "§8%[§c%-§8%]§c") or 
           string.find(message, "§8%[§a%+§8%]§a") or 
           string.find(message, "youtube.com") or 
           string.find(message, "twitch.tv") then
            return true
        end
    end
end)