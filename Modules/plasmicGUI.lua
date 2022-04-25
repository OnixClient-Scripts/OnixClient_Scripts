name = "Plasmic ClickGUI"
description = "Plasmic ClickGUI by MCBE Craft"

--[[
    made by MCBE Craft
]]--

client.settings.addAir(5)
openingKey = 0
client.settings.addKeybind("Gui key", "openingKey")

client.settings.addAir(5)
backColor = {0, 0, 0, 100}
client.settings.addColor("Background color", "backColor")

client.settings.addAir(5)
textColor = {255, 255, 255, 255}
client.settings.addColor("Text color", "textColor")

client.settings.addAir(5)
borderColor = {0, 0, 255, 255}
client.settings.addColor("Border color", "borderColor")

client.settings.addAir(5)
moduleColor = {0, 255, 0, 255}
client.settings.addColor("Enabled module color", "moduleColor")

local renderMenu = false
SettingMenu = {}
clientMods = {}
scriptMods = {}
local selectedModule = 0
local scrolling1 = 0
local scrolling2 = 0
local posX1 = 0
local posY1 = 0
local posX2 = 0
local posY2 = 0
local sizeX1 = 0
local sizeY1 = 0
local sizeX2 = 0
local sizeY2 = 0
local posYMod = 0
local font = gui.font()
local mouseClicked = false
local pressedKey = 0
local sizeMod = {1, 2, 2, 1, 0, 0, 3, 3}
local showScript = false
sizeMod[100] = 1
sizeMod[101] = 1
sizeMod[102] = 1

lib = importLib("keyconverter.lua")


function openMenu()
    SettingMenu = "Global Settings"
    selectedModule = 0
    renderMenu = true
    showScript = false
    scrolling1 = 0
    scrolling2 = 0
    gui.setGrab(true)
    clientMods = client.modules()
    SettingMenu = table.remove(clientMods, 1)
    for i = #clientMods, 1, -1 do
        if clientMods[i].isScript then
            table.remove(clientMods, i)
        end
    end
end

function mouseIn(x, y, sx, sy)
    mX = gui.mousex()
    mY = gui.mousey()
    if x <= mX and mX <= x + sx and y <= mY and mY <= y + sy then
        return true
    else
        return false
    end
end

function cursor(x, y, sx, value, min, max, setting)
    value = math.floor(value * 100) / 100
    gfx.color(borderColor.r, borderColor.g, borderColor.b, borderColor.a)
    gfx.rect(x, y + font.height / 3, sx - 15 - font.width(value .. ""), font.height / 3)
    gfx.rect(x + value / (max - min) * (sx - 15 - font.width(value .. "") - font.height), y, font.height, font.height)
    gfx.color(textColor.r, textColor.g, textColor.b, textColor.a)
    gfx.text(x + sx - 10 - font.width(value .. ""), y, value)
end

function settingType(setting, number)
    if setting.type == 1 then
        gfx.color(textColor.r, textColor.g, textColor.b, textColor.a)
        gfx.text(posX2 + 5, posYMod, setting.name)
        if setting.value then
            gfx.color(0, 255, 0)
        else
            gfx.color(255, 0, 0)
        end
        gfx.rect(posX2 + sizeX2 - 5 - font.height, posYMod, font.height, font.height)
        posYMod = posYMod + font.wrap
    elseif setting.type == 2 or setting.type == 3 then
        gfx.color(textColor.r, textColor.g, textColor.b, textColor.a)
        gfx.text(posX2 + 5, posYMod, setting.name)
        posYMod = posYMod + font.wrap
        cursor(posX2 + 5, posYMod, sizeX2, setting.value, setting.min, setting.max, setting)
        posYMod = posYMod + font.wrap
    elseif setting.type == 4 then
        gfx.color(textColor.r, textColor.g, textColor.b, textColor.a)
        gfx.text(posX2 + 5, posYMod, setting.name)
        local val = keytostr(setting.value)
        if val == nil or val == "" then
            val = "None"
        end
        gfx.color(borderColor.r, borderColor.g, borderColor.b, borderColor.a)
        gfx.drawRect(posX2 + sizeX2 - 9 - font.width(val), posYMod - 1, font.width(val) + 4, font.wrap, 1)
        gfx.color(textColor.r, textColor.g, textColor.b, textColor.a)
        gfx.text(posX2 + sizeX2 - 7 - font.width(val), posYMod, val)
        posYMod = posYMod + font.wrap
    elseif setting.type == 5 then
        --vec2
    elseif setting.type == 6 then
        --vec3
    elseif setting.type == 7 or setting.type == 8 then
        gfx.color(setting.value.r * 255, setting.value.g * 255, setting.value.b * 255, setting.value.a * 255)
        gfx.text(posX2 + 5, posYMod, setting.name)
        posYMod = posYMod + font.wrap
        cursor(posX2 + 5, posYMod, (sizeX2 - 10) / 2, setting.value.r * 255, 0, 255, setting)
        cursor(posX2 + 5 + (sizeX2 - 10) / 2, posYMod, (sizeX2 - 10) / 2, setting.value.g * 255, 0, 255, setting)
        posYMod = posYMod + font.wrap
        cursor(posX2 + 5, posYMod, (sizeX2 - 10) / 2, setting.value.b * 255, 0, 255, setting)
        cursor(posX2 + 5 + (sizeX2 - 10) / 2, posYMod, (sizeX2 - 10) / 2, setting.value.a * 255, 0, 255, setting)
        posYMod = posYMod + font.wrap
    elseif setting.type == 100 then
        posYMod = posYMod + setting.value
    elseif setting.type == 101 then
        gfx.color(textColor.r, textColor.g, textColor.b, textColor.a)
        gfx.text(posX2 + 5, posYMod, setting.value)
        posYMod = posYMod + font.wrap
    elseif setting.type == 102 then
        gfx.color(borderColor.r, borderColor.g, borderColor.b, borderColor.a)
        local val = "ask Onix"
        gfx.drawRect(posX2 + sizeX2 - 9 - font.width(val), posYMod - 1, font.width(val) + 4, font.wrap, 1)
        gfx.color(textColor.r, textColor.g, textColor.b, textColor.a)
        gfx.text(posX2 + sizeX2 - 7 - font.width(val), posYMod, val)
        gfx.text(posX2 + 5, posYMod, setting.name)
        posYMod = posYMod + font.wrap
    else

    end
end

function settingClick(drag, reset)
    mod = SettingMenu.settings
    local posY = posY2 + font.wrap * 2
    for i, v in ipairs(mod) do
        if mouseIn(posX2, posY, sizeX2, font.wrap * sizeMod[v.type]) then
            if v.type == 1 then
                if mouseIn(posX2 + sizeX2 - 5 - font.height, posY, font.height, font.height) and not drag then
                    if not reset then
                        v.value = not v.value
                    else
                        v.value = v.default
                    end
                end
            elseif v.type == 2 or v.type == 3 then
                if not reset then
                    mX = gui.mousex()
                    local val = (mX - posX2 - 5) / (sizeX2 - 15 - font.width(math.floor(v.value * 100) / 100 .. "") - font.height) * (v.max - v.min)
                    if val >= v.min and val <= v.max then
                        v.value = val
                    elseif val < v.min then
                        v.value = v.min
                    elseif val > v.max then
                        v.value = v.max
                    end
                else
                    v.value = v.default
                end
            elseif v.type == 4 then
                if not reset then
                    local val = keytostr(v.value)
                    if val == nil or val == "" then
                        val = "None"
                    end
                    if mouseIn(posX2 + sizeX2 - 9 - font.width(val), posY - 1, font.width(val) + 4, font.wrap) and not drag then
                        v.value = pressedKey
                    end
                else
                    v.value = v.default
                end
            elseif v.type == 7 or v.type == 8 then
                if not reset then
                    posY = posY + font.wrap
                    local color = v.value
                    if mouseIn(posX2 + 5, posY, (sizeX2 - 10) / 2, font.wrap) then
                        mX = gui.mousex()
                        local val = (mX - posX2 - 5) / ((sizeX2 - 10) / 2 - 5 - font.width(math.floor(v.value.r * 100) / 100 .. "") - font.height)
                        if val >= 0 and val <= 1 then
                            color.r = val
                        elseif val < 0 then
                            color.r = 0
                        elseif val > 1 then
                            color.r = 1
                        end
                    elseif mouseIn(posX2 + 5 + (sizeX2 - 10) / 2, posY, (sizeX2 - 10) / 2, font.wrap) then
                        mX = gui.mousex()
                        local val = (mX - posX2 - 5 - ((sizeX2 - 10) / 2)) / ((sizeX2 - 10) / 2 - 5 - font.width(math.floor(v.value.g * 100) / 100 .. "") - font.height)
                        if val >= 0 and val <= 1 then
                            color.g = val
                        elseif val < 0 then
                            color.g = 0
                        elseif val > 1 then
                            color.g = 1
                        end
                    else
                        posY = posY + font.wrap
                        if mouseIn(posX2 + 5, posY, (sizeX2 - 10) / 2, font.wrap) then
                            mX = gui.mousex()
                            local val = (mX - posX2 - 5) / ((sizeX2 - 10) / 2 - 5 - font.width(math.floor(v.value.b * 100) / 100 .. "") - font.height)
                            if val >= 0 and val <= 1 then
                                color.b = val
                            elseif val < 0 then
                                color.b = 0
                            elseif val > 1 then
                                color.b = 1
                            end
                        elseif mouseIn(posX2 + 5 + (sizeX2 - 10) / 2, posY, (sizeX2 - 10) / 2, font.wrap) then
                            mX = gui.mousex()
                            local val = (mX - posX2 - 5 - ((sizeX2 - 10) / 2)) / ((sizeX2 - 10) / 2 - 5 - font.width(math.floor(v.value.a * 100) / 100 .. "") - font.height)
                            if val >= 0 and val <= 1 then
                                color.a = val
                            elseif val < 0 then
                                color.a = 0
                            elseif val > 1 then
                                color.a = 1
                            end
                        end
                    end
                    v.value = color
                    posY = posY - 2*font.wrap
                else
                    v.value = v.default
                end
            end
        end
        if v.type == 100 then
            posY = posY + v.value
        else
            posY = posY + font.wrap * sizeMod[v.type]
        end
    end
end

function moduleSise(mod)
    local posY = posY2 + font.wrap * 2
    for i, v in ipairs(mod) do
        if v.type == 100 then
            posY = posY + v.value
        else
            posY = posY + font.wrap * sizeMod[v.type]
        end
    end
    return posY
end


function update(dt)
    if renderMenu then
        clientMods = client.modules()
        table.remove(clientMods, 1)
        for i = #clientMods, 1, -1 do
            if not showScript then
                if clientMods[i].isScript then
                    table.remove(clientMods, i)
                end
            else
                if not clientMods[i].isScript then
                    table.remove(clientMods, i)
                end
            end
        end
        sizeX1 = 300
        sizeY1 = gui.height() - 30
        sizeX2 = 300
        sizeY2 = gui.height() - 30
        posX1 = gui.width() / 2 - sizeX1 - 5
        posY1 = 15
        posX2 = gui.width() / 2 + 5
        posY2 = 15
        font = gui.font()
    end
end

function render(dt)
    if renderMenu then
        if mouseClicked then
            if mouseIn(posX2, posY2 + font.wrap, sizeX2, posYMod) then
                settingClick(true, false)
            end
            if mouseIn(posX1 + sizeX1 - 10, posY1, 12, sizeY1) then
                mY = gui.mousey()
                if mY <= posY1 + (sizeY1 - sizeY1*10*(1/#clientMods)) * (scrolling1 / (#clientMods - math.floor((sizeY1/11) - 1))) and scrolling1 > 0 then
                    scrolling1 = scrolling1 - 1
                elseif mY >= posY1 + (sizeY1 - sizeY1*10*(1/#clientMods)) * (scrolling1 / (#clientMods - math.floor((sizeY1/11) - 1))) + sizeY1*10*(1/#clientMods) and scrolling1 + math.floor((sizeY1/11) - 1) < #clientMods then
                    scrolling1 = scrolling1 + 1
                end
            end
        end
        gfx.color(0, 0, 0, 100)
        gfx.rect(posX1, posY1, sizeX1, sizeY1)
        gfx.rect(posX2, posY2, sizeX2, sizeY2)
        gfx.rect(posX1 + sizeX1 - 5, posY1 + (sizeY1 - sizeY1*10*(1/#clientMods)) * (scrolling1 / (#clientMods - math.floor((sizeY1/11) - 1))), 3, sizeY1*10*(1/#clientMods))
        gfx.color(moduleColor.r, moduleColor.g, moduleColor.b, moduleColor.a)
        for i = 1, #clientMods, 1 do
            if i + scrolling1 <= #clientMods then
                local mod = clientMods[i+scrolling1]
                if mod.enabled and i < math.floor(sizeY1/11)  then
                    gfx.text(posX1 + 5, posY1 + font.wrap * i, mod.name)
                end
            end
        end
        gfx.color(textColor.r, textColor.g, textColor.b, textColor.a)
        if selectedModule > 0 and posY1 + font.wrap * (selectedModule - scrolling1) > posY1 and posY1 + font.wrap * (selectedModule - scrolling1) + font.wrap < posY1 + sizeY1 then
            gfx.rect(posX1, posY1 + font.wrap * (selectedModule - scrolling1), 3, font.wrap)
        end
        for i = 1, #clientMods, 1 do
            if i + scrolling1 <= #clientMods then
                local mod = clientMods[i+scrolling1]
                if not mod.enabled and i < math.floor(sizeY1/11)  then
                    gfx.text(posX1 + 5, posY1 + font.wrap * i, mod.name)
                end
            end
        end
        gfx.text(posX2 + 5, posY2 + 3, SettingMenu.name, 2)
        posYMod = posY2 + font.wrap * 2
        local endfor = 0
        if moduleSise(SettingMenu.settings) < sizeY2 - font.wrap * 2 then
            endfor = #SettingMenu.settings
        else
            endfor = math.floor((sizeY2/11) - 1)
        end
        for i = scrolling2 + 1, scrolling2 + endfor, 1 do
            if SettingMenu.settings[i] ~= nil then
                settingType(SettingMenu.settings[i], i)
            end
        end
        gfx.color(textColor.r, textColor.g, textColor.b, textColor.a)
        gfx.text(posX1 + 5, posY1 + sizeY1 - font.wrap - 5, "Script modules")
        if showScript then
            gfx.color(0, 255, 0)
        else
            gfx.color(255, 0, 0)
        end
        gfx.rect(posX1 + 10 + font.width("Script modules"), posY1 + sizeY1 - font.wrap - 5, font.wrap, font.wrap)
    end
end

event.listen("KeyboardInput", function(key, down)
    if down and key == openingKey and not renderMenu and not gui.mouseGrabbed() then
        openMenu()
        return true
    elseif down and renderMenu then
        if key == 0x1B then
            renderMenu = false
            gui.setGrab(false)
            return true
        end
    end
    if renderMenu then
        if down then
            pressedKey = key
            return true
        else
            pressedKey = 0
        end
    end
end)

event.listen("MouseInput", function(button, down)
    if renderMenu then
        if button == 1 and down and mouseIn(posX1, posY1 + font.wrap, sizeX1 - 7, sizeY1 - font.wrap * 4.7) then
            mY = gui.mousey()
            selectedModule = math.floor((mY - posY1) / font.wrap) + scrolling1
            SettingMenu = clientMods[selectedModule]
            gui.clickSound()
        end
        if button == 1 and down and mouseIn(posX1 + 10 + font.width("Script modules"), posY1 + sizeY1 - font.wrap - 5, font.wrap, font.wrap) then
            showScript = not showScript
        end
        if button == 1 and down and mouseIn(posX1 + sizeX1 - 7, posY1, 7, sizeY1) then
            mY = gui.mousey()
            if mY <= posY1 + (sizeY1 - sizeY1*10*(1/#clientMods)) * (scrolling1 / (#clientMods - math.floor((sizeY1/11) - 1))) and scrolling1 > 0 then
                scrolling1 = scrolling1 - 1
            elseif mY >= posY1 + (sizeY1 - sizeY1*10*(1/#clientMods)) * (scrolling1 / (#clientMods - math.floor((sizeY1/11) - 1))) + sizeY1*10*(1/#clientMods) and scrolling1 + math.floor((sizeY1/11) - 1) < #clientMods then
                scrolling1 = scrolling1 + 1
            end
        end
        if button == 1 and down and mouseIn(posX2, posY2 + font.wrap, sizeX2, posYMod) then
            settingClick(false)
            gui.clickSound()
        end
        if button == 4 and mouseIn(posX1, posY1 + font.wrap, sizeX1, sizeY1) then
            if not down and scrolling1 > 0 then
                scrolling1 = scrolling1 - 1
            elseif down and scrolling1 + math.floor((sizeY1/11) - 1) < #clientMods then
                scrolling1 = scrolling1 + 1
            end
        end
        if button == 4 and mouseIn(posX2, posY2 + font.wrap, sizeX2, sizeY2) then
            if not down and scrolling2 > 0 then
                scrolling2 = scrolling2 - 1
            elseif down and scrolling2 + math.floor((sizeY2/11) - 1) < math.floor(moduleSise(SettingMenu.settings) / font.wrap) then
                scrolling2 = scrolling2 + 1
            end
        end
        if button == 2 and down and mouseIn(posX1, posY1 + font.wrap, sizeX1, sizeY1 - font.wrap * 4.7) then
            mY = gui.mousey()
            selectedModule = math.floor((mY - posY1) / font.wrap) + scrolling1
            SettingMenu = clientMods[selectedModule]
            SettingMenu.enabled = not SettingMenu.enabled
            gui.clickSound()
        end
        if button == 3 and down and mouseIn(posX1, posY1 + font.wrap, sizeX1, sizeY1 - font.wrap * 4.7) then
            mY = gui.mousey()
            selectedModule = math.floor((mY - posY1) / font.wrap) + scrolling1
            SettingMenu = clientMods[selectedModule]
            mod = SettingMenu.settings
            for i, v in ipairs(mod) do
                if v.type >= 1 and v.type <= 8 then
                    v.value = v.default
                end
            end
            client.notification(SettingMenu.name .. " resetted")
            gui.clickSound()
        end
        if button == 3 and down and mouseIn(posX2, posY2 + font.wrap, sizeX2, posYMod) then
            settingClick(false, true)
            gui.clickSound()
        end
        if button == 1 then
            mouseClicked = down
        end
        return true
    end
end)

