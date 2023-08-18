-- This script was originally written in TypeScript.
-- By Tom (discord: @s.amat) (aka jerry)
-- Console object
local console = {
  log = function(...)
    local str = ""
    for _, v in ipairs({ ... }) do
      if type(v) == "table" then v = tableToJson(v, true) end
      str = str .. " " .. tostring(v)
    end
    print("§8[§7" .. name .. "§8]§r" .. str)
  end,
  warn = function(...)
    local str = ""
    for _, v in ipairs({ ... }) do
      if type(v) == "table" then v = tableToJson(v, true) end
      str = str .. " " .. tostring(v)
    end
    print("§8[§7" .. name .. "§8]§r§e" .. str .. "§r")
  end,
  error = function(...)
    local str = ""
    for _, v in ipairs({ ... }) do
      if type(v) == "table" then v = tableToJson(v, true) end
      str = str .. " " .. tostring(v)
    end
    print("§8[§7" .. name .. "§8]§r§c" .. str .. "§r")
  end,
}
-- End of Console object
-- Lua Library inline imports
local function __TS__Class(self)
    local c = {prototype = {}}
    c.prototype.__index = c.prototype
    c.prototype.constructor = c
    return c
end

local __TS__Symbol, Symbol
do
    local symbolMetatable = {__tostring = function(self)
        return ("Symbol(" .. (self.description or "")) .. ")"
    end}
    function __TS__Symbol(description)
        return setmetatable({description = description}, symbolMetatable)
    end
    Symbol = {
        iterator = __TS__Symbol("Symbol.iterator"),
        hasInstance = __TS__Symbol("Symbol.hasInstance"),
        species = __TS__Symbol("Symbol.species"),
        toStringTag = __TS__Symbol("Symbol.toStringTag")
    }
end

local __TS__Iterator
do
    local function iteratorGeneratorStep(self)
        local co = self.____coroutine
        local status, value = coroutine.resume(co)
        if not status then
            error(value, 0)
        end
        if coroutine.status(co) == "dead" then
            return
        end
        return true, value
    end
    local function iteratorIteratorStep(self)
        local result = self:next()
        if result.done then
            return
        end
        return true, result.value
    end
    local function iteratorStringStep(self, index)
        index = index + 1
        if index > #self then
            return
        end
        return index, string.sub(self, index, index)
    end
    function __TS__Iterator(iterable)
        if type(iterable) == "string" then
            return iteratorStringStep, iterable, 0
        elseif iterable.____coroutine ~= nil then
            return iteratorGeneratorStep, iterable
        elseif iterable[Symbol.iterator] then
            local iterator = iterable[Symbol.iterator](iterable)
            return iteratorIteratorStep, iterator
        else
            return ipairs(iterable)
        end
    end
end

local Map
do
    Map = __TS__Class()
    Map.name = "Map"
    function Map.prototype.____constructor(self, entries)
        self[Symbol.toStringTag] = "Map"
        self.items = {}
        self.size = 0
        self.nextKey = {}
        self.previousKey = {}
        if entries == nil then
            return
        end
        local iterable = entries
        if iterable[Symbol.iterator] then
            local iterator = iterable[Symbol.iterator](iterable)
            while true do
                local result = iterator:next()
                if result.done then
                    break
                end
                local value = result.value
                self:set(value[1], value[2])
            end
        else
            local array = entries
            for ____, kvp in ipairs(array) do
                self:set(kvp[1], kvp[2])
            end
        end
    end
    function Map.prototype.clear(self)
        self.items = {}
        self.nextKey = {}
        self.previousKey = {}
        self.firstKey = nil
        self.lastKey = nil
        self.size = 0
    end
    function Map.prototype.delete(self, key)
        local contains = self:has(key)
        if contains then
            self.size = self.size - 1
            local next = self.nextKey[key]
            local previous = self.previousKey[key]
            if next ~= nil and previous ~= nil then
                self.nextKey[previous] = next
                self.previousKey[next] = previous
            elseif next ~= nil then
                self.firstKey = next
                self.previousKey[next] = nil
            elseif previous ~= nil then
                self.lastKey = previous
                self.nextKey[previous] = nil
            else
                self.firstKey = nil
                self.lastKey = nil
            end
            self.nextKey[key] = nil
            self.previousKey[key] = nil
        end
        self.items[key] = nil
        return contains
    end
    function Map.prototype.forEach(self, callback)
        for ____, key in __TS__Iterator(self:keys()) do
            callback(nil, self.items[key], key, self)
        end
    end
    function Map.prototype.get(self, key)
        return self.items[key]
    end
    function Map.prototype.has(self, key)
        return self.nextKey[key] ~= nil or self.lastKey == key
    end
    function Map.prototype.set(self, key, value)
        local isNewValue = not self:has(key)
        if isNewValue then
            self.size = self.size + 1
        end
        self.items[key] = value
        if self.firstKey == nil then
            self.firstKey = key
            self.lastKey = key
        elseif isNewValue then
            self.nextKey[self.lastKey] = key
            self.previousKey[key] = self.lastKey
            self.lastKey = key
        end
        return self
    end
    Map.prototype[Symbol.iterator] = function(self)
        return self:entries()
    end
    function Map.prototype.entries(self)
        local items = self.items
        local nextKey = self.nextKey
        local key = self.firstKey
        return {
            [Symbol.iterator] = function(self)
                return self
            end,
            next = function(self)
                local result = {done = not key, value = {key, items[key]}}
                key = nextKey[key]
                return result
            end
        }
    end
    function Map.prototype.keys(self)
        local nextKey = self.nextKey
        local key = self.firstKey
        return {
            [Symbol.iterator] = function(self)
                return self
            end,
            next = function(self)
                local result = {done = not key, value = key}
                key = nextKey[key]
                return result
            end
        }
    end
    function Map.prototype.values(self)
        local items = self.items
        local nextKey = self.nextKey
        local key = self.firstKey
        return {
            [Symbol.iterator] = function(self)
                return self
            end,
            next = function(self)
                local result = {done = not key, value = items[key]}
                key = nextKey[key]
                return result
            end
        }
    end
    Map[Symbol.species] = Map
end

local function __TS__New(target, ...)
    local instance = setmetatable({}, target.prototype)
    instance:____constructor(...)
    return instance
end

local __TS__StringReplace
do
    local sub = string.sub
    function __TS__StringReplace(source, searchValue, replaceValue)
        local startPos, endPos = string.find(source, searchValue, nil, true)
        if not startPos then
            return source
        end
        local before = sub(source, 1, startPos - 1)
        local replacement = type(replaceValue) == "string" and replaceValue or replaceValue(nil, searchValue, startPos - 1, source)
        local after = sub(source, endPos + 1)
        return (before .. replacement) .. after
    end
end

local function __TS__StringSubstring(self, start, ____end)
    if ____end ~= ____end then
        ____end = 0
    end
    if ____end ~= nil and start > ____end then
        start, ____end = ____end, start
    end
    if start >= 0 then
        start = start + 1
    else
        start = 1
    end
    if ____end ~= nil and ____end < 0 then
        ____end = 0
    end
    return string.sub(self, start, ____end)
end

local function __TS__ArrayFind(self, predicate, thisArg)
    for i = 1, #self do
        local elem = self[i]
        if predicate(thisArg, elem, i - 1, self) then
            return elem
        end
    end
    return nil
end
-- End of Lua Library inline imports
--- Lib to make interacting with the scripting repo easier
-- Callback-based because promises are weird with tstl, also to be usable from lua scripts too
-- 
-- Haven't tested it completely, but works so far
-- 
-- REPO_URL = the base URL of the repo
REPO_URL = "https://raw.githubusercontent.com/OnixClient-Scripts/OnixClient_Scripts/master"
scriptingRepo = scriptingRepo or ({})
do
    local networkListeners = __TS__New(Map)
    --- Download a script file (module/command/lib/autocomplete file) from the repo.
    -- 
    -- @param url URL of the script to download (github raw content URL from the repo).
    -- @param callback Function called when the file is finished downloading.
    function scriptingRepo.downloadScript(url, callback)
        local id = "download-" .. tostring(math.random())
        networkListeners:set(
            id,
            function(data, code) return callback(code) end
        )
        local oldDir = workingDir
        workingDir = "RoamingState/OnixClient/Scripts"
        local filePath = __TS__StringSubstring(
            __TS__StringReplace(url, REPO_URL, ""),
            1
        )
        --console.log("Downloading...", {filePath = filePath, url = url})
        network.fileget(filePath, url, id)
        workingDir = oldDir
        return
    end
    --- Get the current index for the scripting repo.
    -- 
    -- @param callback Function to call when the index is received.
    function scriptingRepo.getIndex(callback)
        local listenerID = tostring(math.random())
        networkListeners:set(
            listenerID,
            function(data, code) return callback(
                jsonToTable(data),
                code
            ) end
        )
        network.get(REPO_URL .. "/index.json", listenerID)
        return
    end
    --- Get a module's info by its file name.
    -- 
    -- @param file The file name of the module to get.
    -- @param callback Function to call when the module is found.
    function scriptingRepo.getModule(file, callback)
        return scriptingRepo.getIndex(function(index) return callback(__TS__ArrayFind(
            index.modules,
            function(____, mod) return mod.file == file .. ".lua" end
        )) end)
    end
    --- Get a module's info by its name.
    -- 
    -- @param name The display name of the module to get.
    -- @param callback Function to call when info about the module with that display name is received.
    function scriptingRepo.getModuleByName(name, callback)
        return scriptingRepo.getIndex(function(index) return callback(__TS__ArrayFind(
            index.modules,
            function(____, mod) return mod.name == name end
        )) end)
    end
    --- Get info about a scripting module, if it exists on the repo.
    -- 
    -- @param module The scripting module to get info about.
    -- @param callback Info about the provided scripting module.
    function scriptingRepo.getModuleByObj(module, callback)
        return scriptingRepo.getModuleByName(module.name, callback)
    end
    --- Download a module from the repo by its filename.
    -- 
    -- @param fileName The filename of the module to download.
    -- @param callback Function called when the module is finished downloading.
    function scriptingRepo.downloadModule(fileName, callback)
        return scriptingRepo.getModule(
            fileName,
            function(moduleData)
                if not moduleData then
                    return
                end
                return scriptingRepo.downloadScript(moduleData.url, callback)
            end
        )
    end
    --- Get a command's info by its file name.
    -- 
    -- @param name The file name of the command to get.
    -- @param callback Info about the command with that file name.
    function scriptingRepo.getCommand(name, callback)
        return scriptingRepo.getIndex(function(index) return callback(__TS__ArrayFind(
            index.commands,
            function(____, cmd) return cmd.file == name .. ".lua" end
        )) end)
    end
    --- Get a command's info by its name.
    -- 
    -- @param name The display name of the command to get.
    -- @param callback Info about the command with that display name.
    function scriptingRepo.getCommandByName(name, callback)
        return scriptingRepo.getIndex(function(index) return callback(__TS__ArrayFind(
            index.commands,
            function(____, cmd) return cmd.name == name end
        )) end)
    end
    --- Download a command from the repo by its filename.
    -- 
    -- @param fileName The filename of the command to download
    -- @param callback Function called when the command is finished downloading.
    function scriptingRepo.downloadCommand(fileName, callback)
        return scriptingRepo.getCommand(
            fileName,
            function(cmdData)
                if not cmdData then
                    return
                end
                return scriptingRepo.downloadScript(cmdData.url, callback)
            end
        )
    end
    --- Get a lib's info by its name.
    -- 
    -- @param name The name of the lib to get.
    -- @param callback Info about the lib with that name.
    function scriptingRepo.getLib(name, callback)
        return scriptingRepo.getIndex(function(index) return callback(__TS__ArrayFind(
            index.libs,
            function(____, lib) return lib.name == name end
        )) end)
    end
    --- Download a lib from the repo by its filename.
    -- 
    -- @param fileName The filename of the lib to download.
    -- @param callback Function called when the lib is finished downloading.
    function scriptingRepo.downloadLib(fileName, callback)
        return scriptingRepo.getLib(
            fileName,
            function(libData)
                if not libData then
                    return
                end
                return scriptingRepo.downloadScript(libData.url, callback)
            end
        )
    end
    --- Get an autocomplete file's info by its name.
    -- 
    -- @param name The file name of the autocomplete file to get.
    -- @param callback Info about the autocomplete file with that file name.
    function scriptingRepo.getAutocomplete(name, callback)
        return scriptingRepo.getIndex(function(index) return callback(name == "config" and index.autocomplete.config or __TS__ArrayFind(
            index.autocomplete.library,
            function(____, ac) return ac.file == name .. ".lua" end
        )) end)
    end
    --- Download an autocomplete file from the repo by its filename.
    -- 
    -- @param fileName The filename of the autocomplete file to download.
    -- @param callback Function called when the autocomplete file is finished downloading.
    function scriptingRepo.downloadAutocomplete(fileName, callback)
        return scriptingRepo.getAutocomplete(
            fileName,
            function(acData)
                if not acData then
                    return
                end
                return scriptingRepo.downloadScript(acData.url, callback)
            end
        )
    end
    --- Call this function inside onNetworkData(), to call callbacks from other functions.
    -- e.g.
    -- ```lua
    -- function onNetworkData(code, id, data)
    --   scriptingRepo.fetchNetworkData(code, id, data)
    -- end
    -- ```
    -- or
    -- ```ts
    -- onNetworkData = (code, id, data) => {
    --   scriptingRepo.fetchNetworkData(code, id, data);
    -- }
    -- ```
    function scriptingRepo.fetchNetworkData(...)
        local ____bindingPattern0 = {...}
        local data
        local id
        local code
        code = ____bindingPattern0[1]
        id = ____bindingPattern0[2]
        data = ____bindingPattern0[3]
        local listener = networkListeners:get(id)
        if not listener then
            return
        end
        listener(data, code)
    end
end
