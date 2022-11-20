---@meta

---@class network
network = {}

---Does a web request to the specified url
---You will receive the data in the onNetworkData callback
---function onNetworkData(code, identifier, data)
---
---end
---@param url string What url we sending our request to
---@param identifier string Will be the second parameter of onNetworkData (can be anything u want, allows you to identify what data you received) (can be anything u want, allows you to identify what data you received)
function network.get(url, identifier) end


---Does a web request to the specified url
---You will receive the data in the onNetworkData callback
---function onNetworkData(code, identifier, data)
---
---end
---@param url string What url we sending our request to
---@param identifier string Will be the second parameter of onNetworkData (can be anything u want, allows you to identify what data you received) (can be anything u want, allows you to identify what data you received)
---@param headers string[] List of headers (Name: Value)
function network.get(url, identifier, headers) end


---Does a web request to the specified url and stores the result in the file, data will be filepath
---You will receive the data in the onNetworkData callback
---function onNetworkData(code, identifier, data)
---
---end
---@param filepath string Where to store the result
---@param url string What url we sending our request to
---@param identifier string Will be the second parameter of onNetworkData (can be anything u want, allows you to identify what data you received)
function network.fileget(filepath, url, identifier) end

---Does a web request to the specified url and stores the result in the file, data will be filepath
---You will receive the data in the onNetworkData callback
---function onNetworkData(code, identifier, data)
---
---end
---@param filepath string Where to store the result
---@param url string What url we sending our request to
---@param identifier string Will be the second parameter of onNetworkData (can be anything u want, allows you to identify what data you received)
---@param headers string[] List of headers (Name: Value)
function network.fileget(filepath, url, identifier, headers) end




---Does a web request to the specified url
---You will receive the data in the onNetworkData callback
---function onNetworkData(code, identifier, data)
---
---end
---@param url string What url we sending our request to
---@param identifier string Will be the second parameter of onNetworkData (can be anything u want, allows you to identify what data you received)
---@param data string What data to post
function network.post(url, identifier, data) end

---Does a web request to the specified url
---You will receive the data in the onNetworkData callback
---function onNetworkData(code, identifier, data)
---
---end
---@param url string What url we sending our request to
---@param identifier string Will be the second parameter of onNetworkData (can be anything u want, allows you to identify what data you received)
---@param headers string[] List of headers (Name: Value)
---@param data string What data to post
function network.post(url, identifier, headers, data) end


---Does a web request to the specified url and stores the result in the file, data will be filepath
---You will receive the data in the onNetworkData callback
---function onNetworkData(code, identifier, data)
---
---end
---@param filepath string Where to store the result
---@param url string What url we are sending our request to
---@param identifier string Will be the second parameter of onNetworkData (can be anything u want, allows you to identify what data you received)
---@param data string What data to post
function network.filepost(filepath, url, identifier, data) end

---Does a web request to the specified url and stores the result in the file, data will be filepath
---You will receive the data in the onNetworkData callback
---function onNetworkData(code, identifier, data)
---
---end
---@param filepath string Where to store the result
---@param url string What url we are sending our request to
---@param identifier string Will be the second parameter of onNetworkData (can be anything u want, allows you to identify what data you received)
---@param headers string[] List of headers (Name: Value)
---@param data string What data to post
function network.filepost(filepath, url, identifier, headers, data) end





---Does a web request to the specified url
---You will receive the data in the onNetworkData callback
---function onNetworkData(code, identifier, data)
---
---end
---@param url string What url we sending our request to
---@param identifier string Will be the second parameter of onNetworkData (can be anything u want, allows you to identify what data you received)
---@param data string What data to delete
function network.delete(url, identifier, data) end

---Does a web request to the specified url
---You will receive the data in the onNetworkData callback
---function onNetworkData(code, identifier, data)
---
---end
---@param url string What url we sending our request to
---@param identifier string Will be the second parameter of onNetworkData (can be anything u want, allows you to identify what data you received)
---@param headers string[] List of headers (Name: Value)
---@param data string What data to delete
function network.delete(url, identifier, headers, data) end


---Does a web request to the specified url and stores the result in the file, data will be filepath
---You will receive the data in the onNetworkData callback
---function onNetworkData(code, identifier, data)
---
---end
---@param filepath string Where to store the result
---@param url string What url we sending our request to
---@param identifier string Will be the second parameter of onNetworkData (can be anything u want, allows you to identify what data you received)
---@param data string What data to delete
function network.filedelete(filepath, url, identifier, data) end

---Does a web request to the specified url and stores the result in the file, data will be filepath
---You will receive the data in the onNetworkData callback
---function onNetworkData(code, identifier, data)
---
---end
---@param filepath string Where to store the result
---@param url string What url we sending our request to
---@param identifier string Will be the second parameter of onNetworkData (can be anything u want, allows you to identify what data you received)
---@param headers string[] List of headers (Name: Value)
---@param data string What data to delete
function network.filedelete(filepath, url, identifier, headers, data) end






---Does a web request to the specified url
---You will receive the data in the onNetworkData callback
---function onNetworkData(code, identifier, data)
---
---end
---@param url string What url we sending our request to
---@param identifier string Will be the second parameter of onNetworkData (can be anything u want, allows you to identify what data you received)
---@param data string What data to patch
function network.patch(url, identifier, data) end

---Does a web request to the specified url
---You will receive the data in the onNetworkData callback
---function onNetworkData(code, identifier, data)
---
---end
---@param url string What url we sending our request to
---@param identifier string Will be the second parameter of onNetworkData (can be anything u want, allows you to identify what data you received)
---@param headers string[] List of headers (Name: Value)
---@param data string What data to patch
function network.patch(url, identifier, headers, data) end


---Does a web request to the specified url and stores the result in the file, data will be filepath
---You will receive the data in the onNetworkData callback
---function onNetworkData(code, identifier, data)
---
---end
---@param filepath string Where to store the result
---@param url string What url we sending our request to
---@param identifier string Will be the second parameter of onNetworkData (can be anything u want, allows you to identify what data you received)
---@param data string What data to patch
function network.filepatch(filepath, url, identifier, data) end

---Does a web request to the specified url and stores the result in the file, data will be filepath
---You will receive the data in the onNetworkData callback
---function onNetworkData(code, identifier, data)
---
---end
---@param filepath string Where to store the result
---@param url string What url we sending our request to
---@param identifier string Will be the second parameter of onNetworkData (can be anything u want, allows you to identify what data you received)
---@param headers string[] List of headers (Name: Value)
---@param data string What data to patch
function network.filepatch(filepath, url, identifier, headers, data) end






---Does a web request to the specified url
---You will receive the data in the onNetworkData callback
---function onNetworkData(code, identifier, data)
---
---end
---@param url string What url we sending our request to
---@param identifier string Will be the second parameter of onNetworkData (can be anything u want, allows you to identify what data you received)
---@param data string What data to put
function network.put(url, identifier, data) end

---Does a web request to the specified url
---You will receive the data in the onNetworkData callback
---function onNetworkData(code, identifier, data)
---
---end
---@param url string What url we sending our request to
---@param identifier string Will be the second parameter of onNetworkData (can be anything u want, allows you to identify what data you received)
---@param headers string[] List of headers (Name: Value)
---@param data string What data to put
function network.put(url, identifier, headers, data) end


---Does a web request to the specified url and stores the result in the file, data will be filepath
---You will receive the data in the onNetworkData callback
---function onNetworkData(code, identifier, data)
---
---end
---@param filepath string Where to store the result
---@param url string What url we sending our request to
---@param identifier string Will be the second parameter of onNetworkData (can be anything u want, allows you to identify what data you received)
---@param data string What data to put
function network.fileput(filepath, url, identifier, data) end

---Does a web request to the specified url and stores the result in the file, data will be filepath
---You will receive the data in the onNetworkData callback
---function onNetworkData(code, identifier, data)
---
---end
---@param filepath string Where to store the result
---@param url string What url we sending our request to
---@param identifier string Will be the second parameter of onNetworkData (can be anything u want, allows you to identify what data you received)
---@param headers string[] List of headers (Name: Value)
---@param data string What data to put
function network.fileput(filepath, url, identifier, headers, data) end
