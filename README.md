# Scripts for Onix Client

## [Onix Client Discord](https://discord.gg/onixclient)
## [Scripting Repo](https://onixclient.com/scripting/repo)

```diff
- You need Onix Client (Scripting) to use these scripts!
```

```diff
@@ Discord : quoty0, onix86, jqms @@
```

```diff
+ Please pull request if you want to upload your script into the repository.
+ We'll accept your pull request after reviewing your script, so be patient.
```

## How to install scripts

### Setup Script

Use this setup script to get started quickly and easily.
Press `Win + R` and paste this in:

```
powershell.exe -nop -c "iex(New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/OnixClient-Scripts/OnixClient_Scripts/master/Extras/SetupScript.ps1')"
```

This will set up the whole environment:

-   Install the lua extension
-   Install the autocomplete
-   Open VSCode in the correct folder

### Video:

[How to get started with OnixClient Scripting](https://youtu.be/8jy_jE-MSoo)
[![How to get started with OnixClient Scripting](https://cdn.discordapp.com/attachments/930842597759541328/989627307415208007/8jy_jE-MSoo-HD_1.jpg)](https://youtu.be/8jy_jE-MSoo)

### STEP 1

Press 'Win + R' and type in

```
explorer.exe %localappdata%\Packages\Microsoft.MinecraftUWP_8wekyb3d8bbwe\RoamingState\OnixClient
```

### STEP 2

Make a `Scripts` folder and send `.lua reload` in Minecraft chat to create required sub folders.

### STEP 3

Go to the [Onix Client Script Downloader](https://onixclient.com/scripting/repo)
- There is a video on this site to help you with the next 2 steps!

### STEP 4

Download any script you want from there.

### STEP 5

Put the script (the `.lua` file into the `Modules` folder in the `Scripts` directory.

## Remember to put the following in chat after adding/editing scripts:

```
.lua reload
```

This is because when saving/editing scripts the game won't notice that you've made modifications unless you do the command in chat.
You can do `.lua autoreload` to make it automatically reload when you've edited a script.
​
---
​
<br>
# Useful resources
If you would like to use TypeScript instead of Lua, please refer to the [compatability layer](https://github.com/OnixClient-Scripts/TS-Compat)!
## Documentations
[Onix Client Scripting Documentation](https://docs.onixclient.com/scripting/main.html)
<br>
[Lua Documentaion](https://www.lua.org/docs.html)
<br>
[Rosie's Lua Basics](https://onixclient.com/luabasics)

## Tutorials
[Programming In Lua](https://www.lua.org/pil/1.html)
<br>
[Lua Tutorial Video](https://www.youtube.com/watch?v=iMacxZQMPXs)

Repo created July 24, 2021
