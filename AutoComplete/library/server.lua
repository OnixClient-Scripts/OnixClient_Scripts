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

---If the server is the integrated server (when you host a world in singleplayer)
---@return boolean isIntegrated If the server is integrated
function server.isIntegrated() end

---The server's ping
---@param average boolean|nil If you want the average ping (defaults to false)
---@return integer ping The server's ping
function server.ping(average) end

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


---@class Objective
---@field name string The name of the objective
---@field displayName string The display/pretty name of the objective
---@field scores table The scores, keys are the name of the holder and the value is the score

---@class DisplayObjective : Objective
---@field isDescendingOrder boolean If the objective is sorted in descending order (big boy first)

---@class Scoreboard
local _acp__Scoreboard_z = {}
---Gives you the display objective for that location
---@param place string|"sidebar"|"belowname"|"list"
---@return DisplayObjective objective The display objective
function _acp__Scoreboard_z.getDisplayObjective(place) end

---Gives you the display objective for that location
---Note: that its not it's not guaranteed you will get anything beyond the display ones.
---@param name string The name of the objective (not the display name)
---@return Objective|nil objective The objective or nil if it was not found
function _acp__Scoreboard_z.getObjective(name) end

---Gives you the display objective for that location
---Note: that its not it's not guaranteed you will get anything beyond the display ones.
---@return Objective[] objectives The objectives
function _acp__Scoreboard_z.getObjectives() end

---Gives you the display objective for that location
---Note: that its not it's not guaranteed you will get anything beyond the display ones.
---@return string[] objectives The objective names
function _acp__Scoreboard_z.getObjectiveNames() end

--Gets you the server scoreboard
---@return Scoreboard scoreboard The scoreboard
function server.scoreboard() end
