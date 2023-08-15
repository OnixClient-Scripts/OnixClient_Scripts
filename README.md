# Onix Client Scripting GitHub Repository

Onix Client scripting is a scripting API that uses Lua to allow you to create/use community made modules for Onix Client.

## Prerequisites
- Onix Client Scripting

## Setup
To set up Onix Client scripting for script usage (go [here](https://github.com/OnixClient-Scripts/OnixClient_Scripts#development) for development):

1. Press `Windows Key + R` and paste the following in:
```
explorer.exe %localappdata%\Packages\Microsoft.MinecraftUWP_8wekyb3d8bbwe\RoamingState\OnixClient
```
3. Press `OK` or the enter key.
4. Make a `Scripts` folder inside of the folder that opens.
5. Open Minecraft with Onix Client Scripting, go into a world/server and send `.lua reload` in the game chat. This will create required sub folders within the `Scripts` folder.

## Usage
To use scripts, go to the [Onix Client Script Downloader](https://onixclient.com/scripting/repo).
- There is a video on this site to help you with the rest of the script usage!
- You can also go to the video [here](https://youtu.be/R21GLHJphtg).
---

# Development

**Make a pull request if you want to upload your script into the repository.**
**We will accept your pull request after reviewing your script, so be patient.**<br>
If you would like to use TypeScript instead of Lua, please refer to the [experimental compatability layer](https://github.com/OnixClient-Scripts/TS-Compat)!

## Setup
Use this setup script to get started quickly and easily.
Press `Windows Key + R` and paste the following in:
```
powershell.exe -nop -c "iex(New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/OnixClient-Scripts/OnixClient_Scripts/master/Extras/SetupScript.ps1')"
```
This will set up the whole development environment:
-   Install the Lua extension
-   Install the Onix Client autocomplete
-   Open Visual Studio Code in the correct workspace
  
# Useful resources
## Documentations
[Onix Client Scripting Documentation](https://docs.onixclient.com/scripting/main.html)
<br>
[Lua Documentaion](https://www.lua.org/docs.html)
<br>
[Rosie's Lua Basics](https://onixclient.com/luabasics)

## Tutorials
[How to get started with OnixClient Scripting](https://youtu.be/8jy_jE-MSoo)
<br>
[Programming In Lua](https://www.lua.org/pil/1.html)
<br>
[Lua Tutorial Video](https://www.youtube.com/watch?v=iMacxZQMPXs)

Repo created `July 24, 2021`.
