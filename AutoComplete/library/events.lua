---@meta


---@class event
event = {}


---@class ModalFormRequestCustomFormContentLabel
---@field text string

---@class ModalFormRequestCustomFormContentInput
---@field text string
---@field placeholder string
---@field default string

---@class ModalFormRequestCustomFormContentDropdown
---@field text string
---@field options string[]
---@field default integer

---@class ModalFormRequestCustomFormContentSlider
---@field text string
---@field min integer
---@field max integer
---@field value integer

---@class ModalFormRequestCustomFormContentStepSlider
---@field text string
---@field steps string[]
---@field default integer

---@class ModalFormRequestCustomFormContentToggle
---@field text string
---@field default boolean

---@class ModalFormRequestCustomFormContent
---@field type string|"label"|"input"|"dropdown"|"slider"|"step_slider"|"toggle"
---@field label ModalFormRequestCustomFormContentLabel
---@field input ModalFormRequestCustomFormContentInput
---@field dropdown ModalFormRequestCustomFormContentDropdown
---@field slider ModalFormRequestCustomFormContentSlider
---@field stepSlider ModalFormRequestCustomFormContentStepSlider
---@field toggle ModalFormRequestCustomFormContentToggle




---@class ModalFormRequestCustomForm
---@field title string
---@field content ModalFormRequestCustomFormContent[]

---@class ModalFormRequestModal
---@field title string
---@field content string
---@field button1 string
---@field button2 string

---@class ModalFormRequestFormImage
---@field type string|"path"|"url"
---@field data string

---@class ModalFormRequestFormButton
---@field text string
---@field image ModalFormRequestFormImage|nil

---@class ModalFormRequestForm
---@field title string
---@field content string
---@field buttons ModalFormRequestFormButton[]



---@class ModalFormRequest
---@field type string|"custom_form"|"form"|"modal"
---@field customForm ModalFormRequestCustomForm|nil
---@field form ModalFormRequestForm|nil
---@field modal ModalFormRequestModal|nil


---@class ModalFormReplyer_CustomForm
---@field canReply boolean Whether the form can be replied to, false when already replied or event was not canceled
local _acp__ModalFormReplyer_CustomForm_ = {}
---Sets the value of a control in the custom form, invalid values will result in errors
---@param index integer The index of the control to reply to
---@param value string|integer|boolean|nil The value to reply with
function _acp__ModalFormReplyer_CustomForm_:replyTo(index, value) end
---Sends the form
function _acp__ModalFormReplyer_CustomForm_:reply() end
---Closes the form without replying
function _acp__ModalFormReplyer_CustomForm_:cancel() end

---@class ModalFormReplyer_Form
---@field canReply boolean Whether the form can be replied to, false when already replied or event was not canceled
local _acp__ModalFormReplyer_Form_ = {}
---Clicks the button at the specified index
---@param index integer The index of the button to click
function _acp__ModalFormReplyer_Form_:reply(index) end
---Closes the form without clicking anything
function _acp__ModalFormReplyer_Form_:cancel() end

---@class ModalFormReplyer_Modal
---@field canReply boolean Whether the form can be replied to, false when already replied or event was not canceled
local _acp__ModalFormReplyer_Modal_ = {}
---Clicks the button 1 or two
---@param isButton1 boolean Whether to click button 1 or 2
function _acp__ModalFormReplyer_Modal_:reply(isButton1) end
---Closes the form without clicking anything
function _acp__ModalFormReplyer_Modal_:cancel() end

---@class ModalFormReplyer
---@field customForm ModalFormReplyer_CustomForm|nil
---@field form ModalFormReplyer_Form|nil
---@field modal ModalFormReplyer_Modal|nil




---Binds an event to a function
---Here are the events you can listen to
---This will be called everytime the user presses a key.
---The value of the different keys can be found there
---https://learn.microsoft.com/en-us/windows/win32/inputdev/virtual-key-codes
---You can cancel this event by returning true (and the game will have no clue it ever happened)
---event.listen("KeyboardInput", function(key, down)
---    
---end)
---
---This will be called everytime the user clicks a mouse button.
---button values:
---1 == Left Click
---2 == Right Click
---3 == Middle Click
---4 == Mouse Scroll
---You can cancel this event by returning true (and the game will have no clue it ever happened)
---event.listen("MouseInput", function(button, down)
---    
---end)
---
---This will be called everytime a chat message is added to the chat
---The username will most likely only be filled for whisper/chat message
---Here are the types of messages
---0 == Raw
---1 == Chat
---2 == Translate
---3 == Popup
---4 == JukeboxPopup
---5 == Tip
---6 == SystemMessage
---7 == Whisper
---8 == Announcement
---9 == TextObject
---You can cancel this event by returning true and it won't add it to the chat
---event.listen("ChatMessageAdded", function(message, username, type, xuid)
---    
---end)
---This will be called everytime a chat message is requested to be sent
---You can cancel this event by returning true and it won't send the message
---You can modify the message by returning true and client.execute("say " .. message)
---event.listen("ChatMessageRequest", function(message)
---
---end)
---
---This will get called everytime any script calls "sendLocalData"
---Generally you want to filter them to make sure it is the one you want
---(Before actually trying to read the content)
---event.listen("LocalDataReceived", function(uuid, content)
---
---end)
---
---This will be called everytime the script config is saved
---You can use it to save a lua table (basic tytpes only: integer, number, string, table)
---return the table you wish to save
---event.listen("ConfigurationSaved", function()
---    local data = {}
---    
---    return data
---end)
---
---This will be called everytime the script config is loaded
---data will be lua table you returned at the "ConfigurationSaved" event
---event.listen("ConfigurationLoaded", function(data)
---    
---end)
---
---This will be called every server tick (~20 times per seconds)
---You can do server things in there like getting serverside blockActor
---event.listen("LocalServerUpdate", function()
---    
---end)
---
---This will be called every client tick (~20 times per second)
---event.listen("Tick", function()
---
---end)
---
---This will be called when a subtitle changes
---titleType can be the following: "clear", "reset", "title", "subtitle", "actionbar", "titleraw", "subtitleraw", "actionbarraw"
---event.listen("TitleChanged", function(text, titleType)
---    
---end)
---@param eventName string | '"KeyboardInput", function(key, down)\n\t\nend' | '"MouseInput", function(button, down)\n\t\nend' | '"ChatMessageAdded", function(message, username, type, xuid)\n\t\nend' | '"ChatMessageRequest", function(message)\n\t\nend' | '"Tick", function()\n\t\nend' | '"LocalDataReceived", function(uuid, content)\n\t\nend' | '"ConfigurationSaved", function()\n\tlocal data = {}\n\t\n\treturn data\nend' | '"ConfigurationLoaded", function(data)\n\t\nend' | '"LocalServerUpdate", function()\n\t\nend' | '"BlockChanged", function(x, y, z, newBlock, oldBlock)\n\t\nend' | '"TitleChanged", function(text, titleType)\n\t\nend'|'"InventoryTick", function()\n\t\nend'|'"ModalRequested", function (ARG1, ARG2)\n\t--use these (autocomplete)\n\t---@type ModalFormRequest\n\tlocal request = ARG1\n\t---@type ModalFormReplyer\n\tlocal response = ARG2\n\t\nend' Name of the event to listen to
---@param handler function Function that will handle the event
---@return nil
function event.listen(eventName, handler) end
