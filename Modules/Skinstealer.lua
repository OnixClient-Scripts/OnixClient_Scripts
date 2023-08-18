name="Skinstealer"
description="Steals peoples skins."

function stealMySkin()
    local mySkin = player.skin()
    local myName = player.name()

    if mySkin ~= nil then
        if myName ~= nil then
            local playerName = string.split(myName, "\n")
            if string.find(playerName[1],"§.") then
                username = string.gsub(playerName[1],"§.","")
                if string.find(username,"%[") then username = string.gsub(username," %[.*%]","") end
            else
                username = myName
            end
        end
        if fs.exist("Skinstealer/" .. username) == false then
            fs.mkdir("Skinstealer/" .. username)
        else
            local i = 1
            while fs.exist("Skinstealer/" .. username .. "_" .. i) do
                i = i + 1
            end
            fs.mkdir("Skinstealer/" .. username .. "_" .. i)
            username = username .. "_" .. i
        end
        mySkin.save("Skinstealer/" .. myName .. "/" .. myName .. ".png")
        if mySkin.hasCape() then
            mySkin.saveCape("Skinstealer/" .. myName .. "/" .. myName .. "_cape.png")
        end
        local file = io.open("Skinstealer/" .. username .. "/" .. username .. "_geometry.json","w")
        file:write(skin.geometry())
        file:close()
        print("Stole your own skin!")
    end
end
function openLastSkin()
    fs.showFolder("Skinstealer/" .. username)
end
function openSkinstealFolder()
    fs.showFolder("Skinstealer/")
end
fs.mkdir("Skinstealer")
grabSkin = false
username = ""
usernameTest = ""


client.settings.addAir(5)
client.settings.addCategory("Skinsteal Settings")
skinstealKey = client.settings.addNamelessKeybind("Skinsteal Key", 0)
client.settings.addAir(5)

client.settings.addCategory("Mouse Settings")
disableMiddleClick = client.settings.addNamelessBool("Disable Mouse Button Skin Stealing", false)
disableMouseButtons = client.settings.addNamelessBool("Prohibit Selected Mouse Button Input", false)
mouseButtonToUse = client.settings.addNamelessInt("Mouse Button to Use",1,3,3)
mouseButtonInfo = "Mouse Button: Middle"
client.settings.addInfo("mouseButtonInfo").scale = 0.9
mouseSettingsAir = client.settings.addAir(5)

client.settings.addCategory("Clone Settings")
cloneSkin = client.settings.addNamelessBool("Clone Skin", false)
dontStealSkinWhenCloning = client.settings.addNamelessBool("Don't Steal Skin When Cloning", false)
beLocal = client.settings.addNamelessBool("Local Only", false)
client.settings.addAir(5)

client.settings.addCategory("Misc Settings")
holdToSteal = client.settings.addNamelessBool("Hold to steal skins", false)
skinStealFolderFunc = client.settings.addFunction("Open Skinsteal Folder","openSkinstealFolder","Open")
lastSkinFolderFunc = client.settings.addFunction("Open Last Stolen Skin Folder","openLastSkin","Open")
stealLocalSkin = client.settings.addFunction("Steal Your Own Skin", "stealMySkin", "Steal")
client.settings.addAir(5)

client.settings.addCategory("Chat Settings")
disableChatMessage = client.settings.addNamelessBool("Disable Chat Messages",false)
warningMessage = client.settings.addNamelessBool("Disable \"Could not steal skin.\" message.",false)

local mouseButtons = {
    "Mouse Button: Left",
    "Mouse Button: Right",
    "Mouse Button: Middle"
}

function setDescriptionScale(scale)
    local settings = holdToSteal.parent.settings
    for _, s in pairs(settings) do
        if s.saveName == "description" then
            s.scale = scale
            break
        end
    end
end

function cloneSkinFunc()
    local selectedSkin = player.selectedEntity().skin()
    local skin = player.skin()
    local isLocal = beLocal.value

    skin.setSkinCapeGeometry(selectedSkin.texture(), selectedSkin.capeTexture(), selectedSkin.geometry(), selectedSkin.defaultGeometryName(), selectedSkin.geometryName(), isLocal)
end

function update()
    setDescriptionScale(1.25)
    if disableMiddleClick.value == false then
        disableMouseButtons.visible = true
        mouseButtonToUse.visible = true
        mouseSettingsAir.visible = true
        mouseButtonInfo = mouseButtons[mouseButtonToUse.value]
    end
    if disableChatMessage.value == true then
        warningMessage.visible = false
    end
    if holdSteal then
        skinsteal()
    end
end
event.listen("KeyboardInput", function(key,down)
    if gui.mouseGrabbed() == true then return end
    if key == skinstealKey.value and down then
        skinsteal()
    end
    if key == skinstealKey and holdToSteal.value == true then
        holdSteal = down
    end
end)
event.listen("MouseInput", function(button,down)
    if gui.mouseGrabbed() == true then return end
    if button == mouseButtonToUse.value and down and disableMiddleClick.value == false then
        skinsteal()
    end
    if button == mouseButtonToUse.value and disableMiddleClick.value == false and holdToSteal.value == true then
        holdSteal = down
    end
    if disableMouseButtons.value == true and button == mouseButtonToUse.value then
        return true
    end
end)

function skinsteal()
    if player.facingEntity() then
        if player.selectedEntity().type ~= "player" and warningMessage.value == false and disableChatMessage.value == false then
            if player.selectedEntity().username == "" then
                print("§cCould not steal skin.")
                print("§cThis could be because it's not a player.")
                return
            end
        else
            if cloneSkin.value then
                cloneSkinFunc()
            end
            if dontStealSkinWhenCloning.value then return end
            local selectedPlayer = player.selectedEntity()
            if selectedPlayer.username ~= nil then
                local playerName = string.split(selectedPlayer.username, "\n")
                if string.find(playerName[1],"§.") then
                    username = string.gsub(playerName[1],"§.","")
                    if string.find(username,"%[") then username = string.gsub(username," %[.*%]","") end
                else
                    username = string.split(selectedPlayer.username, "\n")[1]
                end
            else
                playerName = selectedPlayer.type
            end
            if selectedPlayer.skin == nil then return end
            local skin = selectedPlayer.skin()
            if skin ~= nil then
                if fs.exist("Skinstealer/" .. username) == false then
                    fs.mkdir("Skinstealer/" .. username)
                else
                    local i = 1
                    while fs.exist("Skinstealer/" .. username .. "_" .. i) do
                        i = i + 1
                    end
                    fs.mkdir("Skinstealer/" .. username .. "_" .. i)
                    username = username .. "_" .. i
                end
                if disableChatMessage.value == false and username ~= usernameTest then print("§aStole " .. username .. "'s skin!") usernameTest = username end
                skin.save("Skinstealer/" .. username .. "/" .. username .. "_skin.png")
                if skin.hasCape() then
                    skin.saveCape("Skinstealer/" .. username .. "/" .. username .. "_cape.png")
                end
                local file = io.open("Skinstealer/" .. username .. "/" .. username .. "_geometry.json","w")
                file:write(skin.geometry())
                file:close()
            end
        end
    end
end
registerCommand("skinsteal", function(args)
    if args == "" then
        fs.showFolder("Skinstealer")
    elseif args == "--lastStolen" or args == "--lastSteal" then
        fs.showFolder("Skinstealer/" .. username)
    elseif args == "help" then
        print("§c§lSkinstealer Help§r\n§aArguments can be added with §r§o§7--[argument]§r.§a\n§lArgs:\n§r§7--lastStolen §a§oOpens the folder of the last stolen skin.")
    elseif args == "--showSettings" then
        print("§a")
    else
        print("§aUnknown argument \"§7" .. args .. "§a\".\ndo §o§7.skinsteal help §r§afor help")
    end
end)
