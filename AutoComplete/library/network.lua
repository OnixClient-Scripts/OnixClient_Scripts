---@meta

networking = {}

---Does a web request to the specified url
---@param url string What url we sending our request to
---@param identifier string Will be the second parameter of onNetworkData
function networking.get(url, identifier) end

---Does a web request to the specified url
---@param url string What url we sending our request to
---@param identifier string Will be the second parameter of onNetworkData
---@param headers string[] List of headers
function networking.get(url, identifier, headers) end


---Does a web request to the specified url and stores the result in the file, data will be filepath
---@param filepath string Where to store the result
---@param url string What url we sending our request to
---@param identifier string Will be the second parameter of onNetworkData
function networking.fileget(filepath, url, identifier) end

---Does a web request to the specified url and stores the result in the file, data will be filepath
---@param filepath string Where to store the result
---@param url string What url we sending our request to
---@param identifier string Will be the second parameter of onNetworkData
---@param headers string[] List of headers
function networking.fileget(filepath, url, identifier, headers) end
