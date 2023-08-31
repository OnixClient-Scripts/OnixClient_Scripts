command = "stats"
help_message = "Adds the ability to check stats on Hyperlands"

function execute(name)
    if name == "" then
        print("§l§4Requires a gamertag .stats [gamertag]")
        return
    end

    identifier = ""
    local url = "http://api.hyperlandsmc.net/stats/" .. name
    network.get(url,identifier)
    print("§6Fetching stats for " .. name .. "...")
end

function onNetworkData(code, identifier, data)
    result = jsonToTable(data)
    if type(result) ~= "table" then
        print("§4Error")
        return
    end
    if result["error"] == "Player not found." then
        print("§l§4Player Not Found")
        return
    else
        -- Rank Colours
        genRank = result["rankData"]["rank"]
        if genRank == "Hyper" or genRank == "Prime" or genRank == "Prime+" or genRank == "Trainee" then
            print("§l§bRank: " .. genRank)
        elseif genRank == "Elite" or genRank == "Elite+" or genRank == "Elite++" then
            print("§l§9Rank: " .. genRank)
        elseif genRank == "YouTuber" or genRank == "Admin" or genRank == "Manager" then
            print("§l§4Rank: " .. genRank)
        elseif genRank == "Helper" then
            print("§l§1Rank: " .. genRank)
        elseif genRank == "DevTeam" or genRank == "Developer" then
            print("§l§5Rank: " .. genRank)
        elseif genRank == "Builder" then
            print("§d§5Rank: " .. genRank)
        else
            print("§l§7Rank: " .. genRank)
        end

        -- Will add level colors once I have managed to compile a list of the colours which represent each level
        print("Level: " .. result["stats"]["general"]["level"])

        -- Tier Colours
        genTier = result["stats"]["general"]["tier"]
        if genTier == "I" then
            print("§l§7Tier: "..genTier)
        end
        if genTier == "II" then
            print("§l§8Tier: "..genTier)
        end
        if genTier == "III" then
            print("§l§1Tier: "..genTier)
        end
        if genTier == "IV" then
            print("§l§bTier: "..genTier)
        end
        if genTier == "V" then
            print("§l§aTier: "..genTier)
        end
        if genTier == "VI" then
            print("§l§eTier: "..genTier)
        end
        if genTier == "VII" then
            print("§l§6Tier: "..genTier)
        end
        if genTier == "VIII" then
            print("§l§5Tier: "..genTier)
        end
        if genTier == "IX" then
            print("§l§cTier: "..genTier)
        end
        if genTier == "X" then
            print("§l§4Tier: "..genTier)
        end

        -- Skywars Stats
        print("§l§7Sky§l§2wars")
        print("§7Wins: " .. result["stats"]["skywars"]["wins"])
        print("§7Kills: " .. result["stats"]["skywars"]["kills"])

        -- Bedwars Stats
        print("§l§7Bed§l§4wars")
        print("§7Wins: " .. result["stats"]["bedwars"]["wins"])
        print("§7Kills: " .. result["stats"]["bedwars"]["kills"])
        print("§7Beds: " .. result["stats"]["bedwars"]["bedsBroken"])
        
        -- The Bridge Stats
        print("§l§9The§l§cBridge")
        print("§7Wins: " .. result["stats"]["thebridge"]["wins"])
        print("§7Goals: " .. result["stats"]["thebridge"]["goals"])
        print("§7Elo: " .. math.floor(result["stats"]["thebridge"]["ratingDataSolos"]["r"]))

        -- Duels Stats
        print("§l§3D§6u§3e§6l§3s")
        print("§7Wins: " .. (result["stats"]["duels"]["buildUhcWins"] + result["stats"]["duels"]["potWins"] + result["stats"]["duels"]["ironWins"] + result["stats"]["duels"]["archerWins"] + result["stats"]["duels"]["sumoWins"]))
        -- Calculate Best Gamemdoe
        builduhcWins = result["stats"]["duels"]["buildUhcWins"]
        potWins = result["stats"]["duels"]["potWins"]
        ironWins = result["stats"]["duels"]["ironWins"]
        archerWins = result["stats"]["duels"]["archerWins"]
        sumoWins = result["stats"]["duels"]["sumoWins"]
        local variables = {
            builduhcWins = builduhcWins,
            potWins = potWins,
            ironWins = ironWins,
            archerWins = archerWins,
            sumoWins = sumoWins,
        }
        local highestVariable = ""
        local highestValue = -math.huge
        for variable, value in pairs(variables) do
            if value > highestValue then
                highestValue = value
                highestVariable = variable
            end
        end
        highestVariable = highestVariable:sub(1, -5)
        highestVariable = highestVariable:upper()
        print("§7Best Mode: ".. highestVariable)
        print("§7Elo: " .. result["stats"]["duels"]["elo"])
    end
end