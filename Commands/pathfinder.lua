command = "path"
help_message = "Copies the directories of the specified location"

--Variables

local configPath = "%localappdata%/Packages/Microsoft.MinecraftUWP_8wekyb3d8bbwe/RoamingState/OnixClient/Configs"
local configMesg = "§l[§1Onix§fClient]§r Config directory copied to clipboard!"
local configNotif = "Config directory copied to clipboard!"

local scriptPath = "%localappdata%/Packages/Microsoft.MinecraftUWP_8wekyb3d8bbwe/RoamingState/OnixClient/Scripts"
local scriptMesg = "§l[§1Onix§fClient]§r Script directory copied to clipboard!"
local scriptNotif = "Script directory copied to clipboard!"

local screenshotPath = "%localappdata%/Packages/Microsoft.MinecraftUWP_8wekyb3d8bbwe/RoamingState/OnixClient/Screenshots"
local screenshotMesg = "§l[§1Onix§fClient]§r Screenshot directory copied to clipboard!"
local screenshotNotif = "Screenshot directory copied to clipboard!"

local packPath = "%localappdata%/Packages/Microsoft.MinecraftUWP_8wekyb3d8bbwe/LocalState/games/com.mojang/resource_packs"
local packMesg = "§l[§1Onix§fClient]§r Texture Pack directory copied to clipboard!"
local packNotif = "Texture Pack directory copied to clipboard!"

local globalPath = "%localappdata%/Packages/Microsoft.MinecraftUWP_8wekyb3d8bbwe/RoamingState/OnixClient"
local globalMesg = "§l[§1Onix§fClient]§r Global directory copied to clipboard!"
local globalNotif = "Global directory copied to clipboard!"

-- Script Start

function findSpace(str)
    local strlen = string.len(str)
    for i=1,strlen do
        if (string.sub(str, i,i) == " ") then return i end
    end
    return nil
end

function execute(arguments)
    local sortedArgs = {}
    local space = findSpace(arguments)
    while (space ~= nil) do
        local newstr = string.sub(arguments, 1, space)
        table.insert(sortedArgs, newstr)
        arguments = string.sub(arguments, space+1, -1)
        space = findSpace(arguments)
    end
    table.insert(sortedArgs, arguments)

    for index, value in pairs(sortedArgs) do

            --Configs

        if (value == "config") then
            echo("Config")
            setClipboard(configPath)
            client.notification(configNotif)
            print(configMesg)
        else if (value == "configs") then
            setClipboard(configPath)
            client.notification(configNotif)
            print(configMesg)
        else if (value == "Configs") then
            setClipboard(configPath)
            client.notification(configNotif)
            print(configMesg)

            --Scripts

        else if (value == "script") then
            setClipboard(scriptPath)
            client.notification(scriptNotif)
            print(scriptMesg)
        else if (value == "scripts") then
            setClipboard(scriptPath)
            client.notification(scriptNotif)
            print(scriptMesg)
        else if (value == "Script") then
            setClipboard(scriptPath)
            client.notification(scriptNotif)
            print(scriptMesg)
        else if (value == "Scripts") then
            setClipboard(scriptPath)
            client.notification(scriptNotif)
            print(scriptMesg)

            --Screenshots

        else if (value == "screenshot") then
            setClipboard(screenshotPath)
            client.notification(screenshotNotif)
            print(screenshotMesg)
        else if (value == "screenshots") then
            setClipboard(screenshotPath)
            client.notification(screenshotNotif)
            print(screenshotMesg)
        else if (value == "Screenshot") then
            setClipboard(screenshotPath)
            client.notification(screenshotNotif)
            print(screenshotMesg)
        else if (value == "Screenshots") then
            setClipboard(screenshotPath)
            client.notification(screenshotNotif)
            print(screenshotMesg)

            --Crosshairs

        else if (value == "crosshair") then
            setClipboard(crosshairPath)
            client.notification(crosshairNotif)
            print(crosshairMesg)
        else if (value == "crosshairs") then
            setClipboard(crosshairPath)
            client.notification(crosshairNotif)
            print(crosshairMesg)
        else if (value == "Crosshair") then
            setClipboard(crosshairPath)
            client.notification(crosshairNotif)
            print(crosshairMesg)
        else if (value == "Crosshairs") then
            setClipboard(crosshairPath)
            client.notification(crosshairNotif)
            print(crosshairMesg)

            --Packs

        else if (value == "pack") then
            setClipboard(packPath)
            client.notification(packNotif)
            print(packMesg)
        else if (value == "packs") then
            setClipboard(packPath)
            client.notification(packNotif)
            print(packMesg)
        else if (value == "Pack") then
            setClipboard(packPath)
            client.notification(packNotif)
            print(packMesg)
        else if (value == "Packs") then
            setClipboard(packPath)
            client.notification(packNotif)
            print(packMesg)
        else if (value == "tpack") then
            setClipboard(packPath)
            client.notification(packNotif)
            print(packMesg)
        else if (value == "tpacks") then
            setClipboard(packPath)
            client.notification(packNotif)
            print(packMesg)
        else if (value == "texture pack") then
            setClipboard(packPath)
            client.notification(packNotif)
            print(packMesg)
        else if (value == "texture packs") then
            setClipboard(packPath)
            client.notification(packNotif)
            print(packMesg)
        else if (value == "Texture pack") then
            setClipboard(packPath)
            client.notification(packNotif)
            print(packMesg)
        else if (value == "Texture Pack") then
            setClipboard(packPath)
            client.notification(packNotif)
            print(packMesg)
        else if (value == "Texture packs") then
            setClipboard(packPath)
            client.notification(packNotif)
            print(packMesg)

            --Global

        else if (value == "global") then
            setClipboard(globalPath)
            client.notification(globalNotif)
            print(globalMesg)

            --Other

        else
            client.notification("Invalid value")
            print("§l[§1Onix§fClient]§r Invalid Value")

        end
        end
        end
        end
        end
        end
        end
        end
        end
        end
        end
        end
        end
        end
        end
        end
        end
        end
        end
        end
        end
        end
        end
        end
        end
        end
        end
    end
end