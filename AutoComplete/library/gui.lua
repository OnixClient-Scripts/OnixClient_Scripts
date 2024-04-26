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
---The position of the mouse on the Y axis (top to bottom)
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
---@field text ColorSetting color of the text on the ui
---@field blocked ColorSetting blocked content in that color
---@field enabled ColorSetting color of enabled stuff, can be used as accent color
---@field disabled ColorSetting color of disabled stuff
---@field highlight ColorSetting the highlight color on top of the elements
---@field outline ColorSetting the color of the outline of ui elements
---@field windowBackground ColorSetting the background color
---@field button ColorSetting most buttons use "enabled" but some use darkbutton's color instead
---@field scrollbar ColorSetting color of the scrollbar
local _acp_theme = {}



---@class Font
---@field isMinecrafttia boolean Is the minecraft blocky font in use
---@field height number the height of one char. For gfx2/render2 use gfx2.textSize
---@field wrap number the height of one line. For gfx2/render2 use gfx2.textSize
local _acp_font = {}

---Returns the size of the text
---For gfx2/render2 use gfx2.textSize
---@param text string The text to get the size of
---@return number widthOfText The width of the input text
---@diagnostic disable-next-line: duplicate-set-field
function _acp_font.width(text) end

---Returns the size of the text with scale
---For gfx2/render2 use gfx2.textSize
---@param text string The text to get the size of
---@param scale number The scale (2 means 2x as large)
---@return number widthOfText The width of the input text
---@diagnostic disable-next-line: duplicate-set-field
function _acp_font.width(text, scale) end
