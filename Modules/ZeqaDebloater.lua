name = "Zeqa Chat Debloater"
description =
"Removes many annoying messages from Zeqa.net's chat.                                                         Made by miniguy7\nWith alot of code from xjqms."

--[[
    Hive Chat Debloater Script

    Made by mini
    Much help from xjqms <3
]]
--

RemoveLogin = true
RemovePSA = true
RemoveJoin = true
RemoveCombat = true
RemoveMisc = true
RemoveCosm = true
Staff = true

function Debloat()
    RemoveLogin = true
    RemovePSA = true
    RemoveJoin = true
    RemoveCombat = true
    RemoveMisc = true
    RemoveCosm = true
    Staff = true
    client.settings.send()
end

function Bloat()
    RemoveLogin = false
    RemovePSA = false
    RemoveJoin = false
    RemoveCombat = false
    RemoveMisc = false
    RemoveCosm = false
    Staff = false
    client.settings.send()
end


client.settings.addAir(5)
client.settings.addFunction("Enable All", "Debloat", "Debloat")
client.settings.addFunction("Disable All", "Bloat", "Bloat")
client.settings.addAir(5)

category = client.settings.addNamelessCategory("Chat Debloater")
--LOGIN--
client.settings.addBool("Remove on login messages.", "RemoveLogin")
client.settings.addInfo("(On login info messages)")
client.settings.addAir(5)
--PSA--
client.settings.addBool("Remove PSA messages.", "RemovePSA")
client.settings.addInfo("(Discord, BetterBedrock, Store)")
client.settings.addAir(5)
--Join & Leave--
client.settings.addBool("Remove join and leave messages.", "RemoveJoin")
client.settings.addInfo("([+], [-])")
client.settings.addAir(5)
--Combat--
client.settings.addBool("Remove combat messages.", "RemoveCombat")
client.settings.addInfo("(In combat, No longer in combat, Interrupting)")
client.settings.addAir(5)
--Misc--
client.settings.addBool("Remove miscellaneous messages.", "RemoveMisc")
client.settings.addInfo("(Tp to hub, No longer in combat, Interrupting)")
client.settings.addAir(5)
--Cosm--
client.settings.addBool("Remove cosmetic related messages.", "RemoveMisc")
client.settings.addInfo("(Apply: Cape, Artifact, Projectile, Killphrase, Pot, Tag, Nick)")
client.settings.addAir(5)

removeLoginMessages = {
    "to open chat",
    "ZEQA » Loading your data...",
    "       Zeqa Network",
    "",
    "   Welcome to Zeqa Network",
    " - Vote: vote.zeqa.net",
    " - Store: store.zeqa.net",
    " - Discord: discord.gg/zeqa",
    "ZEQA » If your mouse double clicks, please download and use DC prevent at discord.gg/zeqa or it will result as a ban"
}
RemoveCombatMessages = {
    "ZEQA » You are in combat",
    "ZEQA » You are no longer in combat",
    "ZEQA » Interrupting is not allowed!"
}
RemoveMiscMessages = {
    "ZEQA » You have been teleported to the hub",
    " has gotten a "
}
RemoveCosmMessages = {
    " has obtained ",
    "§eZEQA§8 » §r§7Applying ",
    "§eZEQA§8 » §r§7You have successfully changed ",
    "§eZEQA§8 » §r§aSuccessfully edited"
}
RemovePsaMessages = {
    "Join our Discord Server for more updates!",
    "Want to support our Network?",
    "Someone who's not following the rules? Type",
    "Better Bedrock Client is the #1 utility texture pack with unique mods & useful quality of life features."
}

-------------------------------------------
event.listen("ChatMessageAdded", function(message, username, type, xuid)
    message1 = message:gsub("§.", "")
    --Login--
    if RemoveLogin then
        for i,v in pairs(removeLoginMessages) do
            if message1:find(v) then
                return true
            end
        end
    end

    --PSA--
    if RemovePSA then
        for i,v in pairs(RemovePsaMessages) do
            if message:find(v) then
                return true
            end
        end
    end

    --Join & Leave--
    if RemoveJoin then
        if message:match("§8]§. ") then
            return true
        end
    end

    --Combat--
    if RemoveCombat then
        for i,v in pairs(RemoveCombatMessages) do
            if message1:find(v) then
                return true
            end
        end
    end

    --Misc--
    if RemoveMisc then
        for i,v in pairs(RemoveMiscMessages) do
            if message1:find(v) then
                return true
            end
        end
    end

    --Cosm--
    if RemoveCosm then
        for i,v in pairs(RemoveCosmMessages) do
            if message:find(v) then
                return true
            end
        end
    end
end)