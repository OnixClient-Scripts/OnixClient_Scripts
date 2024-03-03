
anetwork = {internal={}}

---@param paramSTR string
---@param thread Thread
function anetwork.internal.NetworkingThreadWorkerEntryPoint(paramSTR, thread)
    local params = jsonToTable(paramSTR)
    local workerId = params.workerId
    local requestId = 0
    local function ProgressCallback(dlNow, dlTotal, ulNow, ulTotal)
        thread:pushMessage(tableToJson({
            type = "request_progress",
            requestId = requestId,
            progressDlNow = dlNow,
            progressDlTotal = dlTotal,
            progressUlNow = ulNow,
            progressUlTotal = ulTotal
        }))
    end

    while true do
        while thread:hasMessage() do
            local msg = jsonToTable(thread:popMessage())
            requestId = msg.requestId
            thread:pushMessage(tableToJson({
                type = "change_request",
                requestId = requestId
            }))
            if msg.type == "get_request" then
                local response, error = nil,nil
                if msg.saveFilepath then 
                    response, error = snetwork.fileget(msg.url, msg.saveFilepath, msg.headers, ProgressCallback)
                else
                    response, error = snetwork.get(msg.url, msg.headers, ProgressCallback)
                end
                thread:pushMessage(tableToJson({
                    type = "completed_request",
                    requestId = msg.requestId,
                    response = response,
                    error = error
                }))
            elseif msg.type == "post_request" then
                local response, error = nil,nil
                if msg.saveFilepath then 
                    response, error = snetwork.filepost(msg.url, msg.body, msg.saveFilepath, msg.headers, msg.method, ProgressCallback)
                else
                    response, error = snetwork.post(msg.url, msg.body, msg.headers, msg.method, ProgressCallback)
                end
                thread:pushMessage(tableToJson({
                    type = "completed_request",
                    requestId = msg.requestId,
                    response = response,
                    error = error
                }))
            elseif msg.type == "post_from_file_request" then
                local response, error = nil,nil
                if msg.saveFilepath then 
                    response, error = snetwork.filepostfile(msg.url, msg.bodyPath, msg.saveFilepath, msg.headers, msg.method, ProgressCallback)
                else
                    response, error = snetwork.postfile(msg.url, msg.bodyPath, msg.headers, msg.method, ProgressCallback)
                end
                thread:pushMessage(tableToJson({
                    type = "completed_request",
                    requestId = msg.requestId,
                    response = response,
                    error = error
                }))
            end
        end
        thread:sleep(1)
    end
end

---@class ANETWORK_WorkThread
---@field thread Thread
---@field CurrentReuqestId integer

---@type ANETWORK_WorkThread[]
anetwork.internal.WorkerThreads = {}
anetwork.internal.PendingRequests = {}
anetwork.internal.HasBeenInitialized = false
anetwork.internal.WorkerThreadAmount = 0
anetwork.internal.LastThreadThatReceivedWork = 1
anetwork.internal.GlobalRequestId = 0
function anetwork.internal.GetNextWorkerThread()
    local nextThread = anetwork.internal.LastThreadThatReceivedWork + 1
    if nextThread > anetwork.internal.WorkerThreadAmount then
        nextThread = 1
    end
    anetwork.internal.LastThreadThatReceivedWork = nextThread
    return anetwork.internal.WorkerThreads[nextThread]
end

---@class ANETWORK_Request
---@field url string The URL of the request
---@field headers table<string, string> The headers of the request
---@field doneCallback fun(response:HttpResponse|nil, error:string) The callback to call when the request is done (or failed)
---@field id integer The request ID
---@field progressDlNow integer Currently downloaded bytes
---@field progressDlTotal integer Total bytes to download
---@field progressUlNow integer Currently uploaded bytes
---@field progressUlTotal integer Total bytes to upload
---@field downloadProgress number 0 - 100 progress
---@field uploadProgress number 0 - 100 progress
---@field response HttpResponse|nil The response of the request
---@field error string|"OK" "OK" if no error
---@field isDone boolean If the request has been completed
---@field hasStarted boolean If the request has been started (being uploaded/downloaded)
---@field savePath nil|string The file path to save the response body to



---Performs a GET web request asynchronously.
---@param url string The URL to request.
---@param headers table<string, string>|nil A table of headers to send with the request.
---@param doneCallback fun(response:HttpResponse|nil, error:string) The callback to call when the request is done (or failed)
---@return ANETWORK_Request
function anetwork.get(url, headers, doneCallback)
    assert(anetwork.internal.HasBeenInitialized, "anetwork has not been initialized")
    ---@type ANETWORK_Request
    local request =  {
        url = url,
        savePath = nil,
        headers = headers,
        doneCallback = doneCallback,
        id = anetwork.internal.GlobalRequestId,
        progressDlNow = 0, progressDlTotal = 0,
        progressUlNow = 0, progressUlTotal = 0,
        downloadProgress=0, uploadProgress=0,
        response = nil,
        error = "OK",
        isDone = false, hasStarted = false
    }
    anetwork.internal.PendingRequests[anetwork.internal.GlobalRequestId] = request
    anetwork.internal.GlobalRequestId = anetwork.internal.GlobalRequestId + 1
    local thread = anetwork.internal.GetNextWorkerThread()
    thread.thread:pushMessage(tableToJson({
        type = "get_request",
        requestId = request.id,
        url = url,
        headers = headers
    }))
    return request
end

---Performs a GET web request asynchronously and saves the body to a file.
---@param url string The URL to request.
---@param filepath string The file path to save the response body to.
---@param headers table<string, string>|nil A table of headers to send with the request.
---@param doneCallback fun(response:HttpResponse|nil, error:string) The callback to call when the request is done (or failed)
---@return ANETWORK_Request
function anetwork.fileget(url, filepath, headers, doneCallback)
    assert(anetwork.internal.HasBeenInitialized, "anetwork has not been initialized")
    local request =  {
        url = url,
        savePath = filepath,
        headers = headers,
        doneCallback = doneCallback,
        id = anetwork.internal.GlobalRequestId,
        progressDlNow = 0, progressDlTotal = 0,
        progressUlNow = 0, progressUlTotal = 0,
        downloadProgress=0, uploadProgress=0,
        response = nil,
        error = "OK",
        isDone = false, hasStarted = false
    }
    anetwork.internal.PendingRequests[anetwork.internal.GlobalRequestId] = request
    anetwork.internal.GlobalRequestId = anetwork.internal.GlobalRequestId + 1
    local thread = anetwork.internal.GetNextWorkerThread()
    thread.thread:pushMessage(tableToJson({
        type = "get_request",
        requestId = request.id,
        saveFilepath = filepath,
        url = url,
        headers = headers
    }))
    return request
end

---Performs a POST web request asynchronously.
---@param url string The URL to request.
---@param body string The body of the request.
---@param headers table<string, string>|nil A table of headers to send with the request.
---@param doneCallback fun(response:HttpResponse|nil, error:string) The callback to call when the request is done (or failed)
---@param method nil|string|"POST"|"PUT"|"PATCH" The HTTP method to use for the request.
---@return ANETWORK_Request
function anetwork.post(url, body, headers, doneCallback, method)
    assert(anetwork.internal.HasBeenInitialized, "anetwork has not been initialized")
    local request =  {
        url = url,
        headers = headers,
        doneCallback = doneCallback,
        id = anetwork.internal.GlobalRequestId,
        progressDlNow = 0, progressDlTotal = 0,
        progressUlNow = 0, progressUlTotal = 0,
        downloadProgress=0, uploadProgress=0,
        response = nil,
        error = "OK",
        isDone = false, hasStarted = false
    }
    anetwork.internal.PendingRequests[anetwork.internal.GlobalRequestId] = request
    anetwork.internal.GlobalRequestId = anetwork.internal.GlobalRequestId + 1
    local thread = anetwork.internal.GetNextWorkerThread()
    thread.thread:pushMessage(tableToJson({
        type = "post_request",
        requestId = request.id,
        url = url,
        body = body,
        headers = headers,
        method = method or "POST"
    }))
    return request
end

---Performs a POST web request asynchronously and saves the body to a file.
---@param url string The URL to request.
---@param body string The body of the request.
---@param filepath string The file path to save the response body to.
---@param headers table<string, string>|nil A table of headers to send with the request.
---@param doneCallback fun(response:HttpResponse|nil, error:string) The callback to call when the request is done (or failed)
---@param method nil|string|"POST"|"PUT"|"PATCH" The HTTP method to use for the request.
---@return ANETWORK_Request
function anetwork.filepost(url, body, filepath, headers, doneCallback, method)
    assert(anetwork.internal.HasBeenInitialized, "anetwork has not been initialized")
    local request =  {
        url = url,
        savePath = filepath,
        headers = headers,
        doneCallback = doneCallback,
        id = anetwork.internal.GlobalRequestId,
        progressDlNow = 0, progressDlTotal = 0,
        progressUlNow = 0, progressUlTotal = 0,
        downloadProgress=0, uploadProgress=0,
        response = nil,
        error = "OK",
        isDone = false, hasStarted = false
    }
    anetwork.internal.PendingRequests[anetwork.internal.GlobalRequestId] = request
    anetwork.internal.GlobalRequestId = anetwork.internal.GlobalRequestId + 1
    local thread = anetwork.internal.GetNextWorkerThread()
    thread.thread:pushMessage(tableToJson({
        type = "post_request",
        requestId = request.id,
        url = url,
        body = body,
        saveFilepath = filepath,
        headers = headers,
        method = method or "POST"
    }))
    return request
end

---Performs a POST web request asynchronously and sends the body from a file.
---@param url string The URL to request.
---@param filepathToBody string The filepath containing the body of the request.
---@param headers table<string, string>|nil A table of headers to send with the request.
---@param doneCallback fun(response:HttpResponse|nil, error:string) The callback to call when the request is done (or failed)
---@param method nil|string|"POST"|"PUT"|"PATCH" The HTTP method to use for the request.
---@return ANETWORK_Request
function anetwork.postfile(url, filepathToBody, headers, doneCallback, method)
    assert(anetwork.internal.HasBeenInitialized, "anetwork has not been initialized")
    local request =  {
        url = url,
        headers = headers,
        doneCallback = doneCallback,
        id = anetwork.internal.GlobalRequestId,
        progressDlNow = 0, progressDlTotal = 0,
        progressUlNow = 0, progressUlTotal = 0,
        downloadProgress=0, uploadProgress=0,
        response = nil,
        error = "OK",
        isDone = false, hasStarted = false
    }
    anetwork.internal.PendingRequests[anetwork.internal.GlobalRequestId] = request
    anetwork.internal.GlobalRequestId = anetwork.internal.GlobalRequestId + 1
    local thread = anetwork.internal.GetNextWorkerThread()
    thread.thread:pushMessage(tableToJson({
        type = "post_from_file_request",
        requestId = request.id,
        url = url,
        bodyPath = filepathToBody,
        headers = headers,
        method = method or "POST"
    }))
    return request
end

---Performs a POST web request asynchronously and saves the body to a file.
---@param url string The URL to request.
---@param saveFilepath string The file path to save the response body to.
---@param filepathToBody string The filepath containing the body of the request.
---@param headers table<string, string>|nil A table of headers to send with the request.
---@param doneCallback fun(response:HttpResponse|nil, error:string) The callback to call when the request is done (or failed)
---@param method nil|string|"POST"|"PUT"|"PATCH" The HTTP method to use for the request.
---@return ANETWORK_Request
function anetwork.filepostfile(url, filepathToBody, saveFilepath, headers, doneCallback, method)
    assert(anetwork.internal.HasBeenInitialized, "anetwork has not been initialized")
    local request =  {
        url = url,
        savePath = saveFilepath,
        headers = headers,
        doneCallback = doneCallback,
        id = anetwork.internal.GlobalRequestId,
        progressDlNow = 0, progressDlTotal = 0,
        progressUlNow = 0, progressUlTotal = 0,
        downloadProgress=0, uploadProgress=0,
        response = nil,
        error = "OK",
        isDone = false, hasStarted = false
    }
    anetwork.internal.PendingRequests[anetwork.internal.GlobalRequestId] = request
    anetwork.internal.GlobalRequestId = anetwork.internal.GlobalRequestId + 1
    local thread = anetwork.internal.GetNextWorkerThread()
    thread.thread:pushMessage(tableToJson({
        type = "post_from_file_request",
        requestId = request.id,
        url = url,
        bodyPath = filepathToBody,
        saveFilepath = saveFilepath,
        headers = headers,
        method = method or "POST"
    }))
    return request
end

---Updates the async networking system.
function anetwork.Tick()
    for k, t in pairs(anetwork.internal.WorkerThreads) do
        while t.thread:hasMessage() do
            local msg = jsonToTable(t.thread:popMessage())
            if msg.type == "change_request" then
                t.CurrentReuqestId = msg.requestId
                anetwork.internal.PendingRequests[msg.requestId].hasStarted = true
            elseif msg.type == "completed_request" then
                local request = anetwork.internal.PendingRequests[msg.requestId]
                request.response = msg.response
                request.error = msg.error
                request.isDone = true
                if request.doneCallback then
                    request.doneCallback(request.response, request.error)
                end
                anetwork.internal.PendingRequests[msg.requestId] = nil
            elseif msg.type == "request_progress" then
                local request = anetwork.internal.PendingRequests[msg.requestId]
                request.progressDlNow = msg.progressDlNow
                request.progressDlTotal = msg.progressDlTotal
                request.progressUlNow = msg.progressUlNow
                request.progressUlTotal = msg.progressUlTotal
                request.downloadProgress = (msg.progressDlNow / math.max(1, msg.progressDlTotal)) * 100
                request.uploadProgress = (msg.progressUlNow / math.max(1, msg.progressUlTotal)) * 100
            end
        end
    end
end

---Initializes the async networking system.
---@param workerCount integer The amount of worker threads to use.
function anetwork.Initialise(workerCount)
    anetwork.internal.WorkerThreadAmount = workerCount
    anetwork.internal.LastThreadThatReceivedWork = workerCount
    anetwork.internal.HasBeenInitialized = true
    for i = 1, workerCount do
        local params = {
            workerId = i
        }
        anetwork.internal.WorkerThreads[i] = {
            thread=CreateThread(anetwork.internal.NetworkingThreadWorkerEntryPoint, tableToJson(params), false),
            CurrentReuqestId = 0
        }
    end
end

