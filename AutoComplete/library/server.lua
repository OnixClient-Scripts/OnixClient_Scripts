---@meta

---@class server
server = {}


---The current ip the user is connected to
---@return string ip The current ip the user is connected to
function server.ipConnected() end

---The ip that you used to join the server
---@return string ip The ip used to join the server
function server.ip() end

---The port
---@return integer port The current server port
function server.port() end

---The name of the world (whats in top right in pause screen)
---@return string name The world name
function server.worldName() end


---The name of everyone in the pause menu
---example of usage:
---for _, playerName in pairs(server.players()) do
---
---end
---@return string[] playernames The name of everybody in the playerlist (same as pause menu)
function server.players() end
