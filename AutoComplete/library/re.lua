---@meta

---@class re
re = {}


---Matches the string with the pattern.
---@param pattern string The pattern to match. you can use [[]] instead of "" to escape special characters.
---@param str string The string to match.
---@param allowPartial boolean|nil If true, the pattern will be allowed to not fully match.
---@return string[]|nil matches The matches found in the string, otherwise nil.
function re.match(pattern, str, allowPartial) end


---Finds if a pattern can be fully matched in a string
---@param pattern string The pattern to match. you can use [[]] instead of "" to escape special characters.
---@param str string The string to match.
---@return boolean matched If the pattern can be fully matched in the string.
function re.find(pattern, str) end


---Replaces all matches of a pattern in a string with a replacement.
---@param pattern string The pattern to match. you can use [[]] instead of "" to escape special characters.
---@param str string The string to match.
---@param replacement string The replacement string. (use \1, \2, etc. to insert the matches, \\1 to just type \1) with "" you will need to use \\ instead of \.
---@return string replaced The string with the replacements.
function re.replace(pattern, str, replacement) end