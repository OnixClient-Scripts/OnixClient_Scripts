name = "Green Screen"
description = "Displays a green screen on the selected coords."

greenScrenKey = client.settings.addNamelessKeybind("Greenscreen Key", 0)
hideErrors = client.settings.addNamelessBool("Hide Errors", false)
hideSuccessMessage = client.settings.addNamelessBool("Hide Status Messages", false)
backColor = client.settings.addNamelessColor("Color", {0,255,0})
onlyUseMainColor = client.settings.addNamelessBool("Only use main color", false)

local hasFirstPoint = false
local currentGreenscreenIdentifier = 1
local firstGreenScreenPoint = {}
local currentGreenScreens = {}

function makeGreenScreen(firstPoint, secondPoint)
    local greenscreen = {}
    greenscreen.id = currentGreenscreenIdentifier
    greenscreen.start = firstPoint
    greenscreen.stop = secondPoint
    local minWaypointTemp = {x=math.min(greenscreen.start.x, greenscreen.stop.x), y=math.min(greenscreen.start.y, greenscreen.stop.y), z=math.min(greenscreen.start.z, greenscreen.stop.z)}
    greenscreen.stop = {x=math.max(greenscreen.start.x, greenscreen.stop.x), y=math.max(greenscreen.start.y, greenscreen.stop.y), z=math.max(greenscreen.start.z, greenscreen.stop.z)}
    greenscreen.start = minWaypointTemp
    local id = greenscreen.id
    local settings = {}
    greenscreen.settings = settings

    settings.topAir = client.settings.addAir(6)
    _G["greenscreensus_ClickedOnThe" .. greenscreen.id] = function() 
        local newGreen = {}
        for k, v in pairs(currentGreenScreens) do
            if v.id == id then
                for _, s in pairs(greenscreen.settings) do
                    s.parent.removeSetting(s)
                end
            else
                table.insert(newGreen, v)
            end
        end
        currentGreenScreens = newGreen
    end
        
    settings.delete = client.settings.addFunction("Greenscreen #" .. greenscreen.id, "greenscreensus_ClickedOnThe" .. greenscreen.id, "Remove")
    _G["greenscreensus_ClickedOnThe2" .. greenscreen.id] = function() 
        for k, s in pairs(currentGreenScreens) do
            if s.id == id then
                s.start = {x=math.floor(s.start.x), y=math.floor(s.start.y),z=math.floor(s.start.z)}
                s.stop = {x=math.floor(s.stop.x), y=math.ceil(s.stop.y),z=math.ceil(s.stop.z)}
                break
            end
        end
    end
        
    settings.clamp = client.settings.addFunction("Greenscreen #" .. greenscreen.id, "greenscreensus_ClickedOnThe2" .. greenscreen.id, "Clamp")

    settings.color = client.settings.addNamelessColor("Greenscreen #" .. greenscreen.id .. " Color", {0,255,0})
    settings.color.value = backColor.value

    currentGreenscreenIdentifier = currentGreenscreenIdentifier + 1
    table.insert(currentGreenScreens, greenscreen)
end
function sendErrorMessage(msg)
    if hideErrors.value then return end
    print(msg)
end

function render3d()
    local wallOffset = 0.05
    for _, w in pairs(currentGreenScreens) do
        if onlyUseMainColor.value then
            gfx.color(backColor)
        else
            gfx.color(w.settings.color)
        end
        
        gfx.quad(
            w.start.x+wallOffset, w.start.y+wallOffset, w.start.z+wallOffset,
            w.start.x+wallOffset, w.stop.y+wallOffset, w.start.z+wallOffset,
            w.stop.x+wallOffset, w.stop.y+wallOffset, w.stop.z+wallOffset,
            w.stop.x+wallOffset, w.start.y+wallOffset, w.stop.z+wallOffset, true
        )
        gfx.quad(
            w.start.x-wallOffset, w.start.y-wallOffset, w.start.z-wallOffset,
            w.start.x-wallOffset, w.stop.y-wallOffset, w.start.z-wallOffset,
            w.stop.x-wallOffset, w.stop.y-wallOffset, w.stop.z-wallOffset,
            w.stop.x-wallOffset, w.start.y-wallOffset, w.stop.z-wallOffset, true
        )
    end

end

function putPoint()
    if player.facingBlock() == false then return sendErrorMessage("§cMake sure to look at a block!") end
    if hasFirstPoint == false then
        local x,y,z = player.lookingPos()
        firstGreenScreenPoint = {x=x,y=y,z=z}
        hasFirstPoint = true
        if hideSuccessMessage.value == false then
            print("§aFist point placed!")
        end
    else
        local x,y,z = player.lookingPos()
        makeGreenScreen(firstGreenScreenPoint, {x=x,y=y,z=z})
        if hideSuccessMessage.value == false then
            print("§aGreenscreen Created!")
        end
        hasFirstPoint = false
    end
end

event.listen("KeyboardInput", function(key, down)
    if gui.mouseGrabbed() == false and key == greenScrenKey.value and down then putPoint() end
end)