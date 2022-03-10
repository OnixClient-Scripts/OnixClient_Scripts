# Scripts for Onix Client

## [Onix Client Discord](https://discord.gg/onixclient)

```diff
- You need Onix Client (Scripting Beta) to use these scripts!
```

```diff
@@ Discord : Quoty0#3884, Onix86#0001, ItzHugo#2308, MCBE Craft#6545, notshige#5253 @@
```

```diff
+ Please do pull request if you want to upload your script into the repository.
+ We'll accept your pull request after reviewing your script, so be patient.
```

​

---

​

## How to install scripts

### STEP 1
Press 'Win + R' and type in

```
explorer.exe %localappdata%\Packages\Microsoft.MinecraftUWP_8wekyb3d8bbwe\RoamingState\OnixClient
```

### STEP 2

Make 'Scripts' folder and send in chat ``.lua reload`` to create sub folders.


### STEP 3

Click onto the module or cmd you want from this repo.


### STEP 4

then click the ``raw`` button then do ctrl + s then save in the modules/scripts folder, make sure the file extention is .lua and **not** .txt as it is .txt by default so you're gonna need to change it for the scripts to work.


## Remember to put the following in chat after adding/editing scripts : 

```
.lua reload
```
This is because when saving/editing scripts the game won't notice that you've made modifications unless you do the cmd in chat.

​

---

​

# Scripting documentation
You can see the documentation on [Github](https://github.com/OnixClient-Scripts/OnixClient_Scripts/blob/master/Scripting_Documentation.md) or [official website](http://onixclient.xyz/scripting/main.html)

​

---

​

# What each module/command does

## Modules

## [Ping Counter](https://raw.githubusercontent.com/Quoty0/OnixClient_Scripts/master/Modules/PingCounter.lua)
Ping counter using [external program](https://github.com/Quoty0/OnixClient_Scripts/blob/master/Modules/LuaPingHelper.exe?raw=true).

[This external program](https://github.com/Quoty0/OnixClient_Scripts/blob/master/Modules/LuaPingHelper.exe?raw=true) should be kept open while using the script for it to work.

## [Hive Game Hotkeys](https://raw.githubusercontent.com/Quoty0/OnixClient_Scripts/master/Modules/gamemodehotkeys.lua)
Hive gamemode hotkeys module by [chillihero](https://www.youtube.com/channel/UCvHKDOw_RTDrvxjn-2YUwig), you can also change the hotkeys by replacing the "x" at "key == x" with a key values, find key values [here.](https://docs.microsoft.com/en-us/windows/win32/inputdev/virtual-key-codes)

## [Arrow Counter](https://raw.githubusercontent.com/Quoty0/OnixClient_Scripts/master/Modules/arrowcounter.lua)
Shows the amount of arrow(s) you have.

## [Chunk Positions](https://raw.githubusercontent.com/Quoty0/OnixClient_Scripts/master/Modules/chunkinfo.lua)
Gives you the current chunk's chunk pos and your position inside of it.

## [Coordinate Copy](https://raw.githubusercontent.com/Quoty0/OnixClient_Scripts/master/Modules/coordinatecopy.lua)
Copy coordinates by pressing key ('O' and 'J' for default).

## [Death Coordinates](https://raw.githubusercontent.com/Quoty0/OnixClient_Scripts/master/Modules/deathcoordinates.lua)
Shows player death coordinates.

```
waypoint_style configs
   0: disable waypoint
   1 (default): make a waypoint 'Death' (overwrites the old waypoint)
   2: make a waypoint 'Death [Current Time]
   3: make a waypoint '[Current Time]'
   
example of [Current Time]: [08/21/21 12:30:45]
```

## [Input Example](https://raw.githubusercontent.com/Quoty0/OnixClient_Scripts/master/Modules/inputexample.lua)
Example script about using input library.

## [Minimap](https://raw.githubusercontent.com/Quoty0/OnixClient_Scripts/master/Modules/minimap.lua)
Shows a map of blocks around you,<br/>
It will decrease your fps a lot.

## [Mining Mod](https://raw.githubusercontent.com/Quoty0/OnixClient_Scripts/master/Modules/miningmod.lua)
Shows useful informations and statistics for mining.

## [Module Toggle](https://raw.githubusercontent.com/Quoty0/OnixClient_Scripts/master/Modules/moduletoggle.lua)
Toggles specific modules and shows toggled message using a hotkey.

## [Offhand Slot Display](https://raw.githubusercontent.com/Quoty0/OnixClient_Scripts/master/Modules/offhanddisplay.lua)
Shows the offhand item.

## [Player Info](https://raw.githubusercontent.com/Quoty0/OnixClient_Scripts/master/Modules/playerinfo.lua)
Shows information of the player.

## [Pot Counter](https://raw.githubusercontent.com/Quoty0/OnixClient_Scripts/master/Modules/potcounter.lua)
Shows the amount of pot.

## [Projectile Counter](https://raw.githubusercontent.com/Quoty0/OnixClient_Scripts/master/Modules/projectilecounter.lua)
Shows the amount of projectile.

## [Saturation Display](https://raw.githubusercontent.com/Quoty0/OnixClient_Scripts/master/Modules/saturationdisplay.lua)
Shows the saturation.

## [Scope](https://raw.githubusercontent.com/Quoty0/OnixClient_Scripts/master/Modules/scope.lua)
Adds a scope to bows and crossbows.<br/>
You need [scope.png](https://raw.githubusercontent.com/Quoty0/OnixClient_Scripts/master/Data/scope.png) for this module script.<br/>
[Video of the module in action here.](https://user-images.githubusercontent.com/48370588/132985141-89ad6332-d7cb-408e-9249-473a06879c72.mp4)<br/>

## [Screen Darker](https://raw.githubusercontent.com/Quoty0/OnixClient_Scripts/master/Modules/screendarker.lua)
Make screen darker (make a black dimm on your screen).

## [Stopwatch](https://raw.githubusercontent.com/Quoty0/OnixClient_Scripts/master/Modules/stopwatch.lua)
Count time, if you wish to change the key you can take the key code from [here](https://docs.microsoft.com/en-us/windows/win32/inputdev/virtual-key-codes).

## [TestLuaMod](https://raw.githubusercontent.com/Quoty0/OnixClient_Scripts/master/Modules/testluamod.lua)
Example script about making module script.

## [Blockmap](https://raw.githubusercontent.com/Quoty0/OnixClient_Scripts/master/Modules/wip%20blockmap.lua)
Shows a map of blocks around you (some textures hasn't been setup yet).<br/>
You need [translator library](https://raw.githubusercontent.com/Quoty0/OnixClient_Scripts/master/Libs/translator.lua) for this module script.

WARNING
- causes massive fps drop because of all the textures it is drawing.<br/>
- needs library translator.lua or almost all block textures will be missing.

## [Toggle Sprint Indicator](https://raw.githubusercontent.com/Quoty0/OnixClient_Scripts/master/Modules/sprint.lua)
Customizable toggle sprint indicator.



make sure to have the tsData.txt file in the data folder and the sprintCommand.lua in the command folder and readfile.lua library in the library folder.<br/>
in  tsData.txt file, first line is the text that will be displayed as text in [text: (Toggled)].<br/>
second, third, fourth and fifth are the rgba value codes.<br/>
To use the command, do ".ts color r g b a" by replacing r, g, b and a by the value from 0 to 255 or ".ts text New Text" to change the indicator text.

## [World Edit](https://raw.githubusercontent.com/Quoty0/OnixClient_Scripts/master/Modules/world_edit_mod.lua)
Make your construction easier.

```
- No Longer Works
```

You need [World Edit Command](https://raw.githubusercontent.com/Quoty0/OnixClient_Scripts/master/Commands/world_edit.lua) and [weData](https://raw.githubusercontent.com/Quoty0/OnixClient_Scripts/master/Data/weData.txt) to use this module.

[![World Edit on Minecraft Bedrock edition with Onix Client](https://img.youtube.com/vi/kVMlO3lRBuA/0.jpg)](https://www.youtube.com/watch?v=kVMlO3lRBuA "World Edit on Minecraft Bedrock edition with Onix Client")

## [ew ng](https://raw.githubusercontent.com/Quoty0/OnixClient_Scripts/master/Modules/ew%20ng.lua)
Block onix client on nethergames L

## [Gamemode hotkeys](https://raw.githubusercontent.com/OnixClient-Scripts/OnixClient_Scripts/master/Modules/gamemodehotkeys.lua)
Press hotkey to switch between Gamemode Creative and Survival

## [Fake Ping Display](https://raw.githubusercontent.com/OnixClient-Scripts/OnixClient_Scripts/master/Modules/fakepingdisplay.lua)
Show random number instead of ping

## [Item Counter](https://raw.githubusercontent.com/OnixClient-Scripts/OnixClient_Scripts/master/Modules/itemcounter.lua)
Shows the amount of iron ingot, gold ingot, diamond, and emerald

## [Arraylist](https://github.com/OnixClient-Scripts/OnixClient_Scripts/raw/master/Modules/arraylist.lua)
Shows what module is enabled

## [TabGui](https://github.com/OnixClient-Scripts/OnixClient_Scripts/raw/master/Modules/tabgui.lua)
A simple tabgui

## [Video Player](https://github.com/OnixClient-Scripts/OnixClient_Scripts/raw/master/Modules/video.lua)
[how to use](https://youtu.be/ibfWOKq_TWY)

## [MusicBee Overlay](https://github.com/OnixClient-Scripts/OnixClient_Scripts/raw/master/Modules/musicbeeoverlay.lua)
Displays current song, artist, album name, and album cover. </br>MusicBee only.

![image](https://user-images.githubusercontent.com/62657139/151176126-de908f2e-dbbb-4bbd-966b-0845387238fa.png)


## [Custom Auto GG](https://github.com/OnixClient-Scripts/OnixClient_Scripts/raw/master/Modules/Custom%20Auto%20GG.lua)
Send any message - works like auto GG</br>
edit in the lua file

## [HiveDebloater](https://github.com/OnixClient-Scripts/OnixClient_Scripts/raw/master/Modules/HiveDebloater.lua)
Adds small aesthetic tweaks to The Hive's chat (debloats).</br>
Extra: .block command. (Requires [Blocker.lua](https://github.com/OnixClient-Scripts/OnixClient_Scripts/raw/master/Modules/Blocker.lua) & [Blockernt.lua](https://github.com/OnixClient-Scripts/OnixClient_Scripts/raw/master/Modules/Blockernt.lua)) 

## [Chatlog](https://github.com/OnixClient-Scripts/OnixClient_Scripts/raw/master/Modules/Chatlog.lua)
Saves in Chatlogger.txt

## [Auto Nick](https://github.com/OnixClient-Scripts/OnixClient_Scripts/raw/master/Modules/AutoNick.lua)
Automatically sets your nickname!</br>
Extra: .autonick command (Requires [autonickcommand.lua](https://github.com/OnixClient-Scripts/OnixClient_Scripts/raw/master/Modules/autonickcommand.lua)) 

## [More Keystrokes](https://raw.githubusercontent.com/EpiclyRaspberry/OnixClient_Scripts/master/Modules/morekeystrokes.lua) and [More keystrokes(numpad version)](https://raw.githubusercontent.com/EpiclyRaspberry/OnixClient_Scripts/master/Modules/morekeystrokes(numpad).lua)
More keystrokes to display ingame other than the default keystrokes mod<br>
Uses [keyconverter library](https://raw.githubusercontent.com/EpiclyRaspberry/OnixClient_Scripts/master/Libs/keyconverter.lua)

## [Cinematic Black Bars](https://github.com/EpiclyRaspberry/OnixClient_Scripts/raw/master/Modules/blackbars.lua)
Adds those cinematic black bars, height are adjustable
![image](https://user-images.githubusercontent.com/84133368/156894399-9f0c8f47-fa4e-42d6-85bc-c8a8047ad98d.png)

## [RenderThreeD exemples](https://github.com/EpiclyRaspberry/OnixClient_Scripts/raw/master/Modules/renderthreeDexemples.lua)
Shows all the exemples of [RenderThreeD](https://github.com/EpiclyRaspberry/OnixClient_Scripts/raw/master/Libs/renderthreeD.lua) library

​

---

​

## Commands

## [Color](https://raw.githubusercontent.com/Quoty0/OnixClient_Scripts/master/Commands/color.lua)
Changes module color<br/>
command - ``.color``

**To use:**
make sure you have the readfile.lua in the lib folder.

**In the module files have:**
at the beginning:<br/>
ImportedLib = importLib("readfile.lua")<br/>
color = readFile("color.txt")<br/>
in the update function:<br/>
color = {}<br/>
color = readFile("color.txt")<br/>
for your rendering:<br/>
gfx.color(color[5], color[6], color[7], color[8])<br/>
gfx.rect(0, 0, sizeX, sizeY)<br/>
gfx.color(color[1], color[2], color[3], color[4])<br/>
gfx.text(0, 0, text)

## [Dot](https://raw.githubusercontent.com/Quoty0/OnixClient_Scripts/master/Commands/dot.lua)
Send chat starts with a dot.

command - ``.``

## [Gamemode](https://raw.githubusercontent.com/Quoty0/OnixClient_Scripts/master/Commands/gamemode.lua)
Show information about player's gamemode.

command - ``.gamemode``

## [Inv](https://raw.githubusercontent.com/Quoty0/OnixClient_Scripts/master/Commands/inv.lua)
Sends current inventory.

command - ``.inv``

## [Music](https://raw.githubusercontent.com/Quoty0/OnixClient_Scripts/master/Commands/music.lua)
Plays music in-game from resource pack.

command - ``.music``

you can put in ``11, 13, blocks, chirp, far, mall, mellohi, pigstep, stal, strad, wait, ward``

## [Notification Example](https://raw.githubusercontent.com/Quoty0/OnixClient_Scripts/master/Commands/notification_example.lua)
Example script about using notification.

command - ``.test_notif``

<img src="https://raw.githubusercontent.com/Quoty0/OnixClient_Scripts/master/Extras/notification_example.png">

## [Pathfinder](https://raw.githubusercontent.com/Quoty0/OnixClient_Scripts/master/Commands/pathfinder.lua)
Copies the directories of the specified location.

command - ``.path``

## [TestLuaCmd](https://raw.githubusercontent.com/Quoty0/OnixClient_Scripts/master/Commands/testluacmd.lua)
Example script about making command script.

command - ``.test``

## [World Info](https://raw.githubusercontent.com/Quoty0/OnixClient_Scripts/master/Commands/worldinfo.lua)
Show information about the world.

command - ``.worldinfo``

## [Toggle Sprint Indicator Editor](https://raw.githubusercontent.com/Quoty0/OnixClient_Scripts/master/Commands/sprintCommand.lua)
changes toggle sprint indicator data (text or color).

command - ``.ts``

needs tsData.txt, sprint.lua module and readfile.lua library to work!<br/>
more infos in sprint.lua module.

## [World Edit](https://raw.githubusercontent.com/Quoty0/OnixClient_Scripts/master/Commands/world_edit.lua)
Make your construction easier.

command - ``.we``

setpos1: sets the first position<br/>
setpos2: sets the second position<br/>
os: tells you which coordinates are selected<br/>
wand: gives you the wand tool (wooden sword cuz it doesn't break blocks in creative)<br/>
cut: removes the selected area<br/>
clone: clones the selected area to your current position<br/>
fill: fills the selected area<br/>

## [Blocker](https://raw.githubusercontent.com/Quoty0/OnixClient_Scripts/master/Commands/Blocker.lua)
Blocks a word.

command - ``.block {Word}``


## [Blockernt](https://raw.githubusercontent.com/Quoty0/OnixClient_Scripts/master/Commands/Blockernt.lua)
Unblocks a word.

command - ``.unblock {Word}``

## [autonickcommand](https://raw.githubusercontent.com/Quoty0/OnixClient_Scripts/master/Commands/autonickcommand.lua)
Sets the autonick.

command - ``.autonick {Nickname}``

​

---

​

## Libs

## [Read File](https://raw.githubusercontent.com/Quoty0/OnixClient_Scripts/master/Libs/readfile.lua)
Library used to read color file.<br/>
Check .color command.

## [Translator](https://raw.githubusercontent.com/Quoty0/OnixClient_Scripts/master/Libs/translator.lua)
Library to translate minecraft block name to textures.

## [Key to string](https://raw.githubusercontent.com/EpiclyRaspberry/OnixClient_Scripts/master/Libs/keyconverter.lua)
Library to convert key values into string values

## [RenderThreeD](https://github.com/EpiclyRaspberry/OnixClient_Scripts/raw/master/Libs/renderthreeD.lua)
Library that uses `gfx.quad(x1,y1,z1,x2,y2,z2,x3,y3,z3,x4,y4,z4,displayBothSide)` function to display cubes inside the world<br>
It's documentation is in the file itself
​

---

​

## Data

## [Scope](https://raw.githubusercontent.com/Quoty0/OnixClient_Scripts/master/Data/scope.png)
Example image for scope module.

## [tsData](https://raw.githubusercontent.com/Quoty0/OnixClient_Scripts/master/Data/tsData.txt)
Data file for Toggle Sprint Indicator module.

## [weData](https://raw.githubusercontent.com/Quoty0/OnixClient_Scripts/master/Data/weData.txt)
Data file for World Edit module.
