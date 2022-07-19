name="schematic"
description = "Schematic mod by MCBE Craft"


--[[
    By MCBE Craft
]]


lib = importLib("MinimapBlockTools.lua")
lib = importLib("renderthreeD.lua")
lib = importLib("fileUtility.lua")

renderDistance = 32
client.settings.addInt("Render Distance", "renderDistance", 1, 512)

client.settings.addAir(5)
color = {255, 255, 255, 255}
client.settings.addColor("Selected are lines color", "color")


local structs = {}
local min, max, layer
local timer = 0
local toExecute = {}
local helpMessages = {
    scStruct={{"name"}, "Creates structure [name] from the selection with the [name]"},
    scSave={{"name"}, "Places structure [name] into [name].json in data/schematic"},
    scLoad={{"name"}, "Creates structure [name] from [name].json in data/schematic"},
    scUnload={{"name"}, "Forgets structure [name]"},
    scList={nil, "Gives the name of all loaded and saved structures"},
    scLayer={{nil, "+", "-", "number"}, "Only displays a certain layer of the structures"},
    scBlock={{"name"}, "Gives the block list of the structure [name]"},
    scGive={{"name"}, "Gives a chest with the blocks needed to build the structure [name]"},
    scWand={{nil}, "Gives the wand tool to select areas by right/left clicking"},
    scPos={{nil, 1, 2}, "Sets the position of the selected area"}
}

local function getMin(name)
    local min = nil
    for k, v in pairs(structs[name]) do
        if not min or v.pos[2] < min then
            min = v.pos[2]
        end
    end
    return min
end

function update(dt)
    UpdateMapTools()
    timer = timer + dt
    if #toExecute > 0 and timer >= 0.5 then
        client.execute(toExecute[1])
        table.remove(toExecute, 1)
        timer = 0
    end
end

local function distance3d(x1, y1, z1, x2, y2, z2)
    return math.sqrt((x2-x1)*(x2-x1)+(y2-y1)*(y2-y1)+(z2-z1)*(z2-z1))
end

local function containsBlocks(name, x, y, z)
    for i, v in ipairs(structs[name]) do
        if v.pos[1] == x and v.pos[2] == y and v.pos[3] == z then
            return true
        end
    end
    return false
end

local function blockHidden(name, x, y, z)
    local px, py, pz = player.position()
    py = py + 1
    local result = true
    if x == px and y == py and z == pz then return false end
    if x < px then
        if not containsBlocks(name, x+1, y, z) then result = false end
    end
    if x > px then
        if not containsBlocks(name, x-1, y, z) then result = false end
    end
    if y < py then
        if (not containsBlocks(name, x, y+1, z)) or layer ~= nil then result = false end
    end
    if y > py then
        if (not containsBlocks(name, x, y-1, z)) or layer ~= nil  then result = false end
    end
    if z < pz then
        if not containsBlocks(name, x, y, z+1) then result = false end
    end
    if z > pz then
        if not containsBlocks(name, x, y, z-1) then result = false end
    end
    return result
end

function render3d()
    gfx.renderBehind(false)
    client.execute("waypoint clear")
    local x, y, z = player.position()
    for ks, vs in pairs(structs) do
        for i, v in ipairs(vs) do
            if (not layer or layer == v.pos[2] - getMin(ks)) and (distance3d(v.pos[1], v.pos[2], v.pos[3], x, y, z) < tonumber(renderDistance)) and not blockHidden(ks, v.pos[1], v.pos[2], v.pos[3]) then
                local block = dimension.getBlock(v.pos[1], v.pos[2], v.pos[3])
                if block.id ~= 0 and (block.id ~= v.id or block.data ~= v.data) then
                    gfx.color(200, 0, 0, 100)
                    cube(v.pos[1] - 0.001, v.pos[2] - 0.001, v.pos[3] - 0.001, 1.002)
                    client.execute("waypoint add " .. v.name .. "(" .. v.id .. "," .. v.data .. ") " .. v.pos[1] .. " " .. v.pos[2] .. " " .. v.pos[3])
                elseif block.id ~= v.id or block.data ~= v.data then
                    local blockColor = getMapColorId(v.id, v.data)
                    gfx.color(blockColor[1], blockColor[2], blockColor[3], 100)
                    cube(v.pos[1] - 0.001, v.pos[2] - 0.001, v.pos[3] - 0.001, 1.002)
                end
            end
        end
    end
    if min and max then
        local x1, y1, z1, x2, y2, z2 = min[1], min[2], min[3], max[1], max[2], max[3]
        if x1 > x2 then
            x1 = x1 + 1
        else
            x2 = x2 + 1
        end
        if y1 > y2 then
            y1 = y1 + 1
        else
            y2 = y2 + 1
        end
        if z1 > z2 then
            z1 = z1 + 1
        else
            z2 = z2 + 1
        end
        gfx.renderBehind(true)
        gfx.color(color.r, color.g, color.b, color.a)
        gfx.line(x1, y1, z1, x2, y1, z1)
        gfx.line(x1, y1, z1, x1, y2, z1)
        gfx.line(x1, y1, z1, x1, y1, z2)
        gfx.line(x1, y2, z2, x2, y2, z2)
        gfx.line(x2, y1, z2, x2, y2, z2)
        gfx.line(x2, y2, z1, x2, y2, z2)
        gfx.line(x1, y2, z1, x1, y2, z2)
        gfx.line(x1, y2, z1, x2, y2, z1)
        gfx.line(x1, y1, z2, x2, y1, z2)
        gfx.line(x2, y1, z1, x2, y1, z2)
        gfx.line(x1, y1, z2, x1, y2, z2)
        gfx.line(x2, y1, z1, x2, y2, z1)
    end
end

event.listen("MouseInput", function(button, down)
	local inventory = player.inventory()
    local selected = inventory.at(inventory.selected)
    local x,y,z = player.selectedPos()
    if (down == true and gui.mouseGrabbed() == false and selected ~= nil and selected.id == 308) then
        if (x == 0 and y == 0 and z == 0) then
            x,y,z = player.position()
        end
        if (button == 1) then
            min = {x, y, z}
            print("§eposition 1 set to " .. x .. ", " .. y .. ", " .. z)
        elseif (button == 2) then
            max = {x, y, z}
            print("§eposition 2 set to " .. x .. ", " .. y .. ", " .. z)
        end
    end
end)

registerCommand("scStruct", function (arguments)
    local blocks = {}
    local ii = 1
    if max[1] < min[1] then ii = -1 end
    for i = min[1], max[1], ii do
        local ij = 1
        if max[2] < min[2] then ij = -1 end
        for j = min[2], max[2], ij do
            local ik = 1
            if max[3] < min[3] then ik = -1 end
            for k = min[3], max[3], ik do
                local block = dimension.getBlock(i, j, k)
                if block ~= nil and block.id ~= 0 then
                    table.insert(blocks, {id=block.id, data=block.data, name=block.name, pos={i, j, k}})
                end
            end
        end
    end
    structs[arguments] = blocks
    print("§e" .. arguments .. " has been loaded")
end)

local function saveStruct(name)
    local x, y, z = player.lookingPos()
    local struct = {}
    for k, v in pairs(structs[name]) do
        struct[k] = {id=v.id, data=v.data, name=v.name, pos={v.pos[1] - math.floor(x), v.pos[2] - math.floor(y), v.pos[3] - math.floor(z)}}
    end
    return struct
end

registerCommand("scSave", function (arguments)
    if not fs.exist(name) then fs.mkdir(name) end
    if structs[arguments] then
        jsonDump(saveStruct(arguments), name .. "/" .. arguments .. ".json")
        print("§e" .. arguments .. " has been saved")
    else
        print("§e" .. arguments .. " isn't loaded")
    end
end)

local function loadStruct(struct)
    local x, y, z = player.lookingPos()
    local newStruct = {}
    for k, v in pairs(struct) do
        newStruct[k] = {id=v.id, data=v.data, name=v.name, pos={v.pos[1] + math.floor(x), v.pos[2] + math.floor(y), v.pos[3] + math.floor(z)}}
    end
    return newStruct
end

registerCommand("scLoad", function (arguments)
    if fs.exist(name .. "/" .. arguments .. ".json") then
        structs[arguments] = loadStruct(jsonLoad(name .. "/" .. arguments .. ".json"))
        print("§e" .. arguments .. " has been loaded")
    else
        print("§e" .. arguments .. " isn't saved")
    end
end)

registerCommand("scList", function (arguments)
    local result = "§eCurrently loaded structures: "
    for k, v in pairs(structs) do
        result = result .. k .. " "
    end
    result = result .. "\nCurrently saved structures: "
    for i, v in ipairs(fs.files(name)) do
        result = result .. string.sub(v, #name + 2, #v-5) .. " "
    end
    print(result)
end)

registerCommand("scLayer", function (arguments)
    if arguments ~= "" and arguments ~= nil then
        if arguments == "+" then
            if not layer then
                layer = 0
            else
                layer = layer + 1
            end
        elseif arguments == "-" then
            if not layer then
                layer = 0
            else
                layer = layer - 1
            end
        else
            layer = tonumber(arguments)
        end
        if layer < 0 then
            layer = nil
        end
    else
        if not layer then
            layer = 0
        else
            layer = nil
        end
    end
    if layer then
        print("§eSwitched to layer " .. layer)
    else
        print("§eDisabled layer")
    end

end)

registerCommand("scBlock", function (arguments)
    if structs[arguments] then
        local blocks = {}
        for k, v in pairs(structs[arguments]) do
            if not blocks[v.name] then
                blocks[v.name] = 1
            else
                blocks[v.name] = blocks[v.name] + 1
            end
        end
        local result = "§eNeeded blocks for " .. arguments .. ": "
        for k, v in pairs(blocks) do
            result = result .. k .. ": " .. v .. " "
        end
        print(result)
    else
        print("§e" .. arguments .. " isn't loaded")
    end
end)

registerCommand("scGive", function (arguments)
    if structs[arguments] then
        local blocks = {}
        for k, v in pairs(structs[arguments]) do
            if not blocks[v.name] then
                blocks[v.name] = 1
            else
                blocks[v.name] = blocks[v.name] + 1
            end
        end
        local nbt = "{\"Items\":["
        local newBlocks = {}
        for k, v in pairs(blocks) do
            local quantity = v
            for i = 1, v, 64 do
                if quantity < 64 then
                    table.insert(newBlocks, {"block", k, quantity})
                else
                    table.insert(newBlocks, {"block", k, 64})
                    --nbt = nbt .. "{\"Count\":" .. 64 .. "b,\"Name\":\"minecraft:" .. k .. "\",\"Slot\":" .. slot .. "b}"
                    quantity = quantity - 64
                end
                --slot = slot + 1
            end
        end
        nbt = nbt .. blockToNbt(blockChest(newBlocks)) .. "],\"display\":{\"Lore\":[\"(+MATERIALS)\"]}}"
        table.insert(toExecute, "execute /replaceitem entity @s slot.weapon.mainhand 1 chest")
        table.insert(toExecute, "nbt write " .. nbt)
        print("§eGiving items")
    else
        print("§e" .. arguments .. " isn't loaded")
    end
end)

function blockChest(blocks)
    if #blocks > 27 then
        local newBlocks = {}
        for i = 1, #blocks, 27 do
            table.insert(newBlocks, subList(blocks, i, i+27))
        end
        return blockChest(newBlocks)
    else
        return blocks
    end
end

function subList(list, minmax, max)
    if not max then
        max = minmax
        minmax = 1
    end
    local table2 = {}
    for i = minmax, max, 1 do
        if list[i] then
            table.insert(table2, list[i])
        end
    end
    return table2
end

function blockToNbt(blocks)
    local nbt = ""
    for i, v in ipairs(blocks) do
        if v[1] == "block" then
            nbt = nbt .. "{\"Count\":" .. v[3] .. "b,\"Name\":\"minecraft:" .. v[2] .. "\",\"Slot\":" .. i-1 .. "b}"
            if i ~= #blocks then
                nbt = nbt .. ","
            end
        else
            nbt = nbt ..  "{\"Count\":1b,\"Name\":\"minecraft:chest\",\"Slot\":" .. i-1 .. "b,\"tag\":{\"Items\":[" .. blockToNbt(v) .. "],\"display\":{\"Lore\":[\"(+MATERIALS)\"]}}}"
            if i ~= #blocks then
                nbt = nbt .. ","
            end
        end
    end
    return nbt
end

registerCommand("scUnload", function (arguments)
    if structs[arguments] then
        structs[arguments] = nil
        print("§e" .. arguments .. " has been unloaded")
    else
        print("§e" .. arguments .. " isn't loaded")
    end
end)

registerCommand("scWand", function (arguments)
    client.execute("execute /give @s wooden_sword")
    print("§eGave wand item")
end)

registerCommand("scPos", function (arguments)
    local x,y,z = player.selectedPos()
    if (x == 0 and y == 0 and z == 0) then
        x,y,z = player.position()
    end
    if (arguments == "1") then
        min = {x, y, z}
        print("§eposition 1 set to " .. x .. ", " .. y .. ", " .. z)
    elseif (arguments == "2") then
        max = {x, y, z}
        print("§eposition 2 set to " .. x .. ", " .. y .. ", " .. z)
    else
        min = {x, y, z}
        max = {x, y, z}
        print("§eposition 1&2 set to " .. x .. ", " .. y .. ", " .. z)
    end
end)


registerCommand("scHelp", function (arguments)
    local result = ""
    for command, message in pairs(helpMessages) do
        result = result .. command .. " "
        if message[1] then
            for i, v in ipairs(message[1]) do
                result = result .. "<" .. v .. "> "
            end
        end
        result = result .. ": " .. message[2] .. "\n"
    end
    print(result)
end)

