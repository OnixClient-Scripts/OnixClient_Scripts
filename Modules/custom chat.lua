name="custom chat"
description = "Custom chat by MCBE Craft"

--[[
    custom chat by MCBE Craft

    TODO:
    -(done)full keyboard support
    -(done)execute commands
    -(done)selection
    -(done)up/down arrow
    -(done)hold keys
    -(ok-ish)emoji
    -(to fix)messages go back to next line
]]

--chat display
positionX = 50
positionY = 200
sizeY = 100

--keybind
client.settings.addAir(5)
chatKey = 84 -- t key
client.settings.addKeybind("Chat key", "chatKey")

--chat prefix
client.settings.addAir(5)
dotKey = 190 -- . key
client.settings.addKeybind("Client command prefix", "dotKey")

--color background
client.settings.addAir(5)
backgroundColor = {1, 1, 1, 127}
client.settings.addColor("Background color", "backgroundColor")

--color chatbox
client.settings.addAir(5)
chatboxColor = {1, 1, 1, 127}
client.settings.addColor("Chatbox color", "chatboxColor")

--color cursor
client.settings.addAir(5)
cursorColor = {1, 1, 1, 200}
client.settings.addColor("Cursor color", "cursorColor")

--color text
client.settings.addAir(5)
textColor = {254, 254, 254, 254}
client.settings.addColor("Text color", "textColor")

--clear content on close
client.settings.addAir(5)
clearClose = false
client.settings.addBool("Clear input box content when closing", "clearClose")

--always show chat
client.settings.addAir(5)
AlwaysShowChat = false
client.settings.addBool("Always show chat", "AlwaysShowChat")

--get own messages
client.settings.addAir(5)
getOwnMessage = false
client.settings.addBool("Get own messages when using up/down keys", "getOwnMessage")

--discord chat
client.settings.addAir(5)
discordChat = false
chatBridgeInfo = "(requires external exe to be running)"
client.settings.addBool("Discord to mc chat bridge by Vitsowdy", "discordChat")
client.settings.addInfo("chatBridgeInfo")

--clear content on close
client.settings.addAir(5)
holdTimer = 5
client.settings.addInt("Hold key to continue (in .x seconds)", "holdTimer", 1, 25)

--chat fade
client.settings.addAir(5)
holdChatTimerDefault = 3
holdChatTimer = holdChatTimerDefault
client.settings.addInt("Chat fading delay (in seconds)", "holdChatTimerDefault", 0, 10)

--chat fade
client.settings.addAir(5)
fadeDefault = 5
client.settings.addInt("Chat fading strength (in 0.1 seconds)", "holdChatTimerDefault", 0, 20)

--clear content on close
client.settings.addAir(5)
sizeX = 200
client.settings.addInt("Horizontal size", "sizeX", sizeY, 500)

--variables
fileLib = importLib("fileUtility.lua")

--make string from list
function mkString(tab, start)
    local result = ""
    if tab ~= nil then
        for i = start, #tab, 1 do
            result = result .. tab[i] .. " "
        end
    end
    return result
end

local chat = {}
local Ownchat = {}
local writeShow = false
local alphabet = {"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"}
local numbers = {")", "!", "@", "#", "$", "%", "^", "&", "*", "("}
local sidekeys = {";", "=", ",", "-", ".", "/", "`"}
local sidekeysShift = {":", "+", "<", "_", ">", "?", "~"}
local sideKeys200 = {"[", "\\", "]", "'"}
local sideKeys200Shift = {"{", "|", "}", "\""}
local toSend = ""
local holdCtrl = false
local holdShift = false
local keyCounter = holdTimer
local keyHold = 0
local arrowPos = -1
local cursorPos = 0
local selectionPos = 0
local fading = fadeDefault
local chatMessagePos = 0
local contentPath = {"discordChatBridge\\DiscordChatMessages.txt", "discordChatBridge\\MCChatMessages.txt"}
local discordMessage = ""
local content = discordMessage
local mouseClicked = false
local showCur = 0


function update(deltaTime)
    if discordMessage == " " and content == discordMessage then
        discordMessage = mkString(readFile(contentPath[1]), 2)
        content = discordMessage
    end
    if writeShow then
        if keyHold >= 0 then
            if keyCounter == 0 then
                keys(keyHold)
            else
                keyCounter = keyCounter - 1
            end
        end
        showCur = showCur + deltaTime
        if showCur > 1 then
            showCur = 0
        end
    else
        if holdChatTimer > 0 then
            holdChatTimer = holdChatTimer - 0.1
            fading = fadeDefault
        end
    end
end

function render(deltaTime)
    if discordChat then
        discordMessage = mkString(readFile(contentPath[1]), 2)
        contentTemp = readFile(contentPath[1])
        if (discordMessage ~= content and #contentTemp ~= 0) then
            content = discordMessage
            onChat(discordMessage, "§9[Discord] §r " .. contentTemp[1], 0)
        end
    end
    if (AlwaysShowChat and fading > 0) or writeShow then
        gfx.color(backgroundColor.r, backgroundColor.g, backgroundColor.b, math.floor(backgroundColor.a * (fading/fadeDefault)))
        gfx.rect(0, 0, sizeX, sizeY)
        gfx.color(textColor.r, textColor.g, textColor.b, math.floor(textColor.a * (fading/fadeDefault)))
        for i = 0, 8, 1 do
            if chat[i] ~= nil then
                if chat[i + chatMessagePos][1] ~= "" then
                    gfx.text(5, 10*i - 8, chat[i + chatMessagePos][1] .. ": " .. chat[i + chatMessagePos][2])
                else
                    gfx.text(5, 10*i - 8, chat[i + chatMessagePos][2])
                end
            end
        end
    end
    if writeShow then
        holdChatTimer = holdChatTimerDefault
        fading = fadeDefault
        gfx.color(chatboxColor.r, chatboxColor.g, chatboxColor.b, chatboxColor.a)
        gfx.rect(0, 87, sizeX, sizeY - 87)
        if #chat > 8 then
            local sizeScroll = 87 / (#chat / 8)
            local start = 87 / ((#chat - chatMessagePos) / 8) - sizeScroll
            local mX = gui.mousex()
            local mY = gui.mousey()
            gfx.rect(sizeX - 4, start, 2, sizeScroll)
            if mouseClicked and mX >= positionX and mX <= (positionX + sizeX) and mY >= positionY and mY <= (positionY + sizeY) then
                if mY < (positionY + start) and chatMessagePos > 0 then
                    chatMessagePos = chatMessagePos - 1
                end
                if mY > (positionY + start + sizeScroll) and chatMessagePos + 8 < #chat then
                    chatMessagePos = chatMessagePos + 1
                end
            end
        end
        gfx.color(textColor.r, textColor.g, textColor.b, textColor.a)
        gfx.text(5, 89, toSend)
        gfx.color(cursorColor.r, cursorColor.g, cursorColor.b, cursorColor.a)
        font = gui.font()
        if showCur < 0.5 then
            if cursorPos <= selectionPos then
                gfx.rect(font.width(string.sub(toSend, 1, cursorPos)) + 5, 88, 0 - (font.width(string.sub(toSend, 1, cursorPos)) + 5) + (font.width(string.sub(toSend, 1, selectionPos)) + 6), 11)
            else
                gfx.rect(font.width(string.sub(toSend, 1, selectionPos)) + 5, 88, 0 - (font.width(string.sub(toSend, 1, selectionPos)) + 5) + (font.width(string.sub(toSend, 1, cursorPos)) + 6), 11)
            end
        end
    elseif holdChatTimer <= 0 and fading > 0 then
        fading = fading - (deltaTime * 10)
    end
end




--events

function onChat(message, username, type)
    if (#message + #username - 2 * (countChar(message, "§") + countChar(message, "Â") + countChar(username, "§"))) * (gui.font().width("a")) > sizeX then
        table.insert(chat, {username, string.sub(message, 1, ((sizeX - gui.font().width(username .. ": ")) // gui.font().width("a")) + 2 * (countChar(message, "§") + countChar(message, "Â") + countChar(username, "§")) - 2) .. "-"})
        addMessage(string.sub(message, (sizeX - gui.font().width(username .. ": ")) // gui.font().width("a") + 2 * (countChar(message, "§") + countChar(message, "Â") + countChar(username, "§")) - 1, #message))
    else
        table.insert(chat, {username, message})
    end
    if #chat > 8 then
        chatMessagePos = #chat - 8
    end
    holdChatTimer = holdChatTimerDefault
    fading = fadeDefault
    return true
end
event.listen("ChatMessageAdded", onChat)

function addMessage(m)
    if gui.font().width(m) + 5 > sizeX then
        table.insert(chat, {"", string.sub(m, 1, sizeX // gui.font().width("a") - 2 + 2 * (countChar(m, "§") + countChar(m, "Â") + countChar(username, "§"))) .. "-"})
        addMessage(string.sub(m, sizeX // gui.font().width("a") + 2 * (countChar(m, "§") + countChar(m, "Â") + countChar(m, "§")) - 1, #m))
    else
        table.insert(chat, {"", m})
    end
end


function onKey(key, down)
    if not writeShow and down and (key == chatKey or key == 191) and not gui.mouseGrabbed() then
        if key == 191 then
            toSend = "/"
            cursorPos = 1
            selectionPos = cursorPos
        end
        writeShow = true
        gui.setGrab(writeShow)
    elseif writeShow then
        if not down then
            if key == 27 then
                exitChat()
            end
        elseif down then
            keys(key)
            if jsonLib and os.rename("emotes.json", "emotes.json") then
                emoji2()
            elseif os.rename("emotes.txt", "emotes.txt") then
                emoji()
            end
        end
        if key == 17 then
            holdCtrl = down
        elseif key == 16 then
            holdShift = down
        else
            if down then
                keyCounter = holdTimer
                keyHold = key
            else
                keyHold = 0
            end
        end
    end
    
    return writeShow
end
event.listen("KeyboardInput", onKey)

function onMouse(button, down)
    if writeShow then
        local mX = gui.mousex()
        local mY = gui.mousey()
        if button == 1 then
            mouseClicked = down
        end
        if button == 1 and mX >= positionX and mX <= (positionX + sizeX) and mY >= positionY and mY <= (positionY + sizeY) then
            
        elseif not down and button == 1 then
            exitChat()
        elseif button == 4 then
            if down then
                if chatMessagePos + 8 < #chat then
                    chatMessagePos = chatMessagePos + 1
                end
            else
                if chatMessagePos > 0 then
                    chatMessagePos = chatMessagePos - 1
                end
            end
        end
        return true
    end
end
event.listen("MouseInput", onMouse)


--methods

--exit chat
function exitChat()
    if clearClose then
        toSend = ""
        cursorPos = 0
        selectionPos = 0
    end
    writeShow = false
    gui.setGrab(writeShow)
end

--writes in the chatbox
function write(word)
    if selectionPos ~= cursorPos then
        if selectionPos > cursorPos then
            toSend = string.sub(toSend, 1, cursorPos) .. word .. string.sub(toSend, selectionPos + 1, -1)
            cursorPos = cursorPos + #getClipboard()
            selectionPos = cursorPos
        else
            toSend = string.sub(toSend, 1, selectionPos) .. word .. string.sub(toSend, cursorPos + 1, -1)
            cursorPos = selectionPos + #getClipboard()
            selectionPos = cursorPos
        end
    else
        toSend = string.sub(toSend, 1, cursorPos) .. word .. string.sub(toSend, cursorPos + 1, -1)
        cursorPos = cursorPos + #word
        selectionPos = cursorPos
    end
end

--translate pressed key into an action
function keys(key)
    if holdCtrl and key == 86 then
        write(getClipboard())
        client.notification("pasted from clipboard: " .. getClipboard())
    elseif holdCtrl and key == 67 then
        if selectionPos ~= cursorPos then
            if selectionPos > cursorPos then
                setClipboard(string.sub(toSend, cursorPos + 1, selectionPos))
                client.notification("Selection copied into clipboard")
            else
                setClipboard(string.sub(toSend, selectionPos + 1, cursorPos))
                client.notification("Selection copied into clipboard")
            end
        else
            setClipboard(toSend)
            client.notification("Message copied into clipboard")
        end
    elseif holdCtrl and key == 65 then
        cursorPos = #toSend
        selectionPos = 0
    elseif key == 8 then
        if holdCtrl then
            toSend = string.sub(toSend, cursorPos + 1, -1)
            cursorPos = 0
            selectionPos = 0
        else
            if selectionPos ~= cursorPos then
                if selectionPos > cursorPos then
                    toSend = string.sub(toSend, 1, cursorPos) .. string.sub(toSend, selectionPos + 1, -1)
                    selectionPos = cursorPos
                else
                    toSend = string.sub(toSend, 1, selectionPos) .. string.sub(toSend, cursorPos + 1, -1)
                    cursorPos = selectionPos
                end
            else
                if cursorPos > 0 then
                    toSend = string.sub(toSend, 1, cursorPos - 1) .. string.sub(toSend, cursorPos + 1, -1)
                    if cursorPos > 0 then
                        cursorPos = cursorPos - 1
                        selectionPos = cursorPos
                    end
                end
            end
        end
    elseif key == 46 then
        if holdCtrl then
            toSend = ""
            cursorPos = 0
            selectionPos = 0
        else
            if selectionPos ~= cursorPos then
                if selectionPos > cursorPos then
                    toSend = string.sub(toSend, 1, cursorPos) .. string.sub(toSend, selectionPos + 1, -1)
                    selectionPos = cursorPos
                else
                    toSend = string.sub(toSend, 1, selectionPos) .. string.sub(toSend, cursorPos + 1, -1)
                    cursorPos = selectionPos
                end
            else
                toSend = string.sub(toSend, 1, cursorPos) .. string.sub(toSend, cursorPos + 2, -1)
                if cursorPos > 0 then
                    cursorPos = cursorPos
                    selectionPos = cursorPos
                end
            end
        end
    elseif key == 13 then
        if string.sub(toSend, 1, 1) == keyToChar(dotKey) then
            table.insert(Ownchat, (toSend))
            exitChat()
            if splitString(toSend)[1] == ".discord" or splitString(toSend)[1] == ".dc" then
                writeFile(contentPath[2], mkString(splitString(toSend), 2))
                onChat(mkString(splitString(toSend), 2), player.name() .. " (§9[Discord]§r)", 0)
            else
                client.execute(string.sub(toSend, 2, -1))
            end
        elseif string.sub(toSend, 1, 1) == "/" then
            table.insert(Ownchat, (toSend))
            exitChat()
            client.execute("execute " .. toSend)
        else
            client.execute("say " .. toSend)
            table.insert(Ownchat, (toSend))
        end
        toSend = ""
        cursorPos = 0
        selectionPos = cursorPos
        arrowPos = -1
    elseif key == 38 then
        if getOwnMessage then
            if arrowPos == -1 then
                if #Ownchat > 0 then
                    arrowPos = #Ownchat
                end
            elseif arrowPos > 1 then
                arrowPos = arrowPos - 1
            end
            if arrowPos > 0 and arrowPos < #Ownchat + 1 then
                toSend = Ownchat[arrowPos]
                cursorPos = #toSend
                selectionPos = cursorPos
            end
        else
            if arrowPos == -1 then
                if #chat > 0 then
                    arrowPos = #chat
                end
            elseif arrowPos > 1 then
                arrowPos = arrowPos - 1
            end
            if arrowPos > 0 and arrowPos < #chat + 1 then
                toSend = chat[arrowPos][2]
                cursorPos = #toSend
                selectionPos = cursorPos
            end
        end
    elseif key == 40 then
        if getOwnMessage then
            if arrowPos == #Ownchat then
                arrowPos = -1
                toSend = ""
            elseif arrowPos < #Ownchat + 1 and arrowPos > 0 then
                arrowPos = arrowPos + 1
            end
            if arrowPos > 0 and arrowPos < #Ownchat + 1 then
                toSend = Ownchat[arrowPos]
                cursorPos = #toSend
                selectionPos = cursorPos
            end
        else
            if arrowPos == #chat then
                arrowPos = -1
                toSend = ""
            elseif arrowPos < #chat + 1 and arrowPos > 0 then
                arrowPos = arrowPos + 1
            end
            if arrowPos > 0 and arrowPos < #chat + 1 then
                toSend = chat[arrowPos][2]
                cursorPos = #toSend
                selectionPos = cursorPos
            end
        end
    elseif key == 37 then
        if holdCtrl then
            if holdShift then
                selectionPos = 0
            else
                cursorPos = 0
                selectionPos = cursorPos
            end
        else
            if holdShift then
                if selectionPos > 0 then
                    selectionPos = selectionPos - 1
                end
            else
                if cursorPos > 0 or selectionPos > 0 then
                    cursorPos = math.min(cursorPos, selectionPos) - 1
                    selectionPos = cursorPos
                end
            end
        end
    elseif key == 39 then
        if holdCtrl then
            if holdShift then
                selectionPos = #toSend
            else
                cursorPos = #toSend
                selectionPos = cursorPos
            end
        else
            if holdShift then
                if selectionPos < #toSend then
                    selectionPos = selectionPos + 1
                end
            else
                if cursorPos < #toSend or selectionPos < #toSend then
                    cursorPos = max(cursorPos, selectionPos) + 1
                    selectionPos = cursorPos
                end
            end
        end
    else
        local char = keyToChar(key)
        if char ~= "" and char ~= nil then
            write(char)
        end
    end
end

--translate key to character
function keyToChar(key)
    character = nil
    if key >= 65 and key < 91 then
        if holdShift then
            character = (alphabet[key - 64]:upper())
        else
            character = (alphabet[key - 64])
        end
    elseif key >= 48 and key <= 57 then
        if holdShift then
            character = (numbers[key - 47])
        else
            character = ((key - 48) .. "")
        end
    elseif key >= 186 and key <= 192 then
        if holdShift then
            character = (sidekeysShift[key - 185])
        else
            character = (sidekeys[key - 185])
        end
    elseif key >= 219 and key <= 222 then
        if holdShift then
            character = (sideKeys200Shift[key - 218])
        else
            character = (sideKeys200[key - 218])
        end
    elseif key == 32 then
        character = (" ")
    end
    return character
end

--changes :emojiName: into emoji
function emoji()
    local lines = io.lines("emotes.txt")
    for line in lines do
        local result = {}
        result = splitString(line)
        if result[1] ~= nil and result[2] ~= nil then
            toSend = toSend:gsub(result[1], result[2])
        end
    end
end

--emoji json
function emoji2()
    local emotes = {}
    emotes = jsonLoad("emotes.json")
    for k, v in pairs(emotes) do
        toSend = toSend:gsub(k, v)
    end
end

--split string from space
function splitString(text)
    local result = {}
    for i in string.gmatch(text, "[^%s]+") do
        table.insert(result, i)
    end
    return result
end

--count char
function countChar(s, c)
    if s == nil or s == "" then
        return 0
    end
    local _,n = s:gsub(c,"")
    return n
end