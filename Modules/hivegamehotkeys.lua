name = "hivegamehotkeys"
description = "gamemodehotkeys modul and tryout from chillihero"


    --[[ 
    HOW TO USE THIS MODUL
    Replace the "x" at "key == x" with a key values
    find key value here https://docs.microsoft.com/en-us/windows/win32/inputdev/virtual-key-codes
    ]]

function keyboard(key, isDown)

    --FUNCTIONAL KEYS
    if key == x and isDown == true then client.execute("execute /hub") end --/hub
    if key == x and isDown == true then client.execute("execute /connection") end --/connection (to check your connected server)

    --SKYWARS
    if key == x and isDown == true then client.execute("execute /q sky") end --queue Sky Solo
    if key == x and isDown == true then client.execute("execute /q sky-duos") end --queue Sky Duo
    if key == x and isDown == true then client.execute("execute /q sky-trios") end --queue Sky Trio
    if key == x and isDown == true then client.execute("execute /q sky-squads") end --queue Sky Squad

    --SKYROYALE
    if key == x and isDown == true then client.execute("execute /q sky-royale") end --queue Sky Royale

    --TREASUREWARS
    if key == x and isDown == true then client.execute("execute /q wars") end --queue Treasurewars Solo
    if key == x and isDown == true then client.execute("execute /q wars-duos") end --queue Treasurewars Duo
    if key == x and isDown == true then client.execute("execute /q wars-trios") end --queue Treasurewars Trio
    if key == x and isDown == true then client.execute("execute /q wars-squads") end --queue Treasurewars Squad

    --TREASUREWARS MEGA
    if key == x and isDown == true then client.execute("execute /q wars-mega") end --queue Treasurewars Mega

    --TREASUREWARS PREVIEW (not always available)
    if key == x and isDown == true then client.execute("execute /q wars-preview") end --queue Preview Treasurewars

    --SURIVALGAMES
    if key == x and isDown == true then client.execute("execute /q sg") end --queue Surivalgames Solo
    if key == x and isDown == true then client.execute("execute /q sg-duos") end --queue Surivalgames Duo

    --MURDER MYSTERY
    if key == x and isDown == true then client.execute("execute /q murder") end --queue Murder MYSTERY

    --HIDE AND SEEK
    if key == x and isDown == true then client.execute("execute /q hide") end --queue Hide and Seek

    --DEATH RUN
    if key == x and isDown == true then client.execute("execute /q dr") end --queue Death Run

    --JUST BUILD
    if key == x and isDown == true then client.execute("execute /q build") end --queue Just Build Solo
    if key == x and isDown == true then client.execute("execute /q build-duos") end --queue Just Build Duo
    if key == x and isDown == true then client.execute("execute /q buildX") end --queue Just Build Double Time Solo
    if key == x and isDown == true then client.execute("execute /q build-duosX") end --queue Just Build Double Time Duo

    --SEASONAL
    if key == x and isDown == true then client.execute("execute /q gi") end --queue Shost Invasion (Autumn)
    if key == x and isDown == true then client.execute("execute /q snow") end --queue Snow Wars (Winter)
    if key == x and isDown == true then client.execute("execute /q ground") end --queue Ground Wars

end



