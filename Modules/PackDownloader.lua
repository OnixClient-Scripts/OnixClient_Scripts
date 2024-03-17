name = "Pack Downloader"
description = "Allows you to download and install texture packs from the web, directly inside the game."

client.settings.addTitle("Type .pack help in the chat for usage information")

workingDir = "RoamingState/"
fs.mkdir("PackManager/packs")
workingDir = "RoamingState/PackManager/packs"
foundDownload = false
discordLink = ""

registerCommand("pack", function(args)
    if args:find("download https://") then
        client.notification("Downloading Pack. Please wait...")
        getDownload(args:sub(10, -1))
    elseif args == "help" then
        print("Usage: .pack download <link>\n\nSupported links:\nMediafire\nDiscord")
    else
        print("Invalid link!")
    end
end)

function getDownload(link)
    if link:find("mediafire.com") then
        network.get(link, "mediafireFetch")
    elseif link:find("cdn.discordapp.com/attachments") then
        network.get(link, "discordFetch")
        discordLink = link
    else
        print("Invalid link!")
    end
end

function downloadPack(pack)
    foundDownload = false
    filepath = pack:sub(pack:find("([^/]+)$"), -1)
    filepath = filepath:gsub("zip", "mcpack")
    network.fileget(filepath, pack, "packDownloader")
end

function onNetworkData(code, id, data)
    if id == "mediafireFetch" then
        if code == 0 then
            if data:find("https://download[%d]+.mediafire.com/") and foundDownload == false then
                foundDownload = true
                temp = data:sub(data:find("https://download[%d]+.mediafire.com/"), -1)
                downloadLink = temp:sub(1, temp:find("mcpack") + 5)
                downloadPack(downloadLink)
            else
                return
            end
        else
            print("Failed to fetch page!")
        end
    end
    if id == "discordFetch" then
        if code == 0 then
            filepath = discordLink:sub(discordLink:find("([^/]+)$"), -1)
            filepath = filepath:gsub("zip", "mcpack")
            network.fileget(filepath, discordLink, "packDownloader")
        end
    end
    if id == "packDownloader" then
        if code == 0 then
            foundDownload = false
            setClipboard(
            "C:/Users/%USERNAME%/AppData/Local/Packages/Microsoft.MinecraftUWP_8wekyb3d8bbwe/RoamingState/PackManager/packs/" ..
            filepath)
            client.notification("      Downloaded pack successfully!\nPress Win + R and paste to import the pack.")
        elseif fs.exist(filepath) then
            client.notification("Pack already downloaded!")
        else
            client.notification("Failed to download pack!")
        end
    end
end
