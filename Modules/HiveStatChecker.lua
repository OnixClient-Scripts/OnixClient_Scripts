name = "Hive Statistic Checker"
description = "Allows you to check the statistics of people in-game."

--[[
    by rosie
    thnx onix for being epic and making the brain of the script lol
]]

importLib("hiveGamemodes.lua")

ign = ""
local lastResult = {}
local result = {}
formattedGamemode = getListGamemodes()
local ip = server.ip()
function tablelen(tbl)
    local a = 0
    for k, v in pairs(tbl) do
        a = a + 1
    end
    return a
end
function onNetworkData(code, netGamemode, data)
    if code == 0 then
        result = jsonToTable(data)
        if type(result) ~= "table" then
            print("Error...")
            return
        end
        if tablelen(result) == 0 then
            print("No results found.")
            return
        else
            print("§b§l------------------------------------§r\n§eHive Statistics Checker\n§cUser: §r" .. username .. "\n§aGamemode: §r" .. formattedGamemode[string.upper(gamemode)] .. "\n§b§l------------------------------------§r")
            if netGamemode == "wars" then
                print("§2Experience: §e" .. result["xp"])
                print("§8Games Played: §e" .. result["played"])
                print("§6Victories: §e" .. result["victories"])
                print("§8Losses: §e" .. result["played"] - result["victories"])
                print("§1Winrate: §e" .. math.floor((result["victories"] / result["played"]) * 1000)/10 .. "%")
                print("§4Lossrate: §e" .. 100-math.floor((result["victories"] / result["played"]) * 1000)/10 .. "%")
                print("§3Final Kills: §e" .. result["final_kills"])
                print("§5Kills: §e" .. result["kills"])
                print("§4Deaths: §e" .. result["deaths"])
                print("§6Treasures Destroyed: §e" .. result["treasure_destroyed"])
                print("§eK§cD§eR: §e" .. math.floor((result["kills"] / result["deaths"])*100)/100)
                print("§3Prestige: §e" .. result["prestige"])
            elseif netGamemode == "sky" then
                print("§2Experience: §e" .. result["xp"])
                print("§8Games Played: §e" .. result["played"])
                print("§6Victories: §e" .. result["victories"])
                print("§8Losses: §e" .. result["played"] - result["victories"])
                print("§1Winrate: §e" .. math.floor((result["victories"] / result["played"]) * 100) .. "%")
                print("§4Lossrate: §e" .. math.floor(100-(result["victories"] / result["played"]) * 100) .. "%")
                print("§5Kills: §e" .. result["kills"])
                print("§dMystery Chests Destroyed: §e" .. result["mystery_chests_destroyed"])
                print("§9Ores Mined: §e" .. result["ores_mined"])
                print("§dSpells Used: §e" .. result["spells_used"])
            elseif netGamemode == "ctf" then
                print("§2Experience: §e" .. result["xp"])
                print("§8Games Played: §e" .. result["played"])
                print("§6Victories: §e" .. result["victories"])
                print("§8Losses: §e" .. result["played"] - result["victories"])
                print("§1Winrate: §e" .. math.floor((result["victories"] / result["played"]) * 100) .. "%")
                print("§4Lossrate: §e" .. math.floor(100-(result["victories"] / result["played"]) * 100) .. "%")
                print("§5Kills: §e" .. result["kills"])
                print("§4Deaths: §e" .. result["deaths"])
                print("§eK§cD§eR: §e" .. math.floor((result["kills"] / result["deaths"])*100)/100)
                print("§bFlags Captured: §e" .. result["flags_captured"])
                print("§cFlags Returned: §e" .. result["flags_returned"])
                print("§2Assists: §e" .. result["assists"])
            elseif netGamemode == "sg" then
                print("§2Experience: §e" .. result["xp"])
                print("§8Games Played: §e" .. result["played"])
                print("§6Victories: §e" .. result["victories"])
                print("§8Losses: §e" .. result["played"] - result["victories"])
                print("§1Winrate: §e" .. math.floor((result["victories"] / result["played"]) * 100) .. "%")
                print("§4Lossrate: §e" .. math.floor(100-(result["victories"] / result["played"]) * 100) .. "%")
                print("§5Kills: §e" .. result["kills"])
                print("§7Crates: §e" .. result["crates"])
                print("§8Deathmatches: §e" .. result["deathmatches"])
                print("§cCows: §e" .. result["cows"])
            elseif netGamemode == "dr" then
                print("§2Experience: §e" .. result["xp"])
                print("§8Games Played: §e" .. result["played"])
                print("§6Victories: §e" .. result["victories"])
                print("§8Losses: §e" .. result["played"] - result["victories"])
                print("§1Winrate: §e" .. math.floor((result["victories"] / result["played"]) * 100) .. "%")
                print("§4Lossrate: §e" .. math.floor(100-(result["victories"] / result["played"]) * 100) .. "%")
                print("§5Kills: §e" .. result["kills"])
                print("§4Deaths: §e" .. result["deaths"])
                print("§0C§rh§0e§rc§0k§rp§0o§ri§0n§rt§0s§r: §e" .. result["checkpoints"])
                print("§bT§dr§ra§dp§bs §aActivated: §e" .. result["activated"])
            elseif netGamemode == "hide" then
                print("§2Experience: §e" .. result["xp"])
                print("§8Games Played: §e" .. result["played"])
                print("§6Victories: §e" .. result["victories"])
                print("§8Losses: §e" .. result["played"] - result["victories"])
                print("§1Winrate: §e" .. math.floor((result["victories"] / result["played"]) * 100) .. "%")
                print("§4Lossrate: §e" .. math.floor(100-(result["victories"] / result["played"]) * 100) .. "%")
                print("§4Deaths: §e" .. result["deaths"])
                print("§1Hider Kills: §e" .. result["hider_kills"])
                print("§4Seeker Kills: §e" .. result["seeker_kills"])
            elseif netGamemode == "murder" then
                print("§2Experience: §e" .. result["xp"])
                print("§8Games Played: §e" .. result["played"])
                print("§6Victories: §e" .. result["victories"])
                print("§8Losses: §e" .. result["played"] - result["victories"])
                print("§1Winrate: §e" .. math.floor((result["victories"] / result["played"]) * 100) .. "%")
                print("§4Lossrate: §e" .. math.floor(100-(result["victories"] / result["played"]) * 100) .. "%")
                print("§5Kills: §e" .. result["kills"])
                print("§4Deaths: §e" .. result["deaths"])
                print("§6Coins: §e" .. result["coins"])
                print("§4Times Murderer: §e" .. result["murderers"])
            elseif netGamemode == "drop" then
                print("§2Experience: §e" .. result["xp"])
                print("§8Games Played: §e" .. result["played"])
                print("§6Victories: §e" .. result["victories"])
                print("§8Losses: §e" .. result["played"] - result["victories"])
                print("§1Winrate: §e" .. math.floor((result["victories"] / result["played"]) * 100) .. "%")
                print("§4Lossrate: §e" .. math.floor(100-(result["victories"] / result["played"]) * 100) .. "%")
                print("§4Deaths: §e" .. result["deaths"])
                print("§Blocks Destroyed: §e" .. result["blocks_destroyed"])
                print("§bPowerups Collected: §e" .. result["powerups_collected"])
                print("§aVaults Used: §e" .. result["vaults_used"])
            elseif netGamemode == "ground" then
                print("§2Experience: §e" .. result["xp"])
                print("§8Games Played: §e" .. result["played"])
                print("§6Victories: §e" .. result["victories"])
                print("§8Losses: §e" .. result["played"] - result["victories"])
                print("§1Winrate: §e" .. math.floor((result["victories"] / result["played"]) * 100) .. "%")
                print("§4Lossrate: §e" .. math.floor(100-(result["victories"] / result["played"]) * 100) .. "%")
                print("§4Deaths: §e" .. result["deaths"])
                print("§3Blocks Destroyed: §e" .. result["blocks_destroyed"])
                print("§dProjectiles Fired: §e" .. result["projectiles_fired"])
            elseif netGamemode == "build" then
                print("§2Experience: §e" .. result["xp"])
                print("§8Games Played: §e" .. result["played"])
                print("§6Victories: §e" .. result["victories"])
                print("§8Losses: §e" .. result["played"] - result["victories"])
                print("§1Winrate: §e" .. math.floor((result["victories"] / result["played"]) * 100) .. "%")
                print("§4Lossrate: §e" .. math.floor(100-(result["victories"] / result["played"]) * 100) .. "%")
                print("§2Loved Builds: §e" .. result["rating_love_received"])
                print("§aGood Builds: §e" .. result["rating_good_received"])
                print("§eOkay Builds: §e" .. result["rating_okay_received"])
                print("§cMeh Builds: §e" .. result["rating_meh_received"])
            else
                if tablelen(result) == 0 then
                    print("No results found.")
                else
                    for k,v in pairs (result) do
                        print(k .. ": " .. v)
                    end
                end
            end
            print("§b§l------------------------------------§r")
        end
    end
end



registerCommand("stats", function (arguments)
    if arguments == "" then
        print("§b§l------------------------------------§r\n§eUsage:\n§cUsername§r, §aGamemode \n§r§b§l------------------------------------§r")
    elseif string.find(arguments, ", ") then
        gamemode = string.sub(arguments, string.find(arguments, ", ") + 2)
        username = tostring(string.sub(arguments, 1, string.find(arguments, ", ") - 1))

        if string.find(gamemode, "-") then
            gamemode = string.sub(gamemode, 1, string.find(gamemode, "-") - 1)
            print(gamemode)
        end
        if formattedGamemode[string.upper(username)] then
            --dude switched gamemode and username L
            local temp = username
            username = gamemode
            gamemode = temp
        elseif not formattedGamemode[string.upper(gamemode)] then
            print("§b§l------------------------------------§r\n§eUnknown gamemode:§r\n\"" .. gamemode .. "\"\n§r§b§l------------------------------------§r")
            return
        end
        print("§b§l------------------------------------§r\n§eGetting §a".. formattedGamemode[string.upper(gamemode)] .. "§r§e statistics for§r§c " .. username .. "§r\n§r§b§l------------------------------------§r")
        network.get("https://api.playhive.com/v0/game/all/" .. gamemode .. "/" .. username, gamemode)
    end
end)