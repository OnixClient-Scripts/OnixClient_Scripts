-- for use with https://github.com/jqms/OnixClientLogger

function getHash()
    workingDir = "RoamingState/OnixClient/Scripts/Libs/"
    hash = fs.hash("OnixClientVSLogger.lua")
    network.get("https://raw.githubusercontent.com/OnixClient-Scripts/OnixClient_Scripts/master/index.json", "index")
    workingDir = "RoamingState/OnixClient/Scripts/Data"
end

function onNetworkData(code,id,data)
    if id == "index" then
        local index = jsonToTable(data)
        if index["libs"] then
            for i,lib in pairs(index["libs"]) do
                if lib["name"] == "OnixClientVSLogger" then
                    if lib["hash"] == hash then
                        network.get(lib["url"], "lib")
                    else
                        vs.log("OnixClientVSLogger hash mismatch... Updating...")
                        network.get(lib["url"], "lib")
                    end
                end
            end
        end
    end
    if id == "lib" then
        workingDir = "RoamingState/OnixClient/Scripts/Libs/"
        io.open("OnixClientVSLogger.lua", "w"):write(data):close()
        vs.log("OnixClientVSLogger updated!")
    end
end

function postInit()
    getHash()
end

vs = {
---Logs a string to the OnixVSLogs.txt file
---@param text string The text to log
---@return nil
    log = function (text)
        local path = "OnixVSLogs/OnixVSLogs.txt"
        local file = io.open(path, "a")
        if type(text) == "table" then
            text = tableToJson(text)
        end
        if type(text) == "boolean" then
            if text then
                text = "true"
            else
                text = "false"
            end
        end
        if text == nil then
            text = "nil"
        end
        file:write(text .. "\n")
        file:close()
    end,

---Clears the OnixVSLogs.txt file
---@return nil
    clearLog = function ()
        if fs.exist("OnixVSLogs/OnixVSLogs.txt") then
            fs.delete("OnixVSLogs/OnixVSLogs.txt")
        end
    end
}
