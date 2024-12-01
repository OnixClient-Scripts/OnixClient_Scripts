---@meta

--[[]

---@class IntellisenseHelper
local __acp_IntellisenseHelper = {}

---Creates a new overload
---@return CommandOverload
function __acp_IntellisenseHelper:addOverload() end

--- Creates a new intellisense helper that can parse the input text
---@param inputText string The input text
---@return IntellisenseHelper intellisense The intellisense helper
function MakeIntellisenseHelper(inputText) end



---@class CommandOverload
---@field size integer The size of the input data
---@@field inputOffset integer How far it is from the start of the input
---@field input string The input data
local __acp_CommandOverload = {}

---Peeks the text of the input
---@param offset integer? The offset to peek at
---@param quantity integer? The quantity of text to peek
---@return string text The text at the offset
function __acp_CommandOverload:peek(offset, quantity) end


---Advances the input by a specified count
---@param count integer The number of characters to advance
---@return string text The advanced text
function __acp_CommandOverload:advance(count) end

---Checks if the input is whitespace or empty
---@param startPos integer The starting position to check
---@return boolean isWhitespaceOrEmpty True if the input is whitespace or empty
function __acp_CommandOverload:isWhitespaceOrEmpty(startPos) end

---Checks if the input is whitespace and not empty
---@param startPos integer The starting position to check
---@return boolean isWhitespaceAndNotEmpty True if the input is whitespace and not empty
function __acp_CommandOverload:isWhitespaceAndNotEmpty(startPos) end

---Adds a display parameter to the overload
---if parameterName is "" then typeName will be displayed alone
---@param parameterName string The name of the parameter
---@param typeName string The type of the parameter
---@param isOptional boolean If the parameter is optional
function __acp_CommandOverload:addDisplayParameter(parameterName, typeName, isOptional) end

---Adds a score to the overload
---The more score an overload gets the higher it will rank
---@param score integer The score to add
function __acp_CommandOverload:addScore(score) end

---Adds a tab option to the overload
---@param rawValue string The raw value of the tab option
---@param displayValue string? The display value of the tab option
---@param item Item? The item stack associated with the tab option
---@param score integer? The score of the tab option
---@param startPos integer? The starting position of the tab option
function __acp_CommandOverload:addTabOption(rawValue, displayValue, item, score, startPos) end

---Adds a tab option block to the overload
---@param rawValue string The raw value of the tab option block
---@param displayValue string? The display value of the tab option block
---@param block Block? The block associated with the tab option block
---@param score integer? The score of the tab option block
---@param startPos integer?% The starting position of the tab option block
function __acp_CommandOverload:addTabOptionBlock(rawValue, displayValue, block, score, startPos) end

---Matches an integer in the input
---@param parameterName string The name of the argument
---@param optional boolean? Whether the match is optional
---@return integer? value The matched integer or nil
function __acp_CommandOverload:matchInt(parameterName, optional) end

---Matches a float in the input
---@param parameterName string The name of the argument
---@param optional boolean? Whether the match is optional
---@return number? value The matched float or nil
function __acp_CommandOverload:matchFloat(parameterName, optional) end

---Matches a string in the input
---@param parameterName string The name of the argument
---@param optional boolean? Whether the match is optional
---@return string? value The matched string or nil
function __acp_CommandOverload:matchString(parameterName, optional) end

---Matches a boolean in the input
---@param parameterName string The name of the argument
---@param optional boolean? Whether the match is optional
---@return boolean? value The matched boolean or nil
function __acp_CommandOverload:matchBool(parameterName, optional) end

---Matches a block in the input
---@param parameterName string The name of the argument
---@param optional boolean? Whether the match is optional
---@return Block? block The matched block or nil
function __acp_CommandOverload:matchBlock(parameterName, optional) end

---Matches an item in the input
---@param parameterName string The name of the argument
---@param optional boolean? Whether the match is optional
---@return Item? item The matched item or nil
function __acp_CommandOverload:matchItem(parameterName, optional) end

---Matches the rest of the input
---@param parameterName string The name of the argument
---@param typeName string The replacement string
---@param optional boolean? Whether the match is optional
---@return string? value The matched rest or nil
function __acp_CommandOverload:matchRest(parameterName, typeName, optional) end

---Matches an enum in the input
---if parameterName is "" then typeName will be displayed alone
---@param parameterName string The name of the argument
---@param typeName string The replacement string
---@param options table The options for the enum
---@param optional boolean? Whether the match is optional
---@return string? value The matched enum or nil
function __acp_CommandOverload:matchEnum(parameterName, typeName, options, optional) end

---Matches a soft enum in the input, a soft enum accepts string values that are not amongst the options
---if parameterName is "" then typeName will be displayed alone
---@param parameterName string The name of the argument
---@param typeName string The replacement string
---@param options table The options for the soft enum
---@param optional boolean? Whether the match is optional
---@return string? value The matched soft enum or nil
function __acp_CommandOverload:matchSoftEnum(parameterName, typeName, options, optional) end

---Ends the overload
function __acp_CommandOverload:endOverload() end

]]
