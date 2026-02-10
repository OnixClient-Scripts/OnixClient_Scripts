name = "Terminal"
description = "Terminal script for Minecraft using the games chat. (Not a real terminal, just lets you run commands in the chat from any screen.)"

function sendMessageToChat(message)
    client.execute("say " .. message)
end

function sendCommandToChat(command)
    client.execute("execute " .. command)
end

function sendOnixCommandToChat(command)
    client.execute(command)
end

isHudScreen = false

function render3d()
    isHudScreen = gui.screen() == "hud_screen" or gui.screen() == "chat_screen"
end

textbox = gui.newTextbox("", "Command:", 1024)
function postInit()
end

renderEverywhere = true
previousCommands = {}
currentCommandIndex = 0

terminalVisible = false
terminalAnimationStartTime = 0
terminalAnimationDuration = 250
terminalClosing = false
terminalTimeoutTime = 0

buttonVisible = true
buttonAnimationStartTime = 0
buttonAnimationDuration = 400
buttonSize = 20
buttonVisibleHeight = 5
buttonHovered = false
buttonHoverScale = 1.15
buttonHoverAnimation = 0
buttonHoverAnimationSpeed = 5
buttonPulse = 0
buttonPulseDir = 1
buttonPulseSpeed = 0.02
buttonLastFrame = os.clock()
lastHoverState = false

function easeOutBack(x)
    local c1 = 1.70158
    local c3 = c1 + 1

    return 1 + c3 * math.pow(x - 1, 3) + c1 * math.pow(x - 1, 2)
end

function easeInBack(x)
    local c1 = 1.70158
    local c3 = c1 + 1

    return c3 * x * x * x - c1 * x * x
end

function getTerminalAnimationProgress()
    local currentTime = os.clock() * 1000
    local elapsed = currentTime - terminalAnimationStartTime
    local progress = math.min(elapsed / terminalAnimationDuration, 1)

    if terminalClosing and elapsed >= terminalAnimationDuration and currentTime >= terminalTimeoutTime then
        terminalVisible = false
        terminalClosing = false

        showButton()
    end

    if terminalVisible then
        if terminalClosing then
            return 1 - easeInBack(progress)
        else
            return easeOutBack(progress)
        end
    else
        return 0
    end
end

function getButtonAnimationProgress()
    local currentTime = os.clock() * 1000
    local elapsed = currentTime - buttonAnimationStartTime
    local progress = math.min(elapsed / buttonAnimationDuration, 1)

    if buttonVisible then
        return easeOutBack(progress)
    else
        return 1 - easeInBack(progress)
    end
end

function getTerminalPosition()
    local screenWidth = gui.width()
    local screenHeight = gui.height()
    local terminalWidth = 200
    local terminalHeight = 20

    local targetY = screenHeight - terminalHeight - 10
    local hiddenY = screenHeight + 10

    local progress = getTerminalAnimationProgress()
    local currentY = hiddenY - (hiddenY - targetY) * progress

    return {
        x = (screenWidth - terminalWidth) / 2,
        y = currentY,
        w = terminalWidth,
        h = terminalHeight
    }
end

function getButtonPosition()
    local screenWidth = gui.width()
    local screenHeight = gui.height()

    return {
        x = (screenWidth - buttonSize) / 2,
        y = screenHeight - buttonVisibleHeight,
        w = buttonSize,
        h = buttonSize
    }
end

function isMouseOverButton()
    if not buttonVisible then return false end

    local btnPos = getButtonPosition()
    local mX, mY = gui.mousex(), gui.mousey()

    return mX >= btnPos.x and mX <= btnPos.x + btnPos.w and mY >= btnPos.y and mY <= btnPos.y + buttonSize
end

function showTerminal()
    terminalVisible = true
    terminalClosing = false
    terminalAnimationStartTime = os.clock() * 1000
    hideButton()
end

function hideTerminal()
    if terminalVisible and not terminalClosing then
        terminalClosing = true
        terminalAnimationStartTime = os.clock() * 1000
        terminalTimeoutTime = terminalAnimationStartTime + terminalAnimationDuration + 50
        textbox.focused = false
    end
end

function showButton()
    buttonVisible = true
    buttonAnimationStartTime = os.clock() * 1000
end

function hideButton()
    buttonVisible = false
    buttonAnimationStartTime = os.clock() * 1000
end

function toggleTerminal()
    if terminalVisible then
        hideTerminal()
    else
        showTerminal()
    end
end

function closeTerminal()
    hideTerminal()
end

function render2()
    if isHudScreen or textbox == nil then return end

    local now = os.clock()
    local delta = now - buttonLastFrame
    buttonLastFrame = now

    local currentHoverState = isMouseOverButton()

    if currentHoverState ~= lastHoverState then
        lastHoverState = currentHoverState
    end

    if currentHoverState then
        buttonHoverAnimation = math.min(1, buttonHoverAnimation + (buttonHoverAnimationSpeed * delta))
    else
        buttonHoverAnimation = math.max(0, buttonHoverAnimation - (buttonHoverAnimationSpeed * delta))
    end

    buttonPulse = buttonPulse + (buttonPulseSpeed * buttonPulseDir * delta * 60)
    if buttonPulse > 1 then
        buttonPulse = 1
        buttonPulseDir = -1
    elseif buttonPulse < 0 then
        buttonPulse = 0
        buttonPulseDir = 1
    end

    local pos = getTerminalPosition()

    if getTerminalAnimationProgress() > 0 then
        textbox:render(pos.x, pos.y, pos.w, pos.h)
    end

    local btnAnimProgress = getButtonAnimationProgress()

    if btnAnimProgress > 0 then
        local btnPos = getButtonPosition()

        local hoverEffectScale = 1 + ((buttonHoverScale - 1) * easeOutBack(buttonHoverAnimation))

        local btnScale = btnAnimProgress * hoverEffectScale

        local btnCenterX = btnPos.x + btnPos.w/2
        local btnCenterY = btnPos.y + btnPos.h/2
        local btnSizeAnimated = buttonSize * btnScale

        local animatedBtnX = btnCenterX - (btnSizeAnimated/2)
        local animatedBtnY = btnPos.y + buttonSize - btnSizeAnimated

        local hoverColorBoost = math.floor(20 * buttonHoverAnimation)
        local pulseInfluence = math.sin(now * 4) * 0.1
        local arrowBounce = math.sin(now * 4) * buttonHoverAnimation * 0.8

        gfx2.color(25 + hoverColorBoost, 25 + hoverColorBoost, 25 + hoverColorBoost, 200 * btnAnimProgress)
        gfx2.fillRoundRect(animatedBtnX, animatedBtnY, btnSizeAnimated, btnSizeAnimated, 5)

        local pulseAmount = 10 + (10 * buttonHoverAnimation)
        local pulseColor = math.floor(pulseAmount * (0.5 + pulseInfluence))
        gfx2.color(255 + pulseColor, 255 + pulseColor, 255 + pulseColor, 114.75 * btnAnimProgress)
        gfx2.drawRoundRect(animatedBtnX, animatedBtnY, btnSizeAnimated, btnSizeAnimated, 5, 0.5)

        gfx2.color( 25 + math.floor(10 * buttonHoverAnimation), 23 + math.floor(10 * buttonHoverAnimation), 22 + math.floor(10 * buttonHoverAnimation), 255 * btnAnimProgress)
        gfx2.fillTriangle( btnCenterX - 5 * btnScale, btnCenterY + (2 - arrowBounce) * btnScale, btnCenterX + 5 * btnScale, btnCenterY + (2 - arrowBounce) * btnScale, btnCenterX, btnCenterY + (-3 - arrowBounce) * btnScale)
    end
end

event.listen("MouseInput", function(button, down)
    if isHudScreen then return end

    if button == 1 and down then
        local mX, mY = gui.mousex(), gui.mousey()
        local pos = getTerminalPosition()

        if terminalVisible and mX >= pos.x and mX <= pos.x + pos.w and mY >= pos.y and mY <= pos.y + pos.h then
            textbox.focused = true
            return
        else
            textbox.focused = false
            if terminalVisible and not terminalClosing then
                hideTerminal()
            end
        end

        local btnPos = getButtonPosition()
        if buttonVisible and mX >= btnPos.x and mX <= btnPos.x + btnPos.w and mY >= btnPos.y and mY <= btnPos.y + buttonSize then
            toggleTerminal()
            gui.clickSound()
            return
        end
    end
end)

event.listen("KeyboardInput", function(key, down)
    if isHudScreen then return end
    if textbox.focused then
        if key == 13 and down == false then
            local command = textbox.text
            if command:sub(1, 1) == "/" then
                sendCommandToChat(command:sub(2))
            elseif command:sub(1, 1) == "." then
                sendOnixCommandToChat(command:sub(2))
            else
                sendMessageToChat(command)
            end
            table.insert(previousCommands, command)
            textbox.text = ""
            currentCommandIndex = 0
        end
        if key == 38 and down then
            if #previousCommands > 0 then
                if currentCommandIndex < #previousCommands then
                    currentCommandIndex = currentCommandIndex + 1
                end
                textbox.text = previousCommands[#previousCommands - currentCommandIndex + 1]
            end
        end
        if key == 40 and down then
            if currentCommandIndex > 0 then
                currentCommandIndex = currentCommandIndex - 1
                if currentCommandIndex == 0 then
                    textbox.text = ""
                else
                    textbox.text = previousCommands[#previousCommands - currentCommandIndex + 1]
                end
            end
        end
        return true
    end

    if key == 192 and down then
        toggleTerminal()
        return true
    end

    if key == 27 and down and terminalVisible and not terminalClosing then
        hideTerminal()
        return true
    end
end)