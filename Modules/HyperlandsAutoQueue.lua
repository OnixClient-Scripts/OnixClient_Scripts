name = "HyperlandsAutoQueue"
description = "Auto Queues any gamemode in hyperlands"

BedWars_Solos = false
BedWars_Doubles = false
BedWars_Squads = false

SkyWars_Solos = false
SkyWars_Doubles = false
SkyWars_Duels = false

TheBridge_Solos = false
TheBridge_Doubles = false
TheBridge_Squads = false

Duels_BUHC = false
Duels_PotPvP = false
Duels_Iron = false
Duels_Archer = false
Duels_Sumo = false

UHCM = false

client.settings.addBool("Bedwars Solos", "BedWars_Solos")
client.settings.addBool("Bedwars Doubles", "BedWars_Doubles")
client.settings.addBool("Bedwars Squads", "BedWars_Squads")

client.settings.addAir(15)

client.settings.addBool("SkyWars Solos", "SkyWars_Solos")
client.settings.addBool("SkyWars Doubles", "SkyWars_Doubles")
client.settings.addBool("SkyWars Duels", "SkyWars_Duels")

client.settings.addAir(15)

client.settings.addBool("TheBridge Solos", "TheBridge_Solos")
client.settings.addBool("TheBridge Doubles", "TheBridge_Doubles")
client.settings.addBool("TheBridge Squads", "TheBridge_Squads")

client.settings.addAir(15)

client.settings.addBool("Duels BUHC", "Duels_BUHC")
client.settings.addBool("Duels PotPvP", "Duels_PotPvP")
client.settings.addBool("Duels Iron", "Duels_Iron")
client.settings.addBool("Duels Archer", "Duels_Archer")
client.settings.addBool("Duels Sumo", "Duels_Sumo")

client.settings.addAir(15)

client.settings.addBool("UHC Meetup", "UHCM")


function onChat(message, username, type)
    message = string.lower(message)
    Winstreak = string.find(message, "win") and string.find(message, "streak") and (string.find(message, "current") or  string.find(message, "ended")) and (string.find(message, "of") or string.find(message, "is"))
    AutoQueue = string.find(message, "autoqueue")
    
    if BedWars_Solos == true and (Winstreak or AutoQueue) then
        client.execute("say /q bedwars-solos")
    end

    if BedWars_Doubles == true and (Winstreak or AutoQueue) then
        client.execute("say /q bedwars-doubles")
    end

    if BedWars_Squads == true and (Winstreak or AutoQueue) then
        client.execute("say /q bedwars-squads")
    end

    if SkyWars_Solos == true and (Winstreak or AutoQueue) then
        client.execute("say /q skywars-solos")
    end

    if SkyWars_Doubles == true and (Winstreak or AutoQueue) then
        client.execute("say /q skywars-doubles")
    end

    if SkyWars_Duels == true and (Winstreak or AutoQueue) then
        client.execute("say /q skywars-duels")
    end

    if TheBridge_Solos == true and (Winstreak or AutoQueue) then
        client.execute("say /q thebridge-solos")
    end

    if TheBridge_Doubles == true and (Winstreak or AutoQueue) then
        client.execute("say /q thebridge-doubles")
    end

    if TheBridge_Squads == true and (Winstreak or AutoQueue) then
        client.execute("say /q thebridge-squads")
    end

    if Duels_BUHC == true and (Winstreak or AutoQueue) then
        client.execute("say /q duels-builduhc")
    end

    if Duels_PotPvP == true and (Winstreak or AutoQueue) then
        client.execute("say /q duels-potpvp")
    end

    if Duels_Iron == true and (Winstreak or AutoQueue) then
        client.execute("say /q duels-iron")
    end

    if Duels_Archer == true and (Winstreak or AutoQueue) then
        client.execute("say /q duels-archer")
    end

    if Duels_Sumo == true and (Winstreak or AutoQueue) then
        client.execute("say /q duels-sumo")
    end

    if UHCM == true and (Winstreak or AutoQueue) then
        client.execute("say /q uhcmeetup-solos")
    end
end

event.listen("ChatMessageAdded", onChat)