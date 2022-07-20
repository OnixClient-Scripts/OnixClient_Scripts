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




---Does a web request to the specified url
---@param url string What url we sending our request to
---@param identifier string Will be the second parameter of onNetworkData
---@param data string What data to post
function networking.post(url, identifier, data) end

---Does a web request to the specified url
---@param url string What url we sending our request to
---@param identifier string Will be the second parameter of onNetworkData
---@param headers string[] List of headers
---@param data string What data to post
function networking.post(url, identifier, headers, data) end


---Does a web request to the specified url and stores the result in the file, data will be filepath
---@param filepath string Where to store the result
---@param url string What url we sending our request to
---@param identifier string Will be the second parameter of onNetworkData
---@param data string What data to post
function networking.filepost(filepath, url, identifier, data) end

---Does a web request to the specified url and stores the result in the file, data will be filepath
---@param filepath string Where to store the result
---@param url string What url we sending our request to
---@param identifier string Will be the second parameter of onNetworkData
---@param headers string[] List of headers
---@param data string What data to post
function networking.filepost(filepath, url, identifier, headers, data) end





---Does a web request to the specified url
---@param url string What url we sending our request to
---@param identifier string Will be the second parameter of onNetworkData
---@param data string What data to delete
function networking.delete(url, identifier, data) end

---Does a web request to the specified url
---@param url string What url we sending our request to
---@param identifier string Will be the second parameter of onNetworkData
---@param headers string[] List of headers
---@param data string What data to delete
function networking.delete(url, identifier, headers, data) end


---Does a web request to the specified url and stores the result in the file, data will be filepath
---@param filepath string Where to store the result
---@param url string What url we sending our request to
---@param identifier string Will be the second parameter of onNetworkData
---@param data string What data to delete
function networking.filedelete(filepath, url, identifier, data) end

---Does a web request to the specified url and stores the result in the file, data will be filepath
---@param filepath string Where to store the result
---@param url string What url we sending our request to
---@param identifier string Will be the second parameter of onNetworkData
---@param headers string[] List of headers
---@param data string What data to delete
function networking.filedelete(filepath, url, identifier, headers, data) end






---Does a web request to the specified url
---@param url string What url we sending our request to
---@param identifier string Will be the second parameter of onNetworkData
---@param data string What data to patch
function networking.patch(url, identifier, data) end

---Does a web request to the specified url
---@param url string What url we sending our request to
---@param identifier string Will be the second parameter of onNetworkData
---@param headers string[] List of headers
---@param data string What data to patch
function networking.patch(url, identifier, headers, data) end


---Does a web request to the specified url and stores the result in the file, data will be filepath
---@param filepath string Where to store the result
---@param url string What url we sending our request to
---@param identifier string Will be the second parameter of onNetworkData
---@param data string What data to patch
function networking.filepatch(filepath, url, identifier, data) end

---Does a web request to the specified url and stores the result in the file, data will be filepath
---@param filepath string Where to store the result
---@param url string What url we sending our request to
---@param identifier string Will be the second parameter of onNetworkData
---@param headers string[] List of headers
---@param data string What data to patch
function networking.filepatch(filepath, url, identifier, headers, data) end






---Does a web request to the specified url
---@param url string What url we sending our request to
---@param identifier string Will be the second parameter of onNetworkData
---@param data string What data to put
function networking.put(url, identifier, data) end

---Does a web request to the specified url
---@param url string What url we sending our request to
---@param identifier string Will be the second parameter of onNetworkData
---@param headers string[] List of headers
---@param data string What data to put
function networking.put(url, identifier, headers, data) end


---Does a web request to the specified url and stores the result in the file, data will be filepath
---@param filepath string Where to store the result
---@param url string What url we sending our request to
---@param identifier string Will be the second parameter of onNetworkData
---@param data string What data to put
function networking.fileput(filepath, url, identifier, data) end

---Does a web request to the specified url and stores the result in the file, data will be filepath
---@param filepath string Where to store the result
---@param url string What url we sending our request to
---@param identifier string Will be the second parameter of onNetworkData
---@param headers string[] List of headers
---@param data string What data to put
function networking.fileput(filepath, url, identifier, headers, data) end
