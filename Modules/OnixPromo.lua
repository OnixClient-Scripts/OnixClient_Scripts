name="Onix Promo"
description="Promotes Onix Client in Hive chat."

PromoteOnix = false
PromoteOnixText = "Promote Onix Client in Hive chat. It replaces the server messages with Onix Client promotion. :)"

client.settings.addInfo("PromoteOnixText")
client.settings.addBool("Promote Onix Client in Hive chat.", "PromoteOnix")

function onChat(message, username, type)
    --Replace Store Purhcase Message
    if PromoteOnix == true and message == "§6[§e!§6] §r§7Didn't get your store purchase? §3Try §a/fixpurchase" then
        return true
    end
    if PromoteOnix == true and message == "§6[§e!§6] §r§7Didn't get your store purchase? §3Try §a/fixpurchase" then
        print("§6[§e!§6] §r§7Don't have Onix Client patreon? §3Try going to §apatreon.com/onixclient")
    end
    --Replace Support Message
    if PromoteOnix == true and message == "§6[§e!§6] §r§9Need help? §3Go to §asupport.playhive.com" then
        return true
    end
    if PromoteOnix == true and message == "§6[§e!§6] §r§9Need help? §3Go to §asupport.playhive.com" then
        print("§6[§e!§6] §r§9Need support with Onix Client? §3Go to the §a#community-support§3 channel or read §a#help-me§3!")
    end
    --Replace Forums Message
    if PromoteOnix == true and message == "§6[§e!§6] §r§aJoin our forums: §3Go to §bforum.playhive.com" then
        return true
    end
    if PromoteOnix == true and message == "§6[§e!§6] §r§aJoin our forums: §3Go to §bforum.playhive.com" then
        print("§6[§e!§6] §r§aJoin our Reddit: §3Go to §breddit.com/r/onixclient")
    end
    --Replace Follow Instagram Message
    if PromoteOnix == true and message == "§6[§e!§6] §r§bFollow our Instagram: §a@theHiveMC" then
        return true
    end
    if PromoteOnix == true and message == "§6[§e!§6] §r§bFollow our Instagram: §a@onixclient" then
        print("§6[§e!§6] §r§bWant scripting access?: §apatreon.com/onixclient")
    end
    --Replace Follow Twitter Message
    if PromoteOnix == true and message == "§6[§e!§6] §r§aFollow our Twitter: §b@theHiveMC" then
        return true
    end
    if PromoteOnix == true and message == "§6[§e!§6] §r§aFollow our Twitter: §b@theHiveMC" then
        print("§6[§e!§6] §r§aFollow the Onix Client twitter!: §b@OnixClient")
    end
    --Replace Join Discord Message
    if PromoteOnix == true and message == "§6[§e!§6] §r§9Join our Discord: run §d/discord §9or visit §ddiscord.gg/hive" then
        return true
    end
    if PromoteOnix == true and message == "§6[§e!§6] §r§9Join our Discord: run §d/discord §9or visit §ddiscord.gg/hive" then
        print("§6[§e!§6] §r§9Join the Onix Client discord Discord: §ddiscord.gg/onixclient")
    end
end
event.listen("ChatMessageAdded", onChat)


