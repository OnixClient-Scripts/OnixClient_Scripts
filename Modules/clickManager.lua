name="Click Manager"
description = "Click manager by MCBE Craft"


client.settings.addAir(5)
airClickCancel = false
client.settings.addBool("Only click when facing something", "airClickCancel")

client.settings.addAir(5)
swordEntityClick = false
client.settings.addBool("Only hit entities when holding a sword", "swordEntityClick")

client.settings.addAir(5)
noSwordEntityClick = false
client.settings.addBool("Cancel hitting entity when not holding a sword", "noSwordEntityClick")

client.settings.addAir(5)
cropBreaking = false
client.settings.addBool("Cancel breaking not fully grown crops", "cropBreaking")

client.settings.addAir(5)
redstoneBreaking = false
client.settings.addBool("Cancel breaking redstone component when holding something", "redstoneBreaking")

client.settings.addAir(5)
mlgWater = false
client.settings.addBool("Water mlg helper", "mlgWater")

client.settings.addAir(5)
cooldownClick = false
client.settings.addBool("Only hit when outside of cooldown", "cooldownClick")

client.settings.addAir(5)
hitCooldown = 50
client.settings.addInt("Hit cooldown (in 0.01 seconds)", "hitCooldown", 0, 100)

client.settings.addAir(5)
cpsCounter = false
client.settings.addBool("Show cps", "cpsCounter")

client.settings.addAir(5)
backgroundColor = {0, 0, 0, 127}
client.settings.addColor("Background color", "backgroundColor")

client.settings.addAir(5)
textColor = {254, 254, 254, 254}
client.settings.addColor("Text color", "textColor")

client.settings.addAir(5)
cpsMaxEnabled = false
client.settings.addBool("Enable CPS limiter", "cpsMaxEnabled")

client.settings.addAir(5)
cpsMax = 15
client.settings.addInt("CPS limiter", "cpsMax", 0, 100)

client.settings.addAir(5)
cancelJump = false
client.settings.addBool("Cancel jumping when on block", "cancelJump")

client.settings.addAir(5)
jumpKey = 0
client.settings.addKeybind("Jump key", "jumpKey")

event.listen("KeyboardInput", function(key, down)
    if cancelJump and key == jumpKey and down then
        local x, y, z = player.position()
        local block = dimension.getBlock(x, y-1, z)
        if block.id ~= 0 then
            return true
        end
    end
end)


positionX = 100
positionY = 100
sizeX = 50
sizeY = 10

local timeStamp = 0
local leftButton = false
local rightButton = false
local leftStamps = {}
local rightStamps = {}
local cropList = {59, 244, 142, 141}
local redstoneList = {55, 149, 93}

function update(deltaTime)
    for i = #leftStamps, 1, -1 do
        if leftStamps[i] < (timeStamp - 1) then
            table.remove(leftStamps, i)
        end
    end
    for i = #rightStamps, 1, -1 do
        if rightStamps[i] < (timeStamp - 1) then
            table.remove(rightStamps, i)
        end
    end
end

function render(deltaTime)
    timeStamp = timeStamp + deltaTime
    if cpsCounter then
        local text = #leftStamps .. " | " .. #rightStamps
        local font = gui.font()
        sizeX = font.width(text) + 2
        sizeY = font.height + 2
        if leftButton then
            gfx.color(backgroundColor.r, backgroundColor.g, backgroundColor.b, backgroundColor.a)
            gfx.rect(0, 0, sizeX/2, sizeY)
        end
        if rightButton then
            gfx.color(backgroundColor.r, backgroundColor.g, backgroundColor.b, backgroundColor.a)
            gfx.rect(sizeX/2, 0, sizeX/2, sizeY)
        end
        gfx.color(textColor.r, textColor.g, textColor.b, textColor.a)
        gfx.text(1, 1, text)
    end
end


function onMouse(button, down)
    if down and not gui.mouseGrabbed() and button == 1 then
        if airClickCancel then
            if not (player.facingEntity() or player.facingBlock()) then
                return true
            end
        end
        if swordEntityClick then
            local inventory = player.inventory()
            local selected = inventory.at(inventory.selected)
            if selected ~= nil and (string.match(selected.name:lower(), "sword") and not player.facingEntity()) then
                return true
            end
        end
        if noSwordEntityClick then
            local inventory = player.inventory()
            local selected = inventory.at(inventory.selected)
            if selected == nil and player.facingEntity() then
                return true
            elseif selected ~= nil and (not string.match(selected.name:lower(), "sword") and player.facingEntity()) then
                return true
            end
        end
        if cropBreaking then
            local x,y,z = player.selectedPos()
            local block = dimension.getBlock(x,y,z)
            if contains(cropList, block.id) and block.data < 7 or block.id == 127 and block.data < 9 then
                return true
            end
        end
        if redstoneBreaking then
            local x,y,z = player.selectedPos()
            local block = dimension.getBlock(x,y,z)
            local inventory = player.inventory()
            local selected = inventory.at(inventory.selected)
            if contains(redstoneList, block.id) and selected ~= nil then
                return true
            end
        end
        if cooldownClick then
            if #leftStamps > 0 and (leftStamps[#leftStamps] > timeStamp - (hitCooldown / 100)) then
                return true
            end
        end
        if cpsMaxEnabled then
            if #leftStamps > 0 and (leftStamps[#leftStamps] > timeStamp - 1/cpsMax) then
                return true
            end
        end
    end
    if down and not gui.mouseGrabbed() and button == 2 then
        if mlgWater then
            local inventory = player.inventory()
            local selected = inventory.at(inventory.selected)
            local x, y, z = player.position()
            if selected and (selected.name == "bucket" and not (player.getFlag(1) or dimension.getBlock(x, y, z).name == "water")) then
                return true
            end
        end
    end
    if down then
        if button == 1 then
            table.insert(leftStamps, timeStamp)
            leftButton = true
        end
        if button == 2 then
            table.insert(rightStamps, timeStamp)
            rightButton = true
        end
    else
        if button == 1 then
            leftButton = false
        end
        if button == 2 then
            rightButton = false
        end
    end
end
event.listen("MouseInput", onMouse)

function contains(t, e)
    result = false
    for key, value in pairs(t) do
        if value == e then
            result = true
        end
    end
    return result
end




