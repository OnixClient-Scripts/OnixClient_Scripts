name="Onix Promo"
description="Promotes Onix Client in Hive chat."

PromoteOnix = false
PromoteOnixText = "Promote Onix Client in Hive chat. It replaces the server messages with Onix Client promotion. :)"

client.settings.addInfo("PromoteOnixText")
client.settings.addBool("Promote Onix Client in Hive chat.", "PromoteOnix")

function onChat(message, username, type)
    --Replace Store Purhcase Message
    if PromoteOnix == true and message == "§6[§e!§6] §r§7Didn't get your store purchase? §3Try §a/fixpurchase" then
        print("§6[§e!§6] §r§7Don't have Onix Client patreon? §3Try going to §apatreon.com/onixclient")
        return true
    end
    --Replace Support Message
    if PromoteOnix == true and message == "§6[§e!§6] §r§9Need help? §3Go to §asupport.playhive.com" then
        print("§6[§e!§6] §r§9Need support with Onix Client? §3Go to the §a#community-support§3 channel or read §a#help-me§3!")
        return true
    end
    --Replace Forums Message
    if PromoteOnix == true and message == "§6[§e!§6] §r§aJoin our forums: §3Go to §bforum.playhive.com" then
        print("§6[§e!§6] §r§aJoin our Reddit: §3Go to §breddit.com/r/onixclient")
        return true
    end
    --Replace Follow Instagram Message
    if PromoteOnix == true and message == "§6[§e!§6] §r§bFollow our Instagram: §a@theHiveMC" then
        print("§6[§e!§6] §r§7Want to report a bug? §3Make a ticket in the §aOnix Client discord!")
        return true
    end
    --Replace Follow Twitter Message
    if PromoteOnix == true and message == "§6[§e!§6] §r§aFollow our Twitter: §b@theHiveMC" then
        print("§6[§e!§6] §r§aFollow the Onix Client twitter!: §b@OnixClient")
        return true
    end
    --Replace Join Discord Message
    if PromoteOnix == true and message == "§6[§e!§6] §r§9Join our Discord: run §d/discord §9or visit §ddiscord.gg/hive" then
        print("§6[§e!§6] §r§9Join the Onix Client discord Discord: §ddiscord.gg/onixclient")
        return true
    end
end
event.listen("ChatMessageAdded", onChat)


