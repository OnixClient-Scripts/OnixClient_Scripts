name = "Hive Gamemode Hotkeys"
description = "Allows you to queue any hive gamemode with a key"


FUNCTIONAL_TITLE = "Functional"

FUNCTIONAL_hub = 0
FUNCTIONAL_connection = 0

SKYWARS_TITLE = "Skywars"
SKYWARS_sky = 0
SKYWARS_sky_duos = 0
SKYWARS_sky_trios = 0
SKYWARS_sky_squads = 0

TREASUREWARS_TITLE = "Treasure Wars"
TREASUREWARS_wars = 0
TREASUREWARS_wars_duos = 0
TREASUREWARS_wars_trios = 0
TREASUREWARS_wars_squads = 0
TREASUREWARS_wars_mega = 0
TREASUREWARS_wars_peview = 0

SURIVALGAMES_TITLE = "Survival Game"
SURIVALGAMES_solo = 0
SURIVALGAMES_duos = 0

JUST_BUILD_TITLE = "Just Build"
JUST_BUILD_solo = 0
JUST_BUILD_duos = 0
JUST_BUILD_solo_dt = 0
JUST_BUILD_duos_dt = 0

OTHER_TITLE = "Other"
SKYROYALE_key = 0
MURDERMYSTERY_key = 0
HIDEANDSEEK_key = 0
DEATHRUN_key = 0

SEASONAL_TITLE = "Seasonal"
SEASONAL_shost = 0
SEASONAL_snow = 0
SEASONAL_groundwar = 0

client.settings.addInfo("FUNCTIONAL_TITLE")
client.settings.addKeybind("Hub", "FUNCTIONAL_hub")
client.settings.addKeybind("Connection", "FUNCTIONAL_connection")
client.settings.addAir(8)

client.settings.addInfo("SKYWARS_TITLE")
client.settings.addKeybind("Solo", "SKYWARS_sky")
client.settings.addKeybind("Duos", "SKYWARS_sky_duos")
client.settings.addKeybind("Trios", "SKYWARS_sky_trios")
client.settings.addKeybind("Squads", "SKYWARS_sky_squads")
client.settings.addAir(8)

client.settings.addInfo("TREASUREWARS_TITLE")
client.settings.addKeybind("Solo", "TREASUREWARS_wars")
client.settings.addKeybind("Duos", "TREASUREWARS_wars_duos")
client.settings.addKeybind("Trios", "TREASUREWARS_wars_trios")
client.settings.addKeybind("Squads", "TREASUREWARS_wars_squads")
client.settings.addKeybind("Mega", "TREASUREWARS_wars_mega")
client.settings.addKeybind("Preview", "TREASUREWARS_wars_peview")
client.settings.addAir(8)

client.settings.addInfo("SURIVALGAMES_TITLE")
client.settings.addKeybind("Solo", "SURIVALGAMES_solo")
client.settings.addKeybind("Duos", "SURIVALGAMES_duos")
client.settings.addAir(8)

client.settings.addInfo("JUST_BUILD_TITLE")
client.settings.addKeybind("Solo", "JUST_BUILD_solo")
client.settings.addKeybind("Duos", "JUST_BUILD_duos")
client.settings.addKeybind("Solo Double Time", "JUST_BUILD_solo_dt")
client.settings.addKeybind("Duos Double Time", "JUST_BUILD_duos_dt")
client.settings.addAir(8)

client.settings.addInfo("OTHER_TITLE")
client.settings.addKeybind("Sky Royale", "SKYROYALE_key")
client.settings.addKeybind("Murder Mystery", "MURDERMYSTERY_key")
client.settings.addKeybind("Hide and Seek", "HIDEANDSEEK_key")
client.settings.addKeybind("Death Run", "DEATHRUN_key")
client.settings.addAir(8)

client.settings.addInfo("SEASONAL_TITLE")
client.settings.addKeybind("Shost Invasion (Autumn)", "SEASONAL_shost")
client.settings.addKeybind("Snow Wars (Winter)", "SEASONAL_snow")
client.settings.addKeybind("Ground Wars", "SEASONAL_groundwar")
client.settings.addAir(8)

function keyboard(key, isDown)
    if string.match(server.ip(), "hive") == nil then return end --make sure we on hive

    --FUNCTIONAL KEYS
    if key == FUNCTIONAL_hub and isDown == true then client.execute("execute /hub") end --/hub
    if key == FUNCTIONAL_connection and isDown == true then client.execute("execute /connection") end --/connection (to check your connected server)

    --SKYWARS
    if key == SKYWARS_sky and isDown == true then client.execute("execute /q sky") end --queue Sky Solo
    if key == SKYWARS_sky_duos and isDown == true then client.execute("execute /q sky-duos") end --queue Sky Duo
    if key == SKYWARS_sky_trios and isDown == true then client.execute("execute /q sky-trios") end --queue Sky Trio
    if key == SKYWARS_sky_squads and isDown == true then client.execute("execute /q sky-squads") end --queue Sky Squad

    --SKYROYALE
    if key == SKYROYALE_key and isDown == true then client.execute("execute /q sky-royale") end --queue Sky Royale

    --TREASUREWARS
    if key == TREASUREWARS_wars and isDown == true then client.execute("execute /q wars") end --queue Treasurewars Solo
    if key == TREASUREWARS_wars_duos and isDown == true then client.execute("execute /q wars-duos") end --queue Treasurewars Duo
    if key == TREASUREWARS_wars_trios and isDown == true then client.execute("execute /q wars-trios") end --queue Treasurewars Trio
    if key == TREASUREWARS_wars_squads and isDown == true then client.execute("execute /q wars-squads") end --queue Treasurewars Squad

    --TREASUREWARS MEGA
    if key == TREASUREWARS_wars_mega and isDown == true then client.execute("execute /q wars-mega") end --queue Treasurewars Mega

    --TREASUREWARS PREVIEW (not always available)
    if key == TREASUREWARS_wars_peview and isDown == true then client.execute("execute /q wars-preview") end --queue Preview Treasurewars

    --SURIVALGAMES
    if key == SURIVALGAMES_solo and isDown == true then client.execute("execute /q sg") end --queue Surivalgames Solo
    if key == SURIVALGAMES_duos and isDown == true then client.execute("execute /q sg-duos") end --queue Surivalgames Duo

    --MURDER MYSTERY
    if key == MURDERMYSTERY_key and isDown == true then client.execute("execute /q murder") end --queue Murder MYSTERY

    --HIDE AND SEEK
    if key == HIDEANDSEEK_key and isDown == true then client.execute("execute /q hide") end --queue Hide and Seek

    --DEATH RUN
    if key == DEATHRUN_key and isDown == true then client.execute("execute /q dr") end --queue Death Run

    --JUST BUILD
    if key == JUST_BUILD_solo and isDown == true then client.execute("execute /q build") end --queue Just Build Solo
    if key == JUST_BUILD_duos and isDown == true then client.execute("execute /q build-duos") end --queue Just Build Duo
    if key == JUST_BUILD_solo_dt and isDown == true then client.execute("execute /q buildX") end --queue Just Build Double Time Solo
    if key == JUST_BUILD_duos_dt and isDown == true then client.execute("execute /q build-duosX") end --queue Just Build Double Time Duo

    --SEASONAL
    if key == SEASONAL_shost and isDown == true then client.execute("execute /q gi") end --queue Shost Invasion (Autumn)
    if key == SEASONAL_snow and isDown == true then client.execute("execute /q snow") end --queue Snow Wars (Winter)
    if key == SEASONAL_groundwar and isDown == true then client.execute("execute /q ground") end --queue Ground Wars

end
event.listen("KeyboardInput", keyboard)


