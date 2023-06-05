-- for use with https://github.com/jqms/OnixClientLogger
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
