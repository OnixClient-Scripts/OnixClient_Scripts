name = "Half Life 2 GUI"
description = "Recreates the HalfLife 2 GUI, Based on the HalfLife 2 Episode 2 HUD"
--[[
    Made by: Raspberry#8582
    with help from:
    - jqms#9999
    - Onix86#0001
]]-- 

-- colors
indicator_color = {255, 186, 25}
low_indicator_color = {255, 0, 0}
background = {0,0,0,64}

client.settings.addColor("Background Color","background")
client.settings.addColor("Indicator Color","indicator_color")
client.settings.addColor("Low Indicator Color","low_indicator_color")

-- list of all obtainable light sources in minecraft

local light_sources = {
    "beacon",
    "conduit",
    "end_portal_frame",
    "pearlescent_froglight",
    "verdant_froglight",
    "ochre_froglight"
}

local function contains(table, val) for i=1,#table do if table[i] == val then return true end end return false end -- checks if a table contains something
local function format_string(str) return string.gsub(string.gsub(str, "_", " "), "%S+", function(word) return string.upper(string.sub(word, 1, 1)) .. string.sub(word, 2) end) end -- reformats item name like item_name to Item Name
-- puts the selected invoentory to 1 so this module wont break
function postInit() player.inventory().setSelectedSlot(1) end

-- made the rendering funcs in separate funcs so i can fold it in vsc

function render_health()
    -- health
    local health_color = indicator_color
    gfx2.color(background[1],background[2],background[3],background[4])
    gfx2.fillRect(10,gui.height() - 35,70,25)
    gfx2.color(health_color[1],health_color[2],health_color[3])
    gfx2.text(16,gui.height() - 20,"HEALTH")
    -- player health
    health = math.floor(player.attributes().name("minecraft:health").value * 5)
    gfx2.text(45,gui.height() - 35,tostring(health),3)
    -- color health red if low
    if health < 20 then
        health_color = low_indicator_color
    else
        health_color = indicator_color
    end
end

function render_suit()
    local suit_color = indicator_color
    -- suit start
    gfx2.color(background[1],background[2],background[3],background[4])
    gfx2.fillRect(90,gui.height() - 35,70,25)
    gfx2.color(suit_color[1],suit_color[2],suit_color[3])
    gfx2.text(96,gui.height() - 20,"SUIT")
    -- getting average of all armor pieces
    local total_durability = 0
    local current_durability = 0
    local armors = player.inventory().armor()
    local h,c,l,b = armors.helmet, armors.chestplate, armors.leggings, armors.boots
    for _,armor in pairs({h,c,l,b}) do
        if armor ~= nil then
            total_durability = total_durability + armor.maxDamage
            current_durability = current_durability + armor.maxDamage - armor.durability
        end
    end
    -- print("t: "..total_durability.." c: "..current_durability)
    -- calculating percentage
    local average = math.floor((current_durability / total_durability) * 100)
    -- color suit red if low
    if average < 20 then
        suit_color = low_indicator_color
    else
        suit_color = indicator_color
    end
    -- way to remove that stupid -nan(ind) thing
    local s = ''
    if tostring(average) == "-nan(ind)" then
        s = "0"
    else
        s = tostring(average)
    end
    gfx2.text(125,gui.height() - 35,s, 3)
    -- suit end

end

function render_flashlight()
    -- flashlight icon
    -- turns on when someone is holding a light source
    gfx2.color(background[1],background[2],background[3],background[4])
    gfx2.fillRect(170, gui.height() - 25, 30, 15)
    -- flashlight icon
    local alpha = 64
    -- change alpha if holding a light source
    if player.inventory().at(player.inventory().selected) ~= nil then
    if contains(light_sources,player.inventory().at(player.inventory().selected).name) then
        alpha = 255
    else
        alpha = 64
    end
    end
    gfx2.color(indicator_color[1], indicator_color[2], indicator_color[3], alpha)
    gfx2.fillRect(173,gui.height() - 20, 15, 5)
    gfx2.fillTriangle(188,gui.height() - 20, 191, gui.height() - 20, 191, gui.height() - 23)
    gfx2.fillRect(191,gui.height() - 23, 3, 3)
    gfx2.fillRect(188,gui.height() - 20, 6, 5)
    gfx2.fillTriangle(188,gui.height() - 15, 191, gui.height() - 15, 191, gui.height() - 12)
    gfx2.fillRect(191,gui.height() - 15, 3, 3)
    gfx2.fillRect(195, gui.height() - 23, 3,11)
end

function render_ammo()
    gfx.color(background[1],background[2],background[3],background[4])
    gfx.rect(gui.width() - 80,gui.height() - 35,70,25)
    if player.inventory().at(player.inventory().selected) then
        gfx.item(gui.width() - 80,gui.height() - 35,player.inventory().at(player.inventory().selected))
        gfx.color(indicator_color[1],indicator_color[2],indicator_color[3])
        gfx.text(gui.width() - 80,gui.height() - 20,format_string(player.inventory().at(player.inventory().selected).name),1)
        if player.inventory().at(player.inventory().selected).maxDamage == 0 then -- if its a regular item
            gfx.text(gui.width() - 55,gui.height() - 35,tostring(player.inventory().at(player.inventory().selected).count),2)
            gfx.text(gui.width() - 37.5,gui.height() - 30,"/ "..tostring(player.inventory().at(player.inventory().selected).maxStackCount),1.5)
        else -- if its a weapon
            gfx.text(gui.width() - 55,gui.height() - 35,tostring(player.inventory().at(player.inventory().selected).maxDamage - player.inventory().at(player.inventory().selected).durability),2)
            gfx.text(gui.width() - 37.5,gui.height() - 30,"/ "..tostring(player.inventory().at(player.inventory().selected).maxDamage),1.5)
        end
    end
end
local scrolling = false
function render2(dt)
    render_health()
    render_suit()
    render_flashlight()
end

--pls donnt mess with this atm
-- local pos = {
--     {gui.width()/2 - 125, 50}, --1
--     {gui.width()/2 - 70, 20}, --2
--     {gui.width()/2 - 45, 20}, --3
--     {gui.width()/2 - 20, 20}, --4
--     {gui.width()/2 - -5, 20}, --5
--     {gui.width()/2 + 30, 20}, --6
--     {gui.width()/2 + 55, 20}, --7
--     {gui.width()/2 + 80, 20}, --8
--     {gui.width()/2 + 105, 20} --9
-- }
-- local firstItemTbl = {
--     {gui.width()/2 - 125, 50}, --1
--     {gui.width()/2 - 70, 20}, --2
--     {gui.width()/2 - 45, 20}, --3
--     {gui.width()/2 - 20, 20}, --4
--     {gui.width()/2 - -5, 20}, --5
--     {gui.width()/2 + 30, 20}, --6
--     {gui.width()/2 + 55, 20}, --7
--     {gui.width()/2 + 80, 20}, --8
--     {gui.width()/2 + 105, 20} --9
-- }
function render(dt)
    -- using this func because there's no equivalent for gfx.item in new renderer
    -- gfx.color(background[1],background[2],background[3],background[4])
    -- gfx.rect(gui.width()/2 - 25, 30,50, 50)
    -- if player.inventory().at(player.inventory().selected) then
    -- gfx.item(gui.width()/2 - 24, 30,player.inventory().at(player.inventory().selected),3) end
    -- if scrolling then
    -- end
    -- ammo
    render_ammo()
    -- ok this is the scrolling items part
    -- for _, a in ipairs(pos) do
    --     gfx.color(background[1],background[2],background[3],background[4])
    --     gfx.rect(a[1],30,a[2],a[2])
    --     if player.inventory().at(player.inventory().selected) and player.inventory().selected == _ then
    --         gfx.item(a[1],30,player.inventory().at(player.inventory().selected),3)
    --         gfx.color(indicator_color[1],indicator_color[2],indicator_color[3])
    --         gfx.text(gui.width()/2 - gui.font().width(player.inventory().at(player.inventory().selected).name)/2, 55,player.inventory().at(player.inventory().selected).name)
    --     else 
    --         gfx.color(indicator_color[1],indicator_color[2],indicator_color[3])
    --         gfx.text(a[1],30,tostring(_),1.25) end
    -- end
    -- end
end

-- local clicked = false
-- local prev = 1
-- local function shiftToRight()
--     pos[player.inventory().selected][2] = 20
--     pos[player.inventory().selected + 1][1] = pos[player.inventory().selected + 1][1] - 30
--     pos[player.inventory().selected + 1][2] = 50
-- end
-- local function shiftToLeft()
--     pos[player.inventory().selected][2] = 20
--     pos[player.inventory().selected][1] = pos[player.inventory().selected][1] + 30
--     pos[player.inventory().selected - 1][2] = 50
-- end
-- -- event.listen("MouseInput", function(button, down)
--     if button == 4 then -- mouse scroll
--         if down then -- scrolling down
--             scrolling = true
--             if prev == 9 and player.inventory().selected == 1 then
--                 prev = player.inventory().selected
--                 pos = firstItemTbl
--                 return nil
--             end
--             prev = player.inventory().selected
--             pos[player.inventory().selected][2] = 20
--             pos[player.inventory().selected + 1][1] = pos[player.inventory().selected + 1][1] - 30
--             pos[player.inventory().selected + 1][2] = 50
--         elseif not down then --scrolling up
--             scrolling = true
--             if prev == 1 and player.inventory().selected == 9 then
--                 for i = 1, 8, 1 do
--                     pos[i][2] = 20
--                     pos[i + 1][1] = pos[i + 1][1] - 30
--                     pos[i + 1][2] = 50
--                 end
--             end
--             prev = player.inventory().selected
--             pos[player.inventory().selected][2] = 20
--             pos[player.inventory().selected][1] = pos[player.inventory().selected][1] + 30
--             pos[player.inventory().selected - 1][2] = 50
--         end
        
--     else scrolling = false end
-- end)