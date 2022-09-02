local elements = {}
local mouseX, mouseY, keyPressed, uiOpened, cursorShow, shiftHeld
local time = 0

importLib("keyconverter.lua")

local keyToAction = {}

for k, v in pairs(string.split("65=A,32= ,66=B,0x43=C,67=D,69=E,70=F,71=G,72=H,73=I,74=J,75=K,76=L,77=M,78=N,79=O,80=P,81=Q,82=R,83=S,84=T,85=U,86=V,87=W,88=X,89=Y,90=Z,48=0,49=1,50=2,51=3,52=4,53=5,54=6,55=7,56=8,57=9", ",")) do
    local splitted = string.split(v, "=")
    keyToAction[splitted[1]] = splitted[2]
end

function gfx.setUiKey(key)
    openKey = key
    client.settings.addKeybind("ui key", "openKey")
end

function renderUi(dt)
    if not uiOpened then return end
    time = time + dt
    if time % 2 >= 1.5 or (time%2 >=0.5 and time%2 <1) then
        cursorShow = true
    else
        cursorShow = false
    end
    mouseX = gui.mousex()
    mouseY = gui.mousey()
    if not gui.mouseGrabbed() then
        uiOpened = false
    end
    for _, thing in pairs(elements) do
        thing.render()
    end
    if keyPressed and uiOpened then
        for _, element in pairs(elements) do
            if element.type == "slider" then element.isClicked(keyPressed) end
        end
    end
end

function updateUiMouse(button, down)
    local gotClicked
    if down and uiOpened then
        keyPressed = button
        mouseX = gui.mousex()
        mouseY = gui.mousey()
        for _, element in pairs(elements) do
            if element.isClicked(button) then gotClicked = true end
        end
        if not gotClicked then
            uiOpened = false
            gui.setGrab(uiOpened)
        end
        return true
    else
        keyPressed = nil
        for _, element in pairs(elements) do
            if element.type ~= "text" then element.pressed = false end
        end
    end
end

function updateUiKey(key, down)
    if key == 16 then shiftHeld = down end
    if down then
        if uiOpened then
            local textOpened
            for _, element in pairs(elements) do
                if element.type == "text" and element.pressed then
                    textOpened = true
                    local result = keyToAction[tostring(key)]
                    if result then
                        if shiftHeld then
                            element.value = element.value .. result
                        else
                            element.value = element.value .. string.lower(result)
                        end
                    else
                        if key == 8 then element.value = string.sub(element.value, 1, -2) end
                        if key == 13 then element.pressed = false end
                        if key == 27 then element.pressed = false end
                    end
                    -- if keytostr(key) == "BackSpace" then
                    --     element.value = string.sub(element.value, 1, -2)
                    -- else
                    --     element.value = element.value .. keytostr(key)
                    -- end
                end
            end
            if not textOpened and key == 27 then 
                uiOpened = false
                gui.setGrab(uiOpened)
            end
            return true
        elseif key == openKey then
            uiOpened = not gui.mouseGrabbed()
            gui.setGrab(uiOpened)
            return true
        end
    end
end

function getElement(filter)
    local default = { type = nil, value = nil, display = nil, pressed = nil }
    for k, v in pairs(filter) do
        default[k] = v
    end
    local results = {}
    for _, element in pairs(elements) do
        local found = true
        for k, v in pairs(default) do
            if v ~= nil and element[k] ~= v then found = false end
            table.insert(results, element)
        end
    end
    return results
end

function fitTextEnd(text, size)
    while gui.font().width(text) > size do
        text = string.sub(text, 2, -1)
    end
    return text
end

function fitTextStart(text, size)
    while gui.font().width(text) > size do
        text = string.sub(text, 1, -2)
    end
    return text
end

---@param x number --X pos
---@param y number --Y pos
---@param sx number --Size x
---@param sy number --Size y
---@param color ColorSetting --Color
---@param text string --Text displayed on the button
---@param toExecuteLeft fun():nil --Called when left click
---@param toExecuteRight fun():nil --Called when right click
function gfx.createButton(x, y, sx, sy, color, text, toExecuteLeft, toExecuteRight)
    if not color then color = {r=0, g=144, b=194, a=255} end
    if not text then text = "" end
    local button = {
        x=x,
        y=y,
        sx=sx,
        sy=sy,
        color=color,
        value=text,
        pressed=false,
        execute={toExecuteLeft, toExecuteRight},
        type = "button",
        display=true
    }
    local function isHovered()
        return button.display and mouseX >= button.x and mouseX <= button.x+button.sx and mouseY >= button.y and mouseY <= button.y+button.sy
    end
    button.isHovered = isHovered
    local function isClicked(mouseB)
        if not button.display then return end
        button.pressed = button.isHovered()
        if button.pressed then
            if button.execute[mouseB] then
                button.execute[mouseB]()
            else
                button.pressed=false
            end
        end
        return button.isHovered()
    end
    button.isClicked=isClicked
    local function render()
        if not button.display then return end
        if button.pressed then
            gfx.color(button.color.r/2, button.color.g/2, button.color.b/2, button.color.a)
        elseif button.isHovered() then
            gfx.color(button.color.r/1.25, button.color.g/1.25, button.color.b/1.25, button.color.a)
        else
            gfx.color(button.color.r, button.color.g, button.color.b, button.color.a)
        end
        gfx.rect(button.x, button.y, button.sx, button.sy)
        gfx.color(255, 255, 255)
        -- local displayedText = fitTextEnd(button.value, button.sx - 2)
        local textSize = (button.sx - 4) / gui.font().width(button.value)
        if textSize > 1 then
            textSize = 1
        end
        gfx.text(button.x + button.sx/2 - gui.font().width(button.value, textSize)/2, button.y + button.sy/2 - gui.font().height/2, button.value, textSize)
    end
    button.render=render
    table.insert(elements, button)
    return button
end

---@param x number --X pos
---@param y number --Y pos
---@param width number --Width
---@param size number --Size
---@param min number --Minimum value
---@param max number --Maximum value
---@param default number --Default value
---@param orientation boolean --Wether it is horizontal or vertical
---@param color ColorSetting --Color
function gfx.createSlider(x, y, width, size, min, max, default, orientation, color)
    if not color then color = {r=0, g=144, b=194, a=255} end
    if orientation == nil then orientation = true end
    local slider = {
        x = x,
        y = y,
        width = width,
        size = size,
        color = color,
        orientation = orientation,
        min = min,
        max = max,
        default = default,
        value = default,
        pressed = false,
        type="slider",
        display=true
    }
    local function isHovered()
        if slider.orientation then
            return slider.display and mouseX >= slider.x and mouseX <= slider.x + slider.size and mouseY >= slider.y and mouseY <= slider.y + slider.width
        else
            return slider.display and mouseX >= slider.x and mouseX <= slider.x + slider.width and mouseY >= slider.y and mouseY <= slider.y + slider.size
        end
    end
    slider.isHovered = isHovered
    local function render()
        if not slider.display then return end
        if slider.isHovered() then
            gfx.color(slider.color.r/1.25, slider.color.g/1.25, slider.color.b/1.25, slider.color.a)
        else
            gfx.color(slider.color.r, slider.color.g, slider.color.b, slider.color.a)
        end
        if slider.orientation then
            gfx.rect(slider.x, slider.y+slider.width/4, slider.size, slider.width/2)
            gfx.rect((slider.value-slider.min)/(slider.max-slider.min)*slider.size+slider.x, slider.y, 1, slider.width)
        else
            gfx.rect(slider.x+slider.width/4, slider.y, slider.width/2, slider.size)
            gfx.rect(slider.x, (slider.value-slider.min)/(slider.max-slider.min)*slider.size+slider.y, slider.width, 1)
        end
    end
    slider.render = render
    local function isClicked(mouseB)
        if not slider.display then return end
        slider.pressed = slider.isHovered()
        if slider.orientation then
            if slider.pressed then
                if mouseB == 1 then
                    slider.value = (slider.max-slider.min)*(mouseX-slider.x)/slider.size+slider.min
                elseif mouseB == 2 then
                    slider.value = slider.default
                end
            end
        else
            if slider.pressed then
                if mouseB == 1 then
                    slider.value = (slider.max-slider.min)*(mouseY-slider.y)/slider.size+slider.min
                elseif mouseB == 2 then
                    slider.value = slider.default
                end
            end
        end
        return slider.pressed
    end
    slider.isClicked = isClicked
    local function getVal()
        return slider.value
    end
    slider.getVal=getVal
    table.insert(elements, slider)
    return slider
end

---@param x number --X pos
---@param y number --Y pos
---@param sx number --Width
---@param sy number --height
---@param color ColorSetting --Color
---@param default string --default text
function gfx.createTextArea(x, y, sx, sy, color, default)
    if not color then color = {r=0, g=0, b=0, a=255} end
    if not default then default = "" end
    local textArea = {
        x = x,
        y = y,
        sx = sx,
        sy = sy,
        color = color,
        default = default,
        value = default,
        pressed = false,
        type="text",
        display=true
    }
    local function isHovered()
        return textArea.display and mouseX >= textArea.x and mouseX <= textArea.x + textArea.sx and mouseY >= textArea.y and mouseY <= textArea.y + textArea.sy
    end
    textArea.isHovered = isHovered
    local function render()
        if not textArea.display then return end
        gfx.color(textArea.color.r, textArea.color.g, textArea.color.b, textArea.color.a)
        -- gfx.roundRect(textArea.x, textArea.y, textArea.sx, textArea.sy, 5, 5)
        -- if textArea.pressed then
        --     gfx.color(200, 200, 200)
        -- else
        --     gfx.color(255, 255, 255)
        -- end
        -- gfx.roundRect(textArea.x + 1, textArea.y + 1, textArea.sx - 2, textArea.sy - 2, 4, 5)
        gfx.rect(textArea.x, textArea.y, textArea.sx, textArea.sy)
        if textArea.pressed then
            gfx.color(200, 200, 200)
        elseif textArea.isHovered() then
            gfx.color(240, 240, 240)
        else
            gfx.color(255, 255, 255)
        end
        gfx.rect(textArea.x + 1, textArea.y + 1, textArea.sx - 2, textArea.sy - 2)
        gfx.color(textArea.color.r, textArea.color.g, textArea.color.b, textArea.color.a)
        local displayedText = fitTextStart(textArea.value, textArea.sx - 7)
        if textArea.pressed then
            displayedText = fitTextEnd(textArea.value, textArea.sx - 7)
            if cursorShow then gfx.rect(textArea.x + textArea.sx/2 + gui.font().width(displayedText)/2 + 1, textArea.y + textArea.sy/2 - gui.font().height/2, 1, gui.font().height) end
        end
        gfx.text(textArea.x + textArea.sx/2 - gui.font().width(displayedText)/2, textArea.y + textArea.sy/2 - gui.font().height/2, displayedText)
    end
    textArea.render = render
    local function isClicked(mouseB)
        if not textArea.display then return end
        if textArea.isHovered() then
            if mouseB == 1 then textArea.pressed = true else textArea.pressed = false end
            if mouseB == 2 then textArea.value = textArea.default end
            return true
        end
        textArea.pressed = false
    end
    textArea.isClicked = isClicked
    local function getVal()
        return textArea.value
    end
    textArea.getVal=getVal
    table.insert(elements, textArea)
    return textArea
end

---@param x number --X pos
---@param y number --Y pos
---@param sx number? --Width
---@param sy number? --height
---@param color ColorSetting --Color
function gfx.createSwitch(x, y, sx, sy, color)
    if not color then color = {r=0, g=144, b=194, a=255} end
    if not sx then sx = 40 end
    if not sy then sy = 20 end
    local switch = {
        x = x,
        y = y,
        sx = sx,
        sy = sy,
        color = color,
        value = false,
        display = true,
        pressed = false
    }
    local function isHovered()
        return switch.display and mouseX >= switch.x and mouseX <= switch.x + switch.sx and mouseY >= switch.y and mouseY <= switch.y + switch.sy
    end
    switch.isHovered = isHovered
    local function render()
        if not switch.display then return end
        if switch.pressed then
            gfx.color(switch.color.r / 2, switch.color.g / 2, switch.color.b / 2, switch.color.a)
        elseif switch.isHovered() then
            gfx.color(switch.color.r / 1.25, switch.color.g / 1.25, switch.color.b / 1.25, switch.color.a)
        else
            gfx.color(switch.color.r, switch.color.g, switch.color.b, switch.color.a)
        end
        gfx.roundRect(switch.x, switch.y, switch.sx, switch.sy, sy / 2, 5)
        gfx.color(255, 255, 255)
        if switch.value then
            gfx.circle(switch.x + switch.sx - switch.sy/2-(switch.sy-4) / 2.5, switch.y+switch.sy/2-(switch.sy-4) / 2.5, (switch.sy-4) / 1.25, 50)
        else
            gfx.circle(switch.x+switch.sy/2-(switch.sy-4) / 2.5, switch.y+switch.sy/2-(switch.sy-4) / 2.5, (switch.sy-4) / 1.25, 50)
        end
    end
    switch.render = render
    local function isClicked(mB)
        if not switch.display then return end
        if switch.isHovered() then
            switch.pressed = true
            switch.value = not switch.value
            return true
        end
    end
    switch.isClicked = isClicked
    table.insert(elements, switch)
    return switch
end


