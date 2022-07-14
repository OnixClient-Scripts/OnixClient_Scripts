name="Hive Custom AutoGG"
description="AutoGG Reimagined."

--[[ 
made by rosie <3 (and as always, big thanks to mcbe for being epic + gaming + cool + grass toucher)
if you want me to add any messages, lmk and ill add them <3
this only works on sky wars as of right now WITH THE DEFAULT KILL MESSAGE!!!!!!!!!
]]

importLib("DependentBoolean")

lastGamemode = ""

killMessage = false
hackedClientMessages = false

toxicMessages = false
kindMessages = false
randomMessages = false
palmMessages = false

packetMessages = false
ngMessages = false

allMessages = false

client.settings.addAir(5)
client.settings.addBool("Send a message on kill?","killMessage")
client.settings.addAir(5)
client.settings.addDependentBool("All Messages?","allMessages","killMessage")
client.settings.addAir(5)
client.settings.addDependentBool("Be toxic?","toxicMessages","killMessage")
client.settings.addDependentBool("Be kind?","kindMessages","killMessage")
client.settings.addDependentBool("Palmzy messages?","palmMessages","killMessage")
client.settings.addDependentBool("Random assortment?","randomMessages","killMessage")
client.settings.addAir(5)
client.settings.addDependentBool("Hacked client messages?","hackedClientMessages","killMessage")
client.settings.addAir(5)
client.settings.addDependentBool("Packet Client messages?","packetMessages","hackedClientMessages")
client.settings.addDependentBool("NG Client messages?","ngMessages","hackedClientMessages")

function update(dt)
	client.settings.updateDependencies()
end
function getPlayerHealth()
	local playerHealth = player.attributes().name("minecraft:health").value / 2
	if math.floor(playerHealth) == math.ceil(playerHealth) then
		return string.format("%.0f", playerHealth)
	else
		return string.format("%.1f", playerHealth)
	end
end
function getToxicMessage(playerKilled)
	local messages = {
		"Hey, @".. playerKilled .. ", get some SKILL + bad.",
		"LOL, @" .. playerKilled .. ", how did u even hit the play button with that aim?",
		"@" .. playerKilled .. ", i ruined you LOL",
		"HEY, @" .. playerKilled .. ", GO CRY ABOUT IT",
		"go to sleep, @" .. playerKilled .. ", your parents are mad at you",
		"imagine being bad LOL @" .. playerKilled .. "",
		"is your monitor even turned on?? @" .. playerKilled .. "",
		"bro, @" .. playerKilled .. " is dogger than my dog",
		"i just trolled @" .. playerKilled .. "",
		"oi, @" .. playerKilled .. ", your hits are slower than my grandma, and shes " .. math.random(65, 100),
		"u lack robux, @" .. playerKilled .. "",
		"L bozo, @" .. playerKilled .. "",
		"instead of aimbot, you have MISSbot LOL, @" .. playerKilled .. "",
		"mad skillz, @" .. playerKilled .. ", bro 100% respect + gamer",
		"guys i think @" .. playerKilled .. " is malding",
		"@" .. playerKilled .. " is coping currently",
		"just obliterated @" .. playerKilled .. "!",
		"oops! @" .. playerKilled .. " threw a 404 error: skill not found",
		"my dog is better than you @" .. playerKilled .. "",
		"my goldfish has better aim than you @" .. playerKilled .. ""
	}
	return messages[math.random(1, #messages)]
end
function getKindMessage(playerKilled)
	local messages = {
		"good game, @" .. playerKilled .. "",
		"you played well <3 @" .. playerKilled .. "",
		"nice skin :D, @" .. playerKilled .. "",
		"you played valiantly, @" .. playerKilled .. "",
		"you remind me of my grandma, @" .. playerKilled .. "",
		"thank u for participating in this battle, @" .. playerKilled .. "",
		"hey, awesome fight we had <3",
		"dont worry, youll get me next time! @" .. playerKilled .. "",
		"better luck next time, @" .. playerKilled .. "",
		"dw u still good, @" .. playerKilled .. "",
		"i was on " .. getPlayerHealth() .. " hearts omg, @" .. playerKilled .. "",
		"that was a close one, @" .. playerKilled .. "! i had " .. getPlayerHealth() .. " hearts left",
		"you almost had me there, @" .. playerKilled .. "",
		"frfr ong i just turned @" .. playerKilled .. " into a pancake",
		"looking good! @" .. playerKilled .. "",
		"Don't cry because it's over, smile because it happened. - You played well, @" .. playerKilled .. ", I'm proud of you.",
		"Keep improving, @" .. playerKilled .. "!",
		"not even close - Technoblade",
		"Excellent fight, " .. playerKilled .. "",
		"\"If you wish to defeat me, @" .. playerKilled .. " you must train for another 200 years.\" - Technoblade",
		"that was intense, @" .. playerKilled .. ""
	}
	return messages[math.random(1, #messages)]
end
function getRandomMessage(playerKilled)
	local messages = {
		"zephyr on top, @" .. playerKilled,
		"packet on top, @" .. playerKilled,
		"@" .. playerKilled .. ", horion on top",
		"cheating w @" .. playerKilled,
		"nitr0 on top @" .. playerKilled,
		"arabian client is the best, @" .. playerKilled,
		"imagine not using onix, @" .. playerKilled ..  " LOL",
		"poop on top, @" .. playerKilled,
		"bypassing so easily",
		"OhEU clicker best, @" .. playerKilled,
		"imagine not having 50cps LOL",
		"fortnite move, @" .. playerKilled,
		"fireXI w",
		"sub2palm",
		"imagine not using onix client, @" .. playerKilled,
		"@" .. playerKilled .. " is maidenless ong",
		"sheeeesh",
		"3.5 blocks = pure skill, @" .. playerKilled,
		"ziqy runs u, on gang, bro @" .. playerKilled,
		"palmzy w",
		"smokin on your " .. math.random(65,100) .. " year old nan",
		"your kill aura failed, @" .. playerKilled,
		"Zephyr is your new home",
		"Download Packet Client, @" .. playerKilled,
		"You should install Packet Client, @" .. playerKilled,
		"Zephyr increases your skill, @" .. playerKilled,
		"@" .. playerKilled .. " isnt even using packet client",
		"my reach owns you, @" .. playerKilled,
		"no knockback? (megamind)",
		"my kill aura runs you, @" .. playerKilled,
		"no cheats? (megamind)",
		"its okay to cry, @" .. playerKilled,
		"@" .. playerKilled .. " should install zephyr",
		"hive anti cheat is the best, @" .. playerKilled,
		"this anticheat is so good!",
		"rosie client is the best, @" .. playerKilled,
		"@" .. playerKilled .. " should install rosie client",
		"bad gaming chair, @" .. playerKilled,
		"@" .. playerKilled .. ", here's your tickets to the juice wrld concert",
		"@" .. playerKilled .. ", i bet you probably shop at Costco",
		"@" .. playerKilled .. ", do you buy your groceries at the dollar store?",
		"@" .. playerKilled .. ", i guess u forgot to get sulfur...",
		"@" .. playerKilled .. ", what do your clothes have in common with your skills? they're both straight out of a dumpster",
		"@" .. playerKilled .. ", i don't cheat, you just need to click faster",
		"@" .. playerKilled .. ", i speak english not your gibberish",
		"@" .. playerKilled .. ", i understand why your parents abused you",
		"@" .. playerKilled .. ", i'd tell you to uninstall, but your aim is so bad you'd miss and click on your among us r34 instead",
		"@" .. playerKilled .. ", im not saying you're worthless, but i'd unplug ur life support to charge my phone",
		"@" .. playerKilled .. ", need some pvp advice?",
		"@" .. playerKilled .. ", how are you so bad? just practice your aim and hold w",
		"@" .. playerKilled .. ", you do be lookin' kinda bad at the game doh :flushed:",
		"@" .. playerKilled .. ", you look like you were drawn with my left hand",
		"@" .. playerKilled .. ", you pressed the wrong button when you installed Minecraft",
		"@" .. playerKilled .. ", you should look into buying a client",
		"@" .. playerKilled .. ", you're so white that you don't play on vanilla, you play on clear",
		"@" .. playerKilled .. ", your difficulty settings must be stuck on easy",
		"@" .. playerKilled .. ", even your mom is better than you in this game",
		"@" .. playerKilled .. ", go back to fortnite you degenerate",
		"@" .. playerKilled .. ", go commit stop breathing plz",
		"@" .. playerKilled .. ", go play roblox you worthless degenerate",
		"@" .. playerKilled .. ", go take a long walk off a short bridge",
		"@" .. playerKilled .. ", if the body is 70% water then how is your body 100% salt?",
		"@" .. playerKilled .. ", lol you probably speak dog eater",
		"@" .. playerKilled .. ", mans probably got an error on his hello world program lmao",
		"@" .. playerKilled .. ", no top hat, you're more trash than my garbage can",
		"@" .. playerKilled .. ", plz no repotr i no want ban plesae!",
		"@" .. playerKilled .. ", report me im really scared",
		"@" .. playerKilled .. ", seriously? go back to fortnite monkey brain",
		"Ladies and Gentleman: The runner-up to the participation award, @" .. playerKilled .. "!",
		"@" .. playerKilled .. ", some kids were dropped at birth, but you got thrown at the wall",
		"@" .. playerKilled .. ", you really like taking L's",
		"@" .. playerKilled .. ", you're the type of guy to quickdrop irl",
		"@" .. playerKilled .. ", you're the type to get 3rd place in a 1v1",
		"@" .. playerKilled .. ", you have an IQ lower than that of a bathtub",
		"@" .. playerKilled .. ", your parents abandoned you, then the orphanage did the same",
		"@" .. playerKilled .. ", you go to the doctors and they say you shrunk",
		"@" .. playerKilled .. ", onix client, drop kicking lil' kids and fat obese staff since 2021",
		"@" .. playerKilled .. ", who would win; an anticheat with a $100,000 per year budget or one packet?",
		"@" .. playerKilled .. ", is the hives anticheat, a bee watching players or a bee watching a watch",
		"@" .. playerKilled .. ", yo mama so fat, she sat on an iphone and it became an ipad",
		"@" .. playerKilled .. ", this anticheat is disabled as you, vegetable",
		"@" .. playerKilled .. ", your aim is like a toddler with parkinson's trying to aim a water gun",
		"@" .. playerKilled .. ", i'd insult you after that death but by merely existing you do all the work for me",
		"@" .. playerKilled .. ", yo whens the documentary crew coming to your house to film the next episode of my 600 pound life?",
		"@" .. playerKilled .. ", you are the type of person to think FOV increases reach",
		"@" .. playerKilled .. ", your cumulative intelligence is that of a rock",
		"@" .. playerKilled .. ", you're the type of guy to buy vape v4 and cry when you get auto-banned",
		"@" .. playerKilled .. ", you shouldn't be running away with all these monkeys coming after you",
		"@" .. playerKilled .. ", yes, record me, send the footage straight to child lover tenebrous",
		"@" .. playerKilled .. ", your killaura was coded in scratch with help from zhn",
		"@" .. playerKilled .. ", you deserved to be bhopped on",
		"@" .. playerKilled .. ", your birth certificate was an apology letter from the condom factory",
		"@" .. playerKilled .. ", always remember you're unique - just like everyone else",
		"@" .. playerKilled .. ", how do you keep an idiot amused? watch this message until it fades away",
		"@" .. playerKilled .. ", if practice makes perfect, and nobody's perfect, why practice?",
		"@" .. playerKilled .. ", if i could rearrange the alphabet, i'd put U and I as far away as possible",
		"@" .. playerKilled .. ", i'd smack you, but that would be animal abuse",
		"@" .. playerKilled .. ", if i wanted to stop living, i'd climb to your ego and jump to your IQ",
		"@" .. playerKilled .. ", man's so ugly he made his happy meal cry",
		"@" .. playerKilled .. ", your face makes onions cry",
		"@" .. playerKilled .. ", you are like a cloud, when you disappear it's a beautiful day",
		"@" .. playerKilled .. ", you bring everyone so much joy! you know, when you leave the room. but, still",
		"@" .. playerKilled .. ", you are missing a brain",
		"@" .. playerKilled .. ", are you a primate?",
		"@" .. playerKilled .. ", you're so ugly your portraits hang themselves",
		"@" .. playerKilled .. ", your brain is so smooth even a 3090Ti can't simulate the reflectiveness",
		"@" .. playerKilled .. ", shouldn't you have a license for being that ugly?",
		"@" .. playerKilled .. ", the village called, they want their idiot back",
		"@" .. playerKilled .. ", beauty is skin deep, but ugliness is to the bone",
		"@" .. playerKilled .. ", sorry i can't think of an insult stupid enough for you",
		"@" .. playerKilled .. ", if i could be one person for a day, it sure as hell wouldn't be you",
		"@" .. playerKilled .. ", earth is full. go home",
		"@" .. playerKilled .. ", roses are red violets are blue, god made me pretty, what the hell happened to you?",
		"@" .. playerKilled .. ", i called your boyfriend gay and he hit me with his purse!",
		"@" .. playerKilled .. ", just because your head is shaped like a light bulb doesn't mean you have good ideas",
		"@" .. playerKilled .. ", you're the type of person to join a vending machine reward club",
		"@" .. playerKilled .. ", i've seen gay parades straighter than u"
	}
	return messages[math.random(1, #messages)]
end
function getPacketMessage(playerKilled)
	local messages = {
		"@" .. playerKilled .. ", download Packet today to kick azs while aiding to some abstractional!",
		"@" .. playerKilled .. ", I found you in task manager and I ended your process",
		"@" .. playerKilled .. ", what's yellow and can't swim? A bus full of children",
		"@" .. playerKilled .. ", you are more disappointing than an unsalted pretzel",
		"@" .. playerKilled .. ", take a shower, you smell like your grandpa's toes",
		"@" .. playerKilled .. ", you are not Parghet Clent approved :rage:",
		"@" .. playerKilled .. ", I'm not flying, I'm just defying gravity!",
		"@" .. playerKilled .. ", stop running, you weren't going to win",
		"@" .. playerKilled .. ", knock knock, who's there? Your life",
		"@" .. playerKilled .. ", your client has stopped working",
		"@" .. playerKilled .. ", warning, I have detected haram",
		"@" .. playerKilled .. ", I don't hack, I just use onix!",
		"@" .. playerKilled .. ", you should end svchost.exe!",
		"@" .. playerKilled .. ", just aided my pantiez",
		"@" .. playerKilled .. ", you were an accident",
		"@" .. playerKilled .. ", abstractional aidz",
		"@" .. playerKilled .. ", get dogwatered on",
		"@" .. playerKilled .. ", get 360 No-Scoped",
		"@" .. playerKilled .. ", you afraid of me?",
		"@" .. playerKilled .. ", go do the dishes",
		"@" .. playerKilled .. ", get a job immediately",
		"@" .. playerKilled .. ", delete System32",
		"@" .. playerKilled .. ", I Alt-F4'ed you",
		"@" .. playerKilled .. ", touch grass",
		"@" .. playerKilled .. ", jajajaja",
		"@" .. playerKilled .. ", kkkkkk",
		"@" .. playerKilled .. ", clean",
		"@" .. playerKilled .. ", F",
		"@" .. playerKilled .. ", how does this bypass ?!?!?",
		"@" .. playerKilled .. ", switch to PacketV2 today!",
		"@" .. playerKilled .. ", violently bhopping I see!",
		"@" .. playerKilled .. ", why Zephyr when Packet?",
		"@" .. playerKilled .. ", you probably use Zephyr",
		"@" .. playerKilled .. ", must be using Kek.Club+",
		"@" .. playerKilled .. ", man you're violent",
		"@" .. playerKilled .. ", horion moment"
	}
	return messages[math.random(1, #messages)]
end
function getNGMessage(playerKilled)
	local messages = {
		"@" .. playerKilled .. ", my gaming chair runs u",
		"@" .. playerKilled .. ", ur bad",
		"@" .. playerKilled .. ", L",
		"@" .. playerKilled .. ", ezz",
		"@" .. playerKilled .. ", ur so as",
		"@" .. playerKilled .. ", i run u",
		"@" .. playerKilled .. ", ur as",
		"@" .. playerKilled .. ", stay mad",
		"@" .. playerKilled .. ", you are big mad",
		"@" .. playerKilled .. ", keep crying",
		"@" .. playerKilled .. ", my gaming chair owns u",
		"@" .. playerKilled .. ", ur mad",
		"@" .. playerKilled .. ", trash",
		"@" .. playerKilled .. ", tossed",
		"@" .. playerKilled .. ", ur so bad",
		"@" .. playerKilled .. ", ez mop",
		"@" .. playerKilled .. ", violated.",
		"@" .. playerKilled .. ", you just got mopped",
		"@" .. playerKilled .. ", stay down",
		"@" .. playerKilled .. ", u are not valid",
		"@" .. playerKilled .. ", ur so mad",
		"@" .. playerKilled .. ", keep raging",
		"@" .. playerKilled .. ", i own u",
		"@" .. playerKilled .. ", Lost.",
		"@" .. playerKilled .. ", take dis L",
		"@" .. playerKilled .. ", how mad 1/10",
		"@" .. playerKilled .. ", mad cuz bad",
		"@" .. playerKilled .. ", im just too valid",
		"@" .. playerKilled .. ", 300+ confirmed bypasses",
		"@" .. playerKilled .. ", you just got ran",
		"@" .. playerKilled .. ", you ape",
		"@" .. playerKilled .. ", i think ur big mad",
		"@" .. playerKilled .. ", how mad are u 1/10",
		"@" .. playerKilled .. ", im best pvp",
		"@" .. playerKilled .. ", i run Hive",
		"@" .. playerKilled .. ", ur so as at this game",
		"@" .. playerKilled .. ", report me im really scared",
		"@" .. playerKilled .. ", u just got ran up on",
		"@" .. playerKilled .. ", get owned",
		"@" .. playerKilled .. ", lol ur so as",
		"@" .. playerKilled .. ", stop trying ur so bad",
		"@" .. playerKilled .. ", ah yes all team on me i dare you",
		"@" .. playerKilled .. ", gaming chair too op",
		"@" .. playerKilled .. ", imagine dying",
		"@" .. playerKilled .. ", if ur so mad then leave",
		"@" .. playerKilled .. ", RQ i run u",
		"@" .. playerKilled .. ", get out my lobby",
		"@" .. playerKilled .. ", hive anticheat is non-existant",
		"@" .. playerKilled .. ", how mad are u rn",
		"@" .. playerKilled .. ", keep sweating buddy ur not good",
		"@" .. playerKilled .. ", i ran you out my lobby",
		"@" .. playerKilled .. ", im insane at the craft",
		"@" .. playerKilled .. ", i shot u up",
		"@" .. playerKilled .. ", ur dead bro",
		"@" .. playerKilled .. ", RQ i own u",
		"@" .. playerKilled .. ", I run you all",
		"@" .. playerKilled .. ", try again when ur valid at the game",
		"@" .. playerKilled .. ", U should have RQed",
		"@" .. playerKilled .. ", my gaming chair is just too OP",
		"@" .. playerKilled .. ", you are mad i hack",
		"@" .. playerKilled .. ", hive bigmad",
		"@" .. playerKilled .. ", sweaty ape has been eliminated",
		"@" .. playerKilled .. ", if u report ur mad",
		"@" .. playerKilled .. ", just too sweaty for hive",
		"@" .. playerKilled .. ", u are now dead",
		"@" .. playerKilled .. ", ur mad hes mad shes mad",
		"@" .. playerKilled .. ", im no hak",
		"@" .. playerKilled .. ", ape down",
		"@" .. playerKilled .. ", keep raging buddy",
		"@" .. playerKilled .. ", the hive just doesnt have an anticheat",
		"@" .. playerKilled .. ", hive anticheat is not effective",
		"@" .. playerKilled .. ", ur dead",
		"@" .. playerKilled .. ", ezz mop",
		"@" .. playerKilled .. ", im not getting kicked",
		"@" .. playerKilled .. ", bhoppin and now ur games ended",
		"@" .. playerKilled .. ", its all over now rq",
		"@" .. playerKilled .. ", bop bop u are now mopped",
		"@" .. playerKilled .. ", stop spam placing ur not good",
		"@" .. playerKilled .. ", I dont hack i just have the OP gaming chair",
		"@" .. playerKilled .. ", stop hackusating",
		"@" .. playerKilled .. ", rlly am i just too good",
		"@" .. playerKilled .. ", sweating wont help",
		"@" .. playerKilled .. ", hive anticheat is good amirite",
		"@" .. playerKilled .. ", stay salty",
		"@" .. playerKilled .. ", u cant kill me",
		"@" .. playerKilled .. ", ur big noob",
		"@" .. playerKilled .. ", sweat harder next time",
		"@" .. playerKilled .. ", sorry but your time on the hive network has ended",
		"@" .. playerKilled .. ", run my s",
		"@" .. playerKilled .. ", stop auto clicking ur not good",
		"@" .. playerKilled .. ", LOL",
		"@" .. playerKilled .. ", imagine hacking",
		"@" .. playerKilled .. ", hackusated.",
		"@" .. playerKilled .. ", I'm not hacking its just my new gaming chair",
		"@" .. playerKilled .. ", im too good bro",
		"@" .. playerKilled .. ", get off this game ur as",
		"@" .. playerKilled .. ", I have 600+ confirmed bypasses",
		"@" .. playerKilled .. ", mopped u",
		"@" .. playerKilled .. ", u were shot up bop bop",
		"@" .. playerKilled .. ", stop with the spam placing",
		"@" .. playerKilled .. ", hes hacking!1!!11",
		"@" .. playerKilled .. ", imagine exploiting",
		"@" .. playerKilled .. ", im not hacking you're just bad!",
		"@" .. playerKilled .. ", imagine cheating",
		"@" .. playerKilled .. ", hop off ur as",
		"@" .. playerKilled .. ", too valid keep crying",
		"@" .. playerKilled .. ", You tried, you died.",
		"@" .. playerKilled .. ", Better luck next time",
		"@" .. playerKilled .. ", No one beats me",
		"@" .. playerKilled .. ", How are you so bad? just practice your aim and hold w",
		"@" .. playerKilled .. ", Report me to microsoft",
		"@" .. playerKilled .. ", ur fuming",
		"@" .. playerKilled .. ", cry",
		"@" .. playerKilled .. ", jajaja :v",
		"@" .. playerKilled .. ", report me to the hive network",
		"@" .. playerKilled .. ", false report bozo",
		"@" .. playerKilled .. ", my gaming chair is just too good",
		"@" .. playerKilled .. ", report me bozo im shaking in my boots",
		"@" .. playerKilled .. ", ezz bypass",
		"@" .. playerKilled .. ", u can try but u will die",
		"@" .. playerKilled .. ", U quickdropped",
		"@" .. playerKilled .. ", I dropped u",
		"@" .. playerKilled .. ", 1v1 me bro",
		"@" .. playerKilled .. ", negative IQ",
		"@" .. playerKilled .. ", whats the point of cheating",
		"@" .. playerKilled .. ", sorry but u lost bozo",
		"@" .. playerKilled .. ", my gaming chair is immune to Hive's Anticheat",
		"@" .. playerKilled .. ", stop placing ur as",
		"@" .. playerKilled .. ", u cant kill me i run u",
		"@" .. playerKilled .. ", sweat mad",
		"@" .. playerKilled .. ", just another kill to my kill count",
		"@" .. playerKilled .. ", just void bro",
		"@" .. playerKilled .. ", bypass lvl insane",
		"@" .. playerKilled .. ", hive runs u",
		"@" .. playerKilled .. ", Surrender rn",
		"@" .. playerKilled .. ", Hackusated.",
		"@" .. playerKilled .. ", its all over now",
		"@" .. playerKilled .. ", LOL get gud",
		"@" .. playerKilled .. ", handed u the L",
		"@" .. playerKilled .. ", im just the best pvp",
		"@" .. playerKilled .. ", hop off me bro ur as",
		"@" .. playerKilled .. ", get better",
		"@" .. playerKilled .. ", ur gonna report me?",
		"@" .. playerKilled .. ", shiver me timbers no report plesae",
		"@" .. playerKilled .. ", too ez",
		"@" .. playerKilled .. ", ur a clown",
		"@" .. playerKilled .. ", light work",
		"@" .. playerKilled .. ", didnt even have to sweat",
		"@" .. playerKilled .. ", runnin thru these sweats",
		"@" .. playerKilled .. ", dont even say nothin to me ur bad",
		"@" .. playerKilled .. ", someones raging",
		"@" .. playerKilled .. ", i win every time",
		"@" .. playerKilled .. ", u have been killed",
		"@" .. playerKilled .. ", ur game is now ended",
		"@" .. playerKilled .. ", rq why are u still here",
		"@" .. playerKilled .. ", just shot an opp up",
		"@" .. playerKilled .. ", 0 DTR"
	}
	return messages[math.random(1, #messages)]
end
function getDaddyPalmzyRawr(playerKilled)
	local messages = {
		"@" .. playerKilled .. ", sub2palm",
		"@" .. playerKilled .. ", george says the word of u (bad)",
		"@" .. playerKilled .. ", palmzy is bae",
		"@" .. playerKilled .. ", palmzy runs you",
		"@" .. playerKilled .. ", #sychoforcc",
		"@" .. playerKilled .. ", palmzy is the best",
		"@" .. playerKilled .. ", palm w",
		"@" .. playerKilled .. ", palmzy owns you",
		"@" .. playerKilled .. ", daddy palmzy plwease",
		"@" .. playerKilled .. ", meow for palm",
		"@" .. playerKilled .. ", smoolh makes me... happy",
		"@" .. playerKilled .. ", untimeout sycho from gxorg disc server",
		"@" .. playerKilled .. ", rosie owns u",
		"@" .. playerKilled .. ", i love pyth",
		"@" .. playerKilled .. ", big man gogy",
		"@" .. playerKilled .. ", palmzy owns splodger",
		"@" .. playerKilled .. ", smoolh tells you to uninstall",
		"@" .. playerKilled .. ", irish potatoe calls me a cheater, palmzy fights. palm ww",
		"@" .. playerKilled .. ", i ruined you like palmzy ruined my insides",
		"@" .. playerKilled .. ", send palmzy feet pics",
		"@" .. playerKilled .. ", sychoshorts is sychotalls",
		"@" .. playerKilled .. ", papi palmzy",
		"@" .. playerKilled .. ", palmzy makes my tree grow",
		"@" .. playerKilled .. ", women arent real",
		"@" .. playerKilled .. ", palm says hives anticheat is real. palm is a liar"
	}
	return messages[math.random(1, #messages)]
end
function getRegularMessage(playerKilled)
	local messages = {
		"gg, @" .. playerKilled .. "",
		"gf @" .. playerKilled .. "",
		"good fight @" .. playerKilled .. "",
		"bye, @" .. playerKilled .. "",
		"u remind me of a banana, @" .. playerKilled .. ""
	}
	return messages[math.random(1, #messages)]
end

function onChat(message, username, type)

    if string.find(message," joined. §8") then
        client.execute("execute /connection")
    end
    if string.find(message,"You are connected to server ") then
        lastGamemode = message
        lastGamemode = string.sub(message, 29)
        lastGamemode = string.match(lastGamemode,"[%a-]*")
    end

 --hide the /connection message
    if string.find(message, "You are connected to proxy ") then
        return true
    end
    if string.find(message, "You are connected to server ") then
        return true
    end

	local rareMessage = math.random(1, 100)
	_, _, attacker, target = string.find(message, "§r§[0-9a-fk-or]([%a%d ]+) killed §[0-9a-fk-or]([%a%d ]+) +")
    if attacker == nil and lastGamemode ~= string.find(lastGamemode, "WARS") then
        _, _, attacker, target = string.find(message, "§r§[0-9a-fk-or]([%a%d ]+) §.killed §[0-9a-fk-or]([%a%d ]+) -")
        if attacker == nil then
			_, _, attacker, target = string.find(message, "§c§l» §r§e§lFINAL KILL! §r§[0-9a-fk-or]([%a%d ]+) §ckilled §[0-9a-fk-or]([%a%d ]+)§c!")
			if attacker == nil then
    			return
			end
        end
    end
	if attacker == "You" or attacker == player.name() then
		if toxicMessages == true or randomMessages == true or packetMessages == true or ngMessages == true and rareMessage == 86 then
			client.execute("say this is a very rare message of good game (1 in 250 million chance this shows), @" .. target .. " <3") -- this has a 1/250,000,000 chance of being sent! make sure to screenshot if you see it <3
			return
		end

		if allMessages == true then
			local randomNumber = math.random(1,6)
			if randomNumber == 1 then
				client.execute("say " .. getToxicMessage(target))
			elseif randomNumber == 2 then
				client.execute("say " .. getKindMessage(target))
			elseif randomNumber == 3 then
				client.execute("say " .. getRandomMessage(target))
			elseif randomNumber == 4 then
				client.execute("say " .. getPacketMessage(target))
			elseif randomNumber == 5 then
				client.execute("say " .. getNGMessage(target))
			elseif randomNumber == 6 then
				client.execute("say " .. getDaddyPalmzyRawr(target))
			elseif randomNumber == 7 then
				client.execute("say " .. getRegularMessage(target))
			end
		elseif toxicMessages == true then
			client.execute("say " .. getToxicMessage(target))
		elseif kindMessages == true then
			client.execute("say " .. getKindMessage(target))
		elseif randomMessages == true then
			client.execute("say " .. getRandomMessage(target))
		elseif packetMessages == true then
			client.execute("say " .. getPacketMessage(target))
		elseif ngMessages == true then
			client.execute("say " .. getNGMessage(target))
		else
			client.execute("say " .. getRegularMessage(target))
		end
	end
end
event.listen("ChatMessageAdded", onChat)