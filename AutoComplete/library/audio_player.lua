---@meta

---@class AudioPlayer
---@field volume number The volume of the sound, from 0 to 100, default 100 (read/write)
---@field muted boolean Whether the sound is muted or not (read/write)
---@field looping boolean Whether the sound is looping or not (play again when finished) (read/write)
---@field position integer The position of the sound in seconds (read/write)
---@field status string|"opening"|"no_source"|"playing"|"paused"|"stopped"|"buffering" The status of the sound (read only)
---@field duration integer The duration of the sound in seconds (read only)
---@field isFinished boolean Whether the sound has finished playing or not (read only)
---@field isPlaying boolean Whether the sound is playing or not (read only)
---@field isPaused boolean Whether the sound is paused or not (read only)
---@field isStopped boolean Whether the sound is stopped or not (read only)
local ___acp_AudioPlayer = {}

---Plays a sound
---Note: These functions do not change the status immediately
---@param url_or_filepath string The url or filepath of the sound to play
---@return boolean
function ___acp_AudioPlayer:play(url_or_filepath) end

---Resumes a sound
---Note: These functions do not change the status immediately
---@return boolean
function ___acp_AudioPlayer:play() end

---Pauses the sound
---Note: These functions do not change the status immediately
function ___acp_AudioPlayer:pause() end

---Stops the sound (pause & go back to start)
---Note: These functions do not change the status immediately
function ___acp_AudioPlayer:stop() end

---Toggles the sound (play/pause)
---Note: These functions do not change the status immediately
function ___acp_AudioPlayer:toggle() end

---Restarts the sound from the start
---Note: These functions do not change the status immediately
function ___acp_AudioPlayer:restart() end

---Resumes the sound
---Note: These functions do not change the status immediately
function ___acp_AudioPlayer:resume() end

---Creates a new Audio Player
---@return AudioPlayer sound The new Audio Player
function AudioPlayer() end
