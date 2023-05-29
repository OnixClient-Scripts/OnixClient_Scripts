workingDir = "RoamingState/OnixClient/Scripts/Data/Sounds/"

---Downloads a sound from the OnixClient_Scripts repo (upload sounds to the sound folder in data on the repo)
---@param url string The url of the sound to download
---@return nil
function downloadSound(url)
    workingDir = "RoamingState/OnixClient/Scripts/Data"
    if not fs.exist("Sounds") then
        fs.mkdir("Sounds")
    end
    workingDir = "RoamingState/OnixClient/Scripts/Data/Sounds/"
    local name = url:match("([^/]+)$")

    if not fs.exist(name) then
        network.fileget(name,url, name)
    end
end

-- this is only here because it has to be lol
function onNetworkData(code,id,data)
    if id then
        return
    end
end
workingDir = "RoamingState/OnixClient/Scripts/Data"
