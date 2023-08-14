name = "World Edit"
description = "World Edit for bedrock. Type .help for an explanation (The wand isn't an axe, it's a sword). All commands use the \".\" prefix."

  


importLib("auxToState.lua")
client.settings.addAir(10)
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

client.settings.addAir(10)

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


SizeS = true
client.settings.addBool("Do Size Warning","SizeS")
AreaV = 5000
AreaVUI = client.settings.addInt("Area Size Warning","AreaV",500,50000)


--help
registerCommand("WEhelp", function(arguments)
    helpcmd(arguments)
end)

--fill
registerCommand("fill", function (arguments)
    fillcmd(arguments)
end)

--replace
registerCommand("replace",function (arguments)
    repalcecmd(arguments)
end)
registerCommand("rep",function (arguments)
    repalcecmd(arguments)
end)

--line
registerCommand("line",function (arguments)
    linecmd(arguments)
end)

--mirror
registerCommand("mirror",function (arguments)
    mircmd(arguments)
end)
registerCommand("mir",function (arguments)
    mircmd(arguments)
end)

--wall
registerCommand("wall",function (arguments)
    wallcmd(arguments)
end)

-- infwater
registerCommand("infinitewater",function (arguments)
    infwatercmd(arguments)
end)
registerCommand("infwater",function (arguments)
    infwatercmd(arguments)
end)

--circle 
registerCommand("circle",function (arguments)
    circlecmd(arguments)
end)

--sphere
registerCommand("sphere",function (arguments)
    spherecmd(arguments)
end)

--buildup
registerCommand("buildup",function (arguments)
    bucmd(arguments)
end)
registerCommand("build-up",function (arguments)
    bucmd(arguments)
end)
registerCommand("bu",function (arguments)
    bucmd(arguments)
end)

--pos1 and pos2
registerCommand("pos1",function (arguments)
    pos1cmd(arguments)
end)
registerCommand("pos2",function (arguments)
    pos2cmd(arguments)
end)

--up
registerCommand("up",function (arguments)
    upcmd(arguments)
end)

--thrutool
registerCommand("thrutool",function (arguments)
    thrutoolcmd(arguments)
end)

--copy
registerCommand("copy",function (arguments)
    copycmd(arguments)
end)

--paste 
registerCommand("paste",function (arguments)
    pastecmd(arguments)
end)

--count
registerCommand("count",function (arguments)
    countcmd(arguments)
end)

--wand
registerCommand("wand",function (arguments)
    wandcmd(arguments)
end)

--selnear
registerCommand("selnear",function (arguments)
    selnearcmd(arguments)
end)
-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
                                                    --                          USE .HELP TO GET AN EXPLANATION ON HOW TO USE
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
positionX = 50
positionY = 50
sizeX = 180
sizeY = 50
event.listen("MouseInput", function(button, down) --                    SECLECTION
    if gui.mouseGrabbed() == false then
        if down then
            if player.facingBlock() then
                inventory = player.inventory()
                selectedpos = inventory.selected
                selected = inventory.at(selectedpos)
                if selected == nil  then else
                
                    if selected.name == "wooden_sword" then
                        xface, yface, zface = player.selectedPos()
                        if ThruTool == true and button == 1 then
                            x,y,z = player.position()
                            rotdeg, pitchdeg = player.rotation()
                            
                            rot = math.rad(player.rotation()-180)
                            pit = math.rad(pitchdeg)
                            zz = math.cos(pit) * math.cos(rot)*-1
                            xx = math.cos(pit) * math.sin(rot)
                            yy = math.sin(pit)*-1
                        for I = 2, 356, 1 do
                                xxx = math.floor(x+xx*I+0.5)
                                zzz = math.floor(z+zz*I+0.5)
                                yyy = math.floor(y+yy*I+0.5) 
                                blockOfDoom = dimension.getBlock(xxx,yyy+1,zzz).name
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
                                
                            end
                            if button == 2 then                                          -- RIGHT MB
                                xpos2 = xface
                                ypos2 = yface
                                zpos2 = zface
                                if not MuteSel then
                                    print(xpos2 .. " " .. ypos2 .. " " .. zpos2 .. "§c has been set as selection point 2")
                                end
                            end
                        end
                    end
                end
                
            end
            
        end
    end
end) 


function fillcmd(args)
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
    for xInSelectedRange = xpos1, xpos2, xstep do
        for yinSelectedRange = ypos1, ypos2, ystep do
            for zinSelectedRange = zpos1, zpos2, zstep do
                BLOCKYTHING = blockfiguer(arg[1])
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

function repalcecmd(args)
    
    arg = splitSpace(args)
    arg1 = arg[1]
    arg2 = arg[2]
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
                if(dimension.getBlock(xInSelectedRange,yinSelectedRange,zinSelectedRange).name == replacewhat)then
                    replacewith = blockfiguer(replacewith)
                    client.execute("execute /setblock " .. tostring(xInSelectedRange).. " " ..tostring(yinSelectedRange).. " " .. tostring(zinSelectedRange) .. " " .. replacewith)
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
    arrg2 = arg[2]
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
    for countofdis = 1, DISTANCE, tonumber (arg2) do
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

function mircmd(args)
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

function spherecmd(args)
    arg = splitSpace(args)
    arg1 = arg[1]
    arg2 = arg[2]
    
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
                if arg2 == "true" then   -- FILLING IN SPHERE
                    if (MYRAD < SPHERERAD) then
                    client.execute("execute /setblock " .. xa .. " " .. ya .. " " .. za .." " .. arg1)     
                    end      
                else -- surface of sphere
                    if ((MYRAD < SPHERERAD + 0.55) and  (MYRAD > SPHERERAD - 0.55)) then
                        client.execute("execute /setblock " .. xa .. " " .. ya .. " " .. za .." " .. arg1)     
                    end    
                end
            end
        end
    end
    if DingS then
        playCustomSound("WEding.mp3")
    end    
    if not MuteSucess then
        print("§aMade a sphere of §f "..arg1)
    end
end

function circlecmd(args)
    arg = splitSpace(args)
    arg1 = arg[1]
    arg2 = arg[2]
    arg3 =arg[3]
    if arg1 == "x" or arg1 == "y" then else
        print("No specified axis, assuming x")
        arg2 = arg1
        arg1 = "x"
    end
    if not MuteSucess then
        print("§aMaking circle of §f" .. arg2 .. "§a and in the§f " .. arg1 .. " §a plain")
    end
    xdif = xpos1-xpos2
    ydif = ypos1-ypos2
    zdif = zpos1-zpos2
    CIRCLERAD = math.sqrt(xdif*xdif+ydif*ydif+zdif*zdif)
    yaw, pitch = player.rotation()
    x, y, z =player.position()
    client.execute("tp @s " .. xpos1 .. " " .. ypos1 .. " " .. zpos1)

    if arg3 == "true" then
        if (arg1 == "x") then
            for rot  = -180, 180, 1 do
                client.execute("execute /tp @s ".. xpos1 .. " " .. ypos1 .. " " .. zpos1 .. " ".. rot .. " " .. "0" )
                client.execute("execute fill ~ ~ ~ ^ ^ ^"..CIRCLERAD.. " " .. arg2 )
            end

        elseif (arg1 == "y") then
            for rot  = -180, 180, 1 do
                client.execute("execute /tp @s".. xpos1 .. " " .. ypos1 .. " " .. zpos1 .. " " .. 90  .. " ".. rot )
                arg2NEW = blockfiguer(arg2)
                client.execute("execute fill ~ ~ ~ ^ ^ ^"..CIRCLERAD.. " " .. arg2NEW )
            end
            for rot  = -180, 180, 1 do
                client.execute("execute /tp @s ".. xpos1 .. " " .. ypos1 .. " " .. zpos1 .. " ".. " -90 " .. rot )
                arg2NEW = blockfiguer(arg2)
                client.execute("execute fill ~ ~ ~ ^ ^ ^"..CIRCLERAD.. " " .. arg2NEW )
            end
        else
            print("§eThis is not a valid input (please put x or y)")
        end
        client.execute("execute /tp @s " .. x .. " " .. y .. " " .. z)
    else
        if (arg1 == "x") then
            for rot  = -180, 180, 1 do
                client.execute("execute /tp @s ".. xpos1 .. " " .. ypos1 .. " " .. zpos1 .. " ".. rot .. " " .. "0" )
                arg2NEW = blockfiguer(arg2)
                client.execute("execute setblock ^ ^ ^"..CIRCLERAD.. " " .. arg2NEW )
            end
        
        elseif (arg1 == "y") then
            for rot  = -180, 180, 1 do
                client.execute("execute /tp @s ".. xpos1 .. " " .. ypos1 .. " " .. zpos1 .. " " .. 90  .. " ".. rot )
                arg2NEW = blockfiguer(arg2)
                client.execute("execute setblock ^ ^ ^"..CIRCLERAD.. " " .. arg2NEW )
                
            end
            for rot  = -180, 180, 1 do
                client.execute("execute /tp @s ".. xpos1 .. " " .. ypos1 .. " " .. zpos1 .. " ".. " -90 " .. rot )
                arg2NEW = blockfiguer(arg2)
                client.execute("execute setblock ^ ^ ^"..CIRCLERAD.. " " .. arg2NEW )
            end
        else
            print("§dThis is not a valid input (please put x or y)")
        end
    client.execute("execute /tp @s " .. x .. " " .. y .. " " .. z)
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
    xline, yline, zline = player.pposition()
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
    client.execute("execute tp " .. xline .. " " .. yline .. " " .. zline)
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
                    for howhighcount = 1, howhigh, 1 do
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
    keywordColor .. ".replace§r " .. dividerColor .. "| §7replaces all of the first argument's block to the second within the selected range " .. dividerColor .. "| §7" .. usageColor .. ".replace§r <replacewhat> <replacewith>\n" ..
    keywordColor .. ".line§r " .. dividerColor .. "| §7creates a line between the two selected points " .. dividerColor .. "| §7" .. usageColor .. ".line§r <block> [width/precision]\n" ..
    keywordColor .. ".mirror§r " .. dividerColor .. "| §7mirrors one side of the blue line to the other. Doesn't work with block states" .. dividerColor .. "| §7" .. usageColor .. ".mirror§r\n" ..
    keywordColor .. ".wall§r " .. dividerColor .. "| §7creates a wall between two points " .. dividerColor .. "| §7" .. usageColor .. ".wall§r <block> [width/precision]\n" ..
    keywordColor .. ".infinitewater§r " .. dividerColor .. "| §7all non-source water blocks get turned into sources so can spread infinitely in any direction aside from up\n" ..
    dividerColor .. "------------------------------\n" ..
    keywordColor .. ".circle§r " .. dividerColor .. "| §7makes a circle with the radius of the distance between the two selected points (the center being the first) " .. dividerColor .. "| §7" .. usageColor .. ".circle§r <x or y> <block> [true/false:fill]\n" ..
    keywordColor .. ".sphere§r " .. dividerColor .. "| §7makes a sphere with the radius of the distance between the two selected points " .. dividerColor .. "| §7" .. usageColor .. ".sphere§r <block> [true/false:fill]\n" ..
    keywordColor .. ".build-up§r " .. dividerColor .. "| §7duplicates all of the specified block up a specified amount of times " .. dividerColor .. "| §7" .. usageColor .. ".build-up§r <block> <height>\n" ..
    keywordColor .. ".help§r " .. dividerColor .. "| §7I think you already know how to use this one " .. dividerColor .. "| §7" .. usageColor .. ".help§r\n" ..
    keywordColor .. ".pos1§r " .. dividerColor .. "| §7sets position 1 to your current coordinates (your feet) " .. dividerColor .. "| §7" .. usageColor .. ".pos1§r\n" ..
    keywordColor .. ".pos2§r " .. dividerColor .. "| §7same as pos1 " .. dividerColor .. "| §7" .. usageColor .. ".pos2§r\n" ..
    keywordColor .. ".up§r " .. dividerColor .. "| §7teleports you up a specified amount of blocks upward and places a block below you " .. dividerColor .. "| §7" .. usageColor .. ".up§r <height>\n" ..
    keywordColor .. ".thrutool§r " .. dividerColor .. "| §7when pressed against a block click and it will teleport you to the other side of the block/s (intended for going in and out of builds without using a door). Limit of 356 blocks " .. dividerColor .. "| §7" .. usageColor .. ".thrutool§r\n" ..
    dividerColor .. "------------------------------\n" ..
    keywordColor .. ".copy§r " .. dividerColor .. "| §7Copies the selected area to a file in ..scripts\\data " .. dividerColor .. "| §7" .. usageColor .. ".copy§r\n" ..
    keywordColor .. ".paste§r " .. dividerColor .. "| §7pastes the file in the file with no rotational changes. !!WARNING!! This function is laggy and doesn't work with block states on 1.20 blocks. If you're pasting very precisely or a large build, use structure blocks instead. " .. dividerColor .. "| §7" .. usageColor .. ".paste§r [true/false:skip/keep air]\n" ..
    keywordColor .. ".count§r " .. dividerColor .. "| §7counts the number of a specified (or all) block(s) " .. dividerColor .. "| §7" .. usageColor .. ".count [block]§r\n" ..
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
    arg1 = arg[1]
    arg2 = arg[2]
    if xpos1 > xpos2 then
        xdif22  = xpos1-xpos2
    else
        xdif22  = xpos2-xpos1
    end
    if ypos1 > ypos2 then
        ydif22  = ypos1-ypos2
    else
        ydif22  = ypos2-ypos1
    end
    if zpos1 > zpos2 then
        zdif22  = zpos1-zpos2
    else
        zdif22  = zpos2-zpos1
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
    ClipboardFile = io.open("WorldEditClipboard.txt","w+")
    ClipboardFile:write(xdif .. "\n" .. ydif .. "\n" .. zdif .. "\n")
    ClipboardFile:write(xstep .. "\n" .. ystep .. "\n" .. zstep .. "\n")
    for xInSelectedRange = xpos1, xpos2, xstep do
        for yinSelectedRange = ypos1, ypos2, ystep do
            for zinSelectedRange = zpos1, zpos2, zstep do
                FoundBlock = dimension.getBlock(xInSelectedRange, yinSelectedRange, zinSelectedRange)
                BlockData = FoundBlock.data
                BlockName = FoundBlock.name
                BlockDataNew = convertAux(BlockName,BlockData)
                if  ClipboardFile then
                    if BlockDataNew == nil then
                        BlockDataNew = ""
                    end
                    ClipboardFile:write(BlockName .."\n".. BlockName .. " " .. BlockDataNew.."\n")
                end
            end
        end
    end
    io.close(ClipboardFile)
    if not MuteSucess then
        print("§aCopied")
    end
    if DingS then
        playCustomSound("WEding.mp3")
    end
end

function pastecmd (args)
    WorldEditClipboardy = io.open("WorldEditClipboard.txt","r")
    FileLines = {}
    counter = 0
    for line in WorldEditClipboardy:lines() do
        FileLines[counter] = line
        counter = counter +1 
    end
    xdif222 = tonumber(FileLines[0])
    ydif222 = tonumber(FileLines[1])
    zdif222 = tonumber(FileLines[2])
    xstep = tonumber(FileLines[3])
    ystep = tonumber(FileLines[4])
    zstep = tonumber(FileLines[5])
    
    counter = 5
    --print(xdif222.. " " .. ydif222.. " " .. zdif222)
    for xInSelectedRange = xpos1, xpos1+(xdif222*xstep)-xstep, xstep do
        for yinSelectedRange = ypos1, ypos1+(ydif222*ystep)-ystep, ystep do
            for zinSelectedRange = zpos1, zpos1+(zdif222*zstep)-zstep, zstep do
                CURRENTBLOCK = FileLines[counter]
                CURRENTBLOCKDATA = FileLines[counter+1]
                if arg1 == "false" or nil then
                    if CURRENTBLOCK == "air" then
                        goto skip
                        print("§aSKipping air blocks when copying, not skipping will lag and maybe crash your game a lot depending on size. §eTo not skip type .paste true")
                    end
                else
                    if dimension.getBlock(xInSelectedRange,yinSelectedRange,zinSelectedRange) == "air" and CURRENTBLOCK == "air" then
                        goto skip
                    end
                end
                
                client.execute("execute /setblock " .. xInSelectedRange .. " " .. yinSelectedRange .. " " .. zinSelectedRange ..  " " ..CURRENTBLOCKDATA)
                ::skip::
                counter = counter + 2
            end
        end
    end
    if not MuteSucess then
        print("§aPasted")
    end
    if DingS then
        playCustomSound("WEding")
    end
end



function wandcmd(args)
    client.execute("give wooden_sword 1 1 {\"Damage\":0,\"display\":{\"Name\":\"§l§5World Edit Wand §e§kkk\"},\"ench\":[{\"id\":22s,\"lvl\":10s}]}")
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
    x, y, z = player.position()
    xpos1 = x - 10
    xpos2 = x +10
    ypos1 = y - 10
    ypos2 = y +10
    zpos1 = z -10
    zpos2 = z +10
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
        repalcecmd("water water")
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
    if string.sub (message,0,1) == "." then
        print("The World Edit Commands prefix has been changed to  a full stop/period (.)")
    end
    if MuteFill then
        if type == 6 then
            return true
        end
    end
end)
