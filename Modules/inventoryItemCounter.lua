name="Inventory Item Counter"
description="something to keep track of the amount of items in your inventory"

--[[
    Script originally made by Onix86
]]

positionX = 35
positionY = 120
sizeX = 25
sizeY = 25

skipNonStackable = true
minimumCountToShow = 1
itemInHandOnTop = true
handItemOnly = false

client.settings.addBool("Skip non-stackable Items", "skipNonStackable")
client.settings.addInt("Minimum Amount to Show", "minimumCountToShow", 1, 128)

client.settings.addAir(5)
client.settings.addBool("Hand Item on Top", "itemInHandOnTop")
client.settings.addBool("Hand Item Only", "handItemOnly")

client.settings.addAir(10)
textColor = client.settings.addNamelessColor("Text Color", {255,255,255, 127})
backColor = client.settings.addNamelessColor("Background Color", {0, 0, 0, 127})
roundedCornerRadius = client.settings.addNamelessFloat("Roundness ^('_')^", 0, 10, 2)
roundedCornerQuality = client.settings.addNamelessFloat("Triangleness <><><><>", 1, 15, 5)

function render()
    local inventory = player.inventory()

    local items = {}
    local itemt = 1
    
    -- what will check items
    function checkItem(item)
        if item == nil then goto next end
        if skipNonStackable == true and item.maxStack == 1 then goto next end
        

        for i=1,itemt-1 do
            local info = items[i]
            if info ~= nil and info.id == item.id then
                items[i].count = info.count + item.count
                goto next
            end
        end

        items[itemt] = {count=item.count,location=item.location,id=item.id}
        itemt = itemt + 1

        ::next::
    end


    --scan the items, we could add armor but i don't think its important for that (just call checkItem with the armor if you want it tho)
    for i=1,36 do
        local item = inventory.at(i)
        checkItem(item)
    end
    checkItem(inventory.offhand())

    table.sort(items, function(a,b) return a.count > b.count end)

    -- do we need to move the hand item?
    if itemInHandOnTop == true or handItemOnly == true then
        local handItem = inventory.at(inventory.selected)
        if handItem == nil then goto bye end

        table.sort(items, function(a,b) if (a.id == handItem.id) then return true elseif (b.id == handItem.id) then return false else return a.count > b.count end end)
        ::bye::
    end


    --calculate the size of the module
    local font = gui.font()

    local yval = 2
    local yjump = 10
    local maxTextWidth = 0
    local hasOneItem = false
    for name, item in pairs(items) do
        if item.count >= minimumCountToShow then 
            local text = "" .. item.count
            local w = font.width(text)
            if (w > maxTextWidth) then maxTextWidth = w end

            yval = yval + yjump + 2
            hasOneItem = true
        end
        if handItemOnly == true then break end
    end
    if hasOneItem == false then sizeY = yval + yjump + 2 sizeX = 27 return end

    --set the size
    sizeX = maxTextWidth + 17
    sizeY = yval

    if (handItemOnly == true and inventory.at(inventory.selected) == nil) then return end

    --background
    gfx.color(backColor)
    gfx.roundRect(0,0, sizeX, sizeY, roundedCornerRadius.value, roundedCornerQuality.value)

    --render the module
    yval = 2
    yjump = 10
    gfx.color(textColor)
    for name, item in pairs(items) do
        if item.count >= minimumCountToShow then 
            gfx.item(1, yval, item.location, 0.69)
            local text = "" .. item.count
            gfx.text(15, yval + 2, text)

            yval = yval + yjump + 2
        end
        if handItemOnly == true then break end
    end
end
