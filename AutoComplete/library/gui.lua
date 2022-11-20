---@meta


---@class gui
gui = {}


---The width of the screen
---@return number width The width of the screen
function gui.width() end
---The height of the screen
---@return number height The height of the screen
function gui.height() end
---The minecraft guiscale
---@return number scale The minecraft guiscale
function gui.scale() end
---If the user move the mouse it will affect the game or the ui (true = ui)
---@return boolean mouseGrabbed Will be false if in the world
function gui.mouseGrabbed() end

---Set the mouseGrabbed state
---@param grabbed boolean true will not allow the player to interact with the world
function gui.setGrab(grabbed) end

---The position of the mouse on the X axis (left to right)
---@return number mouseX The position of the mouse on the X axis
function gui.mousex() end
---The position of the mouse on the Y axis (left to right)
---@return number mouseY The position of the mouse on the Y axis
function gui.mousey() end

---Opens a client screen, examples:
---"HudEditor"
---"ModuleEditor"
---"CrosshairPainter"
---"ThemeEditor"
---@param name string | "\"HudEditor\"" | "\"ModuleEditor\"" | "\"CrosshairPainter\"" | "\"ThemeEditor\""
---@return boolean screenShowed If the screen was showed
function gui.showScreen(name) end

---Gives you the name of the current minecraft screen
---@return string screenName The name of the current screen
function gui.screen() end

---Plays the click sound (the one in minecraft when u clicc button)
---Will not work on 1.18.30+
function gui.clickSound() end

---Plays a sound on the ui (will not go away if you move)
---Will not work on 1.18.30+
---@param name string any minecraft sounds: https://www.digminecraft.com/lists/sound_list_pe.php
function gui.sound(name) end

---Stops all sound that are playing
---Will not work on 1.18.30+
function gui.stopallsound() end


---Gets the user's theme
---@return Theme theme The user's theme
function gui.theme() end

---Gets the font in use right now
---@return Font font The current font
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
---@return number widthOfText The width of the input text
---@diagnostic disable-next-line: duplicate-set-field
function _acp_font.width(text) end

---Returns the size of the text
---@param text string The text to get the size of
---@param scale number The scale
---@return number widthOfText The width of the input text
---@diagnostic disable-next-line: duplicate-set-field
function _acp_font.width(text, scale) end
