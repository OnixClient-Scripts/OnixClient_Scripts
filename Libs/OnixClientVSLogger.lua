-- for use with https://github.com/jqms/OnixClientLogger
vs = {
    log = function (text)
        local path = "OnixVSLogs/OnixVSLogs.txt"
        local file = io.open(path, "a")
        file:write(text .. "\n")
        file:close()
    end,

    clearLog = function ()
        if fs.exist("OnixVSLogs/OnixVSLogs.txt") then
            fs.delete("OnixVSLogs/OnixVSLogs.txt")
        end
    end
}