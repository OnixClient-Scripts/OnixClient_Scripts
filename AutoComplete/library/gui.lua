---@meta

---@class gui
gui = {}


---The width of the screen
---@return number
function gui.width() end
---The height of the screen
---@return number
function gui.height() end
---The minecraft guiscale
---@return number
function gui.scale() end
---If the user move the mouse it will affect the game or the ui (true = ui)
---@return boolean mouseGrabbed
function gui.mouseGrabbed() end

---Set the mouseGrabbed state
---@param grabbed boolean true will not allow the player to interact with the world
---@return nil
function gui.setGrab(grabbed) end

---The position of the mouse on the X axis (left to right)
---@return number mouseX
function gui.mousex() end
---The position of the mouse on the Y axis (left to right)
---@return number mouseY
function gui.mousey() end

---Opens a client screen, exemple "HudEditor"
---@param name string | "\"HudEditor\"" | "\"ModuleEditor\"" | "\"CrosshairPainter\"" | "\"ThemeEditor\""
---@return boolean screenShowed
function gui.showScreen(name) end

---Plays the click sound (the one in minecraft when u clicc button)
---@return nil
function gui.clickSound() end

---Plays a sound on the ui (will not go away if you move)
---@param name string [any minecraft sounds](https://www.digminecraft.com/lists/sound_list_pe.php)
---@return nil
function gui.sound(name) end

---Stops all sound that are playing
---@return nil
function gui.stopallsound() end

---Stops all sound that are playing
---@return nil
function gui.stopallsound() end

---Stops all sound that are playing
---@return Theme
function gui.theme() end

---Stops all sound that are playing
---@return Font
function gui.font() end


---@class iColor
---@field r integer
---@field g integer
---@field b integer
---@field a integer
local iColor = {}

---@class Theme
---@field back iColor the background color, whats below everything
---@field moduleOutline iColor the outline of the visual modules in the hud editor
---@field moduleOverlay iColor the overlay on top of the visual modules in the hud editor
---@field darkbutton iColor most buttons use "enabled" but some use darkbutton's color instead
---@field text iColor color of the text on the ui
---@field largeArea iColor color of the body of a window/pannel
---@field titlebar iColor color of the titlebar
---@field disabled iColor color of disabled stuff
---@field enabled iColor color of enabled stuff, can be used as accent color
---@field blocked iColor blocked content in that color
local _acp_theme = {}



---@class Font
---@field isMinecrafttia boolean Is the minecraft blocky font in use
---@field height number the height of one char
---@field wrap number the height of one line
local _acp_font = {}

---Returns the size of the text
---@param text string The text to get the size of
---@return number widthOfText
---@diagnostic disable-next-line: duplicate-set-field
function _acp_font.width(text) end

---Returns the size of the text
---@param text string The text to get the size of
---@param scale number The scale
---@return number widthOfText
---@diagnostic disable-next-line: duplicate-set-field
function _acp_font.width(text, scale) end






