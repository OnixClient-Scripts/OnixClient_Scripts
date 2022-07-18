local formattedGamemodes = {
    DROP="Block Drop",
    CTF="Capture The Flag",
    BRIDGE="The Bridge",
    GROUND="Ground Wars",
    SG="Survival Games",
    MURDER="Murder Mystery",
    WARS="Treasure Wars",
    SKY="Skywars",
    BUILD="Just Build",
    HIDE="Hide And Seek",
    DR="DR",
    ARCADE="Arcade Hub",
    HUB="Hub",
    REPLAY="Replay"
}
formattedGamemodes["BRIDGE-DUOS"]="The Bridge: Duos" 
formattedGamemodes["SG-DUOS"]="Survival Games: Duos"
formattedGamemodes["WARS-DUOS"]="Treasure Wars: Duos"
formattedGamemodes["WARS-SQUADS"]="Treasure Wars: Squads"
formattedGamemodes["WARS-MEGA"]="Treasure Wars: Mega"
formattedGamemodes["SKY-DUOS"]="Skywars: Duos"
formattedGamemodes["SKY-TRIOS"]="Skywars: Trios"
formattedGamemodes["SKY-SQUADS"]="Skywars: Squads"
formattedGamemodes["SKY-KITS"]="Skywars Kits"
formattedGamemodes["SKY-KITS-DUOS"]="Skywars Kits: Duos"
formattedGamemodes["SKY-MEGA"]="Skywars Mega"
formattedGamemodes["BUILD-DUOS"]="Just Build: Duos"
formattedGamemodes["BUILDX"]="§5Just Build: Extended"
formattedGamemodes["BUILDX-DUOS"]="Just Build: Extended, Duos"

function formatGamemode(gamemode)
    if formattedGamemodes[gamemode] then
        return formattedGamemodes[gamemode]
    end
    return nil
end

function getListGamemodes()
    return formattedGamemodes
end