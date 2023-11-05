name = "Zeqa Emotes Everywhere"
description = "Makes Zeqa's emotes work everywhere."

emojiToUnicode = {
	[":kiss:"] = "",
	[":nerd:"] = "",
	[":yum:"] = "",
	[":slight_smile:"] = "",
	[":weary:"] = "",
	[":sad:"] = "",
	[":relieved:"] = "",
	[":sob:"] = "",
	[":blush:"] = "",
	[":joy:"] = "",
	[":cool:"] = "",
	[":hot:"] = "",
	[":ayo:"] = "",
	[":love:"] = "",
	[":smirk:"] = "",
	[":kekw:"] = "",
	[":clown:"] = "",
	[":bruh:"] = "",
	[":w:"] = "",
	[":gg:"] = "",
	[":grin:"] = "",
	[":happy:"] = "",
	[":sweat:"] = "",
	[":cry:"] = "",
	[":worried:"] = "",
	[":think:"] = "",
	[":monocle :"] = "",
	[":confused:"] = "",
	[":meh:"] = "",
	[":dead:"] = "",
	[":sleep:"] = "",
	[":skull:"] = "",
	[":down:"] = "",
	[":up:"] = "",
	[":devil:"] = "",
	[":mad_devil:"] = "",
	[":splash:"] = "",
	[":peach:"] = "",
	[":eggplant:"] = "",
	[":tongue:"] = "",
	[":starstruck:"] = "",
	[":heart:"] = "",
	[":heartbreak:"] = "",
	[":rage:"] = "",
	[":wink:"] = "",
	[":poop:"] = "",
	[":pray:"] = "",
	[":cap:"] = "",
	[":sparkles:"] = "",
	[":noob:"] = "",
	[":moyai:"] = "",
	[":angel:"] = "",
	[":teary:"] = "",
	[":dizzy:"] = "",
	[":smile:"] = "",
    [":monocle:"] = ""
}

event.listen("ChatMessageAdded", function(message, username, type, xuid)
    for emoji, unicode in pairs(emojiToUnicode) do
        message = message:gsub(emoji, unicode)
    end
    print(message)
    return true
end)