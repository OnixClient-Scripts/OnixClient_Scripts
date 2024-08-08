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

---Closes the current minecraft screen if it is not the hud as that would be problematic
function gui.closeNonHud() end

---Tells you if the hide hud game setting is enabled
---@return boolean hudHidden If the hud is hidden
function gui.hudHidden() end

---Plays the click sound (the one in minecraft when u clicc button)
function gui.clickSound() end

---Plays a sound on the ui (will not go away if you move)
---@param name string any minecraft sounds: https://www.digminecraft.com/lists/sound_list_pe.php
---@param volume number|nil The volume of the sound
---@param pitch number|nil The pitch of the sound
function gui.sound(name, volume, pitch) end

---Stops all sound that are playing
function gui.stopallsound() end


---Gets the user's theme
---@return Theme theme The user's theme
function gui.theme() end

---Gets the font in use right now
---@return Font font The current font
function gui.font() end

--- Creates a new textbox
---@param text string|nil The text in the textbox
---@param placeholder string|nil The placeholder text in the textbox
---@param maxLength integer|nil The maximum length of the textbox
---@return Textbox textbox The new textbox
function gui.newTextbox(text, placeholder, maxLength) end


---Shows a color picker (you can use the setting.value.finishedPicking to know when the user is done)
---@param setting Setting|nil The setting to show the color picker for, if none provided one will be created.
---@param positionX number|nil The center x position to open the color picker from, if not provided it will be 0
---@param positionY number|nil The center y position to open the color picker from, if not provided it will be 0
---@param yOffset number|nil The y distance between the position and the color picker, if not provided it will be 10
---@return Setting colorSetting The setting the user is currently picking
function gui.showColorPicker(setting, positionX, positionY, yOffset) end


---@class KeyPickingDialogData
---@field key integer The key picked by the user
---@field picked boolean If the user is done picking
---@field canceled boolean If the user canceled the picking (aka pressed escape)

---Shows a key picker (you can use the KeyPickingDialogData to get the result if not giving a setting)
---@param setting Setting|nil The setting to show the key picker for, if none provided the value will only be in the KeyPickingDialogData
---@return KeyPickingDialogData keyData The data of the key picking
function gui.showKeyPicker(setting) end

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


---@class Textbox
---@field text string The text in the textbox
---@field displayText string The display text in the textbox (readonly)
---@field placeholder string The placeholder text in the textbox
---@field number integer|number The number in the textbox (best to use with isNumeric)
---@field allowDecimal boolean If the textbox allows decimals (does not set isNumeric for you)
---@field isNumeric boolean If the textbox only allows numbers
---@field isHex boolean If the textbox allows hex numbers (does not set isNumeric for you)
---@field isPassword boolean If the textbox is a password field
---@field maxLength integer The maximum length of the textbox
---@field cursor integer The position of the cursor in the textbox
---@field focused boolean If the textbox is focused
---@field isEmpty boolean If the textbox is empty (readonly)
---@field new boolean If the text has changed since the last time you checked new, reading it will set it to false (readonly)
---@field confirmed boolean If the user pressed enter, reading it will set it to false (readonly)
---@field validity string|"valid"|"invalid"|"none" The validity of the textbox content
---@field hasSelection boolean If the textbox has a selection (readonly)
---@field selectionStart integer The start of the selection, check hasSelection first (readonly)
---@field selectionStop integer The end of the selection, check hasSelection first (readonly)
local __acp_Textbox__amongus_ = {}
---Sets the textbox text to ""
function __acp_Textbox__amongus_:clear() end
---Removes the active selection
function __acp_Textbox__amongus_:clearSelection() end
---Deletes the text of the selection aswell as the selection
function __acp_Textbox__amongus_:deleteSelection() end
--- Changes where the selection is
function __acp_Textbox__amongus_:setSelection(start, stop) end

--- Renders the textbox somewhere
---@param positionX number The x position of the textbox
---@param positionY number The y position of the textbox
---@param sizeX number The x size of the textbox
---@param sizeY number The y size of the textbox
---@param carret string|"normal"|"show"|"hide"|nil The carret visibility, normal is visible when focused, show is always visible, hide is never visible
---@param textColor ColorSetting|iColor|integer[]|Setting|nil The color of the text, if nil will be the theme.text
---@param backColor ColorSetting|iColor|integer[]|Setting|nil The color of the background, if nil will be the theme.windowBackground
---@param outlineColor ColorSetting|iColor|integer[]|Setting|nil The color of the outline, if nil will be the theme.outline
function __acp_Textbox__amongus_:render(positionX, positionY, sizeX, sizeY, carret, textColor, backColor, outlineColor) end
