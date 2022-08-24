name = "Hive Auto Stat Checker"
description = "Automatically Check Stats."

-- made by rosie (thanks onix and his big fat brain)

importLib("Wait")
inGame = false
lastGamemode = ""

local result = {}

function postInit()
    client.execute("toggle on script " .. name)
end

function getStats()
    while true do
        --make it wait until it should reload names
        while inGame == false do
            wait(20)
        end
        inGame = false
        local players = server.players()
        for _, username in pairs(players) do
            if username ~= player.name() then
                local gamemode = string.lower(lastGamemode)
                if string.find(gamemode, "-") then
                    gamemode = string.sub(gamemode, 1, string.find(gamemode, "-") - 1)
                end
                network.get("https://api.playhive.com/v0/game/all/" .. gamemode .. "/" .. username, gamemode .. "/" .. username)
                wait(50)
            end -- imagine not knowing how to do for lookpsll youself
        end
    end
end

function tablelen(tbl)
    local a = 0
    for k, v in pairs(tbl) do
        a = a + 1
    end
    return a
end

local GAME_XP = {
    wars={150,52},
    dr={200},
    hide={100},
    murder={100, 82},
    sg={150},
    sky={150, 52},
    build={100},
    ground={150},
    drop={150, 22},
    ctf={150}
}
function calculateLevel(game, xp)
    local increment = GAME_XP[game][1] / 2
    local flattenLevel = GAME_XP[game][2]
    local level =
        (-increment + math.sqrt((increment^2) - 4 * increment * -xp)) /
        (2 * increment) +
        1
    if flattenLevel and level > flattenLevel then
        level =
            flattenLevel +
            (xp -
                (increment * ((flattenLevel - 1)^2) +
                    (flattenLevel - 1) * increment)) /
            ((flattenLevel - 1) * increment * 2)
    end
    return level
end

function getLevelColor(level)
    if level <= 9 then
        return "§7"
    elseif level <= 19 then
        return "§6"
    elseif level <= 24 then
        return "§e"
    elseif level <= 29 then
        return "§b"
    elseif level <= 49 then
        return "§d"
    elseif level <= 79 then
        return "§a"
    elseif level <= 99 then
        return "§c"
    elseif level <= 100 then
        return "§9"
    end
    return "Massive fat error contact xJqms"
end
function onNetworkData(code, gamemodeusername, data)
    local gamemode = string.split(gamemodeusername, "/")[1]
    local username = string.split(gamemodeusername, "/")[2]
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
            local level = math.floor(10*(calculateLevel(gamemode, result["xp"])))/10
            print("§8" .. username .. "§f, Lvl: " .. getLevelColor(level) .. level .. "§f, W: §e" .. result["victories"] .. "§f, W/L: §7".. math.floor((result["victories"] / result["played"]) * 1000)/10 .. "%")
        end
    end
end

delayedFunction(getStats)

function render(dt)
    updateTimes(dt)
end

function onChat(message,username,type)
    if string.find(message, "§b§l» §r§a§lVoting has ended!") then
        client.execute("execute /connection")
        inGame = true
    end
    if string.find(message, player.name()) and string.find(message, " joined. §8") then
        client.execute("execute /connection")
        inGame = false
    end
    if string.find(message, "You are connected to server ") then
        lastGamemode = message
        lastGamemode = string.sub(message, 29)
        lastGamemode = string.match(lastGamemode, "[%a-]*")
    end

    -- hide the /connection message
    if string.find(message, "You are connected to proxy ") then
        return true
    end
    if string.find(message, "You are connected to server ") then
        return true
    end
    if string.find(message, "§cYou're issuing commands too quickly, try again later.") then
        return true
    end
    if string.find(message, "§cUnknown command. Sorry!") then
        return true
    end
end
event.listen("ChatMessageAdded", onChat)