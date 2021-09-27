# Scripts for Onix Client

[<h2>Onix Client Discord</h2>](https://discord.gg/onixclient)

```diff
- You need Onix Client (Scripting Beta) to use these scripts
```

```diff
@@ Discord : Quoty0#3884, Onix86#0001, ItzHugo#2308, MCBE Craft#6545 @@
```

​

---

​

<h2>How to install scripts</h2>

<h3>STEP 1</h3>
Press 'Win + R' and type in

```diff
explorer.exe %localappdata%\Packages\Microsoft.MinecraftUWP_8wekyb3d8bbwe\RoamingState\OnixClient
```

<h3>STEP 2</h3>

Make 'Scripts' folder and send in chat ``.lua reload`` to create sub folders


<h3>STEP 3</h3>

Click onto the module or cmd you want from this repo.


<h3>STEP 4</h3>

then click the ``raw`` button then do ctrl + s then save in the modules/scripts folder, make sure the file extention is .lua and **not** .txt as it is .txt by default so you're gonna need to change it for the scripts to work.


<h2>Remember to put the following in chat after adding/editing scripts :</h2> 

```diff
.lua reload
```
This is because when saving/editing scripts the game won't notice that you've made modifications unless you do the cmd in chat.

​

---

​

<h1>What each module/command does</h1>

<h2>Modules</h2>

[<h2>Ping Counter</h2>](https://raw.githubusercontent.com/Quoty0/OnixClient_Scripts/master/Modules/PingCounter.lua)
Ping counter using [external program](https://github.com/Quoty0/OnixClient_Scripts/blob/master/Modules/LuaPingHelper.exe?raw=true)

[This external program](https://github.com/Quoty0/OnixClient_Scripts/blob/master/Modules/LuaPingHelper.exe?raw=true) should be opened

[<h2>Arrow Counter</h2>](https://raw.githubusercontent.com/Quoty0/OnixClient_Scripts/master/Modules/arrowcounter.lua)
Shows the amount of arrow

[<h2>Chunk Positions</h2>](https://raw.githubusercontent.com/Quoty0/OnixClient_Scripts/master/Modules/chunkinfo.lua)
Gives you the current chunk's chunk pos and your position inside of it

[<h2>Coordinate Copy</h2>](https://raw.githubusercontent.com/Quoty0/OnixClient_Scripts/master/Modules/coordinatecopy.lua)
Copy coordinates by pressing key ('O' and 'J' for default)

[<h2>Death Coordinates</h2>](https://raw.githubusercontent.com/Quoty0/OnixClient_Scripts/master/Modules/deathcoordinates.lua)
Shows player death coordinates

waypoint_style configs
   
   0: disable waypoint
   
   1 (default): make a waypoint 'Death' (overwrites the old waypoint) 
   
   2: make a waypoint 'Death [Current Time]
   
   3: make a waypoint '[Current Time]'
   
   example of [Current Time]: [08/21/21 12:30:45]

[<h2>Input Example</h2>](https://raw.githubusercontent.com/Quoty0/OnixClient_Scripts/master/Modules/inputexample.lua)
Example script about using input library

[<h2>Minimap</h2>](https://raw.githubusercontent.com/Quoty0/OnixClient_Scripts/master/Modules/minimap.lua)
Shows a map of blocks around you
It will decrease your fps a lot

[<h2>Mining Mod</h2>](https://raw.githubusercontent.com/Quoty0/OnixClient_Scripts/master/Modules/miningmod.lua)
Shows useful informations and statistics for mining

[<h2>Module Toggle</h2>](https://raw.githubusercontent.com/Quoty0/OnixClient_Scripts/master/Modules/moduletoggle.lua)
Toggles specific modules and shows toggled message using a hotkey

[<h2>Offhand Slot Display</h2>](https://raw.githubusercontent.com/Quoty0/OnixClient_Scripts/master/Modules/offhanddisplay.lua)
Shows the offhand item

[<h2>Player Info</h2>](https://raw.githubusercontent.com/Quoty0/OnixClient_Scripts/master/Modules/playerinfo.lua)
Shows information of the player

[<h2>Pot Counter</h2>](https://raw.githubusercontent.com/Quoty0/OnixClient_Scripts/master/Modules/potcounter.lua)
Shows the amount of pot

[<h2>Projectile Counter</h2>](https://raw.githubusercontent.com/Quoty0/OnixClient_Scripts/master/Modules/projectilecounter.lua)
Shows the amout of projectile

[<h2>Saturation Display</h2>](https://raw.githubusercontent.com/Quoty0/OnixClient_Scripts/master/Modules/saturationdisplay.lua)
Shows the saturation

[<h2>Scope</h2>](https://raw.githubusercontent.com/Quoty0/OnixClient_Scripts/master/Modules/scope.lua)
Adds a scope to bows and crossbows

You need [scope.png](https://raw.githubusercontent.com/Quoty0/OnixClient_Scripts/master/Data/scope.png) for this module script

Video of the module in action here

https://user-images.githubusercontent.com/48370588/132985141-89ad6332-d7cb-408e-9249-473a06879c72.mp4

[<h2>Screen Darker</h2>](https://raw.githubusercontent.com/Quoty0/OnixClient_Scripts/master/Modules/screendarker.lua)
Make screen darker (make a black dimm on your screen)

[<h2>Stopwatch</h2>](https://raw.githubusercontent.com/Quoty0/OnixClient_Scripts/master/Modules/stopwatch.lua)
Count time

[<h2>TestLuaMod</h2>](https://raw.githubusercontent.com/Quoty0/OnixClient_Scripts/master/Modules/testluamod.lua)
Example script about making module script

[<h2>Blockmap</h2>](https://raw.githubusercontent.com/Quoty0/OnixClient_Scripts/master/Modules/wip%20blockmap.lua)
Shows a map of blocks around you (some textures hasn't been setup yet)

You need [translator library](https://raw.githubusercontent.com/Quoty0/OnixClient_Scripts/master/Libs/translator.lua) for this module script

WARNING
- causes massive fps drop because of all the textures it is drawing


- needs library translator.lua or almost all block textures will be missing

[<h2>Toggle Sprint Indicator</h2>](https://raw.githubusercontent.com/Quoty0/OnixClient_Scripts/master/Modules/sprint.lua)
Customizable toggle sprint indicator



make sure to have the tsData.txt file in the data folder and the sprintCommand.lua in the command folder and readfile.lua library in the library folder

in  tsData.txt file, first line is the text that will be displayed as text in [text: (Toggled)]

second, third, fourth and fifth are the rgba value codes

to use the command, do ".ts color r g b a" by replacing r, g, b and a by the value from 0 to 255 or ".ts text New Text" to change the indicator text

[<h2>World Edit</h2>](https://raw.githubusercontent.com/Quoty0/OnixClient_Scripts/master/Modules/world_edit_mod.lua)
Make your construction easier

You need [World Edit Command](https://raw.githubusercontent.com/Quoty0/OnixClient_Scripts/master/Commands/world_edit.lua) and [weData](https://raw.githubusercontent.com/Quoty0/OnixClient_Scripts/master/Data/weData.txt) to use this module.

[![World Edit on Minecraft Bedrock edition with Onix Client](https://img.youtube.com/vi/kVMlO3lRBuA/0.jpg)](https://www.youtube.com/watch?v=kVMlO3lRBuA "World Edit on Minecraft Bedrock edition with Onix Client")

[<h2>ew ng</h2>](https://raw.githubusercontent.com/Quoty0/OnixClient_Scripts/master/Modules/ew%20ng.lua)
Block onix client on nethergames L

​

---

​

<h2>Commands</h2>

[<h2>Color</h2>](https://raw.githubusercontent.com/Quoty0/OnixClient_Scripts/master/Commands/color.lua)
Changes module color

command - ``.color``

to use

make sure you have the readfile.lua in the lib folder

in the module files have

at the beginning:

ImportedLib = importLib("readfile.lua")

color = readFile("color.txt")

in the update function:

color = {}

color = readFile("color.txt")

for your rendering:

gfx.color(color[5], color[6], color[7], color[8])

gfx.rect(0, 0, sizeX, sizeY)

gfx.color(color[1], color[2], color[3], color[4])

gfx.text(0, 0, text)

[<h2>Dot</h2>](https://raw.githubusercontent.com/Quoty0/OnixClient_Scripts/master/Commands/dot.lua)
Send chat starts with a dot

command - ``.``

[<h2>Gamemode</h2>](https://raw.githubusercontent.com/Quoty0/OnixClient_Scripts/master/Commands/gamemode.lua)
Show information about player's gamemode

command - ``.gamemode``

[<h2>Inv</h2>](https://raw.githubusercontent.com/Quoty0/OnixClient_Scripts/master/Commands/inv.lua)
Sends current inventory

command - ``.inv``

[<h2>Music</h2>](https://raw.githubusercontent.com/Quoty0/OnixClient_Scripts/master/Commands/music.lua)
Plays music in-game from resource pack

command - ``.music``

you can put in ``11, 13, blocks, chirp, far, mall, mellohi, pigstep, stal, strad, wait, ward``

[<h2>Notification Example</h2>](https://raw.githubusercontent.com/Quoty0/OnixClient_Scripts/master/Commands/notification_example.lua)
Example script about using notification

command - ``.test_notif``

<img src="https://raw.githubusercontent.com/Quoty0/OnixClient_Scripts/master/Commands/notification_example.png">

[<h2>Pathfinder</h2>](https://raw.githubusercontent.com/Quoty0/OnixClient_Scripts/master/Commands/pathfinder.lua)
Copies the directories of the specified location

command - ``.path``

[<h2>TestLuaCmd</h2>](https://raw.githubusercontent.com/Quoty0/OnixClient_Scripts/master/Commands/testluacmd.lua)
Example script about making command script

command - ``.test``

[<h2>World Info</h2>](https://raw.githubusercontent.com/Quoty0/OnixClient_Scripts/master/Commands/worldinfo.lua)
Show information about the world

command - ``.worldinfo``

[<h2>Toggle Sprint Indicator Editor</h2>](https://raw.githubusercontent.com/Quoty0/OnixClient_Scripts/master/Commands/sprintCommand.lua)
changes toggle sprint indicator data (text or color)

command - ``.ts``

needs tsData.txt, sprint.lua module and readfile.lua library to work

more infos in sprint.lua module

[<h2>World Edit</h2>](https://raw.githubusercontent.com/Quoty0/OnixClient_Scripts/master/Commands/world_edit.lua)
Make your construction easier

command - ``.we``

setpos1: sets the first position

setpos2: sets the second position

os: tells you which coordinates are selected

wand: gives you the wand tool (wooden sword cuz it doesn't break blocks in creative)

cut: removes the selected area

clone: clones the selected area to your current position

fill: fills the selected area

​

---

​

<h2>Libs</h2>

[<h2>Read File</h2>](https://raw.githubusercontent.com/Quoty0/OnixClient_Scripts/master/Libs/readfile.lua)
Library used to read color file

Check .color command

[<h2>Translator</h2>](https://raw.githubusercontent.com/Quoty0/OnixClient_Scripts/master/Libs/translator.lua)
Library to translate minecraft block name to textures

​

---

​

<h2>Data</h2>

[<h2>Scope</h2>](https://raw.githubusercontent.com/Quoty0/OnixClient_Scripts/master/Data/scope.png)
Example image for scope module

[<h2>tsData</h2>](https://raw.githubusercontent.com/Quoty0/OnixClient_Scripts/master/Data/tsData.txt)
Data file for Toggle Sprint Indicator module

[<h2>weData</h2>](https://raw.githubusercontent.com/Quoty0/OnixClient_Scripts/master/Data/weData.txt)
Data file for World Edit module
