--[[
    
      ----------------------------------
    <          Coded by tenzin           >
      ----------------------------------


    DOCUMENTATION:

    - log(text: string, colour: string, format: string)
        - log#text
            The text to be logged
        - log#colour
            The colour to be logged, one of the following values:
                black, dark_blue, green, cyan, dark_red, purple, gold, light_grey, grey
                blue, light_green, light_blue, red, pink, yellow, white, random
        - log#format
            The text to be logged, one of the following values:
                error, warning, info, success, debug or nil
            A value of "nil" will not return a prefix, and will log without a prefix.
]]

colours = {
    black = "§0",
    dark_blue = "§1",
    green = "§2",
    cyan = "§3",
    dark_red = "§4",
    purple = "§5",
    gold = "§6",
    light_grey = "§7",
    grey = "§8",
    blue = "§9",
    ocean_blue = "§t",
    light_purple = "§u",
    light_green = "§a",
    lighter_grey = "§i",
    light_orange = "§p",
    dark_yellow = "§g",
    red_white = "§h",
    dark_grey = "§j",
    brown = "§n",
    deep_red = "§m",
    light_cyan = "§s",
    mid_green = "§q",
    light_blue = "§b",
    red = "§c",
    pink = "§d",
    yellow = "§e",
    white = "§f",
    random = "§k",
}

--- Allows you to log to the chat with a colour and format
--- @param text string The text to log
--- @param colour string The colour to log the text in
--- @param format string The format to log the text in
function log(text, colour, format)
    if type(text) == "table" then
        text = tableToJson(text)
    elseif type(text) == "boolean" then
        text = text and "true" or "false"
    elseif type(text) == "nil" then
        text = "nil"
    end
    if colour == nil then
        formatted = handleFormat(format, text)
        print(formatted .. colours.white .. text)
    else 
        if colours[colour] == nil then
            print(handleFormat("error") .. "The developer has not specificed a colour that is in the colours table. Please contact them to fix this error.")
        else 
            formatted = handleFormat(format, text)
            print(formatted .. colours[colour] .. text)
        end
    end
end

function handleFormat(format)
    if format == nil then
        return ""
    elseif format == "info" then
        return colours.light_blue .. "[INFO] "
    elseif format == "success" then
        return colours.green .. "[SUCCESS] "
    elseif format == "warning" then
        return colours.yellow .. "[WARNING] "
    elseif format == "error" then
        return colours.red .. "[ERROR] "
    elseif format == "debug" then
        return colours.purple .. "[DEBUG] "
    end
end
