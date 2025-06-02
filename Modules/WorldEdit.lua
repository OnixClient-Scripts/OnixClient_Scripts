name = "World Edit"
description = "World Edit for bedrock. Type .WEhelp for an explanation (The wand isn't an axe, it's a sword). All commands use the \".\" prefix."



--                                                      wedit for onix made by @Janjre (github name) mc username = HusdhedCandle753


importLib("auxToState.lua")
importLib("blockList.lua")




function sleep(n)  -- seconds
    local clock = os.clock
   local t0 = clock()
   while clock() - t0 <= n do
   end
end

brushes = {}

xBlockList = {}
yBlockList = {}
zBlockList = {}
blockBlockList = {}
rndBlockList = {}
counterBlockNotList = 0

client.settings.addCategory("Rendering")
DiagS = false
client.settings.addBool("Show Diag","DiagS")
DiagC = {255,0,0}
DiagCUI = client.settings.addColor("Diag Color","DiagC")

client.settings.addAir(5)

BoxS = true
client.settings.addBool("Show Box","BoxS")
BoxC = {0,255,0}
BoxCUI = client.settings.addColor("Box Color","BoxC")

client.settings.addAir(5)

MirS = false
client.settings.addBool("Show Mirror","MirS")
MirC = {0,0,255}
MirCUI = client.settings.addColor("Mirror Color", "MirC")

client.settings.addAir(5)

TextS = false
client.settings.addBool("Show Text", "TextS")
TextC = {255,255,255}
TextCUI = client.settings.addColor("Text Color", "TextC")

client.settings.stopCategory()

client.settings.addAir(10)

client.settings.addCategory("Brushes")

function loadBrush()
    brushesJson = jsonFromFile("brushes.json")
    if brushesJson == nil then print("§eNo brushes have been saved") return end
    brushes = jsonToTable(brushesJson)
end

function saveBrush()
    local file = io.open("brushes.json", "w")
    brushesJson = tableToJson(brushes)
    io.open("brushes.json", "w"):write(brushesJson):close()
end

client.settings.addFunction("Load Brushes", "loadBrush", "Load")
client.settings.addFunction("Save Brushes", "saveBrush", "Save")
client.settings.stopCategory()

client.settings.addAir(10)

muteWarnings = client.settings.addNamelessBool("Mute warnings",false)

MuteFill =  true
MuteSel = false
MuteSucess = false
client.settings.addCategory("Mute Chats")
client.settings.addBool("Mute Fill Messages","MuteFill")
client.settings.addBool("Mute Other Selection Measages","MuteSel")
client.settings.addBool("Mute Sucess Measages (eg Replacing ... with ...)","MuteSucess")
client.settings.stopCategory()
client.settings.addAir(10)
client.settings.addCategory("Sound")
DingS = true
client.settings.addBool("Ding Sound","DingS")
WhooshS = true
client.settings.addBool("Whoosh Sound","WhooshS")
client.settings.stopCategory()

client.settings.addAir(10)

SizeS = false
client.settings.addBool("Do Size Warning","SizeS")
AreaV = 5000
AreaVUI = client.settings.addInt("Area Size Warning","AreaV",500,50000)



----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--                                                                                                                                                               REGISTER COMMANDS 
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


function blankIntellisense() end

--help
registerCommand("WEhelp", function(arguments)
   
    helpcmd(arguments)
    
end,blankIntellisense,"Shows the help menu")

registerCommand("wehelp", function(arguments)

    helpcmd(arguments)

end,blankIntellisense,"Shows the help menu")

registerCommand("WeHelp", function(arguments)

    helpcmd(arguments)

end,   blankIntellisense,"Shows the help menu")

--fill
registerCommand("fill", function (arguments)
    if xpos1 == nil or xpos2 == nil then print("§ePlease select an area before running this command") return end
    local intellisenseHelper = MakeIntellisenseHelper(arguments)
    local parser = intellisenseHelper:addOverload()
    local block = parser:matchEnum("block","block",allBlocks)
    

    fillcmd(arguments)
end,
function (intellisense)
    local overload = intellisense:addOverload()
    overload:matchEnum("block","block",allBlocks)


end, "Fills in the selected area with the specified block")

registerCommand("replace", function (arguments)
    if xpos1  == nil or xpos2 == nil then print("§ePlease select an area before running this command") return end
    local intellisenseHelper = MakeIntellisenseHelper(arguments)
    local parser = intellisenseHelper:addOverload()
    local block1 = parser:matchEnum("replace what","block",allBlocks)
    if block1 == nil then
        print("§cblock1 is required!")
        return
    end
    local block2 = parser:matchEnum("replace with","block",allBlocks)

    local invert = parser:matchBool("invert",true)
    if invert == nil then invert = false end

    replacecmd(arguments)

end,
function (intellisense)
    local overload = intellisense:addOverload()
    overload:matchEnum("replace what","block",allBlocks)
    overload:matchEnum("replace with","block",allBlocks)
    local invert = overload:matchBool("invert",true)

end, "Replaces all of one block in your selected range with another")


--line
registerCommand("line", function (arguments)
    if xpos1  == nil or xpos2 == nil then print("§ePlease select an area before running this command") return end
    local intellisenseHelper = MakeIntellisenseHelper(arguments)
    local parser = intellisenseHelper:addOverload()
    local block = parser:matchEnum("block","block",allBlocks)

    linecmd(arguments)
end,
function (intellisense)
    local overload = intellisense:addOverload()
    overload:matchEnum("block","block",allBlocks)
end, "Creates a line between the two selected points")

--mirror
registerCommand("mirror", function (arguments)
    if xpos1 == nil  or xpos2 == nil then print("§ePlease select an area before running this command") return end
    local intellisenseHelper = MakeIntellisenseHelper(arguments)
    local parser = intellisenseHelper:addOverload()
    local axis = parser:matchEnum("axis","axis",{"x","xz","z"})
    if axis == nil then
        print("§caxis is required!")
        return
    end
    mircmd(arguments)
end,
function (intellisense)
    local overload = intellisense:addOverload()
    overload:matchEnum("axis","axis",{"x","xz","z"})

end, "Mirrors your selection unstable")
--wall
registerCommand("wall", function (arguments)
    if xpos1  == nil  or xpos2 == nil then print("§ePlease select an area before running this command") return end
    local intellisenseHelper = MakeIntellisenseHelper(arguments)
    local parser = intellisenseHelper:addOverload()
    local block = parser:matchEnum("block","block",allBlocks)
   
    wallcmd(arguments)
end,
function (intellisense)
    local overload = intellisense:addOverload()
    overload:matchEnum("block","block",allBlocks)

end, "This is an example of a separated command")

-- infwater
registerCommand("infinitewater",function (arguments)
    if xpos1 == nil == nil  or xpos2 == nil then print("§ePlease select an area before running this command") else
         infwatercmd(arguments)
    end
end,blankIntellisense,"Makes all water blocks in the selected area sources")


--circle come back to 
registerCommand("circle", function (arguments)
    if xpos1 == nil  or xpos2 == nil then print("§ePlease select an area before running this command") return end
    local intellisenseHelper = MakeIntellisenseHelper(arguments)
    local parser = intellisenseHelper:addOverload()
    local plane = parser:matchEnum("plane", "plane", {"xz", "yz","xy"})
    if plane == nil then
        print("§caxis is required!")
        return
    end
    
    local block = parser:matchEnum("block","block",allBlocks)
    
    local fill = parser:matchBool("fill",true)
    if fill == nil then fill = true end

    circlecmd(plane,string.split(arguments," ")[2],fill)

end,
function (intellisense)
    local overload = intellisense:addOverload()
    overload:matchEnum("plane", "plane", {"xz", "yz","xy"})
    overload:matchEnum("block","block",allBlocks)
    overload:matchBool("fill",true)
end, "Makes a circle with the specified block and axis")

--sphere
registerCommand("sphere", function (arguments)
    if xpos1  == nil or xpos2 == nil then print("§ePlease select an area before running this command") return end
    local intellisenseHelper = MakeIntellisenseHelper(arguments)
    local parser = intellisenseHelper:addOverload()
    local block = parser:matchEnum("block","block",allBlocks)
    local fill = parser:matchBool("fill",true)
    if fill == nil then fill = true end
    spherecmd(string.split(arguments," ")[1],fill)
end,
function (intellisense)
    local overload = intellisense:addOverload()
    overload:matchEnum("block","block",allBlocks)
    overload:matchBool("fill",true)
end, "Makes a sphere with the specified block")

--buildup



registerCommand("buildup", function (arguments)
    if xpos1  == nil or xpos2 == nil then print("§ePlease select an area before running this command") return end
    local intellisenseHelper = MakeIntellisenseHelper(arguments)
    local parser = intellisenseHelper:addOverload()
    local block = parser:matchEnum("block","block",allBlocks)
    if block == nil then
        print("§cblock is required!")
        return
    end
    local height = parser:matchInt("height")
    if height == nil then
        print("§cheight is required!")
        return
    end

    bucmd(arguments)

end,
function (intellisense)
    local overload = intellisense:addOverload()
    overload:matchEnum("block","block",allBlocks)
    overload:matchInt("height")

end, "This is an example of a separated command")



--pos1 and pos2
registerCommand("pos1",function (arguments)
    
    pos1cmd(arguments)

end, blankIntellisense, "Sets the first position")
registerCommand("pos2",function (arguments)
    
    pos2cmd(arguments)

end, blankIntellisense, "Sets the second position")

--up
registerCommand("up", function (arguments)
    local intellisenseHelper = MakeIntellisenseHelper(arguments)
    local parser = intellisenseHelper:addOverload()
    local height = parser:matchInt("height")
    if height == nil then
        print("§cHeight is required!")
        return
    end
    upcmd(arguments)
end,
function (intellisense)
    local overload = intellisense:addOverload()
    overload:matchInt("height")

end, "This is an example of a separated command")

--thrutool
registerCommand("thrutool",function (arguments)
    
    thrutoolcmd(arguments)

end, blankIntellisense, "Toggles the through tool")

--copy
registerCommand("copy",function (arguments)
    if xpos1 == nil or xpos2 == nil then print("§ePlease select an area before running this command") else
        copycmd(arguments)
    end
end,blankIntellisense,"Copies the selected area")

--paste 
registerCommand("paste",function (arguments)
    if xpos1 == nil or xpos2 == nil then print("§ePlease select an area before running this command") else
    pastecmd(arguments)
end
end, blankIntellisense, "Pastes the copied area")

--count
registerCommand("count",function (arguments)
    local intellisense = MakeIntellisenseHelper(arguments)
    local parser = intellisense:addOverload()
    parser:matchEnum("block","block",allBlocks)
    if xpos1 == nil or xpos2 == nil then print("§ePlease select an area before running this command") else
        countcmd(arguments)
    end
end, function(intellisense)
    local overload = intellisense:addOverload()
    overload:matchEnum("block","block",allBlocks)
end, "Counts the blocks in the selected area")

--wand
registerCommand("wand",function (arguments)
    
    wandcmd(arguments)

end,blankIntellisense, "Gives you the wand")

--selnear
registerCommand("selnear", function (arguments)
    local intellisenseHelper = MakeIntellisenseHelper(arguments)
    local parser = intellisenseHelper:addOverload()
    local radius = parser:matchInt("radius")
    if radius == nil then
        print("§cradius is required!")
        return
    end
    selnearcmd(arguments)
end,
function (intellisense)
    local overload = intellisense:addOverload()
    overload:matchInt("radius")

end, "This is an example of a separated command")

--rotate
registerCommand("rotate", function (arguments)
    if xpos1 == nil or xpos2 == nil then print("§ePlease select an area before running this command") return end
    local intellisenseHelper = MakeIntellisenseHelper(arguments)
    local parser = intellisenseHelper:addOverload()
    local angle = parser:matchEnum("angle","angle",{"0_degrees","90_degrees","180_degrees","270_degrees"})
    if angle == nil then
        print("§cAngle is required!")
        return
    end

    rotatecmd(arguments )

end,
function (intellisense)
    local overload = intellisense:addOverload()
    overload:matchEnum("angle","angle",{"0_degrees","90_degrees","180_degrees","270_degrees"})

end, "Rotates your selection (unstable)")

registerCommand("rot", function (arguments)
    if xpos1 ==nil or xpos2 == nil then print("§ePlease select an area before running this command") return end
    local intellisenseHelper = MakeIntellisenseHelper(arguments)
    local parser = intellisenseHelper:addOverload()
    local angle = parser:matchEnum("angle","angle",{"0_degrees","90_degrees","180_degrees","270_degrees"})
    if angle == nil then
        print("§cAngle is required!")
        return
    end
    rotatecmd(arguments)
end,
function (intellisense)
    local overload = intellisense:addOverload()
    overload:matchEnum("angle","angle",{"0_degrees","90_degrees","180_degrees","270_degrees"})

end, "Rotates your selection (unstable)")

-- undo
-- registerCommand("undo",function (arguments)
    
--     undocmd()
    
-- end)

registerCommand("copyAlongSel",function (arguments)
    if xpos1 ==nil or xpos2 == nil then print("§ePlease select an area before running this command") return end
    cpAlongSel(arguments)
end,blankIntellisense,"Copies the selected area into every block in your selected area")


registerCommand("addBrush", function (arguments)
    local intellisenseHelper = MakeIntellisenseHelper(arguments)
    local parser = intellisenseHelper:addOverload()
    
    local block = parser:matchEnum("block","block",allBlocksAndClipboard)
    if block == nil then
        if string.find(string.split(arguments," ")[1],"%%") == nil then
            print("§cblock is required!")
            return
        end 
    end
    local size = parser:matchInt("size")
    if size == nil then
        if block == "clipboard" then size = -1 else
            print("§csize is required!")
            return
        end
    end
    local mask = parser:matchEnum("mask","block",allBlocks,true)
    if mask == nil then
        mask = "none"
    end

    for n = 1,#brushes do
        if brushes[n].item == player.inventory().selectedItem().name then
            table.remove(brushes, n)
            break
        end
    end
    table.insert(brushes, {item = player.inventory().selectedItem().name, block = string.split(arguments," ")[1], size = size,mask = mask})
    print("§aAdded brush")
end,
function (intellisense)
    local overload = intellisense:addOverload()
    overload:matchEnum("block","block",allBlocks)   
    overload:matchInt("size")
    overload:matchEnum("mask","block",allBlocks,true)

    local overload2 = intellisense:addOverload()
    overload2:matchEnum("clipboard","clipboard",{"clipboard"})
end, "Adds a brush. When you click holding the item your holding when you run the command it will make a sphere of the specified block with the specified size at the clicked position")  



registerCommand("removeBrush", function (arguments)
    local intellisenseHelper = MakeIntellisenseHelper(arguments)
    local parser = intellisenseHelper:addOverload()


    brushItems = {}
    for i = 1, #brushes do
        table.insert(brushItems, brushes[i].item)
    end

    local item = parser:matchEnum("brush","brush name",brushItems,true)
    if item == nil then
        if player.inventory().selectedItem() == nil then
            print("§cItem is required! You must either hold the item or specify it")
            return
        end
        item = player.inventory().selectedItem().name 
    end

    for n = 1,#brushes do
        if brushes[n].item == item then
            table.remove(brushes, n)
        end
    end
end,
function (intellisense)
    local overload = intellisense:addOverload()
    brushItems = {}
    for i = 1, #brushes do
        table.insert(brushItems, brushes[i].item)
    end

    local item = overload:matchEnum("brush","brush name",brushItems,true)

end, "Removes a brush")

registerCommand("listBrushes", function (arguments)
    local intellisenseHelper = MakeIntellisenseHelper(arguments)
    local parser = intellisenseHelper:addOverload()
    
    for n = 1,#brushes do
        print(brushes[n].item .. " - block: " .. brushes[n].block .. "  size: " .. brushes[n].size .. "  mask: " .. brushes[n].mask)
    end
end,
function (intellisense)
    local overload = intellisense:addOverload()

end, "Lists all of your brushes")

registerCommand("clearBrushes", function (arguments)
    brushes = {}
    print("§aCleared brushes")
end,blankIntellisense,"Clears all of your brushes")

registerCommand("move",function(arguments)
    local intellisenseHelper = MakeIntellisenseHelper(arguments)
    local parser = intellisenseHelper:addOverload()

    local x = parser:matchInt("x")
    if x == nil then
        print("§cx is required!")
        return
    end
    local y = parser:matchInt("y")
    if y == nil then
        print("§cy is required!")
        return
    end
    local z = parser:matchInt("z")
    if z == nil then
        print("§cz is required!")
        return
    end

    xpos1 = xpos1 + x
    xpos2 = xpos2 + x
    ypos1 = ypos1 + y
    ypos2 = ypos2 + y
    zpos1 = zpos1 + z
    zpos2 = zpos2 + z
end,function (intellisense)
    local overload = intellisense:addOverload()
    overload:matchInt("x")
    overload:matchInt("y")
    overload:matchInt("z")
end, "Moves the selected area by the specified amount")


brushes = {}

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
                                                    --                          USE .WEhelp TO GET AN EXPLANATION ON HOW TO USE
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
positionX = 50
positionY = 50
sizeX = 180
sizeY = 50

event.listen("MouseInput", function(button, down) --                    SECLECTION
    if gui.mouseGrabbed() or down then
        return
    end
    if down then return end
    xface, yface, zface = player.selectedPos()
    if player.inventory().selectedItem() == nil then return end
    if player.inventory().selectedItem().name=="wooden_sword" then
        
        if player.facingBlock() == false then return end
        
        
        if ThruTool == true then
            
            for I = 3, 356, 1 do
                xxx,yyy,zzz = player.forwardPosition(I) 
                local blockOfDoom = dimension.getBlock(math.floor(xxx),math.floor(yyy+1),math.floor(zzz)).name
                if  blockOfDoom == "air" or blockOfDoom == "water" then
                    client.execute("execute tp @s ".. xxx .. " " .. yyy+1 .. " " .. zzz)
                    if WhooshS then
                        playCustomSound("WEwhoosh.mp3")
                    end
                    
                    break
                    
                end
            end
        else
            
        

            if button == 1 then       --                                    LEFT MB
                xpos1 = xface
                ypos1 = yface
                zpos1 = zface
                
                
                if not MuteSel then
                    print(xpos1 .. " " .. ypos1 .. " " .. zpos1 .. "§b has been set as selection point 1")
                end
                do return true end 
            end

            if button == 2 then                                          -- RIGHT MB
                xpos2 = xface
                ypos2 = yface
                zpos2 = zface
                if not MuteSel then
                    print(xpos2 .. " " .. ypos2 .. " " .. zpos2 .. "§c has been set as selection point 2")
                end
                do return true end
            end
        end
    end
    if button ==1 then else return end
    for n = 1,  #brushes do
        local block = brushes[n].block
        local size = brushes[n].size
        local item = brushes[n].item
        local mask = brushes[n].mask
        if player.inventory().selectedItem().name == item then 
            for j = 2, 100 do
                
                local xx, yy, zz = player.forwardPosition(j)
                if dimension.getBlock(math.floor(xx), math.floor(yy), math.floor(zz)).name == "air" then else
                
                    if block == "clipboard" then
                        client.execute("execute structure load worldEditClipboard " .. xx .. " " .. yy +1 .. " " .. zz)
                        return
                    end
                
                    for k = -size, size do
                        for l = -size, size do
                            for m = -size, size do
                                if math.sqrt(k*k + l*l + m*m) <= size then
                                    local newBlock = blockfiguer(block)
                                    
                                    if dimension.getBlock(math.floor(xx) + k, math.floor(yy) + l, math.floor(zz) + m).name == mask or mask == "none" then
                                        client.execute("execute /setblock " .. xx + k .. " " .. yy + l .. " " .. zz + m .. " " .. newBlock)
                                    
                                    end
                                 
                                end
                            end
                        end
                    end
                    break
                end
            end
        end

        
    end
end)

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--                                                                                                                                                          ACTUAL COMMANDS
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function fillcmd(args,override)
    curRndBlockNotList = math.random()
    arg = splitSpace(args)
    xstep=1
    if (xpos1 > xpos2) then              --X FIX
        xstep=-1
    end
    ystep = 1
    if (ypos1 > ypos2) then              --YFIX
        ystep = -1
    end
    zstep = 1
    if (zpos1 > zpos2) then              --ZFIX
        zstep = -1
    end
    if not muteWarnings.value then
        
        if not override then
            if math.abs((xpos2 - xpos1) * (ypos2 - ypos1) * (zpos2 - zpos1)) > 1000 then
            
                print("§eThis is a very big area (" .. tostring((xpos2 - xpos1) * (ypos2 - ypos1) * (zpos2 - zpos1)) .. " blocks). Are you sure you want to continue? You can remove this message in settings. yes/no")
                askForConfirm = {true, args}
                return
                
            end
        end
    end


    for xInSelectedRange = xpos1, xpos2, xstep do
        for yinSelectedRange = ypos1, ypos2, ystep do
            for zinSelectedRange = zpos1, zpos2, zstep do
                BLOCKYTHING = blockfiguer(arg[1])
                --newsetblock(xInSelectedRange,yinSelectedRange,zinSelectedRange,BLOCKYTHING)
                client.execute("execute /setblock " .. tostring(xInSelectedRange).. " " ..tostring(yinSelectedRange).. " " .. tostring(zinSelectedRange) .. " " .. BLOCKYTHING)
            end
        end
    end
    if DingS then
        playCustomSound("WEding.mp3")
    end
    if not MuteSucess then
        print("§aFilled area with §r".. arg[1])
    end

end

function replacecmd(args)
    
    arg = splitSpace(args)
    arg1 = arg[1]
    arg2 = arg[2]
    arg3 = arg[3]
    replacewhat = arg1
    replacewith = arg2
    
    if args == 12345 then
        arg[1] = "water water"
        DingS = false
        MuteSucess = true        
    end

    xstep=1
    if (xpos1 > xpos2) then              --X FIX
        xstep=-1
    end
    ystep = 1
    if (ypos1 > ypos2) then              --YFIX
        ystep = -1
    end
    zstep = 1
    if (zpos1 > zpos2) then              --ZFIX
        zstep = -1
    end
    
    for xInSelectedRange = xpos1, xpos2, xstep do
        for yinSelectedRange = ypos1, ypos2, ystep do
            for zinSelectedRange = zpos1, zpos2, zstep do
                if arg3 == "true" then
                    
                    if(dimension.getBlock(xInSelectedRange,yinSelectedRange,zinSelectedRange).name == replacewhat)then else
                        
                        replacewither = blockfiguer(replacewith)
                        client.execute("execute /setblock " .. tostring(xInSelectedRange).. " " ..tostring(yinSelectedRange).. " " .. tostring(zinSelectedRange) .. " " .. replacewither)
                    end
                else
                    
                    if(dimension.getBlock(xInSelectedRange,yinSelectedRange,zinSelectedRange).name == replacewhat)then
                        replacewither = blockfiguer(replacewith)
                        client.execute("execute /setblock " .. tostring(xInSelectedRange).. " " ..tostring(yinSelectedRange).. " " .. tostring(zinSelectedRange) .. " " .. replacewither)
                    end
                end
            end
        end
    end
    if DingS then
        playCustomSound("WEding.mp3")
    end
    if not MuteSucess then
        print("§aReplacing §f " .. replacewhat .. "§a with §f " .. replacewith)
    end
end

function linecmd(args)
    arg = splitSpace(args)
    arg1 = arg[1]
    arrg2 = 1
    if arg1 == nil then print("§eYou need to specify a block") else
        if arg2 == nil then arg2 = 1 end
        xline, yline, zline = player.pposition()
        yaw, pitch = player.rotation()
        client.execute("execute /tp " .. xpos1 .. " " .. ypos1 .. " " .. zpos1 .. " facing " .. xpos2 .. " " .. ypos2 .. " " .. zpos2)
        xdif = xpos1-xpos2
        ydif = ypos1-ypos2
        zdif = zpos1-zpos2
        DISTANCE = math.sqrt(xdif*xdif+ydif*ydif+zdif*zdif)
        if arg2 == nil then
            arg2 = 1
        end
        for countofdis = 1, DISTANCE, 1 do
            client.execute("execute /setblock ^ ^ ^" .. countofdis .. " " .. arg1)
        end
        client.execute("execute tp " .. xline .. " " .. yline .. " " .. zline .. " " .. yaw .. " " .. pitch)
        if DingS then
            playCustomSound("WEding.mp3")
        end
        if not MuteSucess then
            print ("§aDrawn Line")
        end
    end
end

function OLDmircmd(args)
    arg = splitSpace(args)
    arg1 = arg[1]
    arg2 = arg[2]
    if (xpos1 > xpos2) then              --X FIX
        inbetweenyvariable = xpos1
        xpos1 = xpos2
        xpos2 = inbetweenyvariable
    end

    if (ypos1 > ypos2) then              --YFIX
        inbetweenyvariable = ypos1
        ypos1 = ypos2
        ypos2 = inbetweenyvariable
    end

    if (zpos1 > zpos2) then              --ZFIX
        inbetweenyvariable = zpos1
        zpos1 = zpos2
        zpos2 = inbetweenyvariable
    end
    mirrorLine = 0.5*(xpos1+xpos2)
    for xInSelectedRange = xpos1, mirrorLine, 1 do
        for yinSelectedRange = ypos1, ypos2, 1 do
            for zinSelectedRange = zpos1, zpos2, 1 do
                distnacetomirror = mirrorLine-xInSelectedRange
                newx = distnacetomirror+mirrorLine
                client.execute("execute /setblock " .. tostring(newx).. " " ..tostring(yinSelectedRange).. " " .. tostring(zinSelectedRange) .. " " .. dimension.getBlock(xInSelectedRange,yinSelectedRange,zinSelectedRange).name)    
            end
        end
    end
    if DingS then
        playCustomSound("WEding.mp3")
    end
    if not MuteSucess then
        print("§aMirrored")
    end
end

function spherecmd(block,fill)
    
    xdif = xpos1-xpos2
    ydif = ypos1-ypos2
    zdif = zpos1-zpos2
    SPHERERAD = math.ceil (math.sqrt(xdif*xdif+ydif*ydif+zdif*zdif))
    for xa = xpos1-SPHERERAD-1, xpos1+SPHERERAD+1, 1 do
        for ya = ypos1-SPHERERAD-1, ypos1+SPHERERAD+1, 1 do
            for za = zpos1-SPHERERAD-1, zpos1+SPHERERAD+1 , 1 do
            -- print (xa .. " ".. ya .. " "..za)
                xdif = xa-xpos1
                ydif = ya-ypos1
                zdif = za-zpos1
                MYRAD = math.sqrt(xdif*xdif+ydif*ydif+zdif*zdif)
                if fill then   -- FILLING IN SPHERE
                    if (MYRAD < SPHERERAD) then
                        client.execute("execute /setblock " .. xa .. " " .. ya .. " " .. za .." " .. block)     
                    end      
                else -- surface of sphere
                    if ((MYRAD < SPHERERAD + 0.55) and  (MYRAD > SPHERERAD - 0.55)) then
                        client.execute("execute /setblock " .. xa .. " " .. ya .. " " .. za .." " .. block)     
                    end    
                end
            end
        end
    end
    if DingS then
        playCustomSound("WEding.mp3")
    end    
    if not MuteSucess then
        print("§aMade a sphere of §f "..block)
    end
end

function circlecmd(plane,block,fill)
    
    xdif = xpos1-xpos2
    ydif = ypos1-ypos2
    zdif = zpos1-zpos2
    radius = math.ceil (math.sqrt(xdif*xdif+ydif*ydif+zdif*zdif))

    for xInRange = xpos1-radius, xpos1+radius, 1 do
        for yInRange = ypos1-radius, ypos1+radius, 1 do
            for zInRange = zpos1-radius, zpos1+radius, 1 do
                local doit = false
                if fill then
                    if math.sqrt((xInRange-xpos1)^2+(yInRange-ypos1)^2+(zInRange-zpos1)^2) < radius then
                        doit = true
                    end
                else
                    if math.floor(math.sqrt((xInRange-xpos1)^2+(yInRange-ypos1)^2+(zInRange-zpos1)^2)) == radius then
                        doit=true
                    end 
                end
                
                if doit then
                    if plane == "xz" then
                        if yInRange==ypos1 then
                            client.execute("execute /setblock " .. xInRange .. " " .. yInRange .. " " .. zInRange .." " .. block)
                        end 
                    end
                    if plane == "xy" then
                        if zInRange==zpos1 then
                            client.execute("execute /setblock " .. xInRange .. " " .. yInRange .. " " .. zInRange .." " .. block)
                        end 
                    end
                    if plane == "yz" then
                        if xInRange==xpos1 then
                            client.execute("execute /setblock " .. xInRange .. " " .. yInRange .. " " .. zInRange .." " .. block)
                        end 
                    end
                end
               
            end
        end
    end

    
    if DingS then
        playCustomSound("WEding.mp3")
    end
end

function wallcmd(args)
    arg = splitSpace(args)
    arg1 = arg[1]
    arg2 = arg[2]
    if not MuteSucess then
        print("§aMaking wall")
    end
    if arg2 == nil then
        arg2 = 1
    end
    local xline, yline, zline = player.pposition()
    local yaw, pitch = player.rotation()
    ywall1 = ypos1 
    yawll2 = ypos2  
    for yness = math.min(ypos1,ypos2), math.max(ypos2, ypos1), 1 do
        client.execute("execute /tp " .. xpos1 .. " " .. yness .. " " .. zpos1 .. " facing " .. xpos2 .. " " .. yness .. " " .. zpos2)
        xdif = xpos1-xpos2
        ydif = 0  -- it 2d idotss
        zdif = zpos1-zpos2
        DISTANCE = math.sqrt(xdif*xdif+ydif*ydif+zdif*zdif)
        for countofdis = 0, DISTANCE+1, tonumber(arg2) do
            NEWARG1 = blockfiguer(arg1)
            client.execute("execute /setblock ^ ^ ^" .. countofdis .. " " .. NEWARG1 )
        end
    end
    client.execute("execute tp " .. xline .. " " .. yline .. " " .. zline .. " " .. yaw .. " " .. pitch)
end

function infwatercmd(args)
    if doinfinitewater == true then
        doinfinitewater = false
        if not MuteSucess then
            print("§cStopped infinitewater")
        end
    else
        doinfinitewater = true
        if not MuteSucess then
            print("§aStarted infinitewater. Type .infinitewater to stop")
        end 
    end
end



function bucmd(args)
    arg = splitSpace(args)
    arg1 = arg[1]
    arg2 = arg[2]
    replacewhat = arg1
    howhigh = arg2
    if not MuteSucess then
        print("§a Building-Up §f" .. replacewhat .." " .. howhigh .. " §ablocks.")
    end
    if (xpos1 > xpos2) then              --X FIX
        inbetweenyvariable = xpos1
        xpos1 = xpos2
        xpos2 = inbetweenyvariable
    end
    if (ypos1 > ypos2) then              --YFIX
        inbetweenyvariable = ypos1
        ypos1 = ypos2
        ypos2 = inbetweenyvariable
    end
    if (zpos1 > zpos2) then              --ZFIX
        inbetweenyvariable = zpos1
        zpos1 = zpos2
        zpos2 = inbetweenyvariable
    end
    for xInSelectedRange = xpos1, xpos2, 1 do
        for yinSelectedRange = ypos2, ypos1, -1 do
            for zinSelectedRange = zpos1, zpos2, 1 do
                --print("Found block "..dimension.getBlock(xInSelectedRange,yinSelectedRange,zinSelectedRange).name)
                if(dimension.getBlock(xInSelectedRange,yinSelectedRange,zinSelectedRange).name == replacewhat)then
                    for howhighcount = 1, howhigh do
                        strtoexe = "execute /setblock " .. tostring(xInSelectedRange).. " " ..tostring(yinSelectedRange+howhighcount).. " " .. tostring(zinSelectedRange) .. " " .. replacewhat
                    --  print(strtoexe)
                        client.execute(strtoexe)
                    end
                end
            end
        end
    end
    if DingS then
        playCustomSound("WEding.mp3")
    end
end

function helpcmd(args)
    local keywordColor = "§e"  -- Yellow color for keywords
    local usageColor = "§a"    -- Green color for usage
    local dividerColor = "§f"  -- Grey color for dividers
    print("Select 2 positions using a wooden sword then type one of the commands to affect that area.\n" ..
    "When the syntax says \"block\", it means either something like \"dirt\" or something like \"50%dirt,50%air\"\n" ..
    dividerColor .. "------------------------------\n" ..
    keywordColor .. ".fill§r " .. dividerColor .. "| §7runs a normal fill command " .. dividerColor .. "| §7" .. usageColor .. ".fill§r <block>\n" ..
    keywordColor .. ".replace§r " .. dividerColor .. "| §7replaces all of the first argument's block to the second within the selected range " .. dividerColor .. "| §7" .. usageColor .. ".replace§r <replacewhat> <replacewith> <not:bolean>\n" ..
    keywordColor .. ".line§r " .. dividerColor .. "| §7creates a line between the two selected points " .. dividerColor .. "| §7" .. usageColor .. ".line§r <block> \n" ..
    keywordColor .. ".mirror§r " .. dividerColor .. "| §7mirrors one side of the blue line to the other. Doesn't work with block states" .. dividerColor .. "| §7" .. usageColor .. ".mirror§r\n" ..
    keywordColor .. ".wall§r " .. dividerColor .. "| §7creates a wall between two points " .. dividerColor .. "| §7" .. usageColor .. ".wall§r <block> [width/precision]\n" ..
    keywordColor .. ".infinitewater§r " .. dividerColor .. "| §7all non-source water blocks get turned into sources so can spread infinitely in any direction aside from up\n" ..
    dividerColor .. "------------------------------\n" ..
    keywordColor .. ".circle§r " .. dividerColor .. "| §7makes a circle with the radius of the distance between the two selected points (the center being the first) " .. dividerColor .. "| §7" .. usageColor .. ".circle§r <xz,xy or yz:plane> <block> <filled> \n" ..
    keywordColor .. ".sphere§r " .. dividerColor .. "| §7makes a sphere with the radius of the distance between the two selected points " .. dividerColor .. "| §7" .. usageColor .. ".sphere§r <block> [true/false:fill]\n" ..
    keywordColor .. ".buildup§r " .. dividerColor .. "| §7duplicates all of the specified block up a specified amount of times " .. dividerColor .. "| §7" .. usageColor .. ".build-up§r <block> <height>\n" ..
    keywordColor .. ".WEhelp§r " .. dividerColor .. "| §7I think you already know how to use this one " .. dividerColor .. "| §7" .. usageColor .. ".WEhelp§r\n" ..
    keywordColor .. ".pos1§r " .. dividerColor .. "| §7sets position 1 to your current coordinates (your feet) " .. dividerColor .. "| §7" .. usageColor .. ".pos1§r\n" ..
    keywordColor .. ".pos2§r " .. dividerColor .. "| §7sets position 2 to your current coordinates (your feet)  " .. dividerColor .. "| §7" .. usageColor .. ".pos2§r\n" ..
    keywordColor .. ".up§r " .. dividerColor .. "| §7teleports you up a specified amount of blocks upward and places a block below you " .. dividerColor .. "| §7" .. usageColor .. ".up§r <height>\n" ..
    keywordColor .. ".thrutool§r " .. dividerColor .. "| §7when pressed against a block click and it will teleport you to the other side of the block/s (intended for going in and out of builds without using a door). Limit of 356 blocks " .. dividerColor .. "| §7" .. usageColor .. ".thrutool§r\n" ..
    keywordColor .. ".selnear§r " .. dividerColor .. "| §7Selects an area with a radius of x. If given nothing will deafault to 10" .. dividerColor .. "| §7" .. usageColor .. ".selnear §r[radius] \n" ..
    dividerColor .. "------------------------------\n" ..
    keywordColor .. ".copy§r " .. dividerColor .. "| §7Copies the selected area to a file in ..scripts\\data " .. dividerColor .. "| §7" .. usageColor .. ".copy§r\n" ..
    keywordColor .. ".paste§r " .. dividerColor .. "| §7pastes the file in the file with no rotational changes. !!WARNING!! This function is laggy. If you're pasting very precisely or a large build, use structure blocks instead. " .. dividerColor .. "| §7" .. usageColor .. ".paste§r\n" ..
    keywordColor .. ".count§r " .. dividerColor .. "| §7counts the number of a specified (or all) block(s) " .. dividerColor .. "| §7" .. usageColor .. ".count [block]§r\n" ..
    keywordColor .. ".copyAlongSel§r " .. dividerColor .. "| §7Pastes your clipboard onto every block in your selection" .. dividerColor .. "| §7" .. usageColor .. ".copyAlongSel\n" ..
    keywordColor .. ".addBrush§r " .. dividerColor .. "| §7adds a 'brush' to the item your holding, when you left click holding it, it will make a sphere of the specified block and size " .. dividerColor .. "| §7" .. usageColor .. ".addBrush <block> <size> <mask>§r\n" ..
    keywordColor .. ".removeBrush§r " .. dividerColor .. "| §7removes a brush " .. dividerColor .. "| §7" .. usageColor .. ".removeBrush [brush]§r\n" ..
    keywordColor .. ".clearBrushes§r " .. dividerColor .. "| §7removes all of your brushes " .. dividerColor .. "| §7" .. usageColor .. ".clearBrushes§r\n" ..
    keywordColor .. ".listBrushes§r " .. dividerColor .. "| §7lists all of your brushes " .. dividerColor .. "| §7" .. usageColor .. ".listBrushes§r\n" ..  
    keywordColor .. ".wand§r " .. dividerColor .. "| §7gives you a wooden sword " .. dividerColor .. "| §7" .. usageColor .. ".wand§r")
end
    


--if cmdname == ".dupespin" then -- - - - - - - - - - - - - - - -- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -- - - - - - - - -DUPESPIN- - - -- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -- - - - - - - - - - - - - - - -- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -- - - - - - - - - - - - - - - -- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
--    xstep=1 ---                                  NOT FOR USE NOT FOR USE NOT FOR USE NOT FOR USE NOT FOR USE NOT FOR USE NOT FOR USENOT FOR USENOT FOR USENOT FOR USENOT FOR USENOT FOR USENOT FOR USENOT FOR USENOT FOR USENOT FOR USENOT FOR USENOT FOR USENOT FOR USENOT FOR USENOT FOR USENOT FOR USE  
--    if (xpos1 > xpos2) then              --X FIX
--        xstep=-1
--    end
--    ystep = 1
--    if (ypos1 > ypos2) then              --YFIX
--        ystep = -1
--    end
--    zstep = 1
--    if (zpos1 > zpos2) then              --ZFIX
--        zstep = -1
--    end
--    for xInSelectedRange = xpos1, xpos2, xstep do
--       for yinSelectedRange = ypos1, ypos2, ystep do
--            for zinSelectedRange = zpos1, zpos2, zstep do
--                BLOCK = dimension.getBlock(xInSelectedRange,yinSelectedRange,zinSelectedRange)
--                if(BLOCK.name == "air" )then else
--                    xdif = xpos1-xInSelectedRange
--                    ydif = 0
--                    zdif = zpos1-zinSelectedRange
--                   CIRCLERAD = math.sqrt(xdif*xdif+ydif*ydif+zdif*zdif)
--                    for rot  = -180, 180, 1 do
--                        client.execute("execute /tp @s ".. xpos1 .. " " .. yinSelectedRange .. " " .. zpos1 .. " ".. rot .. " " .. "0" )
--                        client.execute("execute setblock ^ ^ ^" .. CIRCLERAD .." " .. BLOCK)
--                    end
--                end
--            end
--        end
--    end
--end

function pos1cmd(args)
    x, y, z = player.position()
    xpos1 = x
    ypos1 =y
    zpos1 =z
    if not MuteSel then
        print(xpos1 .. " " .. ypos1 .. " " .. zpos1 .. "§b has been set as selection point 1")
    end
    
    
end

function pos2cmd(args)
    x, y, z = player.position()
    xpos2 = x
    ypos2 =y
    zpos2 =z
    if not MuteSel then
        print(xpos2 .. " " .. ypos2 .. " " .. zpos2 .. "§c has been set as selection point 2")
    end
    
end

function upcmd(args)
    arg = splitSpace(args)
    arg1 = arg[1]
    arg2 = arg[2]
    if arg1 == nil then
        print("§ePlease specify an amount of blocks to go up")
    else
        client.execute("execute tp @s ~ ~"..arg1 .. " ~")
        client.execute("execute setblock ~ ~-1 ~ glass")
        client.execute("execute setblock ~ ~ ~ air")
        client.execute("execute setblock ~ ~1 ~ air")
    end
    if WhooshS then
        playCustomSound("WEwhoosh.mp3")
    end
    if not MuteSucess then
        print("§aDone!")
    end
end

function thrutoolcmd(args)
    if ThruTool == true then
        if not MuteSucess then
            print("§cThruTool is now false")
        end
        ThruTool = false
    else
        if not MuteSucess then
            print("§aThruTool is now true")
        end
        ThruTool = true
    end
    playCustomSound("WEswitch.mp3")
end

function copycmd(args)
    arg = splitSpace(args)
    
    client.execute("execute structure save worldEditClipboard " .. xpos1 .. " " .. ypos1 .. " " .. zpos1 .. " " .. xpos2 .." " .. ypos2 .. " " .. zpos2)


    if not MuteSucess then
        print("§aCopied")
    end
    if DingS then
        playCustomSound("WEding.mp3")
    end
end

function pastecmd (args)

    arg = splitSpace(args)

    if arg[1] == nil then arg[1] = "0_degrees" end
    if arg[2] == nil then arg[2] = "none" end
    if arg[3] == nil then arg[3] = " " end
    if arg[4] == nil then arg[4] = " " end
    if arg[1] == "0" then arg[1] = "0_degrees" end
    if arg[1] == "90" then arg[1] = "90_degrees" end
    if arg[1] == "180" then arg[1] = "180_degrees" end
    if arg[1] == "270" then arg[1] = "270_degrees" end
    
    client.execute("execute /structure load worldEditClipboard " .. xpos1 .. " " .. ypos1 .. " " .. zpos1 .. " " .. arg[1] .. " " .. arg[2] .. " " ..arg[3] .. " " ..  arg[4])
    if not MuteSucess then
        print("§aPasted")
    end
    if DingS then
        playCustomSound("WEding")
    end
end



function wandcmd(args)
    if server.ip() == "" then
        client.execute("give wooden_sword 1 1 {\"Damage\":0,\"display\":{\"Name\":\"§l§5World Edit Wand §e§kkk\"},\"ench\":[{\"id\":22s,\"lvl\":10s}]}")
    else
        client.execute("execute /give @s wooden_sword")
    end
    
end 

function countcmd(args)
    arg = splitSpace(args)
    if arg[1] == nil then
        if xpos1 > xpos2 then
        xdif  = xpos1-xpos2 +1
        else
            xdif  = xpos2-xpos1 +1
        end
        if ypos1 > ypos2 then
            ydif  = ypos1-ypos2 +1
        else
            ydif  = ypos2-ypos1 +1
        end
        if zpos1 > zpos2 then
            zdif  = zpos1-zpos2 +1
        else
            zdif  = zpos2-zpos1 +1
        end
        areaOfSelection = xdif*ydif*zdif



    else
        countOfSpecifiedBlocksInTheCountCommand = 0


        xstep=1
        if (xpos1 > xpos2) then              --X FIX
            xstep=-1
        end
        ystep = 1
        if (ypos1 > ypos2) then              --YFIX
            ystep = -1
        end
        zstep = 1
        if (zpos1 > zpos2) then              --ZFIX
            zstep = -1
        end
        
        for xInSelectedRange = xpos1, xpos2, xstep do
            for yinSelectedRange = ypos1, ypos2, ystep do
                for zinSelectedRange = zpos1, zpos2, zstep do
                    
                    if dimension.getBlock(xInSelectedRange,yinSelectedRange,zinSelectedRange).name == arg[1] then
                        
                      countOfSpecifiedBlocksInTheCountCommand = countOfSpecifiedBlocksInTheCountCommand + 1  
                      
                    end         
                end
            end
        end
       
        areaOfSelection = countOfSpecifiedBlocksInTheCountCommand
    end
    
    print(areaOfSelection)
end


function selnearcmd(args)
    arg = splitSpace(args)
    if arg[1]==nil then
        arg[1] = 10
    end
    x, y, z = player.position()
    xpos1 = x - arg[1]
    xpos2 = x + arg[1]
    ypos1 = y - arg[1]
    ypos2 = y + arg[1]
    zpos1 = z - arg[1]
    zpos2 = z + arg[1]
end


function rotatecmd(args)
    print("§eDon't use on anything big or that you like. This is in beta (and always will be)")
    arg = splitSpace(args)
    
    client.execute("execute /structure save rotatorClip " .. dothething())

    client.execute("execute /fill " .. dothething() .. " air")


    
    xpastepos = math.min(xpos1,xpos2)
    ypastepos = math.min(ypos1,ypos2)
    zpastepos = math.min(zpos1,zpos2)
    
    
    client.execute("execute /structure load rotatorClip "..xpastepos .. " "..ypastepos .. " " .. zpastepos .." " .. arg[1])

end

function cpAlongSel(args)
    xstep=1
    if (xpos1 > xpos2) then              --X FIX
        xstep=-1
    end
    ystep = 1
    if (ypos1 > ypos2) then              --YFIX
        ystep = -1
    end
    zstep = 1
    if (zpos1 > zpos2) then              --ZFIX
        zstep = -1
    end
    for xInSelectedRange = xpos1, xpos2, xstep do
        for yinSelectedRange = ypos1, ypos2, ystep do
            for zinSelectedRange = zpos1, zpos2, zstep do
                
                --newsetblock(xInSelectedRange,yinSelectedRange,zinSelectedRange,BLOCKYTHING)
                
                
                
                
                client.execute("execute /structure load worldEditClipboard " .. xInSelectedRange .. " " .. yinSelectedRange .. " " .. zinSelectedRange)
            end
        end
    end
end







function mircmd(args)
    print("§eDon't use this on anything big or that you like. This is in beta (and always will be)")
    arg = splitSpace(args)
    
    client.execute("execute /structure save rotatorClip " .. dothething())

    client.execute("execute /fill " .. dothething() .. " air")




    if arg[2] == "weird" then
        xpastepos = xpos1
        ypastepos = ypos1
        zpastepos = zpos1
    else
        xpastepos = math.min(xpos1,xpos2)
        ypastepos = math.min(ypos1,ypos2)
        zpastepos = math.min(zpos1,zpos2)
    end
    
    client.execute("execute /structure load rotatorClip "..xpastepos .. " "..ypastepos .. " " .. zpastepos .." 0_degrees" .. " "..arg[1])

end







---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--                                                                                                                                                                              COMING SOONish
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------




    
function undocmd()
    print("§c I told you there was no undo ...")

    -- sameRnd = true

    -- curRndUndo = rndBlockList[counterBlockNotList-1] 
    -- if counterBlockNotList == 0 or counterBlockNotList == nil then
    --     sameRnd = false
    -- end

    -- while sameRnd do

    --     counterBlockNotList = counterBlockNotList - 1
        
    --     client.execute("execute /setblock " .. xBlockList[counterBlockNotList] .. " " .. yBlockList[counterBlockNotList] .. " " .. zBlockList[counterBlockNotList] .. " " .. blockBlockList[counterBlockNotList])
        
    --     if counterBlockNotList == 0 or counterBlockNotList == nil then
    --         sameRnd = false
    --     else
    --         if rndBlockList[counterBlockNotList-1] == curRndUndo then else
    --             sameRnd = false
    --         end
    --     end
    -- end
    


end

























--================================================================================================================================================================================================================================================================================================================================================================================================                                                                            
--                                                                                                                                                                               RENDER DT
--================================================================================================================================================================================================================================================================================================================================================================================================

function render(dt) 

   
    AreaVUI.visible = SizeS
    DiagCUI.visible = DiagS
    BoxCUI.visible = BoxS
    MirCUI.visible = MirS
    TextCUI.visible = TextS
    if xpos1 == nil or xpos2 == nil then
        displayText = "Either Point 1 or Point 2 isn't selected"
    else
        displayText = xpos1 .. " " .. ypos1 .. " " .. zpos1 .. "\n" .. xpos2 .. " " .. ypos2 .. " " .. zpos2
    end
    if displayText == nil then
        displayText = "Either Point 1 or Point 2 isn't selected"
    end
    local font = gui.font()
    sizeX = font.width(displayText,3)

    sizeY = font.height *3                                                                                                   
    if xpos1 == nil or xpos2 == nil then else
        if xpos1 > xpos2 then
            xdif  = xpos1-xpos2 +1
        else
            xdif  = xpos2-xpos1 +1
        end
        if ypos1 > ypos2 then
            ydif  = ypos1-ypos2 +1
        else
            ydif  = ypos2-ypos1 +1
        end
        if zpos1 > zpos2 then
            zdif  = zpos1-zpos2 +1
        else
            zdif  = zpos2-zpos1 +1
        end
        areaOfSelection = xdif*ydif*zdif
        if SizeS then
            if areaOfSelection > AreaV then
                MuteChat = true
                client.execute("execute title @s actionbar A lot of blocks are selected, this could cause unexpected behavior.")
            end
        end
        
        if TextS then
            gfx.color(TextC.r,TextC.b,TextC.b)
            gfx.text(0,0,displayText,3)
        end
        
    end
    --INFINITE WATER
    if doinfinitewater then
        replacecmd("water water")
    end
end


--================================================================================================================================================================================================================================================================================================================================================================================================                                                                            
--                                                                                                                                                                     RENDER 3D DT      
--================================================================================================================================================================================================================================================================================================================================================================================================                                                                            

function render3d(dt) 
    if xpos1 == nil or xpos2 == nil then else
        if DiagS then
            gfx.color(DiagC.r,DiagC.g,DiagC.b) -- DIAG LINE
            gfx.line(xpos1+0.5,ypos1+0.5,zpos1+0.5,xpos2+0.5,ypos2+0.5,zpos2+0.5)
        end

        if MirS then
            gfx.color(MirC.r,MirC.g,MirC.b) -- MIRROR LINE
            mirrorLine = (xpos1+xpos2)*0.5
            gfx.line(mirrorLine,ypos1,zpos1,mirrorLine,ypos1,zpos2)
        end
        
        if BoxS then
            gfx.color(BoxC.r,BoxC.g,BoxC.b)
            xpos1a = math.min(xpos1, xpos2) -- FIX VARS
            xpos2a = math.max(xpos1, xpos2) + 1
            ypos1a = math.min(ypos1, ypos2)
            ypos2a = math.max(ypos1, ypos2) + 1
            zpos1a = math.min(zpos1, zpos2)
            zpos2a = math.max(zpos1, zpos2) + 1
            gfx.line(xpos1a,ypos1a,zpos1a,xpos1a,ypos2a,zpos1a) -- DRAW CUBE
            gfx.line(xpos1a,ypos1a,zpos1a,xpos2a,ypos1a,zpos1a)
            gfx.line(xpos1a,ypos1a,zpos1a,xpos1a,ypos1a,zpos2a)
            gfx.line(xpos2a,ypos1a,zpos1a,xpos2a,ypos2a,zpos1a)
            gfx.line(xpos2a,ypos1a,zpos1a,xpos2a,ypos1a,zpos2a)
            gfx.line(xpos1a,ypos2a,zpos1a,xpos1a,ypos2a,zpos2a)
            gfx.line(xpos1a,ypos2a,zpos1a,xpos2a,ypos2a,zpos1a)
            gfx.line(xpos1a,ypos1a,zpos2a,xpos2a,ypos1a,zpos2a)
            gfx.line(xpos1a,ypos1a,zpos2a,xpos1a,ypos2a,zpos2a)
            gfx.line(xpos2a,ypos1a,zpos2a,xpos2a,ypos2a,zpos2a)
            gfx.line(xpos2a,ypos2a,zpos1a,xpos2a,ypos2a,zpos2a)
            gfx.line(xpos1a,ypos2a,zpos2a,xpos2a,ypos2a,zpos2a)
        end
        
    end
end


--================================================================================================================================================================================================================================================================================================================================================================================================                                                                            
--                                                                                                                                                             % BLOCK CALCULATOR (when using a % for fill or replace, it figures out what block) 
--The input gives percentages for different types of block e.g. 50%dirt,50%air. 
-- The output is a block chosen at random according to the specified percentages. 
--================================================================================================================================================================================================================================================================================================================================================================================================                                                                            

function blockfiguer(blockstring)
    if string.sub(blockstring,0,1) == "0" or string.sub(blockstring,0,1) == "1" or string.sub(blockstring,0,1) == "2" or string.sub(blockstring,0,1) == "3" or string.sub(blockstring,0,1) == "4" or string.sub(blockstring,0,1) == "5" or string.sub(blockstring,0,1) == "6" or string.sub(blockstring,0,1) == "7" or string.sub(blockstring,0,1) =="8" or string.sub(blockstring,0,1) == "9" then
        local Blocky = {}
        local PercNum = {}
        countycount = 0
        local arrgumtys
        local arrgumtys2
        for arrgumtys in string.gmatch(blockstring, '([^,]+)') do
            countycount2 = 1
            for arrgumtys2 in string.gmatch(arrgumtys, '([^%%]+)') do
                if countycount2 == 1 then
                    PercNum[countycount] = tonumber(arrgumtys2)
                elseif countycount2 == 2 then
                    Blocky[countycount] = arrgumtys2
                end
                countycount2 = countycount2 +1
            end
            countycount = countycount + 1
        end
        Counter10 = 0
        for c1 = 0, countycount-1, 1 do 
            Counter10 = Counter10 + PercNum[c1]
        end
        blockstring = ""
        if Counter10 == 100 then
            chosennumber = math.random(100)
            CumulativePerc = 0
            for countthruarray = 0, countycount-1, 1 do
                CumulativePerc = CumulativePerc + PercNum[countthruarray]
                if (chosennumber < CumulativePerc or chosennumber == CumulativePerc)then
                    return (Blocky[countthruarray])
                end
            end
        else
            print("§eInvalid Input. The sum of percentages don't equal 100")
        end
    else
        return (blockstring)
    end
end


function splitSpace(messagee)
    counterr = 0
    arg = {}
    for token in string.gmatch(messagee, "[^%s]+") do
        counterr = counterr + 1
        arg[counterr] = token
    end
    return arg
end


event.listen("ChatMessageAdded", function(message, username, type, xuid)

    if message == "yes" then
        if askForConfirm[1] then
            fillcmd(askForConfirm[2],true)
            askForConfirm = {}
            return true
        end
    end
    
    --if cqnter4 == nil then cqnter4 = 0 end
    --print("hi")
    --print (string.sub(message,5,11))
    --cqnter4 = cqnter4 + 1
    -- if string.sub(message,5,11) == "he bloc" then   
    --     cqntr3 = cqntr3 + 1 
    --    --print("here" .. " " .. cqntr3)
    --    do return true end
    -- end
    -- if string.sub(message,1,10) == "Successful" then
        
        
    --     THINGTORETURN = cqntr3

    --     --print("YESSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS")
    --     --print("the block is ..... " .. orderofexecuting[THINGTORETURN])


    --     if increaseblockstate then
    --         blocktosetstate = orderofexecuting[THINGTORETURN+1]
            
    --     else 
    --         blocktosetstate = orderofexecuting[THINGTORETURN+-1]
    --     end
    --     if blocktosetstate == nil then blocktosetstate = orderofexecuting[0] end
    --     selblockx, selblocky, selblockz = player.selectedPos()
    --     Blockyyy = dimension.getBlock(selblockx,selblocky,selblockz)
    --     blockNameyyy = Blockyy.name

    --     client.execute("execute /setblock " .. selblockx .. " " .. selblocky .. " " .. selblockz .. " " .. blockNameyyy .. " " .. blocktosetstate)

    --     cqntr3 = 0

    --     do return true end
    -- end


    if MuteFill then
        if type == 6 then
            return true
        end
    end
    
end)


function dothething()
    return(xpos1 .. " " .. ypos1 .. " " .. zpos1 .. " " .. xpos2 .. " " .. ypos2 .. " " .. zpos2)
end

