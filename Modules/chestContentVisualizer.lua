name="Chest Visualizer"
description="Shows content of the selected chest"

positionX = 100
positionY = 100
sizeX = 176
sizeY = 80

local content
local type = "false"

local uiSize = {
    uiTop=21,
    uiBot=5,
    chestMid=54,
    dispMid=54,
    furnaceMid=56,
    hopperMid=18
}

local container = {
    DoubleChest={"uiTop", "chestMid", "chestMid", "uiBot"},
    Chest={"uiTop", "chestMid", "uiBot"},
    Barrel={"uiTop", "chestMid", "uiBot"},
    ShulkerBox={"uiTop", "chestMid", "uiBot"},
    Dispenser={"uiTop", "dispMid", "uiBot"},
    Dropper={"uiTop", "dispMid", "uiBot"},
    Furnace={"uiTop", "furnaceMid", "uiBot"},
    BlastFurnace={"uiTop", "furnaceMid", "uiBot"},
    Smoker={"uiTop", "furnaceMid", "uiBot"},
    Hopper={"uiTop", "hopperMid", "uiBot"}
}

local cookTimes = {
    Furnace = 200,
    BlastFurnace = 100,
    Smoker = 100
}

function postInit()
    for k, _ in pairs(uiSize) do
        if not fs.exist("ui/" .. k .. ".png") then
            print("no " .. k)
            network.fileget("ui/" .. k .. ".png", "https://raw.githubusercontent.com/OnixClient-Scripts/OnixClient_Scripts/master/Data/ui/" .. k .. ".png", "image")
        end
    end
end

function onNetworkData(code, id, data)
    print("code: " .. code .. " id: " .. id .. " data: " .. data)
end

function render(dt)
    if content then
        local yVal = 0
        if container[type][2] == "furnaceMid" then
            gfx.color(183, 183, 183)
            gfx.rect(40, 40, 60, 40)
            if content["CookTime"] then
                gfx.color(255, 255, 255)
                gfx.rect(77, 40, content["CookTime"]/cookTimes[type]*22, 40)
            end
            if content["BurnTime"] then
                gfx.color(255, 182, 0)
                gfx.rect(50, 43+13-13*content["BurnTime"], 22, 13)
            end
        end
        for _, v in ipairs(container[type]) do
            if fs.exist("ui/" .. v .. ".png") then
                gfx.image(0, yVal, 176, uiSize[v], "ui/" .. v .. ".png")
            end
            yVal = yVal + uiSize[v]
        end
        gfx.color(76, 76, 76)
        gfx.text(88-gui.font().width(type)/2, 12, type)
        gfx.color(255, 255, 255)
        if container[type][2] == "chestMid" then
            for i, v in pairs(content) do
                gfx.item((i % 9) * 18 + 8, (i // 9) * 18 + 22, itemFromNbt(v))
                if v.Count >= 10 then
                    gfx.text((i % 9) * 18 + 13, (i // 9) * 18 + 30, tostring(v.Count))
                elseif v.Count > 1 then
                    gfx.text((i % 9) * 18 + 18, (i // 9) * 18 + 30, tostring(v.Count))
                end
            end
        elseif container[type][2] == "dispMid" then
            for i, v in pairs(content) do
                gfx.item((i % 3) * 18 + 62, (i // 3) * 18 + 22, itemFromNbt(v))
                if v.Count >= 10 then
                    gfx.text((i % 3) * 18 + 67, (i // 3) * 18 + 30, tostring(v.Count))
                elseif v.Count > 1 then
                    gfx.text((i % 3) * 18 + 72, (i // 3) * 18 + 30, tostring(v.Count))
                end
            end
        elseif container[type][2] == "hopperMid" then
            for i, v in pairs(content) do
                gfx.item(i * 18 + 44, 22, itemFromNbt(v))
                if v.Count >= 10 then
                    gfx.text(i * 18 + 49, 30, tostring(v.Count))
                elseif v.Count > 1 then
                    gfx.text(i * 18 + 54, 30, tostring(v.Count))
                end
            end
        elseif container[type][2] == "furnaceMid" then
            if content[0] then
                v = content[0]
                gfx.item(51, 22, itemFromNbt(v))
                if v.Count >= 10 then
                    gfx.text(56, 30, tostring(v.Count))
                elseif v.Count > 1 then
                    gfx.text(61, 30, tostring(v.Count))
                end
            end
            if content[1] then
                gfx.item(51, 60, itemFromNbt(content[1]))
                if content[1].Count >= 10 then
                    gfx.text(56, 68, tostring(content[1].Count))
                elseif content[1].Count > 1 then
                    gfx.text(61, 68, tostring(content[1].Count))
                end
            end
            if content[2] then
                v = content[2]
                gfx.item(113, 42, itemFromNbt(v))
                if v.Count >= 10 then
                    gfx.text(118, 51, tostring(v.Count))
                elseif v.Count > 1 then
                    gfx.text(123, 51, tostring(v.Count))
                end
            end
        end
    end
end

local ids = {54, 23, 154, 125, 84, 218, 205, 458, 146, 453, 451, 61, 62, 469, 454}
local containerIds = {}
for _, v in pairs(ids) do
    containerIds[v] = ""
end

event.listen("LocalServerUpdate", function()
    local x,y,z = player.selectedPos()
    local block = dimension.getBlock(math.floor(x),math.floor(y),math.floor(z))

    if containerIds[block.id] then
        local serverBlock = dimension.getBlockEntity(x, y, z, true)
        if not serverBlock["Items"] then
            content = nil
            return
        end
        content = {}
        if serverBlock["pairlead"] then
            type = "DoubleChest"
        else
            type = serverBlock["id"]
        end
        if serverBlock["CookTime"] then
            content["CookTime"] = string.sub(serverBlock["CookTime"], 1, -1)
        end
        if serverBlock["BurnTime"] and serverBlock["BurnDuration"] then
            content["BurnTime"] = string.sub(serverBlock["BurnTime"], 1, -1) / string.sub(serverBlock["BurnDuration"], 1, -1)
        end
        if not serverBlock["pairlead"] or serverBlock["pairlead"] == 1 then
            for _, v in pairs(serverBlock["Items"]) do
                if v["Slot"] then 
                    content[v["Slot"]] = v
                end
            end
        else
            for _, v in pairs(serverBlock["Items"]) do
                if v["Slot"] then 
                    content[v["Slot"] + 27] = v
                end
            end
        end
        if serverBlock["pairlead"] then
            local serverBlock2 = dimension.getBlockEntity(serverBlock["pairx"], y, serverBlock["pairz"], true)
            if serverBlock2["pairlead"] == 0 then
                for k, v in pairs(serverBlock2["Items"]) do
                    if v["Slot"] then 
                        content[v["Slot"] + 27] = v
                    end
                end
            else
                for _, v in pairs(serverBlock2["Items"]) do
                    if v["Slot"] then
                        content[v["Slot"]] = v
                    end
                end
            end
        end
    else
        content = nil
    end
end)