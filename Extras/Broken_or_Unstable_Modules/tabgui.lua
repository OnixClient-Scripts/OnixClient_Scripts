name="TabGui"
description="A simple tabgui"
--[[
    Arraylist Module Script
    
    made by Onix86
]]
positionX = 5
positionY = 5
sizeX = 166
sizeY = 45

use_in_ui = false
client.settings.addBool("Allow Interactions in UI", "use_in_ui")

animate = true
client.settings.addBool("Animate", "animate")




selectedCategory = 2
selectedModule = 0
categoryOpenedSince = 0

local categories = {}
table.insert(categories, 1, "None")
table.insert(categories, 2, "World")
table.insert(categories, 3, "Player")
table.insert(categories, 4, "Visual")
table.insert(categories, 5, "Misc")
table.insert(categories, 6, "Script")

function cagegoryToName(cat)
    if cat < 1 then return "None" end
    if cat > 6 then return "None" end
    return categories[cat]
end


local ModuleCategories = {}
ModuleCategories["Armor HUD"] = 4
ModuleCategories["Auto GG"] = 5
ModuleCategories["Chunk Border"] = 2
ModuleCategories["Combo Counter"] = 4
ModuleCategories["CPS Counter"] = 4
ModuleCategories["Custom Crosshair"] = 4
ModuleCategories["Environment Changer"] = 2
ModuleCategories["FPS Counter"] = 4
ModuleCategories["Fullbright"] = 2
ModuleCategories["Hurt Color"] = 3
ModuleCategories["Java Debug Menu"] = 5
ModuleCategories["Light Overlay"] = 2
ModuleCategories["Pack Display"] = 4
ModuleCategories["Potion HUD"] = 3
ModuleCategories["Render Options"] = 5
ModuleCategories["Snake"] = 5
ModuleCategories["Third Person Nametag"] = 3
ModuleCategories["Toggle Sprint/Sneak"] = 3
ModuleCategories["Zoom"] = 5
ModuleCategories["Audio Subtitles"] = 2
ModuleCategories["Block Outline/Overlay"] = 2
ModuleCategories["Clock"] = 4
ModuleCategories["Coordinates"] = 4
ModuleCategories["Creative Tools"] = 5
ModuleCategories["Direction HUD"] = 4
ModuleCategories["Flappy Bird"] = 5
ModuleCategories["Freelook"] = 3
ModuleCategories["Hitboxes"] = 3
ModuleCategories["Item Physics"] = 2
ModuleCategories["Keystrokes"] = 4
ModuleCategories["Movable Paperdoll"] = 4
ModuleCategories["Player List Tab"] = 4
ModuleCategories["Reach Display"] = 4
ModuleCategories["Server IP"] = 4
ModuleCategories["Speed Display"] = 4
ModuleCategories["TNT Timer"] = 3
ModuleCategories["Waypoints"] = 2

function categoriseModule(module)
    local cat = ModuleCategories[module.name]
    if (cat == nil) then
        if (module.isScript) then
            return 6 --script
        else
            return 5 --misc
        end
    end
    return cat
end

userInteractions = {}

function keyboard(key, down)
    if use_in_ui == false and gui.mouseGrabbed() == true then return end
    if down == false then return end
    if key == 0x26 then
        table.insert(userInteractions, 1)
    elseif key == 0x25 then
        table.insert(userInteractions, 2)
    elseif key == 0x28 then
        table.insert(userInteractions, 3)
    elseif key == 0x27 then
        table.insert(userInteractions, 4)
    end
end
event.listen("KeyboardInput", keyboard)


function tableLenght(t)
    local result = 0
    for a,b in pairs(t) do result = result + 1 end
    return result
end


function render(dt)
    local font = gui.font()
    local moduleWidth = 95
    if font.isMinecraftia == true then
        sizeX = 166
        moduleWidth = 115
    else
        sizeX = 146
    end
    sizeY = (font.wrap + 2) * 5

    for k, v in pairs(userInteractions) do
        if v == 1 then --up
            if selectedModule > 0 then
                selectedModule = selectedModule - 1
                if selectedModule <= 0 then selectedModule = tableLenght(modulesInCategory[selectedCategory]) end
            else
                selectedCategory = selectedCategory - 1
                if selectedCategory <= 1 then selectedCategory = 6 end
            end
        elseif v == 2 then --left
            selectedModule = 0
        elseif v == 3 then --down
            if selectedModule > 0 then
                local selectedCategoryLenght = tableLenght(modulesInCategory[selectedCategory]) + 1
                selectedModule = selectedModule + 1
                if selectedModule >= selectedCategoryLenght then selectedModule = 1 end
            else
                selectedCategory = selectedCategory + 1
                if selectedCategory >= 7 then selectedCategory = 2 end
            end            
        elseif v == 4 then --right
            if selectedModule > 0 then
                modulesInCategory = {{}, {}, {}, {}, {}, {}, {}, {}}
                local mods = client.modules()
                for k, mod in pairs(mods) do
                    table.insert(modulesInCategory[categoriseModule(mod)], mod)
                end
                local mod = modulesInCategory[selectedCategory][selectedModule]
                if mod.enabled == true then 
                    mod.enabled = false
                else                       
                    mod.enabled = true
                end
            else
                selectedModule = 1
                categoryOpenedSince = 0
            end
        end
    end
    userInteractions = {}

    gfx.color(35, 35, 50)
    for i=0,4 do
        gfx.rect(0, i * (font.wrap + 2), 50, font.wrap + 2)        
    end
    if (selectedCategory > 1 and selectedCategory < 7) then
        gfx.color(45, 45, 250)
        gfx.rect(0, (selectedCategory-2) * (font.wrap + 2), 50, font.wrap + 2)
    end

    gfx.color(255,255,255)
    for i=0,4 do
        gfx.text(3, i * (font.wrap + 2) + 1, cagegoryToName(i+2))
    end

    if selectedModule == 0 then return end

    modulesInCategory = {{}, {}, {}, {}, {}, {}, {}, {}}
    local mods = client.modules()
    for k, mod in pairs(mods) do
        table.insert(modulesInCategory[categoriseModule(mod)], mod)
    end
    
    local opacity = 255
    if animate == true and categoryOpenedSince < 0.1 then
        opacity = (categoryOpenedSince * 255) * 10
    end

    gfx.color(35, 35, 50, math.floor(opacity))
    local current_height = 0
    for k, mod in pairs(modulesInCategory[selectedCategory]) do
        if mod.enabled == false then
            gfx.rect(51, current_height * (font.wrap + 2), moduleWidth, font.wrap + 2)
        end
        current_height = current_height + 1
    end

    gfx.color(55, 55, 100, math.floor(opacity))
    current_height = 0
    for k, mod in pairs(modulesInCategory[selectedCategory]) do
        if mod.enabled == true then
            gfx.rect(51, current_height * (font.wrap + 2), moduleWidth, font.wrap + 2)
        end
        current_height = current_height + 1
    end
    --selected
    gfx.color(45, 45, 250, math.floor(opacity))
    gfx.rect(51, (selectedModule-1) * (font.wrap + 2), moduleWidth, font.wrap + 2)


    gfx.color(255,255,255, math.floor(opacity))
    current_height = 0
    for k, mod in pairs(modulesInCategory[selectedCategory]) do
        gfx.text(53, current_height * (font.wrap + 2) + 1, mod.name)
        current_height = current_height + 1
    end

    categoryOpenedSince = categoryOpenedSince + dt
end



