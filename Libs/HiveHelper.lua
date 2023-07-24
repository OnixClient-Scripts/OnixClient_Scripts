Game = {
	TreasureWars = "wars",
	DeathRun = "dr",
	HideAndSeek = "hide",
	MurderMystery = "murder",
	SurvivalGames = "sg",
	SkyWars = "sky",
	JustBuild = "build",
	GroundWars = "ground",
	BlockDrop = "drop",
	CaptureTheFlag = "ctf",
	BlockParty = "party",
	Bridge = "bridge",
	Gravity = "grav"
}

GameInfo = {
    [Game.TreasureWars] = {
        levels = {
            increment = 150,
            increment_cap = 52,
            max = 100,
            max_prestige = 5
        },
        leaderboard_epoch = {
            year = 2018,
            month = 11
        }
    },
    [Game.DeathRun] = {
        levels = {
            increment = 200,
            increment_cap = 42,
            max = 75
        },
        leaderboard_epoch = {
            year = 2019,
            month = 0
        }
    },
    [Game.HideAndSeek] = {
        levels = {
            increment = 100,
            max = 50
        },
        leaderboard_epoch = {
            year = 2022,
            month = 5
        }
    },
    [Game.MurderMystery] = {
        levels = {
            increment = 100,
            increment_cap = 82,
            max = 100,
            max_prestige = 5
        },
        leaderboard_epoch = {
            year = 2019,
            month = 5
        }
    },
    [Game.SurvivalGames] = {
        levels = {
            increment = 150,
            max = 30
        },
        leaderboard_epoch = {
            year = 2019,
            month = 7
        }
    },
    [Game.SkyWars] = {
        levels = {
            increment = 150,
            increment_cap = 52,
            max = 75
        },
        leaderboard_epoch = {
            year = 2020,
            month = 4
        }
    },
    [Game.JustBuild] = {
        levels = {
            increment = 100,
            max = 20
        },
        leaderboard_epoch = {
            year = 2022,
            month = 0
        }
    },
    [Game.GroundWars] = {
        levels = {
            increment = 150,
            max = 20
        },
        leaderboard_epoch = {
            year = 2022,
            month = 5
        }
    },
    [Game.BlockDrop] = {
        levels = {
            increment = 150,
            increment_cap = 22,
            max = 25
        },
        leaderboard_epoch = {
            year = 2022,
            month = 5
        }
    },
    [Game.CaptureTheFlag] = {
        levels = {
            increment = 150,
            max = 20
        },
        leaderboard_epoch = {
            year = 2022,
            month = 5
        }
    },
    [Game.BlockParty] = {
        levels = {
            increment = 150,
            max = 25
        },
        leaderboard_epoch = {
            year = 2023,
            month = 0
        }
    },
    [Game.Bridge] = {
        levels = {
            increment = 0,
            max = 20
        },
        leaderboard_epoch = {
            year = 2023,
            month = 5
        }
    },
    [Game.Gravity] = {
        levels = {
            increment = 150,
            max = 25
        },
        leaderboard_epoch = {
            year = 2023,
            month = 6
        }
    }
}

function calculateLevel(game, xp)
    if game == Game.Bridge then
        if not xp then
            return nil
        end

        local lastXp = 0
        local currentXp = 300
        local increment = 300
        local additionalIncrement = 300

        local i = 2
        while true do
            if xp == currentXp then
                return i
            elseif xp < currentXp then
                return i + (xp - lastXp) / (currentXp - lastXp) - 1
            end

            additionalIncrement = math.floor(additionalIncrement * 1.08)
            increment = increment + additionalIncrement
            lastXp = currentXp
            currentXp = currentXp + increment
            i = i + 1
        end
    end

    local increment = GameInfo[game].levels.increment / 2
    local flattenLevel = GameInfo[game].levels.increment_cap
    local level =
        (-increment + math.sqrt(math.pow(increment, 2) - 4 * increment * -xp)) /
            (2 * increment) +
        1
    if flattenLevel and level > flattenLevel then
        level =
            flattenLevel +
            (xp -
                (increment * math.pow(flattenLevel - 1, 2) +
                    (flattenLevel - 1) * increment)) /
                ((flattenLevel - 1) * increment * 2)
    end
    return level
end