---@diagnostic disable: lowercase-global
name = "Cape Switcher"
description = "Lets you swap and manage your capes, directly from inside the game! (Doesn't apply on join)."

selfmod = client.settings.addAir(0).parent
for _, setting in pairs(selfmod.settings) do
    if setting.name == "Key" then
        setting.visible = false
        break
    end
end
client.settings.addAir(-10)

fs.mkdir("Cosmetics")
workingDir = "RoamingState/OnixClient/Scripts/Data/Cosmetics/"
fs.mkdir("Capes")
padding = 2
plsapplycape = false
lastUIRender = os.clock()

function openCapeFolder()
    fs.showFolder("Capes")
end
client.settings.addFunction("Open Capes Folder", "openCapeFolder", "Open")

---@class Cape
---@field name string
---@field path string
---@field image? Gfx2Texture

---@return Cape[] capes The capes found on disk
function getCapes()
    local capes = {}
    local files = fs.files("Capes")
    for i, file in pairs(files) do
        local cape = {
            name = file:split("\\")[2]:split(".")[1]:gsub("_", " "),
            path = file,
        }
        table.insert(capes, cape)
    end
    return capes
end
capes = getCapes()

hasAppliedCape = false
function update()
    if os.clock() - lastUIRender < 2 then
        capes = getCapes()
    end
end

---@type Cape
selectedCape = nil
selectedCapePath = ""

event.listen("ConfigurationSaved", function()
    if selectedCape ~= nil then
        local data = {
            selectedCapePath = selectedCape.path
        }
        return data
    end
end)

globalConfigData = {}

event.listen("ConfigurationLoaded", function(data)
    globalConfigData = data
    capes = getCapes()
    for _, cape in pairs(capes) do
        if cape.path == data.selectedCapePath then
            setCape(cape)
            break
        end
    end
end)

function onEnable()
    plsapplycape = true
    capes = getCapes()
    if globalConfigData.selectedCapePath ~= "" then
        for _, cape in pairs(capes) do
            if cape.path == globalConfigData.selectedCapePath then
                setCape(cape)
                break
            end
        end
    end
end

function onDisable()
    plsapplycape = false
end

---Sets the player's cape
---@param cape Cape
function setCape(cape)
    if plsapplycape == false then return end
    player.skin().setCape(cape.path, false)
    selectedCapePath = cape.path
    selectedCape = cape
end

customSettingHeight = 0
function CustomSettingType_getHeight()
    return customSettingHeight
end

---Uppercases the first letter of a string
---@param string string
function string.upperFirstLetter(string)
    return string:sub(1,1):upper() .. string:sub(2)
end

---Custom setting type for the cape switcher
---@param setting Setting The setting to render
---@param width number The width of the setting
---@param height number The height of the setting
---@param mouseX number The x position of the mouse
---@param mouseY number The y position of the mouse
---@param didClick boolean Whether the mouse was clicked
---@param mouseButton integer The mouse button that was clicked
---@param lmbDown boolean Whether the left mouse button is down
---@param rmbDown boolean Whether the right mouse button is down
---@param mouseInside boolean Whether the mouse is inside the setting
function CustomSettingType_render(setting, width, height, mouseX, mouseY, didClick, mouseButton, lmbDown, rmbDown, mouseInside)
    lastUIRender = os.clock()
    local capeSize = 44

    local capesPerRow = math.floor(width / (capeSize+padding*2))
    local gridCurrentX = padding
    local capesThisRow = 0
    local xJump = width / capesPerRow
    local gridCurrentY = padding

    for i, cape in pairs(capes) do
        local sizeWidth, sizeHeight = 22, 19
        if cape.image == nil then
            local fatImage = gfx2.loadImage(cape.path)
            local img = gfx2.createImage(sizeWidth, sizeHeight)
            for x=1,sizeWidth do
                for y=1,sizeHeight do
                    if fatImage ~= nil and img ~= nil then
                        local col = fatImage:getPixel(x,y)
                        img:setPixel(x,y,col.r, col.g, col.b, col.a)
                    end
                end
            end
            cape.image = img
        end
        gfx2.color(gui.theme().highlight)
        local capeStartX = gridCurrentX - padding
        local capeStartY = gridCurrentY - padding
        local capeEndX = gridCurrentX - padding + (sizeWidth+padding)*2
        local capeEndY = gridCurrentY - padding + sizeHeight*2
        gfx2.fillRoundRect(gridCurrentX - padding, gridCurrentY - padding, (sizeWidth+padding)*2, sizeHeight*2,2)
        if mouseInside and mouseX >= capeStartX and mouseX <= capeEndX and mouseY >= capeStartY and mouseY <= capeEndY then
            gfx2.color(gui.theme().highlight)
            gfx2.fillRoundRect(gridCurrentX - padding, gridCurrentY - padding, (sizeWidth+padding)*2, sizeHeight*2,2)
            if didClick and mouseButton == 1 then
                if plsapplycape then
                    setCape(cape)
                else
                    client.notification("Cape Switcher - Please enable the module first!")
                end
            end
        end
        gfx2.drawImage(gridCurrentX, gridCurrentY, sizeWidth*2, sizeHeight*2, cape.image)

        --draw cape name in bottom left with some background blur
        local capeTextWidth, capeTextHeight = gfx2.textSize(cape.name, 0.5)
        gfx2.color(gui.theme().windowBackground)

        local nameRectX = gridCurrentX+padding/2
        local nameRectY = capeEndY - (padding + padding/2 + capeTextHeight)
        gfx2.blur(nameRectX, nameRectY, padding + capeTextWidth, capeTextHeight, 255, 2)
        gfx2.fillRoundRect(nameRectX, nameRectY, padding + capeTextWidth, capeTextHeight,2)
        gfx2.color(gui.theme().text)
        gfx2.text(nameRectX+1, nameRectY, cape.name:upperFirstLetter(), 0.5)

        customSettingHeight = 40
        capesThisRow = capesThisRow + 1
        if capesThisRow >= capesPerRow then
            capesThisRow = 0
            gridCurrentY = gridCurrentY + 38 + padding
            gridCurrentX = padding
        else
            gridCurrentX = gridCurrentX + xJump
        end
    end
    customSettingHeight = gridCurrentY + 38 + padding
end

customSettingTypeID = client.settings.registerCustomRenderer(CustomSettingType_getHeight, CustomSettingType_render)

client.settings.addCustom("Cape Switcher", customSettingTypeID, 0)