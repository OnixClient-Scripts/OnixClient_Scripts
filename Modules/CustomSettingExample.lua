name="Custom Setting Example"
description="This is an example of a custom setting."

---Whatever number this function returns will be the height of the setting in the settings menu.
---You can use a lambda but to have documentation and more naming im putting it here.
---@return number
function CustomSettingType_getHeight()
    return 50
end

--- This function will be called for every setting that is of this type.
--- You can use gfx2 only in this function. For those same reason be careful how you access the game.
--- Using gfx will result in an immediate crash.
--- You can use a lambda but to have documentation and more naming im putting it here.
---@param setting Setting The setting that is being drawn.
---@param width number The width of the GUI area you have been given.
---@param height number The height of the GUI area you have been given.
---@param mouseX number The X position of the mouse relative to your setting.
---@param mouseY number The Y position of the mouse relative to your setting.
---@param didClick boolean Whether the mouse was clicked this frame.
---@param mouseButton integer The mouse button that was clicked. (1==lmb, 2==rmb, 3==mmb, 4==scroll, 5==back, 6==forward)
---@param lmbDown boolean Whether the left mouse button is down.
---@param rmbDown boolean Whether the right mouse button is down.
---@param mouseInside boolean Whether the mouse is inside your setting or not (useful when you have click things).
function CustomSettingType_render(setting, width, height, mouseX, mouseY, didClick, mouseButton, lmbDown, rmbDown, mouseInside)
    --if the mouse is among the setting
    if mouseInside then
        -- Set the color to red
        gfx2.color(255,0,0,255)

        --draw a ball where the mouse cursor is.
        gfx2.fillElipse(mouseX, mouseY, 5, 5);
    end

    -- Set the color to white
    gfx2.color(255,255,255,255)

    --x=0,y=0 will be top left of our setting
    -- setting.name is the name given in addCustom (the first parameter)
    -- setting.value is the value given in addCustom (the third parameter)
    -- you can change the setting.value as needed, you get an integer to help differenciate different instances if needed.
    gfx2.text(0, 0, setting.name .. ": " .. math.floor(setting.value) .. "." .. math.floor((setting.value - math.floor(setting.value)) * 100))

    --now lets do a terrible slider if we are a float value (you will need to register the override to see this)
    if setting.type == 3 then
        -- background color of the slider
        -- you can use gui.theme() to get the current theme's color to better integrate
        -- highlight is used as the background by most settings
        gfx2.color(gui.theme().highlight)
        gfx2.fillRoundRect(0, 10, width, 10, 3)

        -- this is bad because you would need to remember the setting you grabbed so that when you go out of the setting area you still drag the slider to the min/max
        if lmbDown and mouseInside then
            setting.value = (mouseX / width) * (setting.max - setting.min) + setting.min
        end

        -- this makes middle clicking the slider set it to the default value (what most onix settings do)
        if didClick and mouseButton == 3 and mouseInside then
            setting.value = setting.default
        end

        -- the slider's value color (the blue part)
        -- you can use gui.theme() to get the current theme's color to better integrate
        -- enabled is the accent color pretty much
        gfx2.color(gui.theme().enabled)
        gfx2.fillRoundRect(0, 10, width * (setting.value - setting.min) / (setting.max - setting.min), 10, 3)
    end
end

-- Registering our custom renderer!
-- the `CustomSettingTypeID` it returns is the ID of the custom setting type.
-- You need it to create an instance of this custom setting
CustomSettingTypeID = client.settings.registerCustomRenderer(CustomSettingType_getHeight, CustomSettingType_render)


-- if you wanted to replace the default renderer for an existing setting type you can do this:
-- note: this should be float, the ids should not change but the client's custom setting order is not guaranteed, non custom ones should be fine.
-- client.settings.registerCustomRendererOverride(3, CustomSettingType_getHeight, CustomSettingType_render)

-- Here we just add it to the onix ui like any other setting, just need to tell it which type.
-- We are giving it the value 69 as a default value, you dont need to use the setting's things if you dont want to.
-- but if you wanted to support multiple instances of this setting you could use the setting.value to differenciate them.
client.settings.addCustom('Custom Setting', CustomSettingTypeID, 69)
