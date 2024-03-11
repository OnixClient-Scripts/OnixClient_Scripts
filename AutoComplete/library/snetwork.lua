---@meta

---@class HttpResponse
---@field status integer
---@field body string
---@field headers table<string, string>


---@class snetwork
snetwork = {}

---Performs a GET web request synchronously.
---@param url string The URL to request.
---@param headers nil|table<string, string> A table of headers to send with the request.
---@param progressCallback nil|fun(downloadDone:integer, downloadTotal:integer, uploadDone:integer, uploadTotal:integer) A function which will be called whenever progress is made on the request.
---@return HttpResponse|nil response The response from the server.
---@return string|"OK" error The error message if the request failed.
function snetwork.get(url, headers, progressCallback) end

---Performs a GET web request synchronously.
---@param url string The URL to request.
---@param saveFilePath string The file path to save the response body to.
---@param headers nil|table<string, string> A table of headers to send with the request.
---@param progressCallback nil|fun(downloadDone:integer, downloadTotal:integer, uploadDone:integer, uploadTotal:integer) A function which will be called whenever progress is made on the request.
---@return HttpResponse|nil response The response from the server.
---@return string|"OK" error The error message if the request failed.
function snetwork.fileget(url, saveFilePath, headers, progressCallback) end

---Performs a POST web request synchronously.
---@param url string The URL to request.
---@param body string The body of the request.
---@param headers nil|table<string, string> A table of headers to send with the request.
---@param method nil|string|"POST"|"PUT"|"PATCH" The HTTP method to use for the request.
---@param progressCallback nil|fun(downloadDone:integer, downloadTotal:integer, uploadDone:integer, uploadTotal:integer) A function which will be called whenever progress is made on the request.
---@return HttpResponse|nil response The response from the server.
---@return string|"OK" error The error message if the request failed.
function snetwork.post(url, body, headers, method, progressCallback) end

---Performs a POST web request synchronously.
---@param url string The URL to request.
---@param filepathToBody string The filepath containing the body of the request.
---@param headers nil|table<string, string> A table of headers to send with the request.
---@param method nil|string|"POST"|"PUT"|"PATCH" The HTTP method to use for the request.
---@param progressCallback nil|fun(downloadDone:integer, downloadTotal:integer, uploadDone:integer, uploadTotal:integer) A function which will be called whenever progress is made on the request.
---@return HttpResponse|nil response The response from the server.
---@return string|"OK" error The error message if the request failed.
function snetwork.postfile(url, filepathToBody, headers, method, progressCallback) end


---Performs a POST web request synchronously.
---@param url string The URL to request.
---@param saveFilepath string The file path to save the response body to.
---@param body string The body of the request.
---@param headers nil|table<string, string> A table of headers to send with the request.
---@param method nil|string|"POST"|"PUT"|"PATCH" The HTTP method to use for the request.
---@param progressCallback nil|fun(downloadDone:integer, downloadTotal:integer, uploadDone:integer, uploadTotal:integer) A function which will be called whenever progress is made on the request.
---@return HttpResponse|nil response The response from the server.
---@return string|"OK" error The error message if the request failed.
function snetwork.filepost(url, saveFilepath, body, headers, method, progressCallback) end

---Performs a POST web request synchronously.
---@param url string The URL to request.
---@param saveFilepath string The file path to save the response body to.
---@param filepathToBody string The filepath containing the body of the request.
---@param headers nil|table<string, string> A table of headers to send with the request.
---@param method nil|string|"POST"|"PUT"|"PATCH" The HTTP method to use for the request.
---@param progressCallback nil|fun(downloadDone:integer, downloadTotal:integer, uploadDone:integer, uploadTotal:integer) A function which will be called whenever progress is made on the request.
---@return HttpResponse|nil response The response from the server.
---@return string|"OK" error The error message if the request failed.
function snetwork.filepostfile(url, saveFilepath, filepathToBody, headers, method, progressCallback) end