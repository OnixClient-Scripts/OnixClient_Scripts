name = "World Edit"
description = "World Edit for bedrock. Type $help for an explanation (The wand isn't an axe, it's a sword). All commands use the \"$\" prefix."

--CHANGLOG
-- SOUNDS
-- settings INCLUDING COLOUR CHOOSING OPTONS, AND INCLUDING mute chat IN SETTINGS
-- BOX FOR MOVING IS SAME SIZE AS TEXT
-- neW HELP COMMAND 
-- NO LONGER CASE SENSITIVE
-- $COUNT COMMAND COUNTS BLOCKS IN SELECTED RANGE
--$SELNEAR OR $SELECTNEAR SELECTS A CUBE AROUND YOU (20 by 20 by 20)
--COMMANDS NOW ONLY WORK IF RUN BY THE USER OF THE SCRIPT (so random people cant use your commands and operator to do things)

local clock = os.clock
function sleep(n)-- seconds
local t0 = clock()
while clock() - t0 <= n do end
end

DiagS = false
client.settings.addBool("Show Diag","DiagS")
DiagC = {255,0,0}
DiagCUI = client.settings.addColor("Diag Color","DiagC")

client.settings.addAir(10)

BoxS = true
client.settings.addBool("Show Box","BoxS")
BoxC = {0,255,0}
BoxCUI = client.settings.addColor("Box Color","BoxC")

client.settings.addAir(10)

MirS = false
client.settings.addBool("Show Mirror","MirS")
MirC = {0,0,255}
MirCUI = client.settings.addColor("Mirror Color", "MirC")

client.settings.addAir(10)

TextS = false
client.settings.addBool("Show Text", "TextS")
TextC = {255,255,255}
TextCUI = client.settings.addColor("Text Color", "TextC")

client.settings.addAir(10)

MuteChat =  true
client.settings.addBool("Mute Chat","MuteChat")
 
client.settings.addAir(10)

DingS = true
client.settings.addBool("Ding Sound","DingS")
WhooshS = true
client.settings.addBool("Whoosh Sound","WhooshS")

client.settings.addAir(10)

SizeS = true
client.settings.addBool("Do Size Warning","SizeS")
AreaV = 5000
AreaVUI = client.settings.addInt("Area Size Warning","AreaV",500,50000)

client.settings.addAir(10)

MaxDis = 2000
client.settings.addInt("Max ThruTool Distance","MaxDis",50,10000)








-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
                                                    --                          USE $HELP TO GET AN EXPLANATION ON HOW TO USE
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
                        for I = 2, MaxDis, 1 do
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
                                print(xpos1 .. " " .. ypos1 .. " " .. zpos1 .. "§b has been set as selection point 1")
                            end
                            if button == 2 then                                          -- RIGHT MB
                                xpos2 = xface
                                ypos2 = yface
                                zpos2 = zface
                                print(xpos2 .. " " .. ypos2 .. " " .. zpos2 .. "§c has been set as selection point 2")
                            end
                        end
                    end
                end
                
            end
            
        end
    end
end) 

--=========================================================================================================================================================================================================================================================================================================================================================================================
--                                                                                                                                                        ON MEASAGE ADDED
--====================================================================================================================================================================================================================================================================================================================================================================================================================================

event.listen("ChatMessageAdded", function(message, username, type, xuid) 
    CommandDone = false
    if username == player.name() then

    
        if string.sub(message, 1, 1) == "$" then --================================================================================================================FIND ARGUMENTS AND CMDNAME========================================================================================================================================================================================================================================================================================
            ccc = 0
            for token in string.gmatch(message, "[^%s]+") do
                if ccc==0 then
                    cmdname = token
                    
                end
                if ccc == 1 then
                    arg1 = token
                end
                if ccc == 2 then
                    arg2 = token
                end
                if ccc == 3 then
                    arg3 = token
                end
                ccc = ccc +1
            end
            cmdname = string.lower(cmdname)
            if xpos1 == nil or xpos2 == nil  then
                if cmdname == "$thrutool" or cmdname == "$mutechat" or cmdname == "$wand" or cmdname == "$up" or cmdname == "$pos1" or cmdname == "$pos2" or cmdname == "$help" or cmdname == "$selnear" or cmdname == "$selectnear" then else
                    print("§eBefore Doing a command, please select an area")
                    goto endOfChatFunc
                end
            end

    -- ==========================================================================================================================================================COMMANDS=====================================================================================================================================================================================================================================================
            cmdname = string.lower(cmdname)
            if cmdname == "$fill" then-- - - - - - - - - - - - - - - -- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - FILL- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  -  -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
                if arg1 == nil then
                    print("§ePlease specify the block you would like to fill")
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
                            BLOCKYTHING = blockfiguer(arg1)
                            client.execute("execute /setblock " .. tostring(xInSelectedRange).. " " ..tostring(yinSelectedRange).. " " .. tostring(zinSelectedRange) .. " " .. BLOCKYTHING)
                        end
                    end
                end
                if DingS then
                    playCustomSound("WEding.mp3")
                end
                CommandDone = true
            end

            if cmdname == "$replace" or cmdname == "$rep" then-- - - - - - - - - - - - - - - -- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - REPLACE -- - - - - - - - - - - - - - - -- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  -- - - - - - - - - - - - - - - -- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  -- - - - - - - - - - - - - - - -- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  
                replacewhat = arg1
                replacewith = arg2
                
                print("§aReplacing §f " .. replacewhat .. "§a with §f " .. replacewith)
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
                CommandDone = true
            end

            if cmdname == "$line" then-- - - - - - - - - - - - - - - -- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -- - - - - - - - - - - - - - - -- - - - - - - - - - - - - - - - - LINE -- - - - - - - - - - - - - - - -- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  -- - - - - - - - - - - - - - - -- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  -- - - - - - - - - - - - - - - -- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
                print("§a Drawing line")
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
                for countofdis = 1, DISTANCE, arg2 do
                    client.execute("execute /setblock ^ ^ ^" .. countofdis .. " " .. arg1)
                end
                client.execute("execute tp " .. xline .. " " .. yline .. " " .. zline .. " " .. yaw .. " " .. pitch)
                if DingS then
                    playCustomSound("WEding.mp3")
                end
                CommandDone = true
            end

            if cmdname == "$mirror" then -- - - - - - - - - - - - - - - -- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -- - - - - - - - - - - - - - - -- - - - - - - - - - - - - - - -MIRROR - - - - - - - - - - - - - - - - - -- - - - - - - - - - - - - - - -- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -- - - - - - - - - - - - - - - -- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
                print("§a Mirroring")
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
                CommandDone = true
            end

            if cmdname == "$sphere" then -- - - - - - - - - - - - - - - -- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  -- - - - - - - - - - - - - -  SPHERE - - - - - - - - - - - - - - - - - - - - - - -  -- - - - - - - - - - - - - - - -- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  -- - - - - - - - - - - - - - - -- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  
                counteryyyyy = 0
                print("§aMaking a sphere of §f "..arg1)
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
                CommandDone = true
            end

            if cmdname == "$circle" then  -- - - - - - - - - - - - - - - -- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  -- - - - - - - - - - - - - - - -- - - -CIRCLE - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  -- - - - - - - - - - - - - - - -- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  -- - - - - - - - - - - - - - - -- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
                if arg1 == "x" or arg1 == "y" then else
                    print("No specified axis, assuming x")
                    arg2 = arg1
                    arg1 = "x"
                end
                print("§aMaking circle of §f" .. arg2 .. "§a and in the§f " .. arg1 .. " §a plain")
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
                CommandDone = true
            end

            if cmdname == "$wall" then -- - - - - - - - - - - - - - - -- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  -- - - - - - - - - - - - - - - - - - WALL - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  -- - - - - - - - - - - - - - - -- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  -- - - - - - - - - - - - - - - -- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
                print("§aMaking wall")
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
                if DingS then
                    playCustomSound("WEding.mp3")
                end
                CommandDone = true

            end

            if cmdname == "$infinitewater" then -- - - - - - - - - - - - - - - -- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  -- - - - - - - - - - - - -INFINTE WATER - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -- - - - - - - - - - - - - - - -- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
                if doinfinitewater == true then
                    doinfinitewater = false
                    print("§cStopped infinitewater")
                else
                    doinfinitewater = true
                    print("§aStarted infinitewater. Type $infinitewater to stop")
                end
                
                CommandDone = true
            end

        

            if cmdname == "$build-up" or cmdname == "$buildup" or cmdname == "$bu" then -- - - - - - - - - - - - - - - -- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  -- - - - - - - - - - - - - - - -- BUILD-UP - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  -- - - - - - - - - - - - - - - -- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  -- - - - - - - - - - - - - - - -- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
                replacewhat = arg1
                howhigh = arg2
                print("§a Building-Up §f" .. replacewhat .." " .. howhigh .. " §ablocks.")
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
                CommandDone = true
            end

            if cmdname == "$help" then -- -- - - - - - - - - - - - - - - -- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -- - - - - - - - - - HELP  - - - -- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -- - - - - - - - - - - - - - - -- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -- - - - - - - - - - - - - - - -- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
                --print("Select 2 positions using a wooden sword then type one of the commands to affect that area.\n When the syntax says \"block\" it means either something like \"dirt\" or something like \"50%dirt,50%air\" \n $fill | runs a normal fill command | $fill <block> \n $replace | replaces all of the first argument's block to the second within the selected range | $replace <replacewhat> <replacewith> \n $line | creates a line between the two selected points | $line <block> [width/precision] \n $mirror | mirrors one side of the blue line to the other. Doesn't work with block states| $mirror \n $wall | creates a wall between two points | $wall <block> [width/precision] \n $infinitewater | all non-source water blocks get turned into sources so can spread infinitly in any direction aside from up \n $circle | makes a circle with the radius of the distance between the two selected points (the center being the first) | $circle <x or y> <block> [true/fasle:fill] \n $sphere | makes a sphere with the radius of the distance between the two selected points | $sphere <block> [true/fasle:fill] \n $HUD | toggles the coordinates of the two selected points | $HUD \n $build-up | duplicates all of the specified block up a specified amount of times | $build-up <block> <height> \n $help | i think you already know how to use this one | $help \n $pos1 | sets position 1 to your current coordinates (your feet) | $pos1 \n $pos2 | same as pos1 | $pos2 \n $up | teleports you up a specified amount of blocks upward and places a block below you | $up <height> \n $thrutool | when pressed against a block click and it will teleport you to the other side of the block/s (intended for going in and out of builds without using a door). Limit of 356 blocks | $thrutool\n $copy | Copies the selected area to a file in ..scripts\\data | $copy \n $paste | pastes the file in the file with no rotational changes. !!WARNING!! This function is laggy and doesn't do block states with 1.20 blocks so if your pasting very precisly or large build just use structure blocks | $paste [true/false:skip/keep air]\n $wand | gives you a wooden sword | $wand   ")
                local keywordColor = "§e"  -- Yellow color for keywords
                local usageColor = "§a"    -- Green color for usage
                local dividerColor = "§f"  -- Grey color for dividers
                
                print("Select 2 positions using a wooden sword then type one of the commands to affect that area.\n" ..
                    "When the syntax says \"block\", it means either something like \"dirt\" or something like \"50%dirt,50%air\"\n" ..
                    dividerColor .. "------------------------------\n" ..
                    keywordColor .. "$fill§r " .. dividerColor .. "| §7runs a normal fill command " .. dividerColor .. "| §7" .. usageColor .. "$fill§r <block>\n" ..
                    keywordColor .. "$replace§r " .. dividerColor .. "| §7replaces all of the first argument's block to the second within the selected range " .. dividerColor .. "| §7" .. usageColor .. "$replace§r <replacewhat> <replacewith>\n" ..
                    keywordColor .. "$line§r " .. dividerColor .. "| §7creates a line between the two selected points " .. dividerColor .. "| §7" .. usageColor .. "$line§r <block> [width/precision]\n" ..
                    keywordColor .. "$mirror§r " .. dividerColor .. "| §7mirrors one side of the blue line to the other. Doesn't work with block states" .. dividerColor .. "| §7" .. usageColor .. "$mirror§r\n" ..
                    keywordColor .. "$wall§r " .. dividerColor .. "| §7creates a wall between two points " .. dividerColor .. "| §7" .. usageColor .. "$wall§r <block> [width/precision]\n" ..
                    keywordColor .. "$infinitewater§r " .. dividerColor .. "| §7all non-source water blocks get turned into sources so can spread infinitely in any direction aside from up\n" ..
                    dividerColor .. "------------------------------\n" ..
                    keywordColor .. "$circle§r " .. dividerColor .. "| §7makes a circle with the radius of the distance between the two selected points (the center being the first) " .. dividerColor .. "| §7" .. usageColor .. "$circle§r <x or y> <block> [true/false:fill]\n" ..
                    keywordColor .. "$sphere§r " .. dividerColor .. "| §7makes a sphere with the radius of the distance between the two selected points " .. dividerColor .. "| §7" .. usageColor .. "$sphere§r <block> [true/false:fill]\n" ..
                    keywordColor .. "$build-up§r " .. dividerColor .. "| §7duplicates all of the specified block up a specified amount of times " .. dividerColor .. "| §7" .. usageColor .. "$build-up§r <block> <height>\n" ..
                    keywordColor .. "$help§r " .. dividerColor .. "| §7I think you already know how to use this one " .. dividerColor .. "| §7" .. usageColor .. "$help§r\n" ..
                    keywordColor .. "$pos1§r " .. dividerColor .. "| §7sets position 1 to your current coordinates (your feet) " .. dividerColor .. "| §7" .. usageColor .. "$pos1§r\n" ..
                    keywordColor .. "$pos2§r " .. dividerColor .. "| §7same as pos1 " .. dividerColor .. "| §7" .. usageColor .. "$pos2§r\n" ..
                    keywordColor .. "$up§r " .. dividerColor .. "| §7teleports you up a specified amount of blocks upward and places a block below you " .. dividerColor .. "| §7" .. usageColor .. "$up§r <height>\n" ..
                    keywordColor .. "$thrutool§r " .. dividerColor .. "| §7when pressed against a block click and it will teleport you to the other side of the block/s (intended for going in and out of builds without using a door). Limit of 356 blocks " .. dividerColor .. "| §7" .. usageColor .. "$thrutool§r\n" ..
                    dividerColor .. "------------------------------\n" ..
                    keywordColor .. "$copy§r " .. dividerColor .. "| §7Copies the selected area to a file in ..scripts\\data " .. dividerColor .. "| §7" .. usageColor .. "$copy§r\n" ..
                    keywordColor .. "$paste§r " .. dividerColor .. "| §7pastes the file in the file with no rotational changes. !!WARNING!! This function is laggy and doesn't work with block states on 1.20 blocks. If you're pasting very precisely or a large build, use structure blocks instead. " .. dividerColor .. "| §7" .. usageColor .. "$paste§r [true/false:skip/keep air]\n" ..
                    keywordColor .. "$wand§r " .. dividerColor .. "| §7gives you a wooden sword " .. dividerColor .. "| §7" .. usageColor .. "$wand§r")
                    CommandDone = true
                end


            if cmdname == "$dupespin" then -- - - - - - - - - - - - - - - -- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -- - - - - - - - -DUPESPIN- - - -- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -- - - - - - - - - - - - - - - -- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -- - - - - - - - - - - - - - - -- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
                print("§eThis Command is UNSUPPORED")
                xstep=1 ---                                  NOT FOR USE NOT FOR USE NOT FOR USE NOT FOR USE NOT FOR USE NOT FOR USE NOT FOR USENOT FOR USENOT FOR USENOT FOR USENOT FOR USENOT FOR USENOT FOR USENOT FOR USENOT FOR USENOT FOR USENOT FOR USENOT FOR USENOT FOR USENOT FOR USENOT FOR USENOT FOR USE  
                
                print("This Command is UNSUPPORED")if (xpos1 > xpos2) then              --X FIX
                    xstep=-1
                
                print("This Command is UNSUPPORED")end
                ystep = 1
                if (ypos1 > ypos2) then              --YFIX
                    ystep = -1
                end
                print("This Command is UNSUPPORED")
                zstep = 1
                if (zpos1 > zpos2) then              --ZFIX
                    zstep = -1
                end
                print("This Command is UNSUPPORED")
                for xInSelectedRange = xpos1, xpos2, xstep do
                    for yinSelectedRange = ypos1, ypos2, ystep do
                        for zinSelectedRange = zpos1, zpos2, zstep do
                            BLOCK = dimension.getBlock(xInSelectedRange,yinSelectedRange,zinSelectedRange)
                            if(BLOCK.name == "air" )then else
                                xdif = xpos1-xInSelectedRange
                                ydif = 0
                                zdif = zpos1-zinSelectedRange
                                CIRCLERAD = math.sqrt(xdif*xdif+ydif*ydif+zdif*zdif)
                                for rot  = -180, 180, 1 do
                                    client.execute("execute /tp @s ".. xpos1 .. " " .. yinSelectedRange .. " " .. zpos1 .. " ".. rot .. " " .. "0" )
                                    client.execute("execute setblock ^ ^ ^" .. CIRCLERAD .." " .. BLOCK)
                                end
                            end
                        end
                    end
                end
                print("This Command is UNSUPPORED")
            end
            
            if cmdname == "$pos1" then -- - - - - - - - - - - - - - - -- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  -- - - - - - - - - - - - - - POS1- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  -- - - - - - - - - - - - - - - -- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  -- - - - - - - - - - - - - - - -- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
                x, y, z = player.position()
                xpos1 = x
                ypos1 =y
                zpos1 =z
                print(xpos1 .. " " .. ypos1 .. " " .. zpos1 .. "§b has been set as selection point 1")
                CommandDone = true
                
            end

            if cmdname == "$pos2" then-- - - - - - - - - - - - - - - -- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  -- - - - - - - - - - - - - - POS2-- - - - - - - - - - - - - - - -- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  -- - - - - - - - - - - - - - -- - - - - - - - - - - - - - - -- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  -- - - - - - - - - - - - - - 
                x, y, z = player.position()
                xpos2 = x
                ypos2 =y
                zpos2 =z
                print(xpos2 .. " " .. ypos2 .. " " .. zpos2 .. "§c has been set as selection point 2")
                CommandDone = true
            end

            if cmdname == "$up" then-- - - - - - - - - - - - - - - -- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  -- - - - - - - - - - - - - -  UP -- - - - - - - - - - - - - - - -- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  -- - - - - - - - - - - - - - -- - - - - - - - - - - - - - - -- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  -- - - - - - - - - - - - - - 
                print("§a Done!")
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
                CommandDone = true
            end

            if cmdname == "$thrutool" then -- - - - - - - - - - - - - - - -- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  -- - - - - - - - - - - THRUTOOL -- - - - - - - - - - - - - - - -- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  -- - - - - - - - - - - - - -  -- - - - - - - - - - - - - - - -- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  -- - - - - - - - - - - - - -  
                if ThruTool == true then
                    print("§cThruTool is now false")
                    ThruTool = false
                else
                    print("§aThruTool is now true")
                    ThruTool = true
                end
                playCustomSound("WEswitch.mp3")
                CommandDone = true
            end

            if cmdname == "$copy" then-- - - - - - - - - - - - - - - -- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  -- - - - - - - - - - - - - -  COPY -- - - - - - - - - - - - - - - -- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  -- - - - - - - - - - - - - -  -- - - - - - - - - - - - - - - -- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  -- - - - - - - - - - - - - -  
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
                for xInSelectedRange = xpos1, xpos2, xstep do
                    for yinSelectedRange = ypos1, ypos2, ystep do
                        for zinSelectedRange = zpos1, zpos2, zstep do
                            FoundBlock = dimension.getBlock(xInSelectedRange, yinSelectedRange, zinSelectedRange)
                            BlockData = FoundBlock.data
                            BlockName = FoundBlock.name
                            BlockDataNew = convertData(BlockName,BlockData)
                            if  ClipboardFile then
                            ClipboardFile:write(BlockName .."\n".. BlockDataNew.."\n")
                            end
                        end
                    end
                end
                io.close(ClipboardFile)
                print("§aCopied")
                if DingS then
                    playCustomSound("WEding.mp3")
                end
                CommandDone = true
            end

            if cmdname == "$paste" then-- - - - - - - - - - - - - - - -- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  -- - - - - - - - - - - - - -  PASTE -- - - - - - - - - - - - - - - -- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  -- - - - - - - - - - - - - -  -- - - - - - - - - - - - - - - -- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  -- - - - - - - - - - - - - -  
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
                xstep=1
                if (xpos1 > xpos2) then              --X FIX
                    xstep = -1
                end
                ystep = 1
                if (ypos1 > ypos2) then              --YFIX
                    ystep = -1
                end
                zstep = 1
                if (zpos1 > zpos2) then              --ZFIX
                    zstep = -1
                end
                counter = 3
                print(xdif222.. " " .. ydif222.. " " .. zdif222)
                for xInSelectedRange = xpos1, xpos1+xdif222, 1 do
                    for yinSelectedRange = ypos1, ypos1+ydif222, 1 do
                        for zinSelectedRange = zpos1, zpos1+zdif222, 1 do
                            CURRENTBLOCK = FileLines[counter]
                            CURRENTBLOCKDATA = FileLines[counter+1]
                            if arg1 == "fasle" or nil then
                                if CURRENTBLOCK == "air" then
                                    goto skip
                                    print("§aSKipping air blocks when copying, not skipping will lag and maybe crash your game alot depending on size.§eTo not skip type $paste true")
                                end
                            else
                                if dimension.getBlock(xInSelectedRange,yinSelectedRange,zinSelectedRange) == "air" and CURRENTBLOCK == "air" then
                                    goto skip
                                end
                            end
                            client.execute("execute /setblock " .. xInSelectedRange .. " " .. yinSelectedRange .. " " .. zinSelectedRange .. " " .. CURRENTBLOCKDATA)
                            ::skip::
                            counter = counter + 2
                        end
                    end
                end
                print("§aPasted")
                if DingS then
                    playCustomSound("WEding")
                end
                CommandDone = true
            end

            

            if cmdname == "$wand" then
                client.execute("execute /give @s wooden_sword")
                CommandDone = true
                
            end

            if cmdname == "$count" then
                countStartOS = os.time()
                
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
                
                print(areaOfSelection .. " blocks are selected")
                
                
                CommandDone = true
            end


            if cmdname == "$selnear" or cmdname == "$selectnear" then
                x, y, z = player.position()
                xpos1 = x - 10
                xpos2 = x +10
                ypos1 = y - 10
                ypos2 = y +10
                zpos1 = z -10
                zpos2 = z +10
                CommandDone = true
                if DingS then
                    playCustomSound("WEding")
                end
            end

            if CommandDone then else
                print("§e\""..cmdname .. "\" is not a supported command. Do \"$help\" for a list of commands!" )
            end

        end
       
    end
    
    if MuteChat then
        if type == 6 then
            return true
        end
    end

    ::endOfChatFunc::
end)


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
        client.execute("say $replace water water")
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


--================================================================================================================================================================================================================================================================================================================================================================================================                                                                            
--                                                                                                                                                                     DATA TO STATE FUNCTION      
--================================================================================================================================================================================================================================================================================================================================================================================================                                                                            

function convertData(Nameyface,Datay)
--  -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -    MINIMISE THE STATE TABLE BY CLICKING THE LITTLE ARROW WHILST HOVERING ON THE LINE UNDER "local stateTable = " TO THE LEFT OF   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -  - -   -    
local stateTable = 
    {
        acacia_button ={
         "[\"button_pressed_bit\" : false, \"facing_direction\" : 0] ",
         "[\"button_pressed_bit\" : false, \"facing_direction\" : 1] ",
         "[\"button_pressed_bit\" : false, \"facing_direction\" : 2] ",
         "[\"button_pressed_bit\" : false, \"facing_direction\" : 3] ",
         "[\"button_pressed_bit\" : false, \"facing_direction\" : 4] ",
         "[\"button_pressed_bit\" : false, \"facing_direction\" : 5] ",
         "[\"button_pressed_bit\" : false, \"facing_direction\" : 6] ",
         "[\"button_pressed_bit\" : false, \"facing_direction\" : 7] ",
         "[\"button_pressed_bit\" : true, \"facing_direction\" : 0] ",
         "[\"button_pressed_bit\" : true, \"facing_direction\" : 1] ",
         "[\"button_pressed_bit\" : true, \"facing_direction\" : 2] ",
         "[\"button_pressed_bit\" : true, \"facing_direction\" : 3] ",
         "[\"button_pressed_bit\" : true, \"facing_direction\" : 4] ",
         "[\"button_pressed_bit\" : true, \"facing_direction\" : 5] ",
         "[\"button_pressed_bit\" : true, \"facing_direction\" : 6] ",
         "[\"button_pressed_bit\" : true, \"facing_direction\" : 7] "
            },
        acacia_door ={
         "[\"direction\" : 0, \"door_hinge_bit\" : false, \"open_bit\" : false, \"upper_block_bit\" : false] ",
         "[\"direction\" : 1, \"door_hinge_bit\" : true, \"open_bit\" : false, \"upper_block_bit\" : false] ",
         "[\"direction\" : 2, \"door_hinge_bit\" : false, \"open_bit\" : false, \"upper_block_bit\" : false] ",
         "[\"direction\" : 3, \"door_hinge_bit\" : true, \"open_bit\" : false, \"upper_block_bit\" : false] ",
         "[\"direction\" : 0, \"door_hinge_bit\" : false, \"open_bit\" : true, \"upper_block_bit\" : false] ",
         "[\"direction\" : 1, \"door_hinge_bit\" : true, \"open_bit\" : true, \"upper_block_bit\" : false] ",
         "[\"direction\" : 2, \"door_hinge_bit\" : false, \"open_bit\" : true, \"upper_block_bit\" : false] ",
         "[\"direction\" : 3, \"door_hinge_bit\" : true, \"open_bit\" : true, \"upper_block_bit\" : false] ",
         "[\"direction\" : 0, \"door_hinge_bit\" : false, \"open_bit\" : false, \"upper_block_bit\" : true] ",
         "[\"direction\" : 1, \"door_hinge_bit\" : true, \"open_bit\" : false, \"upper_block_bit\" : true] ",
         "[\"direction\" : 2, \"door_hinge_bit\" : false, \"open_bit\" : false, \"upper_block_bit\" : true] ",
         "[\"direction\" : 3, \"door_hinge_bit\" : true, \"open_bit\" : false, \"upper_block_bit\" : true] ",
         "[\"direction\" : 0, \"door_hinge_bit\" : false, \"open_bit\" : true, \"upper_block_bit\" : true] ",
         "[\"direction\" : 1, \"door_hinge_bit\" : true, \"open_bit\" : true, \"upper_block_bit\" : true] ",
         "[\"direction\" : 2, \"door_hinge_bit\" : false, \"open_bit\" : true, \"upper_block_bit\" : true] ",
         "[\"direction\" : 3, \"door_hinge_bit\" : true, \"open_bit\" : true, \"upper_block_bit\" : true] ",
         "[\"direction\" : 0, \"door_hinge_bit\" : false, \"open_bit\" : false, \"upper_block_bit\" : false] ",
         "[\"direction\" : 1, \"door_hinge_bit\" : true, \"open_bit\" : false, \"upper_block_bit\" : false] ",
         "[\"direction\" : 2, \"door_hinge_bit\" : false, \"open_bit\" : false, \"upper_block_bit\" : false] ",
         "[\"direction\" : 3, \"door_hinge_bit\" : true, \"open_bit\" : false, \"upper_block_bit\" : false] ",
         "[\"direction\" : 0, \"door_hinge_bit\" : false, \"open_bit\" : true, \"upper_block_bit\" : false] ",
         "[\"direction\" : 1, \"door_hinge_bit\" : true, \"open_bit\" : true, \"upper_block_bit\" : false] ",
         "[\"direction\" : 2, \"door_hinge_bit\" : false, \"open_bit\" : true, \"upper_block_bit\" : false] ",
         "[\"direction\" : 3, \"door_hinge_bit\" : true, \"open_bit\" : true, \"upper_block_bit\" : false] ",
         "[\"direction\" : 0, \"door_hinge_bit\" : false, \"open_bit\" : false, \"upper_block_bit\" : true] ",
         "[\"direction\" : 1, \"door_hinge_bit\" : true, \"open_bit\" : false, \"upper_block_bit\" : true] ",
         "[\"direction\" : 2, \"door_hinge_bit\" : false, \"open_bit\" : false, \"upper_block_bit\" : true] ",
         "[\"direction\" : 3, \"door_hinge_bit\" : true, \"open_bit\" : false, \"upper_block_bit\" : true] ",
         "[\"direction\" : 0, \"door_hinge_bit\" : false, \"open_bit\" : true, \"upper_block_bit\" : true] ",
         "[\"direction\" : 1, \"door_hinge_bit\" : true, \"open_bit\" : true, \"upper_block_bit\" : true] ",
         "[\"direction\" : 2, \"door_hinge_bit\" : false, \"open_bit\" : true, \"upper_block_bit\" : true] ",
         "[\"direction\" : 3, \"door_hinge_bit\" : true, \"open_bit\" : true, \"upper_block_bit\" : true] "
            },
        acacia_fence_gate ={
         "[\"direction\" : 0, \"in_wall_bit\" : false, \"open_bit\" : false] ",
         "[\"direction\" : 1, \"in_wall_bit\" : false, \"open_bit\" : false] ",
         "[\"direction\" : 2, \"in_wall_bit\" : false, \"open_bit\" : false] ",
         "[\"direction\" : 3, \"in_wall_bit\" : false, \"open_bit\" : false] ",
         "[\"direction\" : 0, \"in_wall_bit\" : false, \"open_bit\" : true] ",
         "[\"direction\" : 1, \"in_wall_bit\" : false, \"open_bit\" : true] ",
         "[\"direction\" : 2, \"in_wall_bit\" : false, \"open_bit\" : true] ",
         "[\"direction\" : 3, \"in_wall_bit\" : false, \"open_bit\" : true] ",
         "[\"direction\" : 0, \"in_wall_bit\" : true, \"open_bit\" : false] ",
         "[\"direction\" : 1, \"in_wall_bit\" : true, \"open_bit\" : false] ",
         "[\"direction\" : 2, \"in_wall_bit\" : true, \"open_bit\" : false] ",
         "[\"direction\" : 3, \"in_wall_bit\" : true, \"open_bit\" : false] ",
         "[\"direction\" : 0, \"in_wall_bit\" : true, \"open_bit\" : true] ",
         "[\"direction\" : 1, \"in_wall_bit\" : true, \"open_bit\" : true] ",
         "[\"direction\" : 2, \"in_wall_bit\" : true, \"open_bit\" : true] ",
         "[\"direction\" : 3, \"in_wall_bit\" : true, \"open_bit\" : true] "
            },
        acacia_pressure_plate ={
         "[\"redstone_signal\" : 0] ",
         "[\"redstone_signal\" : 1] ",
         "[\"redstone_signal\" : 2] ",
         "[\"redstone_signal\" : 3] ",
         "[\"redstone_signal\" : 4] ",
         "[\"redstone_signal\" : 5] ",
         "[\"redstone_signal\" : 6] ",
         "[\"redstone_signal\" : 7] ",
         "[\"redstone_signal\" : 8] ",
         "[\"redstone_signal\" : 9] ",
         "[\"redstone_signal\" : 10] ",
         "[\"redstone_signal\" : 11] ",
         "[\"redstone_signal\" : 12] ",
         "[\"redstone_signal\" : 13] ",
         "[\"redstone_signal\" : 14] ",
         "[\"redstone_signal\" : 15] "
            },
        acacia_stairs ={
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 0] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 1] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 2] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 3] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 0] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 1] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 2] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 3] "
            },
        acacia_standing_sign ={
         "[\"ground_sign_direction\" : 0] ",
         "[\"ground_sign_direction\" : 1] ",
         "[\"ground_sign_direction\" : 2] ",
         "[\"ground_sign_direction\" : 3] ",
         "[\"ground_sign_direction\" : 4] ",
         "[\"ground_sign_direction\" : 5] ",
         "[\"ground_sign_direction\" : 6] ",
         "[\"ground_sign_direction\" : 7] ",
         "[\"ground_sign_direction\" : 8] ",
         "[\"ground_sign_direction\" : 9] ",
         "[\"ground_sign_direction\" : 10] ",
         "[\"ground_sign_direction\" : 11] ",
         "[\"ground_sign_direction\" : 12] ",
         "[\"ground_sign_direction\" : 13] ",
         "[\"ground_sign_direction\" : 14] ",
         "[\"ground_sign_direction\" : 15] "
            },
        acacia_trapdoor ={
         "[\"direction\" : 0, \"open_bit\" : false, \"upside_down_bit\" : false] ",
         "[\"direction\" : 1, \"open_bit\" : false, \"upside_down_bit\" : false] ",
         "[\"direction\" : 2, \"open_bit\" : false, \"upside_down_bit\" : false] ",
         "[\"direction\" : 3, \"open_bit\" : false, \"upside_down_bit\" : false] ",
         "[\"direction\" : 0, \"open_bit\" : false, \"upside_down_bit\" : true] ",
         "[\"direction\" : 1, \"open_bit\" : false, \"upside_down_bit\" : true] ",
         "[\"direction\" : 2, \"open_bit\" : false, \"upside_down_bit\" : true] ",
         "[\"direction\" : 3, \"open_bit\" : false, \"upside_down_bit\" : true] ",
         "[\"direction\" : 0, \"open_bit\" : true, \"upside_down_bit\" : false] ",
         "[\"direction\" : 1, \"open_bit\" : true, \"upside_down_bit\" : false] ",
         "[\"direction\" : 2, \"open_bit\" : true, \"upside_down_bit\" : false] ",
         "[\"direction\" : 3, \"open_bit\" : true, \"upside_down_bit\" : false] ",
         "[\"direction\" : 0, \"open_bit\" : true, \"upside_down_bit\" : true] ",
         "[\"direction\" : 1, \"open_bit\" : true, \"upside_down_bit\" : true] ",
         "[\"direction\" : 2, \"open_bit\" : true, \"upside_down_bit\" : true] ",
         "[\"direction\" : 3, \"open_bit\" : true, \"upside_down_bit\" : true] "
            },
        acacia_wall_sign ={
         "[\"facing_direction\" : 0] ",
         "[\"facing_direction\" : 1] ",
         "[\"facing_direction\" : 2] ",
         "[\"facing_direction\" : 3] ",
         "[\"facing_direction\" : 4] ",
         "[\"facing_direction\" : 5] ",
         "[\"facing_direction\" : 6] ",
         "[\"facing_direction\" : 7] "
            },
        activator_rail ={
         "[\"rail_data_bit\" : false, \"rail_direction\" : 0] ",
         "[\"rail_data_bit\" : false, \"rail_direction\" : 1] ",
         "[\"rail_data_bit\" : false, \"rail_direction\" : 2] ",
         "[\"rail_data_bit\" : false, \"rail_direction\" : 3] ",
         "[\"rail_data_bit\" : false, \"rail_direction\" : 4] ",
         "[\"rail_data_bit\" : false, \"rail_direction\" : 5] ",
         "[\"rail_data_bit\" : false, \"rail_direction\" : 6] ",
         "[\"rail_data_bit\" : false, \"rail_direction\" : 7] ",
         "[\"rail_data_bit\" : true, \"rail_direction\" : 0] ",
         "[\"rail_data_bit\" : true, \"rail_direction\" : 1] ",
         "[\"rail_data_bit\" : true, \"rail_direction\" : 2] ",
         "[\"rail_data_bit\" : true, \"rail_direction\" : 3] ",
         "[\"rail_data_bit\" : true, \"rail_direction\" : 4] ",
         "[\"rail_data_bit\" : true, \"rail_direction\" : 5] ",
         "[\"rail_data_bit\" : true, \"rail_direction\" : 6] ",
         "[\"rail_data_bit\" : true, \"rail_direction\" : 7] "
            },
        andesite_stairs ={
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 0] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 1] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 2] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 3] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 0] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 1] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 2] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 3] "
            },
        anvil ={
         "[\"damage\" : \"undamaged\", \"direction\" : 0] ",
         "[\"damage\" : \"undamaged\", \"direction\" : 1] ",
         "[\"damage\" : \"undamaged\", \"direction\" : 2] ",
         "[\"damage\" : \"undamaged\", \"direction\" : 3] ",
         "[\"damage\" : \"slightly_damaged\", \"direction\" : 0] ",
         "[\"damage\" : \"slightly_damaged\", \"direction\" : 1] ",
         "[\"damage\" : \"slightly_damaged\", \"direction\" : 2] ",
         "[\"damage\" : \"slightly_damaged\", \"direction\" : 3] ",
         "[\"damage\" : \"very_damaged\", \"direction\" : 0] ",
         "[\"damage\" : \"very_damaged\", \"direction\" : 1] ",
         "[\"damage\" : \"very_damaged\", \"direction\" : 2] ",
         "[\"damage\" : \"very_damaged\", \"direction\" : 3] ",
         "[\"damage\" : \"broken\", \"direction\" : 0] ",
         "[\"damage\" : \"broken\", \"direction\" : 1] ",
         "[\"damage\" : \"broken\", \"direction\" : 2] ",
         "[\"damage\" : \"broken\", \"direction\" : 3] "
            },
        bamboo ={
         "[\"age_bit\" : false, \"bamboo_leaf_size\" : \"no_leaves\", \"bamboo_stalk_thickness\" : \"thin\"] ",
         "[\"age_bit\" : false, \"bamboo_leaf_size\" : \"no_leaves\", \"bamboo_stalk_thickness\" : \"thick\"] ",
         "[\"age_bit\" : false, \"bamboo_leaf_size\" : \"small_leaves\", \"bamboo_stalk_thickness\" : \"thin\"] ",
         "[\"age_bit\" : false, \"bamboo_leaf_size\" : \"small_leaves\", \"bamboo_stalk_thickness\" : \"thick\"] ",
         "[\"age_bit\" : false, \"bamboo_leaf_size\" : \"large_leaves\", \"bamboo_stalk_thickness\" : \"thin\"] ",
         "[\"age_bit\" : false, \"bamboo_leaf_size\" : \"large_leaves\", \"bamboo_stalk_thickness\" : \"thick\"] ",
         "[\"age_bit\" : false, \"bamboo_leaf_size\" : \"no_leaves\", \"bamboo_stalk_thickness\" : \"thin\"] ",
         "[\"age_bit\" : false, \"bamboo_leaf_size\" : \"no_leaves\", \"bamboo_stalk_thickness\" : \"thick\"] ",
         "[\"age_bit\" : true, \"bamboo_leaf_size\" : \"no_leaves\", \"bamboo_stalk_thickness\" : \"thin\"] ",
         "[\"age_bit\" : true, \"bamboo_leaf_size\" : \"no_leaves\", \"bamboo_stalk_thickness\" : \"thick\"] ",
         "[\"age_bit\" : true, \"bamboo_leaf_size\" : \"small_leaves\", \"bamboo_stalk_thickness\" : \"thin\"] ",
         "[\"age_bit\" : true, \"bamboo_leaf_size\" : \"small_leaves\", \"bamboo_stalk_thickness\" : \"thick\"] ",
         "[\"age_bit\" : true, \"bamboo_leaf_size\" : \"large_leaves\", \"bamboo_stalk_thickness\" : \"thin\"] ",
         "[\"age_bit\" : true, \"bamboo_leaf_size\" : \"large_leaves\", \"bamboo_stalk_thickness\" : \"thick\"] ",
         "[\"age_bit\" : true, \"bamboo_leaf_size\" : \"no_leaves\", \"bamboo_stalk_thickness\" : \"thin\"] ",
         "[\"age_bit\" : true, \"bamboo_leaf_size\" : \"no_leaves\", \"bamboo_stalk_thickness\" : \"thick\"] "
            },
        bamboo_sapling ={
         "[\"age_bit\" : false, \"sapling_type\" : \"oak\"] ",
         "[\"age_bit\" : true, \"sapling_type\" : \"oak\"] ",
         "[\"age_bit\" : false, \"sapling_type\" : \"spruce\"] ",
         "[\"age_bit\" : true, \"sapling_type\" : \"spruce\"] ",
         "[\"age_bit\" : false, \"sapling_type\" : \"birch\"] ",
         "[\"age_bit\" : true, \"sapling_type\" : \"birch\"] ",
         "[\"age_bit\" : false, \"sapling_type\" : \"jungle\"] ",
         "[\"age_bit\" : true, \"sapling_type\" : \"jungle\"] ",
         "[\"age_bit\" : false, \"sapling_type\" : \"acacia\"] ",
         "[\"age_bit\" : true, \"sapling_type\" : \"acacia\"] ",
         "[\"age_bit\" : false, \"sapling_type\" : \"dark_oak\"] ",
         "[\"age_bit\" : true, \"sapling_type\" : \"dark_oak\"] ",
         "[\"age_bit\" : false, \"sapling_type\" : \"oak\"] ",
         "[\"age_bit\" : true, \"sapling_type\" : \"oak\"] ",
         "[\"age_bit\" : false, \"sapling_type\" : \"oak\"] ",
         "[\"age_bit\" : true, \"sapling_type\" : \"oak\"] "
            },
        barrel ={
         "[\"facing_direction\" : 0, \"open_bit\" : false] ",
         "[\"facing_direction\" : 1, \"open_bit\" : false] ",
         "[\"facing_direction\" : 2, \"open_bit\" : false] ",
         "[\"facing_direction\" : 3, \"open_bit\" : false] ",
         "[\"facing_direction\" : 4, \"open_bit\" : false] ",
         "[\"facing_direction\" : 5, \"open_bit\" : false] ",
         "[\"facing_direction\" : 6, \"open_bit\" : false] ",
         "[\"facing_direction\" : 7, \"open_bit\" : false] ",
         "[\"facing_direction\" : 0, \"open_bit\" : true] ",
         "[\"facing_direction\" : 1, \"open_bit\" : true] ",
         "[\"facing_direction\" : 2, \"open_bit\" : true] ",
         "[\"facing_direction\" : 3, \"open_bit\" : true] ",
         "[\"facing_direction\" : 4, \"open_bit\" : true] ",
         "[\"facing_direction\" : 5, \"open_bit\" : true] ",
         "[\"facing_direction\" : 6, \"open_bit\" : true] ",
         "[\"facing_direction\" : 7, \"open_bit\" : true] "
            },
        basalt ={
         "[\"pillar_axis\" : \"y\"] ",
         "[\"pillar_axis\" : \"x\"] ",
         "[\"pillar_axis\" : \"z\"] "
            },
        bed ={
         "[\"direction\" : 0, \"head_piece_bit\" : false, \"occupied_bit\" : false] ",
         "[\"direction\" : 1, \"head_piece_bit\" : false, \"occupied_bit\" : false] ",
         "[\"direction\" : 2, \"head_piece_bit\" : false, \"occupied_bit\" : false] ",
         "[\"direction\" : 3, \"head_piece_bit\" : false, \"occupied_bit\" : false] ",
         "[\"direction\" : 0, \"head_piece_bit\" : false, \"occupied_bit\" : true] ",
         "[\"direction\" : 1, \"head_piece_bit\" : false, \"occupied_bit\" : true] ",
         "[\"direction\" : 2, \"head_piece_bit\" : false, \"occupied_bit\" : true] ",
         "[\"direction\" : 3, \"head_piece_bit\" : false, \"occupied_bit\" : true] ",
         "[\"direction\" : 0, \"head_piece_bit\" : true, \"occupied_bit\" : false] ",
         "[\"direction\" : 1, \"head_piece_bit\" : true, \"occupied_bit\" : false] ",
         "[\"direction\" : 2, \"head_piece_bit\" : true, \"occupied_bit\" : false] ",
         "[\"direction\" : 3, \"head_piece_bit\" : true, \"occupied_bit\" : false] ",
         "[\"direction\" : 0, \"head_piece_bit\" : true, \"occupied_bit\" : true] ",
         "[\"direction\" : 1, \"head_piece_bit\" : true, \"occupied_bit\" : true] ",
         "[\"direction\" : 2, \"head_piece_bit\" : true, \"occupied_bit\" : true] ",
         "[\"direction\" : 3, \"head_piece_bit\" : true, \"occupied_bit\" : true] "
            },
        bedrock ={
         "[\"infiniburn_bit\" : false] ",
         "[\"infiniburn_bit\" : true] "
            },
        beetroot ={
         "[\"growth\" : 0] ",
         "[\"growth\" : 1] ",
         "[\"growth\" : 2] ",
         "[\"growth\" : 3] ",
         "[\"growth\" : 4] ",
         "[\"growth\" : 5] ",
         "[\"growth\" : 6] ",
         "[\"growth\" : 7] "
            },
        bell ={
         "[\"attachment\" : \"standing\", \"direction\" : 0, \"toggle_bit\" : false] ",
         "[\"attachment\" : \"standing\", \"direction\" : 1, \"toggle_bit\" : false] ",
         "[\"attachment\" : \"standing\", \"direction\" : 2, \"toggle_bit\" : false] ",
         "[\"attachment\" : \"standing\", \"direction\" : 3, \"toggle_bit\" : false] ",
         "[\"attachment\" : \"hanging\", \"direction\" : 0, \"toggle_bit\" : false] ",
         "[\"attachment\" : \"hanging\", \"direction\" : 1, \"toggle_bit\" : false] ",
         "[\"attachment\" : \"hanging\", \"direction\" : 2, \"toggle_bit\" : false] ",
         "[\"attachment\" : \"hanging\", \"direction\" : 3, \"toggle_bit\" : false] ",
         "[\"attachment\" : \"side\", \"direction\" : 0, \"toggle_bit\" : false] ",
         "[\"attachment\" : \"side\", \"direction\" : 1, \"toggle_bit\" : false] ",
         "[\"attachment\" : \"side\", \"direction\" : 2, \"toggle_bit\" : false] ",
         "[\"attachment\" : \"side\", \"direction\" : 3, \"toggle_bit\" : false] ",
         "[\"attachment\" : \"multiple\", \"direction\" : 0, \"toggle_bit\" : false] ",
         "[\"attachment\" : \"multiple\", \"direction\" : 1, \"toggle_bit\" : false] ",
         "[\"attachment\" : \"multiple\", \"direction\" : 2, \"toggle_bit\" : false] ",
         "[\"attachment\" : \"multiple\", \"direction\" : 3, \"toggle_bit\" : false] ",
         "[\"attachment\" : \"standing\", \"direction\" : 0, \"toggle_bit\" : true] ",
         "[\"attachment\" : \"standing\", \"direction\" : 1, \"toggle_bit\" : true] ",
         "[\"attachment\" : \"standing\", \"direction\" : 2, \"toggle_bit\" : true] ",
         "[\"attachment\" : \"standing\", \"direction\" : 3, \"toggle_bit\" : true] ",
         "[\"attachment\" : \"hanging\", \"direction\" : 0, \"toggle_bit\" : true] ",
         "[\"attachment\" : \"hanging\", \"direction\" : 1, \"toggle_bit\" : true] ",
         "[\"attachment\" : \"hanging\", \"direction\" : 2, \"toggle_bit\" : true] ",
         "[\"attachment\" : \"hanging\", \"direction\" : 3, \"toggle_bit\" : true] ",
         "[\"attachment\" : \"side\", \"direction\" : 0, \"toggle_bit\" : true] ",
         "[\"attachment\" : \"side\", \"direction\" : 1, \"toggle_bit\" : true] ",
         "[\"attachment\" : \"side\", \"direction\" : 2, \"toggle_bit\" : true] ",
         "[\"attachment\" : \"side\", \"direction\" : 3, \"toggle_bit\" : true] ",
         "[\"attachment\" : \"multiple\", \"direction\" : 0, \"toggle_bit\" : true] ",
         "[\"attachment\" : \"multiple\", \"direction\" : 1, \"toggle_bit\" : true] ",
         "[\"attachment\" : \"multiple\", \"direction\" : 2, \"toggle_bit\" : true] ",
         "[\"attachment\" : \"multiple\", \"direction\" : 3, \"toggle_bit\" : true] "
            },
        birch_button ={
         "[\"button_pressed_bit\" : false, \"facing_direction\" : 0] ",
         "[\"button_pressed_bit\" : false, \"facing_direction\" : 1] ",
         "[\"button_pressed_bit\" : false, \"facing_direction\" : 2] ",
         "[\"button_pressed_bit\" : false, \"facing_direction\" : 3] ",
         "[\"button_pressed_bit\" : false, \"facing_direction\" : 4] ",
         "[\"button_pressed_bit\" : false, \"facing_direction\" : 5] ",
         "[\"button_pressed_bit\" : false, \"facing_direction\" : 6] ",
         "[\"button_pressed_bit\" : false, \"facing_direction\" : 7] ",
         "[\"button_pressed_bit\" : true, \"facing_direction\" : 0] ",
         "[\"button_pressed_bit\" : true, \"facing_direction\" : 1] ",
         "[\"button_pressed_bit\" : true, \"facing_direction\" : 2] ",
         "[\"button_pressed_bit\" : true, \"facing_direction\" : 3] ",
         "[\"button_pressed_bit\" : true, \"facing_direction\" : 4] ",
         "[\"button_pressed_bit\" : true, \"facing_direction\" : 5] ",
         "[\"button_pressed_bit\" : true, \"facing_direction\" : 6] ",
         "[\"button_pressed_bit\" : true, \"facing_direction\" : 7] "
            },
        birch_door ={
         "[\"direction\" : 0, \"door_hinge_bit\" : false, \"open_bit\" : false, \"upper_block_bit\" : false] ",
         "[\"direction\" : 1, \"door_hinge_bit\" : true, \"open_bit\" : false, \"upper_block_bit\" : false] ",
         "[\"direction\" : 2, \"door_hinge_bit\" : false, \"open_bit\" : false, \"upper_block_bit\" : false] ",
         "[\"direction\" : 3, \"door_hinge_bit\" : true, \"open_bit\" : false, \"upper_block_bit\" : false] ",
         "[\"direction\" : 0, \"door_hinge_bit\" : false, \"open_bit\" : true, \"upper_block_bit\" : false] ",
         "[\"direction\" : 1, \"door_hinge_bit\" : true, \"open_bit\" : true, \"upper_block_bit\" : false] ",
         "[\"direction\" : 2, \"door_hinge_bit\" : false, \"open_bit\" : true, \"upper_block_bit\" : false] ",
         "[\"direction\" : 3, \"door_hinge_bit\" : true, \"open_bit\" : true, \"upper_block_bit\" : false] ",
         "[\"direction\" : 0, \"door_hinge_bit\" : false, \"open_bit\" : false, \"upper_block_bit\" : true] ",
         "[\"direction\" : 1, \"door_hinge_bit\" : true, \"open_bit\" : false, \"upper_block_bit\" : true] ",
         "[\"direction\" : 2, \"door_hinge_bit\" : false, \"open_bit\" : false, \"upper_block_bit\" : true] ",
         "[\"direction\" : 3, \"door_hinge_bit\" : true, \"open_bit\" : false, \"upper_block_bit\" : true] ",
         "[\"direction\" : 0, \"door_hinge_bit\" : false, \"open_bit\" : true, \"upper_block_bit\" : true] ",
         "[\"direction\" : 1, \"door_hinge_bit\" : true, \"open_bit\" : true, \"upper_block_bit\" : true] ",
         "[\"direction\" : 2, \"door_hinge_bit\" : false, \"open_bit\" : true, \"upper_block_bit\" : true] ",
         "[\"direction\" : 3, \"door_hinge_bit\" : true, \"open_bit\" : true, \"upper_block_bit\" : true] ",
         "[\"direction\" : 0, \"door_hinge_bit\" : false, \"open_bit\" : false, \"upper_block_bit\" : false] ",
         "[\"direction\" : 1, \"door_hinge_bit\" : true, \"open_bit\" : false, \"upper_block_bit\" : false] ",
         "[\"direction\" : 2, \"door_hinge_bit\" : false, \"open_bit\" : false, \"upper_block_bit\" : false] ",
         "[\"direction\" : 3, \"door_hinge_bit\" : true, \"open_bit\" : false, \"upper_block_bit\" : false] ",
         "[\"direction\" : 0, \"door_hinge_bit\" : false, \"open_bit\" : true, \"upper_block_bit\" : false] ",
         "[\"direction\" : 1, \"door_hinge_bit\" : true, \"open_bit\" : true, \"upper_block_bit\" : false] ",
         "[\"direction\" : 2, \"door_hinge_bit\" : false, \"open_bit\" : true, \"upper_block_bit\" : false] ",
         "[\"direction\" : 3, \"door_hinge_bit\" : true, \"open_bit\" : true, \"upper_block_bit\" : false] ",
         "[\"direction\" : 0, \"door_hinge_bit\" : false, \"open_bit\" : false, \"upper_block_bit\" : true] ",
         "[\"direction\" : 1, \"door_hinge_bit\" : true, \"open_bit\" : false, \"upper_block_bit\" : true] ",
         "[\"direction\" : 2, \"door_hinge_bit\" : false, \"open_bit\" : false, \"upper_block_bit\" : true] ",
         "[\"direction\" : 3, \"door_hinge_bit\" : true, \"open_bit\" : false, \"upper_block_bit\" : true] ",
         "[\"direction\" : 0, \"door_hinge_bit\" : false, \"open_bit\" : true, \"upper_block_bit\" : true] ",
         "[\"direction\" : 1, \"door_hinge_bit\" : true, \"open_bit\" : true, \"upper_block_bit\" : true] ",
         "[\"direction\" : 2, \"door_hinge_bit\" : false, \"open_bit\" : true, \"upper_block_bit\" : true] ",
         "[\"direction\" : 3, \"door_hinge_bit\" : true, \"open_bit\" : true, \"upper_block_bit\" : true] "
            },
        birch_fence_gate ={
         "[\"direction\" : 0, \"in_wall_bit\" : false, \"open_bit\" : false] ",
         "[\"direction\" : 1, \"in_wall_bit\" : false, \"open_bit\" : false] ",
         "[\"direction\" : 2, \"in_wall_bit\" : false, \"open_bit\" : false] ",
         "[\"direction\" : 3, \"in_wall_bit\" : false, \"open_bit\" : false] ",
         "[\"direction\" : 0, \"in_wall_bit\" : false, \"open_bit\" : true] ",
         "[\"direction\" : 1, \"in_wall_bit\" : false, \"open_bit\" : true] ",
         "[\"direction\" : 2, \"in_wall_bit\" : false, \"open_bit\" : true] ",
         "[\"direction\" : 3, \"in_wall_bit\" : false, \"open_bit\" : true] ",
         "[\"direction\" : 0, \"in_wall_bit\" : true, \"open_bit\" : false] ",
         "[\"direction\" : 1, \"in_wall_bit\" : true, \"open_bit\" : false] ",
         "[\"direction\" : 2, \"in_wall_bit\" : true, \"open_bit\" : false] ",
         "[\"direction\" : 3, \"in_wall_bit\" : true, \"open_bit\" : false] ",
         "[\"direction\" : 0, \"in_wall_bit\" : true, \"open_bit\" : true] ",
         "[\"direction\" : 1, \"in_wall_bit\" : true, \"open_bit\" : true] ",
         "[\"direction\" : 2, \"in_wall_bit\" : true, \"open_bit\" : true] ",
         "[\"direction\" : 3, \"in_wall_bit\" : true, \"open_bit\" : true] "
            },
        birch_pressure_plate ={
         "[\"redstone_signal\" : 0] ",
         "[\"redstone_signal\" : 1] ",
         "[\"redstone_signal\" : 2] ",
         "[\"redstone_signal\" : 3] ",
         "[\"redstone_signal\" : 4] ",
         "[\"redstone_signal\" : 5] ",
         "[\"redstone_signal\" : 6] ",
         "[\"redstone_signal\" : 7] ",
         "[\"redstone_signal\" : 8] ",
         "[\"redstone_signal\" : 9] ",
         "[\"redstone_signal\" : 10] ",
         "[\"redstone_signal\" : 11] ",
         "[\"redstone_signal\" : 12] ",
         "[\"redstone_signal\" : 13] ",
         "[\"redstone_signal\" : 14] ",
         "[\"redstone_signal\" : 15] "
            },
        birch_stairs ={
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 0] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 1] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 2] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 3] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 0] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 1] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 2] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 3] "
            },
        birch_standing_sign ={
         "[\"ground_sign_direction\" : 0] ",
         "[\"ground_sign_direction\" : 1] ",
         "[\"ground_sign_direction\" : 2] ",
         "[\"ground_sign_direction\" : 3] ",
         "[\"ground_sign_direction\" : 4] ",
         "[\"ground_sign_direction\" : 5] ",
         "[\"ground_sign_direction\" : 6] ",
         "[\"ground_sign_direction\" : 7] ",
         "[\"ground_sign_direction\" : 8] ",
         "[\"ground_sign_direction\" : 9] ",
         "[\"ground_sign_direction\" : 10] ",
         "[\"ground_sign_direction\" : 11] ",
         "[\"ground_sign_direction\" : 12] ",
         "[\"ground_sign_direction\" : 13] ",
         "[\"ground_sign_direction\" : 14] ",
         "[\"ground_sign_direction\" : 15] "
            },
        birch_trapdoor ={
         "[\"direction\" : 0, \"open_bit\" : false, \"upside_down_bit\" : false] ",
         "[\"direction\" : 1, \"open_bit\" : false, \"upside_down_bit\" : false] ",
         "[\"direction\" : 2, \"open_bit\" : false, \"upside_down_bit\" : false] ",
         "[\"direction\" : 3, \"open_bit\" : false, \"upside_down_bit\" : false] ",
         "[\"direction\" : 0, \"open_bit\" : false, \"upside_down_bit\" : true] ",
         "[\"direction\" : 1, \"open_bit\" : false, \"upside_down_bit\" : true] ",
         "[\"direction\" : 2, \"open_bit\" : false, \"upside_down_bit\" : true] ",
         "[\"direction\" : 3, \"open_bit\" : false, \"upside_down_bit\" : true] ",
         "[\"direction\" : 0, \"open_bit\" : true, \"upside_down_bit\" : false] ",
         "[\"direction\" : 1, \"open_bit\" : true, \"upside_down_bit\" : false] ",
         "[\"direction\" : 2, \"open_bit\" : true, \"upside_down_bit\" : false] ",
         "[\"direction\" : 3, \"open_bit\" : true, \"upside_down_bit\" : false] ",
         "[\"direction\" : 0, \"open_bit\" : true, \"upside_down_bit\" : true] ",
         "[\"direction\" : 1, \"open_bit\" : true, \"upside_down_bit\" : true] ",
         "[\"direction\" : 2, \"open_bit\" : true, \"upside_down_bit\" : true] ",
         "[\"direction\" : 3, \"open_bit\" : true, \"upside_down_bit\" : true] "
            },
        birch_wall_sign ={
         "[\"facing_direction\" : 0] ",
         "[\"facing_direction\" : 1] ",
         "[\"facing_direction\" : 2] ",
         "[\"facing_direction\" : 3] ",
         "[\"facing_direction\" : 4] ",
         "[\"facing_direction\" : 5] ",
         "[\"facing_direction\" : 6] ",
         "[\"facing_direction\" : 7] "
            },
        black_candle ={
         "[\"candles\" : 0, \"lit\" : false] ",
         "[\"candles\" : 1, \"lit\" : false] ",
         "[\"candles\" : 2, \"lit\" : false] ",
         "[\"candles\" : 3, \"lit\" : false] ",
         "[\"candles\" : 0, \"lit\" : true] ",
         "[\"candles\" : 1, \"lit\" : true] ",
         "[\"candles\" : 2, \"lit\" : true] ",
         "[\"candles\" : 3, \"lit\" : true] "
            },
        black_candle_cake ={
         "[\"lit\" : false] ",
         "[\"lit\" : true] "
            },
        black_glazed_terracotta ={
         "[\"facing_direction\" : 0] ",
         "[\"facing_direction\" : 1] ",
         "[\"facing_direction\" : 2] ",
         "[\"facing_direction\" : 3] ",
         "[\"facing_direction\" : 4] ",
         "[\"facing_direction\" : 5] ",
         "[\"facing_direction\" : 6] ",
         "[\"facing_direction\" : 7] "
            },
        blackstone_slab ={
         "[\"top_slot_bit\" : false] ",
         "[\"top_slot_bit\" : true] "
            },
        blackstone_stairs ={
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 0] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 1] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 2] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 3] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 0] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 1] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 2] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 3] "
            },
        blast_furnace ={
         "[\"facing_direction\" : 0] ",
         "[\"facing_direction\" : 1] ",
         "[\"facing_direction\" : 2] ",
         "[\"facing_direction\" : 3] ",
         "[\"facing_direction\" : 4] ",
         "[\"facing_direction\" : 5] ",
         "[\"facing_direction\" : 6] ",
         "[\"facing_direction\" : 7] "
            },
        blue_candle ={
         "[\"candles\" : 0, \"lit\" : false] ",
         "[\"candles\" : 1, \"lit\" : false] ",
         "[\"candles\" : 2, \"lit\" : false] ",
         "[\"candles\" : 3, \"lit\" : false] ",
         "[\"candles\" : 0, \"lit\" : true] ",
         "[\"candles\" : 1, \"lit\" : true] ",
         "[\"candles\" : 2, \"lit\" : true] ",
         "[\"candles\" : 3, \"lit\" : true] "
            },
        blue_candle_cake ={
         "[\"lit\" : false] ",
         "[\"lit\" : true] "
            },
        blue_glazed_terracotta ={
         "[\"facing_direction\" : 0] ",
         "[\"facing_direction\" : 1] ",
         "[\"facing_direction\" : 2] ",
         "[\"facing_direction\" : 3] ",
         "[\"facing_direction\" : 4] ",
         "[\"facing_direction\" : 5] ",
         "[\"facing_direction\" : 6] ",
         "[\"facing_direction\" : 7] "
            },
        bone_block ={
         "[\"deprecated\" : 0, \"direction\" : 0] ",
         "[\"deprecated\" : 1, \"direction\" : 0] ",
         "[\"deprecated\" : 2, \"direction\" : 0] ",
         "[\"deprecated\" : 3, \"direction\" : 0] ",
         "[\"deprecated\" : 0, \"direction\" : 1] ",
         "[\"deprecated\" : 1, \"direction\" : 1] ",
         "[\"deprecated\" : 2, \"direction\" : 1] ",
         "[\"deprecated\" : 3, \"direction\" : 1] ",
         "[\"deprecated\" : 0, \"direction\" : 2] ",
         "[\"deprecated\" : 1, \"direction\" : 2] ",
         "[\"deprecated\" : 2, \"direction\" : 2] ",
         "[\"deprecated\" : 3, \"direction\" : 2] ",
         "[\"deprecated\" : 0, \"direction\" : 3] ",
         "[\"deprecated\" : 1, \"direction\" : 3] ",
         "[\"deprecated\" : 2, \"direction\" : 3] ",
         "[\"deprecated\" : 3, \"direction\" : 3] "
            },
        brewing_stand ={
         "[\"brewing_stand_slot_a_bit\" : false, \"brewing_stand_slot_b_bit\" : false, \"brewing_stand_slot_c_bit\" : false] ",
         "[\"brewing_stand_slot_a_bit\" : true, \"brewing_stand_slot_b_bit\" : false, \"brewing_stand_slot_c_bit\" : false] ",
         "[\"brewing_stand_slot_a_bit\" : false, \"brewing_stand_slot_b_bit\" : true, \"brewing_stand_slot_c_bit\" : false] ",
         "[\"brewing_stand_slot_a_bit\" : true, \"brewing_stand_slot_b_bit\" : true, \"brewing_stand_slot_c_bit\" : false] ",
         "[\"brewing_stand_slot_a_bit\" : false, \"brewing_stand_slot_b_bit\" : false, \"brewing_stand_slot_c_bit\" : true] ",
         "[\"brewing_stand_slot_a_bit\" : true, \"brewing_stand_slot_b_bit\" : false, \"brewing_stand_slot_c_bit\" : true] ",
         "[\"brewing_stand_slot_a_bit\" : false, \"brewing_stand_slot_b_bit\" : true, \"brewing_stand_slot_c_bit\" : true] ",
         "[\"brewing_stand_slot_a_bit\" : true, \"brewing_stand_slot_b_bit\" : true, \"brewing_stand_slot_c_bit\" : true] "
            },
        brick_stairs ={
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 0] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 1] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 2] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 3] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 0] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 1] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 2] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 3] "
            },
        brown_candle ={
         "[\"candles\" : 0, \"lit\" : false] ",
         "[\"candles\" : 1, \"lit\" : false] ",
         "[\"candles\" : 2, \"lit\" : false] ",
         "[\"candles\" : 3, \"lit\" : false] ",
         "[\"candles\" : 0, \"lit\" : true] ",
         "[\"candles\" : 1, \"lit\" : true] ",
         "[\"candles\" : 2, \"lit\" : true] ",
         "[\"candles\" : 3, \"lit\" : true] "
            },
        brown_candle_cake ={
         "[\"lit\" : false] ",
         "[\"lit\" : true] "
            },
        brown_glazed_terracotta ={
         "[\"facing_direction\" : 0] ",
         "[\"facing_direction\" : 1] ",
         "[\"facing_direction\" : 2] ",
         "[\"facing_direction\" : 3] ",
         "[\"facing_direction\" : 4] ",
         "[\"facing_direction\" : 5] ",
         "[\"facing_direction\" : 6] ",
         "[\"facing_direction\" : 7] "
            },
        brown_mushroom_block ={
         "[\"huge_mushroom_bits\" : 0] ",
         "[\"huge_mushroom_bits\" : 1] ",
         "[\"huge_mushroom_bits\" : 2] ",
         "[\"huge_mushroom_bits\" : 3] ",
         "[\"huge_mushroom_bits\" : 4] ",
         "[\"huge_mushroom_bits\" : 5] ",
         "[\"huge_mushroom_bits\" : 6] ",
         "[\"huge_mushroom_bits\" : 7] ",
         "[\"huge_mushroom_bits\" : 8] ",
         "[\"huge_mushroom_bits\" : 9] ",
         "[\"huge_mushroom_bits\" : 10] ",
         "[\"huge_mushroom_bits\" : 11] ",
         "[\"huge_mushroom_bits\" : 12] ",
         "[\"huge_mushroom_bits\" : 13] ",
         "[\"huge_mushroom_bits\" : 14] ",
         "[\"huge_mushroom_bits\" : 15] "
            },
        bubble_column ={
         "[\"drag_down\" : false] ",
         "[\"drag_down\" : true] "
            },
        cactus ={
         "[\"age\" : 0] ",
         "[\"age\" : 1] ",
         "[\"age\" : 2] ",
         "[\"age\" : 3] ",
         "[\"age\" : 4] ",
         "[\"age\" : 5] ",
         "[\"age\" : 6] ",
         "[\"age\" : 7] ",
         "[\"age\" : 8] ",
         "[\"age\" : 9] ",
         "[\"age\" : 10] ",
         "[\"age\" : 11] ",
         "[\"age\" : 12] ",
         "[\"age\" : 13] ",
         "[\"age\" : 14] ",
         "[\"age\" : 15] "
            },
        cake ={
         "[\"bite_counter\" : 0] ",
         "[\"bite_counter\" : 1] ",
         "[\"bite_counter\" : 2] ",
         "[\"bite_counter\" : 3] ",
         "[\"bite_counter\" : 4] ",
         "[\"bite_counter\" : 5] ",
         "[\"bite_counter\" : 6] ",
         "[\"bite_counter\" : 7] "
            },
        campfire ={
         "[\"direction\" : 0, \"extinguished\" : false] ",
         "[\"direction\" : 1, \"extinguished\" : false] ",
         "[\"direction\" : 2, \"extinguished\" : false] ",
         "[\"direction\" : 3, \"extinguished\" : false] ",
         "[\"direction\" : 0, \"extinguished\" : true] ",
         "[\"direction\" : 1, \"extinguished\" : true] ",
         "[\"direction\" : 2, \"extinguished\" : true] ",
         "[\"direction\" : 3, \"extinguished\" : true] "
            },
        candle ={
         "[\"candles\" : 0, \"lit\" : false] ",
         "[\"candles\" : 1, \"lit\" : false] ",
         "[\"candles\" : 2, \"lit\" : false] ",
         "[\"candles\" : 3, \"lit\" : false] ",
         "[\"candles\" : 0, \"lit\" : true] ",
         "[\"candles\" : 1, \"lit\" : true] ",
         "[\"candles\" : 2, \"lit\" : true] ",
         "[\"candles\" : 3, \"lit\" : true] "
            },
        candle_cake ={
         "[\"lit\" : false] ",
         "[\"lit\" : true] "
            },
        carpet ={
         "[\"color\" : \"white\"] ",
         "[\"color\" : \"orange\"] ",
         "[\"color\" : \"magenta\"] ",
         "[\"color\" : \"light_blue\"] ",
         "[\"color\" : \"yellow\"] ",
         "[\"color\" : \"lime\"] ",
         "[\"color\" : \"pink\"] ",
         "[\"color\" : \"gray\"] ",
         "[\"color\" : \"silver\"] ",
         "[\"color\" : \"cyan\"] ",
         "[\"color\" : \"purple\"] ",
         "[\"color\" : \"blue\"] ",
         "[\"color\" : \"brown\"] ",
         "[\"color\" : \"green\"] ",
         "[\"color\" : \"red\"] ",
         "[\"color\" : \"black\"] "
            },
        carrots ={
         "[\"growth\" : 0] ",
         "[\"growth\" : 1] ",
         "[\"growth\" : 2] ",
         "[\"growth\" : 3] ",
         "[\"growth\" : 4] ",
         "[\"growth\" : 5] ",
         "[\"growth\" : 6] ",
         "[\"growth\" : 7] "
            },
        carved_pumpkin ={
         "[\"direction\" : 0] ",
         "[\"direction\" : 1] ",
         "[\"direction\" : 2] ",
         "[\"direction\" : 3] "
            },
        cauldron ={
         "[\"cauldron_liquid\" : \"water\", \"fill_level\" : 0] ",
         "[\"cauldron_liquid\" : \"water\", \"fill_level\" : 1] ",
         "[\"cauldron_liquid\" : \"water\", \"fill_level\" : 2] ",
         "[\"cauldron_liquid\" : \"water\", \"fill_level\" : 3] ",
         "[\"cauldron_liquid\" : \"water\", \"fill_level\" : 4] ",
         "[\"cauldron_liquid\" : \"water\", \"fill_level\" : 5] ",
         "[\"cauldron_liquid\" : \"water\", \"fill_level\" : 6] ",
         "[\"cauldron_liquid\" : \"water\", \"fill_level\" : 7] ",
         "[\"cauldron_liquid\" : \"lava\", \"fill_level\" : 0] ",
         "[\"cauldron_liquid\" : \"lava\", \"fill_level\" : 1] ",
         "[\"cauldron_liquid\" : \"lava\", \"fill_level\" : 2] ",
         "[\"cauldron_liquid\" : \"lava\", \"fill_level\" : 3] ",
         "[\"cauldron_liquid\" : \"lava\", \"fill_level\" : 4] ",
         "[\"cauldron_liquid\" : \"lava\", \"fill_level\" : 5] ",
         "[\"cauldron_liquid\" : \"lava\", \"fill_level\" : 6] ",
         "[\"cauldron_liquid\" : \"lava\", \"fill_level\" : 7] "
            },
        chain ={
         "[\"pillar_axis\" : \"y\"] ",
         "[\"pillar_axis\" : \"x\"] ",
         "[\"pillar_axis\" : \"z\"] "
            },
        chain_command_block ={
         "[\"conditional_bit\" : false, \"facing_direction\" : 0] ",
         "[\"conditional_bit\" : false, \"facing_direction\" : 1] ",
         "[\"conditional_bit\" : false, \"facing_direction\" : 2] ",
         "[\"conditional_bit\" : false, \"facing_direction\" : 3] ",
         "[\"conditional_bit\" : false, \"facing_direction\" : 4] ",
         "[\"conditional_bit\" : false, \"facing_direction\" : 5] ",
         "[\"conditional_bit\" : false, \"facing_direction\" : 6] ",
         "[\"conditional_bit\" : false, \"facing_direction\" : 7] ",
         "[\"conditional_bit\" : true, \"facing_direction\" : 0] ",
         "[\"conditional_bit\" : true, \"facing_direction\" : 1] ",
         "[\"conditional_bit\" : true, \"facing_direction\" : 2] ",
         "[\"conditional_bit\" : true, \"facing_direction\" : 3] ",
         "[\"conditional_bit\" : true, \"facing_direction\" : 4] ",
         "[\"conditional_bit\" : true, \"facing_direction\" : 5] ",
         "[\"conditional_bit\" : true, \"facing_direction\" : 6] ",
         "[\"conditional_bit\" : true, \"facing_direction\" : 7] "
            },
        chalkboard ={
         "[\"direction\" : 0] ",
         "[\"direction\" : 1] ",
         "[\"direction\" : 2] ",
         "[\"direction\" : 3] "
            },
        chemistry_table ={
         "[\"chemistry_table_type\" : \"compound_creator\", \"direction\" : 0] ",
         "[\"chemistry_table_type\" : \"compound_creator\", \"direction\" : 1] ",
         "[\"chemistry_table_type\" : \"compound_creator\", \"direction\" : 2] ",
         "[\"chemistry_table_type\" : \"compound_creator\", \"direction\" : 3] ",
         "[\"chemistry_table_type\" : \"material_reducer\", \"direction\" : 0] ",
         "[\"chemistry_table_type\" : \"material_reducer\", \"direction\" : 1] ",
         "[\"chemistry_table_type\" : \"material_reducer\", \"direction\" : 2] ",
         "[\"chemistry_table_type\" : \"material_reducer\", \"direction\" : 3] ",
         "[\"chemistry_table_type\" : \"element_constructor\", \"direction\" : 0] ",
         "[\"chemistry_table_type\" : \"element_constructor\", \"direction\" : 1] ",
         "[\"chemistry_table_type\" : \"element_constructor\", \"direction\" : 2] ",
         "[\"chemistry_table_type\" : \"element_constructor\", \"direction\" : 3] ",
         "[\"chemistry_table_type\" : \"lab_table\", \"direction\" : 0] ",
         "[\"chemistry_table_type\" : \"lab_table\", \"direction\" : 1] ",
         "[\"chemistry_table_type\" : \"lab_table\", \"direction\" : 2] ",
         "[\"chemistry_table_type\" : \"lab_table\", \"direction\" : 3] "
            },
        chest ={
         "[\"facing_direction\" : 0] ",
         "[\"facing_direction\" : 1] ",
         "[\"facing_direction\" : 2] ",
         "[\"facing_direction\" : 3] ",
         "[\"facing_direction\" : 4] ",
         "[\"facing_direction\" : 5] ",
         "[\"facing_direction\" : 6] ",
         "[\"facing_direction\" : 7] "
            },
        chorus_flower ={
         "[\"age\" : 0] ",
         "[\"age\" : 1] ",
         "[\"age\" : 2] ",
         "[\"age\" : 3] ",
         "[\"age\" : 4] ",
         "[\"age\" : 5] ",
         "[\"age\" : 6] ",
         "[\"age\" : 7] "
            },
        cobbled_deepslate_slab ={
         "[\"top_slot_bit\" : false] ",
         "[\"top_slot_bit\" : true] "
            },
        cobblestone_wall ={
         "[\"wall_block_type\" : \"cobblestone\"] ",
         "[\"wall_block_type\" : \"mossy_cobblestone\"] ",
         "[\"wall_block_type\" : \"granite\"] ",
         "[\"wall_block_type\" : \"diorite\"] ",
         "[\"wall_block_type\" : \"andesite\"] ",
         "[\"wall_block_type\" : \"sandstone\"] ",
         "[\"wall_block_type\" : \"brick\"] ",
         "[\"wall_block_type\" : \"stone_brick\"] ",
         "[\"wall_block_type\" : \"mossy_stone_brick\"] ",
         "[\"wall_block_type\" : \"nether_brick\"] ",
         "[\"wall_block_type\" : \"end_brick\"] ",
         "[\"wall_block_type\" : \"prismarine\"] ",
         "[\"wall_block_type\" : \"red_sandstone\"] ",
         "[\"wall_block_type\" : \"red_nether_brick\"] ",
         "[\"wall_block_type\" : \"cobblestone\"] "
            },
        cocoa ={
         "[\"age\" : 0, \"direction\" : 0] ",
         "[\"age\" : 0, \"direction\" : 1] ",
         "[\"age\" : 0, \"direction\" : 2] ",
         "[\"age\" : 0, \"direction\" : 3] ",
         "[\"age\" : 1, \"direction\" : 0] ",
         "[\"age\" : 1, \"direction\" : 1] ",
         "[\"age\" : 1, \"direction\" : 2] ",
         "[\"age\" : 1, \"direction\" : 3] ",
         "[\"age\" : 2, \"direction\" : 0] ",
         "[\"age\" : 2, \"direction\" : 1] ",
         "[\"age\" : 2, \"direction\" : 2] ",
         "[\"age\" : 2, \"direction\" : 3] ",
         "[\"age\" : 3, \"direction\" : 0] ",
         "[\"age\" : 3, \"direction\" : 1] ",
         "[\"age\" : 3, \"direction\" : 2] ",
         "[\"age\" : 3, \"direction\" : 3] "
            },
        colored_torch_bp ={
         "[\"color_bit\" : false, \"torch_facing_direction\" : \"unknown\"] ",
         "[\"color_bit\" : false, \"torch_facing_direction\" : \"west\"] ",
         "[\"color_bit\" : false, \"torch_facing_direction\" : \"east\"] ",
         "[\"color_bit\" : false, \"torch_facing_direction\" : \"north\"] ",
         "[\"color_bit\" : false, \"torch_facing_direction\" : \"south\"] ",
         "[\"color_bit\" : false, \"torch_facing_direction\" : \"top\"] ",
         "[\"color_bit\" : false, \"torch_facing_direction\" : \"unknown\"] "
            },
        colored_torch_rg ={
         "[\"color_bit\" : false, \"torch_facing_direction\" : \"unknown\"] ",
         "[\"color_bit\" : false, \"torch_facing_direction\" : \"west\"] ",
         "[\"color_bit\" : false, \"torch_facing_direction\" : \"east\"] ",
         "[\"color_bit\" : false, \"torch_facing_direction\" : \"north\"] ",
         "[\"color_bit\" : false, \"torch_facing_direction\" : \"south\"] ",
         "[\"color_bit\" : false, \"torch_facing_direction\" : \"top\"] ",
         "[\"color_bit\" : false, \"torch_facing_direction\" : \"unknown\"] "
            },
        command_block ={
         "[\"conditional_bit\" : false, \"facing_direction\" : 0] ",
         "[\"conditional_bit\" : false, \"facing_direction\" : 1] ",
         "[\"conditional_bit\" : false, \"facing_direction\" : 2] ",
         "[\"conditional_bit\" : false, \"facing_direction\" : 3] ",
         "[\"conditional_bit\" : false, \"facing_direction\" : 4] ",
         "[\"conditional_bit\" : false, \"facing_direction\" : 5] ",
         "[\"conditional_bit\" : false, \"facing_direction\" : 6] ",
         "[\"conditional_bit\" : false, \"facing_direction\" : 7] ",
         "[\"conditional_bit\" : true, \"facing_direction\" : 0] ",
         "[\"conditional_bit\" : true, \"facing_direction\" : 1] ",
         "[\"conditional_bit\" : true, \"facing_direction\" : 2] ",
         "[\"conditional_bit\" : true, \"facing_direction\" : 3] ",
         "[\"conditional_bit\" : true, \"facing_direction\" : 4] ",
         "[\"conditional_bit\" : true, \"facing_direction\" : 5] ",
         "[\"conditional_bit\" : true, \"facing_direction\" : 6] ",
         "[\"conditional_bit\" : true, \"facing_direction\" : 7] "
            },
        composter ={
         "[\"composter_fill_level\" : 0] ",
         "[\"composter_fill_level\" : 1] ",
         "[\"composter_fill_level\" : 2] ",
         "[\"composter_fill_level\" : 3] ",
         "[\"composter_fill_level\" : 4] ",
         "[\"composter_fill_level\" : 5] ",
         "[\"composter_fill_level\" : 6] ",
         "[\"composter_fill_level\" : 7] ",
         "[\"composter_fill_level\" : 8] ",
         "[\"composter_fill_level\" : 9] ",
         "[\"composter_fill_level\" : 10] ",
         "[\"composter_fill_level\" : 11] ",
         "[\"composter_fill_level\" : 12] ",
         "[\"composter_fill_level\" : 13] ",
         "[\"composter_fill_level\" : 14] ",
         "[\"composter_fill_level\" : 15] "
            },
        concrete ={
         "[\"color\" : \"white\"] ",
         "[\"color\" : \"orange\"] ",
         "[\"color\" : \"magenta\"] ",
         "[\"color\" : \"light_blue\"] ",
         "[\"color\" : \"yellow\"] ",
         "[\"color\" : \"lime\"] ",
         "[\"color\" : \"pink\"] ",
         "[\"color\" : \"gray\"] ",
         "[\"color\" : \"silver\"] ",
         "[\"color\" : \"cyan\"] ",
         "[\"color\" : \"purple\"] ",
         "[\"color\" : \"blue\"] ",
         "[\"color\" : \"brown\"] ",
         "[\"color\" : \"green\"] ",
         "[\"color\" : \"red\"] ",
         "[\"color\" : \"black\"] "
            },
        concrete_powder ={
         "[\"color\" : \"white\"] ",
         "[\"color\" : \"orange\"] ",
         "[\"color\" : \"magenta\"] ",
         "[\"color\" : \"light_blue\"] ",
         "[\"color\" : \"yellow\"] ",
         "[\"color\" : \"lime\"] ",
         "[\"color\" : \"pink\"] ",
         "[\"color\" : \"gray\"] ",
         "[\"color\" : \"silver\"] ",
         "[\"color\" : \"cyan\"] ",
         "[\"color\" : \"purple\"] ",
         "[\"color\" : \"blue\"] ",
         "[\"color\" : \"brown\"] ",
         "[\"color\" : \"green\"] ",
         "[\"color\" : \"red\"] ",
         "[\"color\" : \"black\"] "
            },
        coral ={
         "[\"coral_color\" : \"blue\", \"dead_bit\" : false] ",
         "[\"coral_color\" : \"pink\", \"dead_bit\" : false] ",
         "[\"coral_color\" : \"purple\", \"dead_bit\" : false] ",
         "[\"coral_color\" : \"red\", \"dead_bit\" : false] ",
         "[\"coral_color\" : \"yellow\", \"dead_bit\" : false] ",
         "[\"coral_color\" : \"blue\", \"dead_bit\" : false] "
            },
        coral_block ={
         "[\"coral_color\" : \"blue\", \"dead_bit\" : false] ",
         "[\"coral_color\" : \"pink\", \"dead_bit\" : false] ",
         "[\"coral_color\" : \"purple\", \"dead_bit\" : false] ",
         "[\"coral_color\" : \"red\", \"dead_bit\" : false] ",
         "[\"coral_color\" : \"yellow\", \"dead_bit\" : false] ",
         "[\"coral_color\" : \"blue\", \"dead_bit\" : false] "
            },
        coral_fan ={
         "[\"coral_color\" : \"blue\", \"coral_fan_direction\" : 0] ",
         "[\"coral_color\" : \"pink\", \"coral_fan_direction\" : 0] ",
         "[\"coral_color\" : \"purple\", \"coral_fan_direction\" : 0] ",
         "[\"coral_color\" : \"red\", \"coral_fan_direction\" : 0] ",
         "[\"coral_color\" : \"yellow\", \"coral_fan_direction\" : 0] ",
         "[\"coral_color\" : \"blue\", \"coral_fan_direction\" : 0] "
            },
        coral_fan_dead ={
         "[\"coral_color\" : \"blue\", \"coral_fan_direction\" : 0] ",
         "[\"coral_color\" : \"pink\", \"coral_fan_direction\" : 0] ",
         "[\"coral_color\" : \"purple\", \"coral_fan_direction\" : 0] ",
         "[\"coral_color\" : \"red\", \"coral_fan_direction\" : 0] ",
         "[\"coral_color\" : \"yellow\", \"coral_fan_direction\" : 0] ",
         "[\"coral_color\" : \"blue\", \"coral_fan_direction\" : 0] "
            },
        coral_fan_hang ={
         "[\"coral_direction\" : 0, \"coral_hang_type_bit\" : false, \"dead_bit\" : false] ",
         "[\"coral_direction\" : 0, \"coral_hang_type_bit\" : true, \"dead_bit\" : false] ",
         "[\"coral_direction\" : 0, \"coral_hang_type_bit\" : false, \"dead_bit\" : true] ",
         "[\"coral_direction\" : 0, \"coral_hang_type_bit\" : true, \"dead_bit\" : true] ",
         "[\"coral_direction\" : 1, \"coral_hang_type_bit\" : false, \"dead_bit\" : false] ",
         "[\"coral_direction\" : 1, \"coral_hang_type_bit\" : true, \"dead_bit\" : false] ",
         "[\"coral_direction\" : 1, \"coral_hang_type_bit\" : false, \"dead_bit\" : true] ",
         "[\"coral_direction\" : 1, \"coral_hang_type_bit\" : true, \"dead_bit\" : true] ",
         "[\"coral_direction\" : 2, \"coral_hang_type_bit\" : false, \"dead_bit\" : false] ",
         "[\"coral_direction\" : 2, \"coral_hang_type_bit\" : true, \"dead_bit\" : false] ",
         "[\"coral_direction\" : 2, \"coral_hang_type_bit\" : false, \"dead_bit\" : true] ",
         "[\"coral_direction\" : 2, \"coral_hang_type_bit\" : true, \"dead_bit\" : true] ",
         "[\"coral_direction\" : 3, \"coral_hang_type_bit\" : false, \"dead_bit\" : false] ",
         "[\"coral_direction\" : 3, \"coral_hang_type_bit\" : true, \"dead_bit\" : false] ",
         "[\"coral_direction\" : 3, \"coral_hang_type_bit\" : false, \"dead_bit\" : true] ",
         "[\"coral_direction\" : 3, \"coral_hang_type_bit\" : true, \"dead_bit\" : true] "
            },
        coral_fan_hang2 ={
         "[\"coral_direction\" : 0, \"coral_hang_type_bit\" : false, \"dead_bit\" : false] ",
         "[\"coral_direction\" : 0, \"coral_hang_type_bit\" : true, \"dead_bit\" : false] ",
         "[\"coral_direction\" : 0, \"coral_hang_type_bit\" : false, \"dead_bit\" : true] ",
         "[\"coral_direction\" : 0, \"coral_hang_type_bit\" : true, \"dead_bit\" : true] ",
         "[\"coral_direction\" : 1, \"coral_hang_type_bit\" : false, \"dead_bit\" : false] ",
         "[\"coral_direction\" : 1, \"coral_hang_type_bit\" : true, \"dead_bit\" : false] ",
         "[\"coral_direction\" : 1, \"coral_hang_type_bit\" : false, \"dead_bit\" : true] ",
         "[\"coral_direction\" : 1, \"coral_hang_type_bit\" : true, \"dead_bit\" : true] ",
         "[\"coral_direction\" : 2, \"coral_hang_type_bit\" : false, \"dead_bit\" : false] ",
         "[\"coral_direction\" : 2, \"coral_hang_type_bit\" : true, \"dead_bit\" : false] ",
         "[\"coral_direction\" : 2, \"coral_hang_type_bit\" : false, \"dead_bit\" : true] ",
         "[\"coral_direction\" : 2, \"coral_hang_type_bit\" : true, \"dead_bit\" : true] ",
         "[\"coral_direction\" : 3, \"coral_hang_type_bit\" : false, \"dead_bit\" : false] ",
         "[\"coral_direction\" : 3, \"coral_hang_type_bit\" : true, \"dead_bit\" : false] ",
         "[\"coral_direction\" : 3, \"coral_hang_type_bit\" : false, \"dead_bit\" : true] ",
         "[\"coral_direction\" : 3, \"coral_hang_type_bit\" : true, \"dead_bit\" : true] "
            },
        coral_fan_hang3 ={
         "[\"coral_direction\" : 0, \"coral_hang_type_bit\" : false, \"dead_bit\" : false] ",
         "[\"coral_direction\" : 0, \"coral_hang_type_bit\" : true, \"dead_bit\" : false] ",
         "[\"coral_direction\" : 0, \"coral_hang_type_bit\" : false, \"dead_bit\" : true] ",
         "[\"coral_direction\" : 0, \"coral_hang_type_bit\" : true, \"dead_bit\" : true] ",
         "[\"coral_direction\" : 1, \"coral_hang_type_bit\" : false, \"dead_bit\" : false] ",
         "[\"coral_direction\" : 1, \"coral_hang_type_bit\" : true, \"dead_bit\" : false] ",
         "[\"coral_direction\" : 1, \"coral_hang_type_bit\" : false, \"dead_bit\" : true] ",
         "[\"coral_direction\" : 1, \"coral_hang_type_bit\" : true, \"dead_bit\" : true] ",
         "[\"coral_direction\" : 2, \"coral_hang_type_bit\" : false, \"dead_bit\" : false] ",
         "[\"coral_direction\" : 2, \"coral_hang_type_bit\" : true, \"dead_bit\" : false] ",
         "[\"coral_direction\" : 2, \"coral_hang_type_bit\" : false, \"dead_bit\" : true] ",
         "[\"coral_direction\" : 2, \"coral_hang_type_bit\" : true, \"dead_bit\" : true] ",
         "[\"coral_direction\" : 3, \"coral_hang_type_bit\" : false, \"dead_bit\" : false] ",
         "[\"coral_direction\" : 3, \"coral_hang_type_bit\" : true, \"dead_bit\" : false] ",
         "[\"coral_direction\" : 3, \"coral_hang_type_bit\" : false, \"dead_bit\" : true] ",
         "[\"coral_direction\" : 3, \"coral_hang_type_bit\" : true, \"dead_bit\" : true] "
            },
        crimson_button ={
         "[\"button_pressed_bit\" : false, \"facing_direction\" : 0] ",
         "[\"button_pressed_bit\" : false, \"facing_direction\" : 1] ",
         "[\"button_pressed_bit\" : false, \"facing_direction\" : 2] ",
         "[\"button_pressed_bit\" : false, \"facing_direction\" : 3] ",
         "[\"button_pressed_bit\" : false, \"facing_direction\" : 4] ",
         "[\"button_pressed_bit\" : false, \"facing_direction\" : 5] ",
         "[\"button_pressed_bit\" : false, \"facing_direction\" : 6] ",
         "[\"button_pressed_bit\" : false, \"facing_direction\" : 7] ",
         "[\"button_pressed_bit\" : true, \"facing_direction\" : 0] ",
         "[\"button_pressed_bit\" : true, \"facing_direction\" : 1] ",
         "[\"button_pressed_bit\" : true, \"facing_direction\" : 2] ",
         "[\"button_pressed_bit\" : true, \"facing_direction\" : 3] ",
         "[\"button_pressed_bit\" : true, \"facing_direction\" : 4] ",
         "[\"button_pressed_bit\" : true, \"facing_direction\" : 5] ",
         "[\"button_pressed_bit\" : true, \"facing_direction\" : 6] ",
         "[\"button_pressed_bit\" : true, \"facing_direction\" : 7] "
            },
        crimson_door ={
         "[\"direction\" : 0, \"door_hinge_bit\" : false, \"open_bit\" : false, \"upper_block_bit\" : false] ",
         "[\"direction\" : 1, \"door_hinge_bit\" : true, \"open_bit\" : false, \"upper_block_bit\" : false] ",
         "[\"direction\" : 2, \"door_hinge_bit\" : false, \"open_bit\" : false, \"upper_block_bit\" : false] ",
         "[\"direction\" : 3, \"door_hinge_bit\" : true, \"open_bit\" : false, \"upper_block_bit\" : false] ",
         "[\"direction\" : 0, \"door_hinge_bit\" : false, \"open_bit\" : true, \"upper_block_bit\" : false] ",
         "[\"direction\" : 1, \"door_hinge_bit\" : true, \"open_bit\" : true, \"upper_block_bit\" : false] ",
         "[\"direction\" : 2, \"door_hinge_bit\" : false, \"open_bit\" : true, \"upper_block_bit\" : false] ",
         "[\"direction\" : 3, \"door_hinge_bit\" : true, \"open_bit\" : true, \"upper_block_bit\" : false] ",
         "[\"direction\" : 0, \"door_hinge_bit\" : false, \"open_bit\" : false, \"upper_block_bit\" : true] ",
         "[\"direction\" : 1, \"door_hinge_bit\" : true, \"open_bit\" : false, \"upper_block_bit\" : true] ",
         "[\"direction\" : 2, \"door_hinge_bit\" : false, \"open_bit\" : false, \"upper_block_bit\" : true] ",
         "[\"direction\" : 3, \"door_hinge_bit\" : true, \"open_bit\" : false, \"upper_block_bit\" : true] ",
         "[\"direction\" : 0, \"door_hinge_bit\" : false, \"open_bit\" : true, \"upper_block_bit\" : true] ",
         "[\"direction\" : 1, \"door_hinge_bit\" : true, \"open_bit\" : true, \"upper_block_bit\" : true] ",
         "[\"direction\" : 2, \"door_hinge_bit\" : false, \"open_bit\" : true, \"upper_block_bit\" : true] ",
         "[\"direction\" : 3, \"door_hinge_bit\" : true, \"open_bit\" : true, \"upper_block_bit\" : true] ",
         "[\"direction\" : 0, \"door_hinge_bit\" : false, \"open_bit\" : false, \"upper_block_bit\" : false] ",
         "[\"direction\" : 1, \"door_hinge_bit\" : true, \"open_bit\" : false, \"upper_block_bit\" : false] ",
         "[\"direction\" : 2, \"door_hinge_bit\" : false, \"open_bit\" : false, \"upper_block_bit\" : false] ",
         "[\"direction\" : 3, \"door_hinge_bit\" : true, \"open_bit\" : false, \"upper_block_bit\" : false] ",
         "[\"direction\" : 0, \"door_hinge_bit\" : false, \"open_bit\" : true, \"upper_block_bit\" : false] ",
         "[\"direction\" : 1, \"door_hinge_bit\" : true, \"open_bit\" : true, \"upper_block_bit\" : false] ",
         "[\"direction\" : 2, \"door_hinge_bit\" : false, \"open_bit\" : true, \"upper_block_bit\" : false] ",
         "[\"direction\" : 3, \"door_hinge_bit\" : true, \"open_bit\" : true, \"upper_block_bit\" : false] ",
         "[\"direction\" : 0, \"door_hinge_bit\" : false, \"open_bit\" : false, \"upper_block_bit\" : true] ",
         "[\"direction\" : 1, \"door_hinge_bit\" : true, \"open_bit\" : false, \"upper_block_bit\" : true] ",
         "[\"direction\" : 2, \"door_hinge_bit\" : false, \"open_bit\" : false, \"upper_block_bit\" : true] ",
         "[\"direction\" : 3, \"door_hinge_bit\" : true, \"open_bit\" : false, \"upper_block_bit\" : true] ",
         "[\"direction\" : 0, \"door_hinge_bit\" : false, \"open_bit\" : true, \"upper_block_bit\" : true] ",
         "[\"direction\" : 1, \"door_hinge_bit\" : true, \"open_bit\" : true, \"upper_block_bit\" : true] ",
         "[\"direction\" : 2, \"door_hinge_bit\" : false, \"open_bit\" : true, \"upper_block_bit\" : true] ",
         "[\"direction\" : 3, \"door_hinge_bit\" : true, \"open_bit\" : true, \"upper_block_bit\" : true] "
            },
        crimson_fence_gate ={
         "[\"direction\" : 0, \"in_wall_bit\" : false, \"open_bit\" : false] ",
         "[\"direction\" : 1, \"in_wall_bit\" : false, \"open_bit\" : false] ",
         "[\"direction\" : 2, \"in_wall_bit\" : false, \"open_bit\" : false] ",
         "[\"direction\" : 3, \"in_wall_bit\" : false, \"open_bit\" : false] ",
         "[\"direction\" : 0, \"in_wall_bit\" : false, \"open_bit\" : true] ",
         "[\"direction\" : 1, \"in_wall_bit\" : false, \"open_bit\" : true] ",
         "[\"direction\" : 2, \"in_wall_bit\" : false, \"open_bit\" : true] ",
         "[\"direction\" : 3, \"in_wall_bit\" : false, \"open_bit\" : true] ",
         "[\"direction\" : 0, \"in_wall_bit\" : true, \"open_bit\" : false] ",
         "[\"direction\" : 1, \"in_wall_bit\" : true, \"open_bit\" : false] ",
         "[\"direction\" : 2, \"in_wall_bit\" : true, \"open_bit\" : false] ",
         "[\"direction\" : 3, \"in_wall_bit\" : true, \"open_bit\" : false] ",
         "[\"direction\" : 0, \"in_wall_bit\" : true, \"open_bit\" : true] ",
         "[\"direction\" : 1, \"in_wall_bit\" : true, \"open_bit\" : true] ",
         "[\"direction\" : 2, \"in_wall_bit\" : true, \"open_bit\" : true] ",
         "[\"direction\" : 3, \"in_wall_bit\" : true, \"open_bit\" : true] "
            },
        crimson_slab ={
         "[\"top_slot_bit\" : false] ",
         "[\"top_slot_bit\" : true] "
            },
        crimson_stairs ={
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 0] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 1] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 2] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 3] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 0] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 1] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 2] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 3] "
            },
        crimson_standing_sign ={
         "[\"ground_sign_direction\" : 0] ",
         "[\"ground_sign_direction\" : 1] ",
         "[\"ground_sign_direction\" : 2] ",
         "[\"ground_sign_direction\" : 3] ",
         "[\"ground_sign_direction\" : 4] ",
         "[\"ground_sign_direction\" : 5] ",
         "[\"ground_sign_direction\" : 6] ",
         "[\"ground_sign_direction\" : 7] ",
         "[\"ground_sign_direction\" : 8] ",
         "[\"ground_sign_direction\" : 9] ",
         "[\"ground_sign_direction\" : 10] ",
         "[\"ground_sign_direction\" : 11] ",
         "[\"ground_sign_direction\" : 12] ",
         "[\"ground_sign_direction\" : 13] ",
         "[\"ground_sign_direction\" : 14] ",
         "[\"ground_sign_direction\" : 15] "
            },
        crimson_stem ={
         "[\"pillar_axis\" : \"y\"] ",
         "[\"pillar_axis\" : \"x\"] ",
         "[\"pillar_axis\" : \"z\"] "
            },
        crimson_trapdoor ={
         "[\"direction\" : 0, \"open_bit\" : false, \"upside_down_bit\" : false] ",
         "[\"direction\" : 1, \"open_bit\" : false, \"upside_down_bit\" : false] ",
         "[\"direction\" : 2, \"open_bit\" : false, \"upside_down_bit\" : false] ",
         "[\"direction\" : 3, \"open_bit\" : false, \"upside_down_bit\" : false] ",
         "[\"direction\" : 0, \"open_bit\" : false, \"upside_down_bit\" : true] ",
         "[\"direction\" : 1, \"open_bit\" : false, \"upside_down_bit\" : true] ",
         "[\"direction\" : 2, \"open_bit\" : false, \"upside_down_bit\" : true] ",
         "[\"direction\" : 3, \"open_bit\" : false, \"upside_down_bit\" : true] ",
         "[\"direction\" : 0, \"open_bit\" : true, \"upside_down_bit\" : false] ",
         "[\"direction\" : 1, \"open_bit\" : true, \"upside_down_bit\" : false] ",
         "[\"direction\" : 2, \"open_bit\" : true, \"upside_down_bit\" : false] ",
         "[\"direction\" : 3, \"open_bit\" : true, \"upside_down_bit\" : false] ",
         "[\"direction\" : 0, \"open_bit\" : true, \"upside_down_bit\" : true] ",
         "[\"direction\" : 1, \"open_bit\" : true, \"upside_down_bit\" : true] ",
         "[\"direction\" : 2, \"open_bit\" : true, \"upside_down_bit\" : true] ",
         "[\"direction\" : 3, \"open_bit\" : true, \"upside_down_bit\" : true] "
            },
        crimson_wall_sign ={
         "[\"facing_direction\" : 0] ",
         "[\"facing_direction\" : 1] ",
         "[\"facing_direction\" : 2] ",
         "[\"facing_direction\" : 3] ",
         "[\"facing_direction\" : 4] ",
         "[\"facing_direction\" : 5] ",
         "[\"facing_direction\" : 6] ",
         "[\"facing_direction\" : 7] "
            },
        cut_copper_slab ={
         "[\"top_slot_bit\" : false] ",
         "[\"top_slot_bit\" : true] "
            },
        cyan_candle ={
         "[\"candles\" : 0, \"lit\" : false] ",
         "[\"candles\" : 1, \"lit\" : false] ",
         "[\"candles\" : 2, \"lit\" : false] ",
         "[\"candles\" : 3, \"lit\" : false] ",
         "[\"candles\" : 0, \"lit\" : true] ",
         "[\"candles\" : 1, \"lit\" : true] ",
         "[\"candles\" : 2, \"lit\" : true] ",
         "[\"candles\" : 3, \"lit\" : true] "
            },
        cyan_candle_cake ={
         "[\"lit\" : false] ",
         "[\"lit\" : true] "
            },
        cyan_glazed_terracotta ={
         "[\"facing_direction\" : 0] ",
         "[\"facing_direction\" : 1] ",
         "[\"facing_direction\" : 2] ",
         "[\"facing_direction\" : 3] ",
         "[\"facing_direction\" : 4] ",
         "[\"facing_direction\" : 5] ",
         "[\"facing_direction\" : 6] ",
         "[\"facing_direction\" : 7] "
            },
        dark_oak_button ={
         "[\"button_pressed_bit\" : false, \"facing_direction\" : 0] ",
         "[\"button_pressed_bit\" : false, \"facing_direction\" : 1] ",
         "[\"button_pressed_bit\" : false, \"facing_direction\" : 2] ",
         "[\"button_pressed_bit\" : false, \"facing_direction\" : 3] ",
         "[\"button_pressed_bit\" : false, \"facing_direction\" : 4] ",
         "[\"button_pressed_bit\" : false, \"facing_direction\" : 5] ",
         "[\"button_pressed_bit\" : false, \"facing_direction\" : 6] ",
         "[\"button_pressed_bit\" : false, \"facing_direction\" : 7] ",
         "[\"button_pressed_bit\" : true, \"facing_direction\" : 0] ",
         "[\"button_pressed_bit\" : true, \"facing_direction\" : 1] ",
         "[\"button_pressed_bit\" : true, \"facing_direction\" : 2] ",
         "[\"button_pressed_bit\" : true, \"facing_direction\" : 3] ",
         "[\"button_pressed_bit\" : true, \"facing_direction\" : 4] ",
         "[\"button_pressed_bit\" : true, \"facing_direction\" : 5] ",
         "[\"button_pressed_bit\" : true, \"facing_direction\" : 6] ",
         "[\"button_pressed_bit\" : true, \"facing_direction\" : 7] "
            },
        dark_oak_door ={
         "[\"direction\" : 0, \"door_hinge_bit\" : false, \"open_bit\" : false, \"upper_block_bit\" : false] ",
         "[\"direction\" : 1, \"door_hinge_bit\" : true, \"open_bit\" : false, \"upper_block_bit\" : false] ",
         "[\"direction\" : 2, \"door_hinge_bit\" : false, \"open_bit\" : false, \"upper_block_bit\" : false] ",
         "[\"direction\" : 3, \"door_hinge_bit\" : true, \"open_bit\" : false, \"upper_block_bit\" : false] ",
         "[\"direction\" : 0, \"door_hinge_bit\" : false, \"open_bit\" : true, \"upper_block_bit\" : false] ",
         "[\"direction\" : 1, \"door_hinge_bit\" : true, \"open_bit\" : true, \"upper_block_bit\" : false] ",
         "[\"direction\" : 2, \"door_hinge_bit\" : false, \"open_bit\" : true, \"upper_block_bit\" : false] ",
         "[\"direction\" : 3, \"door_hinge_bit\" : true, \"open_bit\" : true, \"upper_block_bit\" : false] ",
         "[\"direction\" : 0, \"door_hinge_bit\" : false, \"open_bit\" : false, \"upper_block_bit\" : true] ",
         "[\"direction\" : 1, \"door_hinge_bit\" : true, \"open_bit\" : false, \"upper_block_bit\" : true] ",
         "[\"direction\" : 2, \"door_hinge_bit\" : false, \"open_bit\" : false, \"upper_block_bit\" : true] ",
         "[\"direction\" : 3, \"door_hinge_bit\" : true, \"open_bit\" : false, \"upper_block_bit\" : true] ",
         "[\"direction\" : 0, \"door_hinge_bit\" : false, \"open_bit\" : true, \"upper_block_bit\" : true] ",
         "[\"direction\" : 1, \"door_hinge_bit\" : true, \"open_bit\" : true, \"upper_block_bit\" : true] ",
         "[\"direction\" : 2, \"door_hinge_bit\" : false, \"open_bit\" : true, \"upper_block_bit\" : true] ",
         "[\"direction\" : 3, \"door_hinge_bit\" : true, \"open_bit\" : true, \"upper_block_bit\" : true] ",
         "[\"direction\" : 0, \"door_hinge_bit\" : false, \"open_bit\" : false, \"upper_block_bit\" : false] ",
         "[\"direction\" : 1, \"door_hinge_bit\" : true, \"open_bit\" : false, \"upper_block_bit\" : false] ",
         "[\"direction\" : 2, \"door_hinge_bit\" : false, \"open_bit\" : false, \"upper_block_bit\" : false] ",
         "[\"direction\" : 3, \"door_hinge_bit\" : true, \"open_bit\" : false, \"upper_block_bit\" : false] ",
         "[\"direction\" : 0, \"door_hinge_bit\" : false, \"open_bit\" : true, \"upper_block_bit\" : false] ",
         "[\"direction\" : 1, \"door_hinge_bit\" : true, \"open_bit\" : true, \"upper_block_bit\" : false] ",
         "[\"direction\" : 2, \"door_hinge_bit\" : false, \"open_bit\" : true, \"upper_block_bit\" : false] ",
         "[\"direction\" : 3, \"door_hinge_bit\" : true, \"open_bit\" : true, \"upper_block_bit\" : false] ",
         "[\"direction\" : 0, \"door_hinge_bit\" : false, \"open_bit\" : false, \"upper_block_bit\" : true] ",
         "[\"direction\" : 1, \"door_hinge_bit\" : true, \"open_bit\" : false, \"upper_block_bit\" : true] ",
         "[\"direction\" : 2, \"door_hinge_bit\" : false, \"open_bit\" : false, \"upper_block_bit\" : true] ",
         "[\"direction\" : 3, \"door_hinge_bit\" : true, \"open_bit\" : false, \"upper_block_bit\" : true] ",
         "[\"direction\" : 0, \"door_hinge_bit\" : false, \"open_bit\" : true, \"upper_block_bit\" : true] ",
         "[\"direction\" : 1, \"door_hinge_bit\" : true, \"open_bit\" : true, \"upper_block_bit\" : true] ",
         "[\"direction\" : 2, \"door_hinge_bit\" : false, \"open_bit\" : true, \"upper_block_bit\" : true] ",
         "[\"direction\" : 3, \"door_hinge_bit\" : true, \"open_bit\" : true, \"upper_block_bit\" : true] "
            },
        dark_oak_fence_gate ={
         "[\"direction\" : 0, \"in_wall_bit\" : false, \"open_bit\" : false] ",
         "[\"direction\" : 1, \"in_wall_bit\" : false, \"open_bit\" : false] ",
         "[\"direction\" : 2, \"in_wall_bit\" : false, \"open_bit\" : false] ",
         "[\"direction\" : 3, \"in_wall_bit\" : false, \"open_bit\" : false] ",
         "[\"direction\" : 0, \"in_wall_bit\" : false, \"open_bit\" : true] ",
         "[\"direction\" : 1, \"in_wall_bit\" : false, \"open_bit\" : true] ",
         "[\"direction\" : 2, \"in_wall_bit\" : false, \"open_bit\" : true] ",
         "[\"direction\" : 3, \"in_wall_bit\" : false, \"open_bit\" : true] ",
         "[\"direction\" : 0, \"in_wall_bit\" : true, \"open_bit\" : false] ",
         "[\"direction\" : 1, \"in_wall_bit\" : true, \"open_bit\" : false] ",
         "[\"direction\" : 2, \"in_wall_bit\" : true, \"open_bit\" : false] ",
         "[\"direction\" : 3, \"in_wall_bit\" : true, \"open_bit\" : false] ",
         "[\"direction\" : 0, \"in_wall_bit\" : true, \"open_bit\" : true] ",
         "[\"direction\" : 1, \"in_wall_bit\" : true, \"open_bit\" : true] ",
         "[\"direction\" : 2, \"in_wall_bit\" : true, \"open_bit\" : true] ",
         "[\"direction\" : 3, \"in_wall_bit\" : true, \"open_bit\" : true] "
            },
        dark_oak_pressure_plate ={
         "[\"redstone_signal\" : 0] ",
         "[\"redstone_signal\" : 1] ",
         "[\"redstone_signal\" : 2] ",
         "[\"redstone_signal\" : 3] ",
         "[\"redstone_signal\" : 4] ",
         "[\"redstone_signal\" : 5] ",
         "[\"redstone_signal\" : 6] ",
         "[\"redstone_signal\" : 7] ",
         "[\"redstone_signal\" : 8] ",
         "[\"redstone_signal\" : 9] ",
         "[\"redstone_signal\" : 10] ",
         "[\"redstone_signal\" : 11] ",
         "[\"redstone_signal\" : 12] ",
         "[\"redstone_signal\" : 13] ",
         "[\"redstone_signal\" : 14] ",
         "[\"redstone_signal\" : 15] "
            },
        dark_oak_stairs ={
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 0] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 1] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 2] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 3] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 0] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 1] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 2] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 3] "
            },
        dark_oak_trapdoor ={
         "[\"direction\" : 0, \"open_bit\" : false, \"upside_down_bit\" : false] ",
         "[\"direction\" : 1, \"open_bit\" : false, \"upside_down_bit\" : false] ",
         "[\"direction\" : 2, \"open_bit\" : false, \"upside_down_bit\" : false] ",
         "[\"direction\" : 3, \"open_bit\" : false, \"upside_down_bit\" : false] ",
         "[\"direction\" : 0, \"open_bit\" : false, \"upside_down_bit\" : true] ",
         "[\"direction\" : 1, \"open_bit\" : false, \"upside_down_bit\" : true] ",
         "[\"direction\" : 2, \"open_bit\" : false, \"upside_down_bit\" : true] ",
         "[\"direction\" : 3, \"open_bit\" : false, \"upside_down_bit\" : true] ",
         "[\"direction\" : 0, \"open_bit\" : true, \"upside_down_bit\" : false] ",
         "[\"direction\" : 1, \"open_bit\" : true, \"upside_down_bit\" : false] ",
         "[\"direction\" : 2, \"open_bit\" : true, \"upside_down_bit\" : false] ",
         "[\"direction\" : 3, \"open_bit\" : true, \"upside_down_bit\" : false] ",
         "[\"direction\" : 0, \"open_bit\" : true, \"upside_down_bit\" : true] ",
         "[\"direction\" : 1, \"open_bit\" : true, \"upside_down_bit\" : true] ",
         "[\"direction\" : 2, \"open_bit\" : true, \"upside_down_bit\" : true] ",
         "[\"direction\" : 3, \"open_bit\" : true, \"upside_down_bit\" : true] "
            },
        dark_prismarine_stairs ={
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 0] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 1] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 2] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 3] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 0] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 1] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 2] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 3] "
            },
        darkoak_standing_sign ={
         "[\"ground_sign_direction\" : 0] ",
         "[\"ground_sign_direction\" : 1] ",
         "[\"ground_sign_direction\" : 2] ",
         "[\"ground_sign_direction\" : 3] ",
         "[\"ground_sign_direction\" : 4] ",
         "[\"ground_sign_direction\" : 5] ",
         "[\"ground_sign_direction\" : 6] ",
         "[\"ground_sign_direction\" : 7] ",
         "[\"ground_sign_direction\" : 8] ",
         "[\"ground_sign_direction\" : 9] ",
         "[\"ground_sign_direction\" : 10] ",
         "[\"ground_sign_direction\" : 11] ",
         "[\"ground_sign_direction\" : 12] ",
         "[\"ground_sign_direction\" : 13] ",
         "[\"ground_sign_direction\" : 14] ",
         "[\"ground_sign_direction\" : 15] "
            },
        darkoak_wall_sign ={
         "[\"facing_direction\" : 0] ",
         "[\"facing_direction\" : 1] ",
         "[\"facing_direction\" : 2] ",
         "[\"facing_direction\" : 3] ",
         "[\"facing_direction\" : 4] ",
         "[\"facing_direction\" : 5] ",
         "[\"facing_direction\" : 6] ",
         "[\"facing_direction\" : 7] "
            },
        daylight_detector ={
         "[\"redstone_signal\" : 0] ",
         "[\"redstone_signal\" : 1] ",
         "[\"redstone_signal\" : 2] ",
         "[\"redstone_signal\" : 3] ",
         "[\"redstone_signal\" : 4] ",
         "[\"redstone_signal\" : 5] ",
         "[\"redstone_signal\" : 6] ",
         "[\"redstone_signal\" : 7] ",
         "[\"redstone_signal\" : 8] ",
         "[\"redstone_signal\" : 9] ",
         "[\"redstone_signal\" : 10] ",
         "[\"redstone_signal\" : 11] ",
         "[\"redstone_signal\" : 12] ",
         "[\"redstone_signal\" : 13] ",
         "[\"redstone_signal\" : 14] ",
         "[\"redstone_signal\" : 15] "
            },
        daylight_detector_inverted ={
         "[\"redstone_signal\" : 0] ",
         "[\"redstone_signal\" : 1] ",
         "[\"redstone_signal\" : 2] ",
         "[\"redstone_signal\" : 3] ",
         "[\"redstone_signal\" : 4] ",
         "[\"redstone_signal\" : 5] ",
         "[\"redstone_signal\" : 6] ",
         "[\"redstone_signal\" : 7] ",
         "[\"redstone_signal\" : 8] ",
         "[\"redstone_signal\" : 9] ",
         "[\"redstone_signal\" : 10] ",
         "[\"redstone_signal\" : 11] ",
         "[\"redstone_signal\" : 12] ",
         "[\"redstone_signal\" : 13] ",
         "[\"redstone_signal\" : 14] ",
         "[\"redstone_signal\" : 15] "
            },
        deepslate_brick_slab ={
         "[\"top_slot_bit\" : false] ",
         "[\"top_slot_bit\" : true] "
            },
        deepslate_tile_slab ={
         "[\"top_slot_bit\" : false] ",
         "[\"top_slot_bit\" : true] "
            },
        detector_rail ={
         "[\"rail_data_bit\" : false, \"rail_direction\" : 0] ",
         "[\"rail_data_bit\" : false, \"rail_direction\" : 1] ",
         "[\"rail_data_bit\" : false, \"rail_direction\" : 2] ",
         "[\"rail_data_bit\" : false, \"rail_direction\" : 3] ",
         "[\"rail_data_bit\" : false, \"rail_direction\" : 4] ",
         "[\"rail_data_bit\" : false, \"rail_direction\" : 5] ",
         "[\"rail_data_bit\" : false, \"rail_direction\" : 6] ",
         "[\"rail_data_bit\" : false, \"rail_direction\" : 7] ",
         "[\"rail_data_bit\" : true, \"rail_direction\" : 0] ",
         "[\"rail_data_bit\" : true, \"rail_direction\" : 1] ",
         "[\"rail_data_bit\" : true, \"rail_direction\" : 2] ",
         "[\"rail_data_bit\" : true, \"rail_direction\" : 3] ",
         "[\"rail_data_bit\" : true, \"rail_direction\" : 4] ",
         "[\"rail_data_bit\" : true, \"rail_direction\" : 5] ",
         "[\"rail_data_bit\" : true, \"rail_direction\" : 6] ",
         "[\"rail_data_bit\" : true, \"rail_direction\" : 7] "
            },
        diorite_stairs ={
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 0] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 1] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 2] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 3] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 0] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 1] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 2] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 3] "
            },
        dirt ={
         "[\"dirt_type\" : \"normal\"] ",
         "[\"dirt_type\" : \"coarse\"] "
            },
        dispenser ={
         "[\"facing_direction\" : 0, \"triggered_bit\" : false] ",
         "[\"facing_direction\" : 1, \"triggered_bit\" : false] ",
         "[\"facing_direction\" : 2, \"triggered_bit\" : false] ",
         "[\"facing_direction\" : 3, \"triggered_bit\" : false] ",
         "[\"facing_direction\" : 4, \"triggered_bit\" : false] ",
         "[\"facing_direction\" : 5, \"triggered_bit\" : false] ",
         "[\"facing_direction\" : 6, \"triggered_bit\" : false] ",
         "[\"facing_direction\" : 7, \"triggered_bit\" : false] ",
         "[\"facing_direction\" : 0, \"triggered_bit\" : true] ",
         "[\"facing_direction\" : 1, \"triggered_bit\" : true] ",
         "[\"facing_direction\" : 2, \"triggered_bit\" : true] ",
         "[\"facing_direction\" : 3, \"triggered_bit\" : true] ",
         "[\"facing_direction\" : 4, \"triggered_bit\" : true] ",
         "[\"facing_direction\" : 5, \"triggered_bit\" : true] ",
         "[\"facing_direction\" : 6, \"triggered_bit\" : true] ",
         "[\"facing_direction\" : 7, \"triggered_bit\" : true] "
            },
        double_plant ={
         "[\"double_plant_type\" : \"sunflower\", \"upper_block_bit\" : false] ",
         "[\"double_plant_type\" : \"syringa\", \"upper_block_bit\" : false] ",
         "[\"double_plant_type\" : \"grass\", \"upper_block_bit\" : false] ",
         "[\"double_plant_type\" : \"fern\", \"upper_block_bit\" : false] ",
         "[\"double_plant_type\" : \"rose\", \"upper_block_bit\" : false] ",
         "[\"double_plant_type\" : \"paeonia\", \"upper_block_bit\" : false] ",
         "[\"double_plant_type\" : \"sunflower\", \"upper_block_bit\" : false] "
            },
        double_stone_block_slab ={
         "[\"stone_slab_type\" : \"smooth_stone\", \"top_slot_bit\" : false] ",
         "[\"stone_slab_type\" : \"sandstone\", \"top_slot_bit\" : false] ",
         "[\"stone_slab_type\" : \"wood\", \"top_slot_bit\" : false] ",
         "[\"stone_slab_type\" : \"cobblestone\", \"top_slot_bit\" : false] ",
         "[\"stone_slab_type\" : \"brick\", \"top_slot_bit\" : false] ",
         "[\"stone_slab_type\" : \"stone_brick\", \"top_slot_bit\" : false] ",
         "[\"stone_slab_type\" : \"quartz\", \"top_slot_bit\" : false] ",
         "[\"stone_slab_type\" : \"nether_brick\", \"top_slot_bit\" : false] ",
         "[\"stone_slab_type\" : \"smooth_stone\", \"top_slot_bit\" : true] ",
         "[\"stone_slab_type\" : \"sandstone\", \"top_slot_bit\" : true] ",
         "[\"stone_slab_type\" : \"wood\", \"top_slot_bit\" : true] ",
         "[\"stone_slab_type\" : \"cobblestone\", \"top_slot_bit\" : true] ",
         "[\"stone_slab_type\" : \"brick\", \"top_slot_bit\" : true] ",
         "[\"stone_slab_type\" : \"stone_brick\", \"top_slot_bit\" : true] ",
         "[\"stone_slab_type\" : \"quartz\", \"top_slot_bit\" : true] ",
         "[\"stone_slab_type\" : \"nether_brick\", \"top_slot_bit\" : true] "
            },
        double_stone_block_slab2 ={
         "[\"stone_slab_type_2\" : \"red_sandstone\", \"top_slot_bit\" : false] ",
         "[\"stone_slab_type_2\" : \"purpur\", \"top_slot_bit\" : false] ",
         "[\"stone_slab_type_2\" : \"prismarine_rough\", \"top_slot_bit\" : false] ",
         "[\"stone_slab_type_2\" : \"prismarine_dark\", \"top_slot_bit\" : false] ",
         "[\"stone_slab_type_2\" : \"prismarine_brick\", \"top_slot_bit\" : false] ",
         "[\"stone_slab_type_2\" : \"mossy_cobblestone\", \"top_slot_bit\" : false] ",
         "[\"stone_slab_type_2\" : \"smooth_sandstone\", \"top_slot_bit\" : false] ",
         "[\"stone_slab_type_2\" : \"red_nether_brick\", \"top_slot_bit\" : false] ",
         "[\"stone_slab_type_2\" : \"red_sandstone\", \"top_slot_bit\" : true] ",
         "[\"stone_slab_type_2\" : \"purpur\", \"top_slot_bit\" : true] ",
         "[\"stone_slab_type_2\" : \"prismarine_rough\", \"top_slot_bit\" : true] ",
         "[\"stone_slab_type_2\" : \"prismarine_dark\", \"top_slot_bit\" : true] ",
         "[\"stone_slab_type_2\" : \"prismarine_brick\", \"top_slot_bit\" : true] ",
         "[\"stone_slab_type_2\" : \"mossy_cobblestone\", \"top_slot_bit\" : true] ",
         "[\"stone_slab_type_2\" : \"smooth_sandstone\", \"top_slot_bit\" : true] ",
         "[\"stone_slab_type_2\" : \"red_nether_brick\", \"top_slot_bit\" : true] "
            },
        double_stone_block_slab3 ={
         "[\"stone_slab_type_3\" : \"end_stone_brick\", \"top_slot_bit\" : false] ",
         "[\"stone_slab_type_3\" : \"smooth_red_sandstone\", \"top_slot_bit\" : false] ",
         "[\"stone_slab_type_3\" : \"polished_andesite\", \"top_slot_bit\" : false] ",
         "[\"stone_slab_type_3\" : \"andesite\", \"top_slot_bit\" : false] ",
         "[\"stone_slab_type_3\" : \"diorite\", \"top_slot_bit\" : false] ",
         "[\"stone_slab_type_3\" : \"polished_diorite\", \"top_slot_bit\" : false] ",
         "[\"stone_slab_type_3\" : \"granite\", \"top_slot_bit\" : false] ",
         "[\"stone_slab_type_3\" : \"polished_granite\", \"top_slot_bit\" : false] ",
         "[\"stone_slab_type_3\" : \"end_stone_brick\", \"top_slot_bit\" : true] ",
         "[\"stone_slab_type_3\" : \"smooth_red_sandstone\", \"top_slot_bit\" : true] ",
         "[\"stone_slab_type_3\" : \"polished_andesite\", \"top_slot_bit\" : true] ",
         "[\"stone_slab_type_3\" : \"andesite\", \"top_slot_bit\" : true] ",
         "[\"stone_slab_type_3\" : \"diorite\", \"top_slot_bit\" : true] ",
         "[\"stone_slab_type_3\" : \"polished_diorite\", \"top_slot_bit\" : true] ",
         "[\"stone_slab_type_3\" : \"granite\", \"top_slot_bit\" : true] ",
         "[\"stone_slab_type_3\" : \"polished_granite\", \"top_slot_bit\" : true] "
            },
        double_stone_block_slab4 ={
         "[\"stone_slab_type_4\" : \"mossy_stone_brick\", \"top_slot_bit\" : false] ",
         "[\"stone_slab_type_4\" : \"smooth_quartz\", \"top_slot_bit\" : false] ",
         "[\"stone_slab_type_4\" : \"stone\", \"top_slot_bit\" : false] ",
         "[\"stone_slab_type_4\" : \"cut_sandstone\", \"top_slot_bit\" : false] ",
         "[\"stone_slab_type_4\" : \"cut_red_sandstone\", \"top_slot_bit\" : false] ",
         "[\"stone_slab_type_4\" : \"mossy_stone_brick\", \"top_slot_bit\" : false] "
            },
        double_wooden_slab ={
         "[\"top_slot_bit\" : false, \"wood_type\" : \"oak\"] ",
         "[\"top_slot_bit\" : false, \"wood_type\" : \"spruce\"] ",
         "[\"top_slot_bit\" : false, \"wood_type\" : \"birch\"] ",
         "[\"top_slot_bit\" : false, \"wood_type\" : \"jungle\"] ",
         "[\"top_slot_bit\" : false, \"wood_type\" : \"acacia\"] ",
         "[\"top_slot_bit\" : false, \"wood_type\" : \"dark_oak\"] ",
         "[\"top_slot_bit\" : false, \"wood_type\" : \"oak\"] "
            },
        dropper ={
         "[\"facing_direction\" : 0, \"triggered_bit\" : false] ",
         "[\"facing_direction\" : 1, \"triggered_bit\" : false] ",
         "[\"facing_direction\" : 2, \"triggered_bit\" : false] ",
         "[\"facing_direction\" : 3, \"triggered_bit\" : false] ",
         "[\"facing_direction\" : 4, \"triggered_bit\" : false] ",
         "[\"facing_direction\" : 5, \"triggered_bit\" : false] ",
         "[\"facing_direction\" : 6, \"triggered_bit\" : false] ",
         "[\"facing_direction\" : 7, \"triggered_bit\" : false] ",
         "[\"facing_direction\" : 0, \"triggered_bit\" : true] ",
         "[\"facing_direction\" : 1, \"triggered_bit\" : true] ",
         "[\"facing_direction\" : 2, \"triggered_bit\" : true] ",
         "[\"facing_direction\" : 3, \"triggered_bit\" : true] ",
         "[\"facing_direction\" : 4, \"triggered_bit\" : true] ",
         "[\"facing_direction\" : 5, \"triggered_bit\" : true] ",
         "[\"facing_direction\" : 6, \"triggered_bit\" : true] ",
         "[\"facing_direction\" : 7, \"triggered_bit\" : true] "
            },
        end_brick_stairs ={
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 0] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 1] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 2] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 3] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 0] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 1] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 2] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 3] "
            },
        end_portal_frame ={
         "[\"direction\" : 0, \"end_portal_eye_bit\" : false] ",
         "[\"direction\" : 1, \"end_portal_eye_bit\" : false] ",
         "[\"direction\" : 2, \"end_portal_eye_bit\" : false] ",
         "[\"direction\" : 3, \"end_portal_eye_bit\" : false] ",
         "[\"direction\" : 0, \"end_portal_eye_bit\" : true] ",
         "[\"direction\" : 1, \"end_portal_eye_bit\" : true] ",
         "[\"direction\" : 2, \"end_portal_eye_bit\" : true] ",
         "[\"direction\" : 3, \"end_portal_eye_bit\" : true] "
            },
        end_rod ={
         "[\"facing_direction\" : 0] ",
         "[\"facing_direction\" : 1] ",
         "[\"facing_direction\" : 2] ",
         "[\"facing_direction\" : 3] ",
         "[\"facing_direction\" : 4] ",
         "[\"facing_direction\" : 5] ",
         "[\"facing_direction\" : 6] ",
         "[\"facing_direction\" : 7] "
            },
        ender_chest ={
         "[\"facing_direction\" : 0] ",
         "[\"facing_direction\" : 1] ",
         "[\"facing_direction\" : 2] ",
         "[\"facing_direction\" : 3] ",
         "[\"facing_direction\" : 4] ",
         "[\"facing_direction\" : 5] ",
         "[\"facing_direction\" : 6] ",
         "[\"facing_direction\" : 7] "
            },
        exposed_cut_copper_slab ={
         "[\"top_slot_bit\" : false] ",
         "[\"top_slot_bit\" : true] "
            },
        farmland ={
         "[\"moisturized_amount\" : 0] ",
         "[\"moisturized_amount\" : 1] ",
         "[\"moisturized_amount\" : 2] ",
         "[\"moisturized_amount\" : 3] ",
         "[\"moisturized_amount\" : 4] ",
         "[\"moisturized_amount\" : 5] ",
         "[\"moisturized_amount\" : 6] ",
         "[\"moisturized_amount\" : 7] "
            },
        fence ={
         "[\"wood_type\" : \"oak\"] ",
         "[\"wood_type\" : \"spruce\"] ",
         "[\"wood_type\" : \"birch\"] ",
         "[\"wood_type\" : \"jungle\"] ",
         "[\"wood_type\" : \"acacia\"] ",
         "[\"wood_type\" : \"dark_oak\"] ",
         "[\"wood_type\" : \"oak\"] "
            },
        fence_gate ={
         "[\"direction\" : 0, \"in_wall_bit\" : false, \"open_bit\" : false] ",
         "[\"direction\" : 1, \"in_wall_bit\" : false, \"open_bit\" : false] ",
         "[\"direction\" : 2, \"in_wall_bit\" : false, \"open_bit\" : false] ",
         "[\"direction\" : 3, \"in_wall_bit\" : false, \"open_bit\" : false] ",
         "[\"direction\" : 0, \"in_wall_bit\" : false, \"open_bit\" : true] ",
         "[\"direction\" : 1, \"in_wall_bit\" : false, \"open_bit\" : true] ",
         "[\"direction\" : 2, \"in_wall_bit\" : false, \"open_bit\" : true] ",
         "[\"direction\" : 3, \"in_wall_bit\" : false, \"open_bit\" : true] ",
         "[\"direction\" : 0, \"in_wall_bit\" : true, \"open_bit\" : false] ",
         "[\"direction\" : 1, \"in_wall_bit\" : true, \"open_bit\" : false] ",
         "[\"direction\" : 2, \"in_wall_bit\" : true, \"open_bit\" : false] ",
         "[\"direction\" : 3, \"in_wall_bit\" : true, \"open_bit\" : false] ",
         "[\"direction\" : 0, \"in_wall_bit\" : true, \"open_bit\" : true] ",
         "[\"direction\" : 1, \"in_wall_bit\" : true, \"open_bit\" : true] ",
         "[\"direction\" : 2, \"in_wall_bit\" : true, \"open_bit\" : true] ",
         "[\"direction\" : 3, \"in_wall_bit\" : true, \"open_bit\" : true] "
            },
        fire ={
         "[\"age\" : 0] ",
         "[\"age\" : 1] ",
         "[\"age\" : 2] ",
         "[\"age\" : 3] ",
         "[\"age\" : 4] ",
         "[\"age\" : 5] ",
         "[\"age\" : 6] ",
         "[\"age\" : 7] ",
         "[\"age\" : 8] ",
         "[\"age\" : 9] ",
         "[\"age\" : 10] ",
         "[\"age\" : 11] ",
         "[\"age\" : 12] ",
         "[\"age\" : 13] ",
         "[\"age\" : 14] ",
         "[\"age\" : 15] "
            },
        flower_pot ={
         "[\"update_bit\" : false] ",
         "[\"update_bit\" : true] "
            },
        flowing_lava ={
         "[\"liquid_depth\" : 0] ",
         "[\"liquid_depth\" : 1] ",
         "[\"liquid_depth\" : 2] ",
         "[\"liquid_depth\" : 3] ",
         "[\"liquid_depth\" : 4] ",
         "[\"liquid_depth\" : 5] ",
         "[\"liquid_depth\" : 6] ",
         "[\"liquid_depth\" : 7] ",
         "[\"liquid_depth\" : 8] ",
         "[\"liquid_depth\" : 9] ",
         "[\"liquid_depth\" : 10] ",
         "[\"liquid_depth\" : 11] ",
         "[\"liquid_depth\" : 12] ",
         "[\"liquid_depth\" : 13] ",
         "[\"liquid_depth\" : 14] ",
         "[\"liquid_depth\" : 15] "
            },
        flowing_water ={
         "[\"liquid_depth\" : 0] ",
         "[\"liquid_depth\" : 1] ",
         "[\"liquid_depth\" : 2] ",
         "[\"liquid_depth\" : 3] ",
         "[\"liquid_depth\" : 4] ",
         "[\"liquid_depth\" : 5] ",
         "[\"liquid_depth\" : 6] ",
         "[\"liquid_depth\" : 7] ",
         "[\"liquid_depth\" : 8] ",
         "[\"liquid_depth\" : 9] ",
         "[\"liquid_depth\" : 10] ",
         "[\"liquid_depth\" : 11] ",
         "[\"liquid_depth\" : 12] ",
         "[\"liquid_depth\" : 13] ",
         "[\"liquid_depth\" : 14] ",
         "[\"liquid_depth\" : 15] "
            },
        frame ={
         "[\"item_frame_map_bit\" : false, \"weirdo_direction\" : 0] ",
         "[\"item_frame_map_bit\" : false, \"weirdo_direction\" : 1] ",
         "[\"item_frame_map_bit\" : false, \"weirdo_direction\" : 2] ",
         "[\"item_frame_map_bit\" : false, \"weirdo_direction\" : 3] ",
         "[\"item_frame_map_bit\" : true, \"weirdo_direction\" : 0] ",
         "[\"item_frame_map_bit\" : true, \"weirdo_direction\" : 1] ",
         "[\"item_frame_map_bit\" : true, \"weirdo_direction\" : 2] ",
         "[\"item_frame_map_bit\" : true, \"weirdo_direction\" : 3] "
            },
        frosted_ice ={
         "[\"age\" : 0] ",
         "[\"age\" : 1] ",
         "[\"age\" : 2] ",
         "[\"age\" : 3] "
            },
        furnace ={
         "[\"facing_direction\" : 0] ",
         "[\"facing_direction\" : 1] ",
         "[\"facing_direction\" : 2] ",
         "[\"facing_direction\" : 3] ",
         "[\"facing_direction\" : 4] ",
         "[\"facing_direction\" : 5] ",
         "[\"facing_direction\" : 6] ",
         "[\"facing_direction\" : 7] "
            },
        glow_lichen ={
         "[\"multi_face_direction_bits\" : 0] ",
         "[\"multi_face_direction_bits\" : 1] ",
         "[\"multi_face_direction_bits\" : 2] ",
         "[\"multi_face_direction_bits\" : 3] ",
         "[\"multi_face_direction_bits\" : 4] ",
         "[\"multi_face_direction_bits\" : 5] ",
         "[\"multi_face_direction_bits\" : 6] ",
         "[\"multi_face_direction_bits\" : 7] ",
         "[\"multi_face_direction_bits\" : 8] ",
         "[\"multi_face_direction_bits\" : 9] ",
         "[\"multi_face_direction_bits\" : 10] ",
         "[\"multi_face_direction_bits\" : 11] ",
         "[\"multi_face_direction_bits\" : 12] ",
         "[\"multi_face_direction_bits\" : 13] ",
         "[\"multi_face_direction_bits\" : 14] ",
         "[\"multi_face_direction_bits\" : 15] ",
         "[\"multi_face_direction_bits\" : 16] ",
         "[\"multi_face_direction_bits\" : 17] ",
         "[\"multi_face_direction_bits\" : 18] ",
         "[\"multi_face_direction_bits\" : 19] ",
         "[\"multi_face_direction_bits\" : 20] ",
         "[\"multi_face_direction_bits\" : 21] ",
         "[\"multi_face_direction_bits\" : 22] ",
         "[\"multi_face_direction_bits\" : 23] ",
         "[\"multi_face_direction_bits\" : 24] ",
         "[\"multi_face_direction_bits\" : 25] ",
         "[\"multi_face_direction_bits\" : 26] ",
         "[\"multi_face_direction_bits\" : 27] ",
         "[\"multi_face_direction_bits\" : 28] ",
         "[\"multi_face_direction_bits\" : 29] ",
         "[\"multi_face_direction_bits\" : 30] ",
         "[\"multi_face_direction_bits\" : 31] ",
         "[\"multi_face_direction_bits\" : 32] ",
         "[\"multi_face_direction_bits\" : 33] ",
         "[\"multi_face_direction_bits\" : 34] ",
         "[\"multi_face_direction_bits\" : 35] ",
         "[\"multi_face_direction_bits\" : 36] ",
         "[\"multi_face_direction_bits\" : 37] ",
         "[\"multi_face_direction_bits\" : 38] ",
         "[\"multi_face_direction_bits\" : 39] ",
         "[\"multi_face_direction_bits\" : 40] ",
         "[\"multi_face_direction_bits\" : 41] ",
         "[\"multi_face_direction_bits\" : 42] ",
         "[\"multi_face_direction_bits\" : 43] ",
         "[\"multi_face_direction_bits\" : 44] ",
         "[\"multi_face_direction_bits\" : 45] ",
         "[\"multi_face_direction_bits\" : 46] ",
         "[\"multi_face_direction_bits\" : 47] ",
         "[\"multi_face_direction_bits\" : 48] ",
         "[\"multi_face_direction_bits\" : 49] ",
         "[\"multi_face_direction_bits\" : 50] ",
         "[\"multi_face_direction_bits\" : 51] ",
         "[\"multi_face_direction_bits\" : 52] ",
         "[\"multi_face_direction_bits\" : 53] ",
         "[\"multi_face_direction_bits\" : 54] ",
         "[\"multi_face_direction_bits\" : 55] ",
         "[\"multi_face_direction_bits\" : 56] ",
         "[\"multi_face_direction_bits\" : 57] ",
         "[\"multi_face_direction_bits\" : 58] ",
         "[\"multi_face_direction_bits\" : 59] ",
         "[\"multi_face_direction_bits\" : 60] ",
         "[\"multi_face_direction_bits\" : 61] ",
         "[\"multi_face_direction_bits\" : 62] ",
         "[\"multi_face_direction_bits\" : 63] "
            },
        golden_rail ={
         "[\"rail_data_bit\" : false, \"rail_direction\" : 0] ",
         "[\"rail_data_bit\" : false, \"rail_direction\" : 1] ",
         "[\"rail_data_bit\" : false, \"rail_direction\" : 2] ",
         "[\"rail_data_bit\" : false, \"rail_direction\" : 3] ",
         "[\"rail_data_bit\" : false, \"rail_direction\" : 4] ",
         "[\"rail_data_bit\" : false, \"rail_direction\" : 5] ",
         "[\"rail_data_bit\" : false, \"rail_direction\" : 6] ",
         "[\"rail_data_bit\" : false, \"rail_direction\" : 7] ",
         "[\"rail_data_bit\" : true, \"rail_direction\" : 0] ",
         "[\"rail_data_bit\" : true, \"rail_direction\" : 1] ",
         "[\"rail_data_bit\" : true, \"rail_direction\" : 2] ",
         "[\"rail_data_bit\" : true, \"rail_direction\" : 3] ",
         "[\"rail_data_bit\" : true, \"rail_direction\" : 4] ",
         "[\"rail_data_bit\" : true, \"rail_direction\" : 5] ",
         "[\"rail_data_bit\" : true, \"rail_direction\" : 6] ",
         "[\"rail_data_bit\" : true, \"rail_direction\" : 7] "
            },
        granite_stairs ={
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 0] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 1] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 2] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 3] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 0] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 1] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 2] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 3] "
            },
        gray_candle ={
         "[\"candles\" : 0, \"lit\" : false] ",
         "[\"candles\" : 1, \"lit\" : false] ",
         "[\"candles\" : 2, \"lit\" : false] ",
         "[\"candles\" : 3, \"lit\" : false] ",
         "[\"candles\" : 0, \"lit\" : true] ",
         "[\"candles\" : 1, \"lit\" : true] ",
         "[\"candles\" : 2, \"lit\" : true] ",
         "[\"candles\" : 3, \"lit\" : true] "
            },
        gray_candle_cake ={
         "[\"lit\" : false] ",
         "[\"lit\" : true] "
            },
        gray_glazed_terracotta ={
         "[\"facing_direction\" : 0] ",
         "[\"facing_direction\" : 1] ",
         "[\"facing_direction\" : 2] ",
         "[\"facing_direction\" : 3] ",
         "[\"facing_direction\" : 4] ",
         "[\"facing_direction\" : 5] ",
         "[\"facing_direction\" : 6] ",
         "[\"facing_direction\" : 7] "
            },
        green_candle ={
         "[\"candles\" : 0, \"lit\" : false] ",
         "[\"candles\" : 1, \"lit\" : false] ",
         "[\"candles\" : 2, \"lit\" : false] ",
         "[\"candles\" : 3, \"lit\" : false] ",
         "[\"candles\" : 0, \"lit\" : true] ",
         "[\"candles\" : 1, \"lit\" : true] ",
         "[\"candles\" : 2, \"lit\" : true] ",
         "[\"candles\" : 3, \"lit\" : true] "
            },
        green_candle_cake ={
         "[\"lit\" : false] ",
         "[\"lit\" : true] "
            },
        green_glazed_terracotta ={
         "[\"facing_direction\" : 0] ",
         "[\"facing_direction\" : 1] ",
         "[\"facing_direction\" : 2] ",
         "[\"facing_direction\" : 3] ",
         "[\"facing_direction\" : 4] ",
         "[\"facing_direction\" : 5] ",
         "[\"facing_direction\" : 6] ",
         "[\"facing_direction\" : 7] "
            },
        grindstone ={
         "[\"attachment\" : \"standing\", \"direction\" : 0] ",
         "[\"attachment\" : \"standing\", \"direction\" : 1] ",
         "[\"attachment\" : \"standing\", \"direction\" : 2] ",
         "[\"attachment\" : \"standing\", \"direction\" : 3] ",
         "[\"attachment\" : \"hanging\", \"direction\" : 0] ",
         "[\"attachment\" : \"hanging\", \"direction\" : 1] ",
         "[\"attachment\" : \"hanging\", \"direction\" : 2] ",
         "[\"attachment\" : \"hanging\", \"direction\" : 3] ",
         "[\"attachment\" : \"side\", \"direction\" : 0] ",
         "[\"attachment\" : \"side\", \"direction\" : 1] ",
         "[\"attachment\" : \"side\", \"direction\" : 2] ",
         "[\"attachment\" : \"side\", \"direction\" : 3] ",
         "[\"attachment\" : \"multiple\", \"direction\" : 0] ",
         "[\"attachment\" : \"multiple\", \"direction\" : 1] ",
         "[\"attachment\" : \"multiple\", \"direction\" : 2] ",
         "[\"attachment\" : \"multiple\", \"direction\" : 3] "
            },
        hard_stained_glass ={
         "[\"color\" : \"white\"] ",
         "[\"color\" : \"orange\"] ",
         "[\"color\" : \"magenta\"] ",
         "[\"color\" : \"light_blue\"] ",
         "[\"color\" : \"yellow\"] ",
         "[\"color\" : \"lime\"] ",
         "[\"color\" : \"pink\"] ",
         "[\"color\" : \"gray\"] ",
         "[\"color\" : \"silver\"] ",
         "[\"color\" : \"cyan\"] ",
         "[\"color\" : \"purple\"] ",
         "[\"color\" : \"blue\"] ",
         "[\"color\" : \"brown\"] ",
         "[\"color\" : \"green\"] ",
         "[\"color\" : \"red\"] ",
         "[\"color\" : \"black\"] "
            },
        hard_stained_glass_pane ={
         "[\"color\" : \"white\"] ",
         "[\"color\" : \"orange\"] ",
         "[\"color\" : \"magenta\"] ",
         "[\"color\" : \"light_blue\"] ",
         "[\"color\" : \"yellow\"] ",
         "[\"color\" : \"lime\"] ",
         "[\"color\" : \"pink\"] ",
         "[\"color\" : \"gray\"] ",
         "[\"color\" : \"silver\"] ",
         "[\"color\" : \"cyan\"] ",
         "[\"color\" : \"purple\"] ",
         "[\"color\" : \"blue\"] ",
         "[\"color\" : \"brown\"] ",
         "[\"color\" : \"green\"] ",
         "[\"color\" : \"red\"] ",
         "[\"color\" : \"black\"] "
            },
        hay_block ={
         "[\"deprecated\" : 0, \"direction\" : 0] ",
         "[\"deprecated\" : 1, \"direction\" : 0] ",
         "[\"deprecated\" : 2, \"direction\" : 0] ",
         "[\"deprecated\" : 3, \"direction\" : 0] ",
         "[\"deprecated\" : 0, \"direction\" : 1] ",
         "[\"deprecated\" : 1, \"direction\" : 1] ",
         "[\"deprecated\" : 2, \"direction\" : 1] ",
         "[\"deprecated\" : 3, \"direction\" : 1] ",
         "[\"deprecated\" : 0, \"direction\" : 2] ",
         "[\"deprecated\" : 1, \"direction\" : 2] ",
         "[\"deprecated\" : 2, \"direction\" : 2] ",
         "[\"deprecated\" : 3, \"direction\" : 2] ",
         "[\"deprecated\" : 0, \"direction\" : 3] ",
         "[\"deprecated\" : 1, \"direction\" : 3] ",
         "[\"deprecated\" : 2, \"direction\" : 3] ",
         "[\"deprecated\" : 3, \"direction\" : 3] "
            },
        heavy_weighted_pressure_plate ={
         "[\"redstone_signal\" : 0] ",
         "[\"redstone_signal\" : 1] ",
         "[\"redstone_signal\" : 2] ",
         "[\"redstone_signal\" : 3] ",
         "[\"redstone_signal\" : 4] ",
         "[\"redstone_signal\" : 5] ",
         "[\"redstone_signal\" : 6] ",
         "[\"redstone_signal\" : 7] ",
         "[\"redstone_signal\" : 8] ",
         "[\"redstone_signal\" : 9] ",
         "[\"redstone_signal\" : 10] ",
         "[\"redstone_signal\" : 11] ",
         "[\"redstone_signal\" : 12] ",
         "[\"redstone_signal\" : 13] ",
         "[\"redstone_signal\" : 14] ",
         "[\"redstone_signal\" : 15] "
            },
        hopper ={
         "[\"facing_direction\" : 0, \"toggle_bit\" : false] ",
         "[\"facing_direction\" : 1, \"toggle_bit\" : false] ",
         "[\"facing_direction\" : 2, \"toggle_bit\" : false] ",
         "[\"facing_direction\" : 3, \"toggle_bit\" : false] ",
         "[\"facing_direction\" : 4, \"toggle_bit\" : false] ",
         "[\"facing_direction\" : 5, \"toggle_bit\" : false] ",
         "[\"facing_direction\" : 6, \"toggle_bit\" : false] ",
         "[\"facing_direction\" : 7, \"toggle_bit\" : false] ",
         "[\"facing_direction\" : 0, \"toggle_bit\" : true] ",
         "[\"facing_direction\" : 1, \"toggle_bit\" : true] ",
         "[\"facing_direction\" : 2, \"toggle_bit\" : true] ",
         "[\"facing_direction\" : 3, \"toggle_bit\" : true] ",
         "[\"facing_direction\" : 4, \"toggle_bit\" : true] ",
         "[\"facing_direction\" : 5, \"toggle_bit\" : true] ",
         "[\"facing_direction\" : 6, \"toggle_bit\" : true] ",
         "[\"facing_direction\" : 7, \"toggle_bit\" : true] "
            },
        iron_door ={
         "[\"direction\" : 0, \"door_hinge_bit\" : false, \"open_bit\" : false, \"upper_block_bit\" : false] ",
         "[\"direction\" : 1, \"door_hinge_bit\" : true, \"open_bit\" : false, \"upper_block_bit\" : false] ",
         "[\"direction\" : 2, \"door_hinge_bit\" : false, \"open_bit\" : false, \"upper_block_bit\" : false] ",
         "[\"direction\" : 3, \"door_hinge_bit\" : true, \"open_bit\" : false, \"upper_block_bit\" : false] ",
         "[\"direction\" : 0, \"door_hinge_bit\" : false, \"open_bit\" : true, \"upper_block_bit\" : false] ",
         "[\"direction\" : 1, \"door_hinge_bit\" : true, \"open_bit\" : true, \"upper_block_bit\" : false] ",
         "[\"direction\" : 2, \"door_hinge_bit\" : false, \"open_bit\" : true, \"upper_block_bit\" : false] ",
         "[\"direction\" : 3, \"door_hinge_bit\" : true, \"open_bit\" : true, \"upper_block_bit\" : false] ",
         "[\"direction\" : 0, \"door_hinge_bit\" : false, \"open_bit\" : false, \"upper_block_bit\" : true] ",
         "[\"direction\" : 1, \"door_hinge_bit\" : true, \"open_bit\" : false, \"upper_block_bit\" : true] ",
         "[\"direction\" : 2, \"door_hinge_bit\" : false, \"open_bit\" : false, \"upper_block_bit\" : true] ",
         "[\"direction\" : 3, \"door_hinge_bit\" : true, \"open_bit\" : false, \"upper_block_bit\" : true] ",
         "[\"direction\" : 0, \"door_hinge_bit\" : false, \"open_bit\" : true, \"upper_block_bit\" : true] ",
         "[\"direction\" : 1, \"door_hinge_bit\" : true, \"open_bit\" : true, \"upper_block_bit\" : true] ",
         "[\"direction\" : 2, \"door_hinge_bit\" : false, \"open_bit\" : true, \"upper_block_bit\" : true] ",
         "[\"direction\" : 3, \"door_hinge_bit\" : true, \"open_bit\" : true, \"upper_block_bit\" : true] ",
         "[\"direction\" : 0, \"door_hinge_bit\" : false, \"open_bit\" : false, \"upper_block_bit\" : false] ",
         "[\"direction\" : 1, \"door_hinge_bit\" : true, \"open_bit\" : false, \"upper_block_bit\" : false] ",
         "[\"direction\" : 2, \"door_hinge_bit\" : false, \"open_bit\" : false, \"upper_block_bit\" : false] ",
         "[\"direction\" : 3, \"door_hinge_bit\" : true, \"open_bit\" : false, \"upper_block_bit\" : false] ",
         "[\"direction\" : 0, \"door_hinge_bit\" : false, \"open_bit\" : true, \"upper_block_bit\" : false] ",
         "[\"direction\" : 1, \"door_hinge_bit\" : true, \"open_bit\" : true, \"upper_block_bit\" : false] ",
         "[\"direction\" : 2, \"door_hinge_bit\" : false, \"open_bit\" : true, \"upper_block_bit\" : false] ",
         "[\"direction\" : 3, \"door_hinge_bit\" : true, \"open_bit\" : true, \"upper_block_bit\" : false] ",
         "[\"direction\" : 0, \"door_hinge_bit\" : false, \"open_bit\" : false, \"upper_block_bit\" : true] ",
         "[\"direction\" : 1, \"door_hinge_bit\" : true, \"open_bit\" : false, \"upper_block_bit\" : true] ",
         "[\"direction\" : 2, \"door_hinge_bit\" : false, \"open_bit\" : false, \"upper_block_bit\" : true] ",
         "[\"direction\" : 3, \"door_hinge_bit\" : true, \"open_bit\" : false, \"upper_block_bit\" : true] ",
         "[\"direction\" : 0, \"door_hinge_bit\" : false, \"open_bit\" : true, \"upper_block_bit\" : true] ",
         "[\"direction\" : 1, \"door_hinge_bit\" : true, \"open_bit\" : true, \"upper_block_bit\" : true] ",
         "[\"direction\" : 2, \"door_hinge_bit\" : false, \"open_bit\" : true, \"upper_block_bit\" : true] ",
         "[\"direction\" : 3, \"door_hinge_bit\" : true, \"open_bit\" : true, \"upper_block_bit\" : true] "
            },
        iron_trapdoor ={
         "[\"direction\" : 0, \"open_bit\" : false, \"upside_down_bit\" : false] ",
         "[\"direction\" : 1, \"open_bit\" : false, \"upside_down_bit\" : false] ",
         "[\"direction\" : 2, \"open_bit\" : false, \"upside_down_bit\" : false] ",
         "[\"direction\" : 3, \"open_bit\" : false, \"upside_down_bit\" : false] ",
         "[\"direction\" : 0, \"open_bit\" : false, \"upside_down_bit\" : true] ",
         "[\"direction\" : 1, \"open_bit\" : false, \"upside_down_bit\" : true] ",
         "[\"direction\" : 2, \"open_bit\" : false, \"upside_down_bit\" : true] ",
         "[\"direction\" : 3, \"open_bit\" : false, \"upside_down_bit\" : true] ",
         "[\"direction\" : 0, \"open_bit\" : true, \"upside_down_bit\" : false] ",
         "[\"direction\" : 1, \"open_bit\" : true, \"upside_down_bit\" : false] ",
         "[\"direction\" : 2, \"open_bit\" : true, \"upside_down_bit\" : false] ",
         "[\"direction\" : 3, \"open_bit\" : true, \"upside_down_bit\" : false] ",
         "[\"direction\" : 0, \"open_bit\" : true, \"upside_down_bit\" : true] ",
         "[\"direction\" : 1, \"open_bit\" : true, \"upside_down_bit\" : true] ",
         "[\"direction\" : 2, \"open_bit\" : true, \"upside_down_bit\" : true] ",
         "[\"direction\" : 3, \"open_bit\" : true, \"upside_down_bit\" : true] "
            },
        jigsaw ={
         "[\"facing_direction\" : 0, \"rotation\" : 0] ",
         "[\"facing_direction\" : 1, \"rotation\" : 0] ",
         "[\"facing_direction\" : 2, \"rotation\" : 0] ",
         "[\"facing_direction\" : 3, \"rotation\" : 0] ",
         "[\"facing_direction\" : 4, \"rotation\" : 0] ",
         "[\"facing_direction\" : 5, \"rotation\" : 0] ",
         "[\"facing_direction\" : 6, \"rotation\" : 0] ",
         "[\"facing_direction\" : 7, \"rotation\" : 0] ",
         "[\"facing_direction\" : 0, \"rotation\" : 1] ",
         "[\"facing_direction\" : 1, \"rotation\" : 1] ",
         "[\"facing_direction\" : 2, \"rotation\" : 1] ",
         "[\"facing_direction\" : 3, \"rotation\" : 1] ",
         "[\"facing_direction\" : 4, \"rotation\" : 1] ",
         "[\"facing_direction\" : 5, \"rotation\" : 1] ",
         "[\"facing_direction\" : 6, \"rotation\" : 1] ",
         "[\"facing_direction\" : 7, \"rotation\" : 1] ",
         "[\"facing_direction\" : 0, \"rotation\" : 2] ",
         "[\"facing_direction\" : 1, \"rotation\" : 2] ",
         "[\"facing_direction\" : 2, \"rotation\" : 2] ",
         "[\"facing_direction\" : 3, \"rotation\" : 2] ",
         "[\"facing_direction\" : 4, \"rotation\" : 2] ",
         "[\"facing_direction\" : 5, \"rotation\" : 2] ",
         "[\"facing_direction\" : 6, \"rotation\" : 2] ",
         "[\"facing_direction\" : 7, \"rotation\" : 2] ",
         "[\"facing_direction\" : 0, \"rotation\" : 3] ",
         "[\"facing_direction\" : 1, \"rotation\" : 3] ",
         "[\"facing_direction\" : 2, \"rotation\" : 3] ",
         "[\"facing_direction\" : 3, \"rotation\" : 3] ",
         "[\"facing_direction\" : 4, \"rotation\" : 3] ",
         "[\"facing_direction\" : 5, \"rotation\" : 3] ",
         "[\"facing_direction\" : 6, \"rotation\" : 3] ",
         "[\"facing_direction\" : 7, \"rotation\" : 3] "
            },
        jungle_button ={
         "[\"button_pressed_bit\" : false, \"facing_direction\" : 0] ",
         "[\"button_pressed_bit\" : false, \"facing_direction\" : 1] ",
         "[\"button_pressed_bit\" : false, \"facing_direction\" : 2] ",
         "[\"button_pressed_bit\" : false, \"facing_direction\" : 3] ",
         "[\"button_pressed_bit\" : false, \"facing_direction\" : 4] ",
         "[\"button_pressed_bit\" : false, \"facing_direction\" : 5] ",
         "[\"button_pressed_bit\" : false, \"facing_direction\" : 6] ",
         "[\"button_pressed_bit\" : false, \"facing_direction\" : 7] ",
         "[\"button_pressed_bit\" : true, \"facing_direction\" : 0] ",
         "[\"button_pressed_bit\" : true, \"facing_direction\" : 1] ",
         "[\"button_pressed_bit\" : true, \"facing_direction\" : 2] ",
         "[\"button_pressed_bit\" : true, \"facing_direction\" : 3] ",
         "[\"button_pressed_bit\" : true, \"facing_direction\" : 4] ",
         "[\"button_pressed_bit\" : true, \"facing_direction\" : 5] ",
         "[\"button_pressed_bit\" : true, \"facing_direction\" : 6] ",
         "[\"button_pressed_bit\" : true, \"facing_direction\" : 7] "
            },
        jungle_door ={
         "[\"direction\" : 0, \"door_hinge_bit\" : false, \"open_bit\" : false, \"upper_block_bit\" : false] ",
         "[\"direction\" : 1, \"door_hinge_bit\" : true, \"open_bit\" : false, \"upper_block_bit\" : false] ",
         "[\"direction\" : 2, \"door_hinge_bit\" : false, \"open_bit\" : false, \"upper_block_bit\" : false] ",
         "[\"direction\" : 3, \"door_hinge_bit\" : true, \"open_bit\" : false, \"upper_block_bit\" : false] ",
         "[\"direction\" : 0, \"door_hinge_bit\" : false, \"open_bit\" : true, \"upper_block_bit\" : false] ",
         "[\"direction\" : 1, \"door_hinge_bit\" : true, \"open_bit\" : true, \"upper_block_bit\" : false] ",
         "[\"direction\" : 2, \"door_hinge_bit\" : false, \"open_bit\" : true, \"upper_block_bit\" : false] ",
         "[\"direction\" : 3, \"door_hinge_bit\" : true, \"open_bit\" : true, \"upper_block_bit\" : false] ",
         "[\"direction\" : 0, \"door_hinge_bit\" : false, \"open_bit\" : false, \"upper_block_bit\" : true] ",
         "[\"direction\" : 1, \"door_hinge_bit\" : true, \"open_bit\" : false, \"upper_block_bit\" : true] ",
         "[\"direction\" : 2, \"door_hinge_bit\" : false, \"open_bit\" : false, \"upper_block_bit\" : true] ",
         "[\"direction\" : 3, \"door_hinge_bit\" : true, \"open_bit\" : false, \"upper_block_bit\" : true] ",
         "[\"direction\" : 0, \"door_hinge_bit\" : false, \"open_bit\" : true, \"upper_block_bit\" : true] ",
         "[\"direction\" : 1, \"door_hinge_bit\" : true, \"open_bit\" : true, \"upper_block_bit\" : true] ",
         "[\"direction\" : 2, \"door_hinge_bit\" : false, \"open_bit\" : true, \"upper_block_bit\" : true] ",
         "[\"direction\" : 3, \"door_hinge_bit\" : true, \"open_bit\" : true, \"upper_block_bit\" : true] ",
         "[\"direction\" : 0, \"door_hinge_bit\" : false, \"open_bit\" : false, \"upper_block_bit\" : false] ",
         "[\"direction\" : 1, \"door_hinge_bit\" : true, \"open_bit\" : false, \"upper_block_bit\" : false] ",
         "[\"direction\" : 2, \"door_hinge_bit\" : false, \"open_bit\" : false, \"upper_block_bit\" : false] ",
         "[\"direction\" : 3, \"door_hinge_bit\" : true, \"open_bit\" : false, \"upper_block_bit\" : false] ",
         "[\"direction\" : 0, \"door_hinge_bit\" : false, \"open_bit\" : true, \"upper_block_bit\" : false] ",
         "[\"direction\" : 1, \"door_hinge_bit\" : true, \"open_bit\" : true, \"upper_block_bit\" : false] ",
         "[\"direction\" : 2, \"door_hinge_bit\" : false, \"open_bit\" : true, \"upper_block_bit\" : false] ",
         "[\"direction\" : 3, \"door_hinge_bit\" : true, \"open_bit\" : true, \"upper_block_bit\" : false] ",
         "[\"direction\" : 0, \"door_hinge_bit\" : false, \"open_bit\" : false, \"upper_block_bit\" : true] ",
         "[\"direction\" : 1, \"door_hinge_bit\" : true, \"open_bit\" : false, \"upper_block_bit\" : true] ",
         "[\"direction\" : 2, \"door_hinge_bit\" : false, \"open_bit\" : false, \"upper_block_bit\" : true] ",
         "[\"direction\" : 3, \"door_hinge_bit\" : true, \"open_bit\" : false, \"upper_block_bit\" : true] ",
         "[\"direction\" : 0, \"door_hinge_bit\" : false, \"open_bit\" : true, \"upper_block_bit\" : true] ",
         "[\"direction\" : 1, \"door_hinge_bit\" : true, \"open_bit\" : true, \"upper_block_bit\" : true] ",
         "[\"direction\" : 2, \"door_hinge_bit\" : false, \"open_bit\" : true, \"upper_block_bit\" : true] ",
         "[\"direction\" : 3, \"door_hinge_bit\" : true, \"open_bit\" : true, \"upper_block_bit\" : true] "
            },
        jungle_fence_gate ={
         "[\"direction\" : 0, \"in_wall_bit\" : false, \"open_bit\" : false] ",
         "[\"direction\" : 1, \"in_wall_bit\" : false, \"open_bit\" : false] ",
         "[\"direction\" : 2, \"in_wall_bit\" : false, \"open_bit\" : false] ",
         "[\"direction\" : 3, \"in_wall_bit\" : false, \"open_bit\" : false] ",
         "[\"direction\" : 0, \"in_wall_bit\" : false, \"open_bit\" : true] ",
         "[\"direction\" : 1, \"in_wall_bit\" : false, \"open_bit\" : true] ",
         "[\"direction\" : 2, \"in_wall_bit\" : false, \"open_bit\" : true] ",
         "[\"direction\" : 3, \"in_wall_bit\" : false, \"open_bit\" : true] ",
         "[\"direction\" : 0, \"in_wall_bit\" : true, \"open_bit\" : false] ",
         "[\"direction\" : 1, \"in_wall_bit\" : true, \"open_bit\" : false] ",
         "[\"direction\" : 2, \"in_wall_bit\" : true, \"open_bit\" : false] ",
         "[\"direction\" : 3, \"in_wall_bit\" : true, \"open_bit\" : false] ",
         "[\"direction\" : 0, \"in_wall_bit\" : true, \"open_bit\" : true] ",
         "[\"direction\" : 1, \"in_wall_bit\" : true, \"open_bit\" : true] ",
         "[\"direction\" : 2, \"in_wall_bit\" : true, \"open_bit\" : true] ",
         "[\"direction\" : 3, \"in_wall_bit\" : true, \"open_bit\" : true] "
            },
        jungle_pressure_plate ={
         "[\"redstone_signal\" : 0] ",
         "[\"redstone_signal\" : 1] ",
         "[\"redstone_signal\" : 2] ",
         "[\"redstone_signal\" : 3] ",
         "[\"redstone_signal\" : 4] ",
         "[\"redstone_signal\" : 5] ",
         "[\"redstone_signal\" : 6] ",
         "[\"redstone_signal\" : 7] ",
         "[\"redstone_signal\" : 8] ",
         "[\"redstone_signal\" : 9] ",
         "[\"redstone_signal\" : 10] ",
         "[\"redstone_signal\" : 11] ",
         "[\"redstone_signal\" : 12] ",
         "[\"redstone_signal\" : 13] ",
         "[\"redstone_signal\" : 14] ",
         "[\"redstone_signal\" : 15] "
            },
        jungle_stairs ={
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 0] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 1] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 2] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 3] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 0] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 1] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 2] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 3] "
            },
        jungle_standing_sign ={
         "[\"ground_sign_direction\" : 0] ",
         "[\"ground_sign_direction\" : 1] ",
         "[\"ground_sign_direction\" : 2] ",
         "[\"ground_sign_direction\" : 3] ",
         "[\"ground_sign_direction\" : 4] ",
         "[\"ground_sign_direction\" : 5] ",
         "[\"ground_sign_direction\" : 6] ",
         "[\"ground_sign_direction\" : 7] ",
         "[\"ground_sign_direction\" : 8] ",
         "[\"ground_sign_direction\" : 9] ",
         "[\"ground_sign_direction\" : 10] ",
         "[\"ground_sign_direction\" : 11] ",
         "[\"ground_sign_direction\" : 12] ",
         "[\"ground_sign_direction\" : 13] ",
         "[\"ground_sign_direction\" : 14] ",
         "[\"ground_sign_direction\" : 15] "
            },
        jungle_trapdoor ={
         "[\"direction\" : 0, \"open_bit\" : false, \"upside_down_bit\" : false] ",
         "[\"direction\" : 1, \"open_bit\" : false, \"upside_down_bit\" : false] ",
         "[\"direction\" : 2, \"open_bit\" : false, \"upside_down_bit\" : false] ",
         "[\"direction\" : 3, \"open_bit\" : false, \"upside_down_bit\" : false] ",
         "[\"direction\" : 0, \"open_bit\" : false, \"upside_down_bit\" : true] ",
         "[\"direction\" : 1, \"open_bit\" : false, \"upside_down_bit\" : true] ",
         "[\"direction\" : 2, \"open_bit\" : false, \"upside_down_bit\" : true] ",
         "[\"direction\" : 3, \"open_bit\" : false, \"upside_down_bit\" : true] ",
         "[\"direction\" : 0, \"open_bit\" : true, \"upside_down_bit\" : false] ",
         "[\"direction\" : 1, \"open_bit\" : true, \"upside_down_bit\" : false] ",
         "[\"direction\" : 2, \"open_bit\" : true, \"upside_down_bit\" : false] ",
         "[\"direction\" : 3, \"open_bit\" : true, \"upside_down_bit\" : false] ",
         "[\"direction\" : 0, \"open_bit\" : true, \"upside_down_bit\" : true] ",
         "[\"direction\" : 1, \"open_bit\" : true, \"upside_down_bit\" : true] ",
         "[\"direction\" : 2, \"open_bit\" : true, \"upside_down_bit\" : true] ",
         "[\"direction\" : 3, \"open_bit\" : true, \"upside_down_bit\" : true] "
            },
        jungle_wall_sign ={
         "[\"facing_direction\" : 0] ",
         "[\"facing_direction\" : 1] ",
         "[\"facing_direction\" : 2] ",
         "[\"facing_direction\" : 3] ",
         "[\"facing_direction\" : 4] ",
         "[\"facing_direction\" : 5] ",
         "[\"facing_direction\" : 6] ",
         "[\"facing_direction\" : 7] "
            },
        kelp ={
         "[\"age\" : 0] ",
         "[\"age\" : 1] ",
         "[\"age\" : 2] ",
         "[\"age\" : 3] ",
         "[\"age\" : 4] ",
         "[\"age\" : 5] ",
         "[\"age\" : 6] ",
         "[\"age\" : 7] ",
         "[\"age\" : 8] ",
         "[\"age\" : 9] ",
         "[\"age\" : 10] ",
         "[\"age\" : 11] ",
         "[\"age\" : 12] ",
         "[\"age\" : 13] ",
         "[\"age\" : 14] ",
         "[\"age\" : 15] "
            },
        ladder ={
         "[\"facing_direction\" : 0] ",
         "[\"facing_direction\" : 1] ",
         "[\"facing_direction\" : 2] ",
         "[\"facing_direction\" : 3] ",
         "[\"facing_direction\" : 4] ",
         "[\"facing_direction\" : 5] ",
         "[\"facing_direction\" : 6] ",
         "[\"facing_direction\" : 7] "
            },
        lantern ={
         "[\"hanging\" : false] ",
         "[\"hanging\" : true] "
            },
        lava ={
         "[\"liquid_depth\" : 0] ",
         "[\"liquid_depth\" : 1] ",
         "[\"liquid_depth\" : 2] ",
         "[\"liquid_depth\" : 3] ",
         "[\"liquid_depth\" : 4] ",
         "[\"liquid_depth\" : 5] ",
         "[\"liquid_depth\" : 6] ",
         "[\"liquid_depth\" : 7] ",
         "[\"liquid_depth\" : 8] ",
         "[\"liquid_depth\" : 9] ",
         "[\"liquid_depth\" : 10] ",
         "[\"liquid_depth\" : 11] ",
         "[\"liquid_depth\" : 12] ",
         "[\"liquid_depth\" : 13] ",
         "[\"liquid_depth\" : 14] ",
         "[\"liquid_depth\" : 15] "
            },
        lava_cauldron ={
         "[\"cauldron_liquid\" : \"water\", \"fill_level\" : 0] ",
         "[\"cauldron_liquid\" : \"water\", \"fill_level\" : 1] ",
         "[\"cauldron_liquid\" : \"water\", \"fill_level\" : 2] ",
         "[\"cauldron_liquid\" : \"water\", \"fill_level\" : 3] ",
         "[\"cauldron_liquid\" : \"water\", \"fill_level\" : 4] ",
         "[\"cauldron_liquid\" : \"water\", \"fill_level\" : 5] ",
         "[\"cauldron_liquid\" : \"water\", \"fill_level\" : 6] ",
         "[\"cauldron_liquid\" : \"water\", \"fill_level\" : 7] ",
         "[\"cauldron_liquid\" : \"lava\", \"fill_level\" : 0] ",
         "[\"cauldron_liquid\" : \"lava\", \"fill_level\" : 1] ",
         "[\"cauldron_liquid\" : \"lava\", \"fill_level\" : 2] ",
         "[\"cauldron_liquid\" : \"lava\", \"fill_level\" : 3] ",
         "[\"cauldron_liquid\" : \"lava\", \"fill_level\" : 4] ",
         "[\"cauldron_liquid\" : \"lava\", \"fill_level\" : 5] ",
         "[\"cauldron_liquid\" : \"lava\", \"fill_level\" : 6] ",
         "[\"cauldron_liquid\" : \"lava\", \"fill_level\" : 7] "
            },
        leaves ={
         "[\"old_leaf_type\" : \"oak\", \"persistent_bit\" : false, \"update_bit\" : false] ",
         "[\"old_leaf_type\" : \"spruce\", \"persistent_bit\" : false, \"update_bit\" : false] ",
         "[\"old_leaf_type\" : \"birch\", \"persistent_bit\" : false, \"update_bit\" : false] ",
         "[\"old_leaf_type\" : \"jungle\", \"persistent_bit\" : false, \"update_bit\" : false] ",
         "[\"old_leaf_type\" : \"oak\", \"persistent_bit\" : false, \"update_bit\" : true] ",
         "[\"old_leaf_type\" : \"spruce\", \"persistent_bit\" : false, \"update_bit\" : true] ",
         "[\"old_leaf_type\" : \"birch\", \"persistent_bit\" : false, \"update_bit\" : true] ",
         "[\"old_leaf_type\" : \"jungle\", \"persistent_bit\" : false, \"update_bit\" : true] ",
         "[\"old_leaf_type\" : \"oak\", \"persistent_bit\" : true, \"update_bit\" : false] ",
         "[\"old_leaf_type\" : \"spruce\", \"persistent_bit\" : true, \"update_bit\" : false] ",
         "[\"old_leaf_type\" : \"birch\", \"persistent_bit\" : true, \"update_bit\" : false] ",
         "[\"old_leaf_type\" : \"jungle\", \"persistent_bit\" : true, \"update_bit\" : false] ",
         "[\"old_leaf_type\" : \"oak\", \"persistent_bit\" : true, \"update_bit\" : true] ",
         "[\"old_leaf_type\" : \"spruce\", \"persistent_bit\" : true, \"update_bit\" : true] ",
         "[\"old_leaf_type\" : \"birch\", \"persistent_bit\" : true, \"update_bit\" : true] ",
         "[\"old_leaf_type\" : \"jungle\", \"persistent_bit\" : true, \"update_bit\" : true] "
            },
        leaves2 ={
         "[\"new_leaf_type\" : \"acacia\", \"persistent_bit\" : false, \"update_bit\" : false] ",
         "[\"new_leaf_type\" : \"dark_oak\", \"persistent_bit\" : false, \"update_bit\" : false] ",
         "[\"new_leaf_type\" : \"acacia\", \"persistent_bit\" : false, \"update_bit\" : false] "
            },
        lectern ={
         "[\"direction\" : 0, \"powered_bit\" : false] ",
         "[\"direction\" : 1, \"powered_bit\" : false] ",
         "[\"direction\" : 2, \"powered_bit\" : false] ",
         "[\"direction\" : 3, \"powered_bit\" : false] ",
         "[\"direction\" : 0, \"powered_bit\" : true] ",
         "[\"direction\" : 1, \"powered_bit\" : true] ",
         "[\"direction\" : 2, \"powered_bit\" : true] ",
         "[\"direction\" : 3, \"powered_bit\" : true] "
            },
        lever ={
         "[\"lever_direction\" : \"down_east_west\", \"open_bit\" : false] ",
         "[\"lever_direction\" : \"east\", \"open_bit\" : false] ",
         "[\"lever_direction\" : \"west\", \"open_bit\" : false] ",
         "[\"lever_direction\" : \"south\", \"open_bit\" : false] ",
         "[\"lever_direction\" : \"north\", \"open_bit\" : false] ",
         "[\"lever_direction\" : \"up_north_south\", \"open_bit\" : false] ",
         "[\"lever_direction\" : \"up_east_west\", \"open_bit\" : false] ",
         "[\"lever_direction\" : \"down_north_south\", \"open_bit\" : false] ",
         "[\"lever_direction\" : \"down_east_west\", \"open_bit\" : true] ",
         "[\"lever_direction\" : \"east\", \"open_bit\" : true] ",
         "[\"lever_direction\" : \"west\", \"open_bit\" : true] ",
         "[\"lever_direction\" : \"south\", \"open_bit\" : true] ",
         "[\"lever_direction\" : \"north\", \"open_bit\" : true] ",
         "[\"lever_direction\" : \"up_north_south\", \"open_bit\" : true] ",
         "[\"lever_direction\" : \"up_east_west\", \"open_bit\" : true] ",
         "[\"lever_direction\" : \"down_north_south\", \"open_bit\" : true] "
            },
        light_block ={
         "[\"block_light_level\" : 0] ",
         "[\"block_light_level\" : 1] ",
         "[\"block_light_level\" : 2] ",
         "[\"block_light_level\" : 3] ",
         "[\"block_light_level\" : 4] ",
         "[\"block_light_level\" : 5] ",
         "[\"block_light_level\" : 6] ",
         "[\"block_light_level\" : 7] ",
         "[\"block_light_level\" : 8] ",
         "[\"block_light_level\" : 9] ",
         "[\"block_light_level\" : 10] ",
         "[\"block_light_level\" : 11] ",
         "[\"block_light_level\" : 12] ",
         "[\"block_light_level\" : 13] ",
         "[\"block_light_level\" : 14] ",
         "[\"block_light_level\" : 15] "
            },
        light_blue_candle ={
         "[\"candles\" : 0, \"lit\" : false] ",
         "[\"candles\" : 1, \"lit\" : false] ",
         "[\"candles\" : 2, \"lit\" : false] ",
         "[\"candles\" : 3, \"lit\" : false] ",
         "[\"candles\" : 0, \"lit\" : true] ",
         "[\"candles\" : 1, \"lit\" : true] ",
         "[\"candles\" : 2, \"lit\" : true] ",
         "[\"candles\" : 3, \"lit\" : true] "
            },
        light_blue_candle_cake ={
         "[\"lit\" : false] ",
         "[\"lit\" : true] "
            },
        light_blue_glazed_terracotta ={
         "[\"facing_direction\" : 0] ",
         "[\"facing_direction\" : 1] ",
         "[\"facing_direction\" : 2] ",
         "[\"facing_direction\" : 3] ",
         "[\"facing_direction\" : 4] ",
         "[\"facing_direction\" : 5] ",
         "[\"facing_direction\" : 6] ",
         "[\"facing_direction\" : 7] "
            },
        light_gray_candle ={
         "[\"candles\" : 0, \"lit\" : false] ",
         "[\"candles\" : 1, \"lit\" : false] ",
         "[\"candles\" : 2, \"lit\" : false] ",
         "[\"candles\" : 3, \"lit\" : false] ",
         "[\"candles\" : 0, \"lit\" : true] ",
         "[\"candles\" : 1, \"lit\" : true] ",
         "[\"candles\" : 2, \"lit\" : true] ",
         "[\"candles\" : 3, \"lit\" : true] "
            },
        light_gray_candle_cake ={
         "[\"lit\" : false] ",
         "[\"lit\" : true] "
            },
        light_weighted_pressure_plate ={
         "[\"redstone_signal\" : 0] ",
         "[\"redstone_signal\" : 1] ",
         "[\"redstone_signal\" : 2] ",
         "[\"redstone_signal\" : 3] ",
         "[\"redstone_signal\" : 4] ",
         "[\"redstone_signal\" : 5] ",
         "[\"redstone_signal\" : 6] ",
         "[\"redstone_signal\" : 7] ",
         "[\"redstone_signal\" : 8] ",
         "[\"redstone_signal\" : 9] ",
         "[\"redstone_signal\" : 10] ",
         "[\"redstone_signal\" : 11] ",
         "[\"redstone_signal\" : 12] ",
         "[\"redstone_signal\" : 13] ",
         "[\"redstone_signal\" : 14] ",
         "[\"redstone_signal\" : 15] "
            },
        lime_candle ={
         "[\"candles\" : 0, \"lit\" : false] ",
         "[\"candles\" : 1, \"lit\" : false] ",
         "[\"candles\" : 2, \"lit\" : false] ",
         "[\"candles\" : 3, \"lit\" : false] ",
         "[\"candles\" : 0, \"lit\" : true] ",
         "[\"candles\" : 1, \"lit\" : true] ",
         "[\"candles\" : 2, \"lit\" : true] ",
         "[\"candles\" : 3, \"lit\" : true] "
            },
        lime_candle_cake ={
         "[\"lit\" : false] ",
         "[\"lit\" : true] "
            },
        lime_glazed_terracotta ={
         "[\"facing_direction\" : 0] ",
         "[\"facing_direction\" : 1] ",
         "[\"facing_direction\" : 2] ",
         "[\"facing_direction\" : 3] ",
         "[\"facing_direction\" : 4] ",
         "[\"facing_direction\" : 5] ",
         "[\"facing_direction\" : 6] ",
         "[\"facing_direction\" : 7] "
            },
        lit_blast_furnace ={
         "[\"facing_direction\" : 0] ",
         "[\"facing_direction\" : 1] ",
         "[\"facing_direction\" : 2] ",
         "[\"facing_direction\" : 3] ",
         "[\"facing_direction\" : 4] ",
         "[\"facing_direction\" : 5] ",
         "[\"facing_direction\" : 6] ",
         "[\"facing_direction\" : 7] "
            },
        lit_furnace ={
         "[\"facing_direction\" : 0] ",
         "[\"facing_direction\" : 1] ",
         "[\"facing_direction\" : 2] ",
         "[\"facing_direction\" : 3] ",
         "[\"facing_direction\" : 4] ",
         "[\"facing_direction\" : 5] ",
         "[\"facing_direction\" : 6] ",
         "[\"facing_direction\" : 7] "
            },
        lit_pumpkin ={
         "[\"direction\" : 0] ",
         "[\"direction\" : 1] ",
         "[\"direction\" : 2] ",
         "[\"direction\" : 3] "
            },
        lit_smoker ={
         "[\"facing_direction\" : 0] ",
         "[\"facing_direction\" : 1] ",
         "[\"facing_direction\" : 2] ",
         "[\"facing_direction\" : 3] ",
         "[\"facing_direction\" : 4] ",
         "[\"facing_direction\" : 5] ",
         "[\"facing_direction\" : 6] ",
         "[\"facing_direction\" : 7] "
            },
        log ={
         "[\"direction\" : 0, \"old_log_type\" : \"oak\"] ",
         "[\"direction\" : 0, \"old_log_type\" : \"spruce\"] ",
         "[\"direction\" : 0, \"old_log_type\" : \"birch\"] ",
         "[\"direction\" : 0, \"old_log_type\" : \"jungle\"] ",
         "[\"direction\" : 1, \"old_log_type\" : \"oak\"] ",
         "[\"direction\" : 1, \"old_log_type\" : \"spruce\"] ",
         "[\"direction\" : 1, \"old_log_type\" : \"birch\"] ",
         "[\"direction\" : 1, \"old_log_type\" : \"jungle\"] ",
         "[\"direction\" : 2, \"old_log_type\" : \"oak\"] ",
         "[\"direction\" : 2, \"old_log_type\" : \"spruce\"] ",
         "[\"direction\" : 2, \"old_log_type\" : \"birch\"] ",
         "[\"direction\" : 2, \"old_log_type\" : \"jungle\"] ",
         "[\"direction\" : 3, \"old_log_type\" : \"oak\"] ",
         "[\"direction\" : 3, \"old_log_type\" : \"spruce\"] ",
         "[\"direction\" : 3, \"old_log_type\" : \"birch\"] ",
         "[\"direction\" : 3, \"old_log_type\" : \"jungle\"] "
            },
        log2 ={
         "[\"direction\" : 0, \"new_log_type\" : \"acacia\"] ",
         "[\"direction\" : 0, \"new_log_type\" : \"dark_oak\"] ",
         "[\"direction\" : 0, \"new_log_type\" : \"acacia\"] "
            },
        loom ={
         "[\"direction\" : 0] ",
         "[\"direction\" : 1] ",
         "[\"direction\" : 2] ",
         "[\"direction\" : 3] "
            },
        magenta_candle ={
         "[\"candles\" : 0, \"lit\" : false] ",
         "[\"candles\" : 1, \"lit\" : false] ",
         "[\"candles\" : 2, \"lit\" : false] ",
         "[\"candles\" : 3, \"lit\" : false] ",
         "[\"candles\" : 0, \"lit\" : true] ",
         "[\"candles\" : 1, \"lit\" : true] ",
         "[\"candles\" : 2, \"lit\" : true] ",
         "[\"candles\" : 3, \"lit\" : true] "
            },
        magenta_candle_cake ={
         "[\"lit\" : false] ",
         "[\"lit\" : true] "
            },
        magenta_glazed_terracotta ={
         "[\"facing_direction\" : 0] ",
         "[\"facing_direction\" : 1] ",
         "[\"facing_direction\" : 2] ",
         "[\"facing_direction\" : 3] ",
         "[\"facing_direction\" : 4] ",
         "[\"facing_direction\" : 5] ",
         "[\"facing_direction\" : 6] ",
         "[\"facing_direction\" : 7] "
            },
        mangrove_button ={
         "[\"button_pressed_bit\" : false, \"facing_direction\" : 0] ",
         "[\"button_pressed_bit\" : false, \"facing_direction\" : 1] ",
         "[\"button_pressed_bit\" : false, \"facing_direction\" : 2] ",
         "[\"button_pressed_bit\" : false, \"facing_direction\" : 3] ",
         "[\"button_pressed_bit\" : false, \"facing_direction\" : 4] ",
         "[\"button_pressed_bit\" : false, \"facing_direction\" : 5] ",
         "[\"button_pressed_bit\" : false, \"facing_direction\" : 6] ",
         "[\"button_pressed_bit\" : false, \"facing_direction\" : 7] ",
         "[\"button_pressed_bit\" : true, \"facing_direction\" : 0] ",
         "[\"button_pressed_bit\" : true, \"facing_direction\" : 1] ",
         "[\"button_pressed_bit\" : true, \"facing_direction\" : 2] ",
         "[\"button_pressed_bit\" : true, \"facing_direction\" : 3] ",
         "[\"button_pressed_bit\" : true, \"facing_direction\" : 4] ",
         "[\"button_pressed_bit\" : true, \"facing_direction\" : 5] ",
         "[\"button_pressed_bit\" : true, \"facing_direction\" : 6] ",
         "[\"button_pressed_bit\" : true, \"facing_direction\" : 7] "
            },
        mangrove_door ={
         "[\"direction\" : 0, \"door_hinge_bit\" : false, \"open_bit\" : false, \"upper_block_bit\" : false] ",
         "[\"direction\" : 1, \"door_hinge_bit\" : true, \"open_bit\" : false, \"upper_block_bit\" : false] ",
         "[\"direction\" : 2, \"door_hinge_bit\" : false, \"open_bit\" : false, \"upper_block_bit\" : false] ",
         "[\"direction\" : 3, \"door_hinge_bit\" : true, \"open_bit\" : false, \"upper_block_bit\" : false] ",
         "[\"direction\" : 0, \"door_hinge_bit\" : false, \"open_bit\" : true, \"upper_block_bit\" : false] ",
         "[\"direction\" : 1, \"door_hinge_bit\" : true, \"open_bit\" : true, \"upper_block_bit\" : false] ",
         "[\"direction\" : 2, \"door_hinge_bit\" : false, \"open_bit\" : true, \"upper_block_bit\" : false] ",
         "[\"direction\" : 3, \"door_hinge_bit\" : true, \"open_bit\" : true, \"upper_block_bit\" : false] ",
         "[\"direction\" : 0, \"door_hinge_bit\" : false, \"open_bit\" : false, \"upper_block_bit\" : true] ",
         "[\"direction\" : 1, \"door_hinge_bit\" : true, \"open_bit\" : false, \"upper_block_bit\" : true] ",
         "[\"direction\" : 2, \"door_hinge_bit\" : false, \"open_bit\" : false, \"upper_block_bit\" : true] ",
         "[\"direction\" : 3, \"door_hinge_bit\" : true, \"open_bit\" : false, \"upper_block_bit\" : true] ",
         "[\"direction\" : 0, \"door_hinge_bit\" : false, \"open_bit\" : true, \"upper_block_bit\" : true] ",
         "[\"direction\" : 1, \"door_hinge_bit\" : true, \"open_bit\" : true, \"upper_block_bit\" : true] ",
         "[\"direction\" : 2, \"door_hinge_bit\" : false, \"open_bit\" : true, \"upper_block_bit\" : true] ",
         "[\"direction\" : 3, \"door_hinge_bit\" : true, \"open_bit\" : true, \"upper_block_bit\" : true] ",
         "[\"direction\" : 0, \"door_hinge_bit\" : false, \"open_bit\" : false, \"upper_block_bit\" : false] ",
         "[\"direction\" : 1, \"door_hinge_bit\" : true, \"open_bit\" : false, \"upper_block_bit\" : false] ",
         "[\"direction\" : 2, \"door_hinge_bit\" : false, \"open_bit\" : false, \"upper_block_bit\" : false] ",
         "[\"direction\" : 3, \"door_hinge_bit\" : true, \"open_bit\" : false, \"upper_block_bit\" : false] ",
         "[\"direction\" : 0, \"door_hinge_bit\" : false, \"open_bit\" : true, \"upper_block_bit\" : false] ",
         "[\"direction\" : 1, \"door_hinge_bit\" : true, \"open_bit\" : true, \"upper_block_bit\" : false] ",
         "[\"direction\" : 2, \"door_hinge_bit\" : false, \"open_bit\" : true, \"upper_block_bit\" : false] ",
         "[\"direction\" : 3, \"door_hinge_bit\" : true, \"open_bit\" : true, \"upper_block_bit\" : false] ",
         "[\"direction\" : 0, \"door_hinge_bit\" : false, \"open_bit\" : false, \"upper_block_bit\" : true] ",
         "[\"direction\" : 1, \"door_hinge_bit\" : true, \"open_bit\" : false, \"upper_block_bit\" : true] ",
         "[\"direction\" : 2, \"door_hinge_bit\" : false, \"open_bit\" : false, \"upper_block_bit\" : true] ",
         "[\"direction\" : 3, \"door_hinge_bit\" : true, \"open_bit\" : false, \"upper_block_bit\" : true] ",
         "[\"direction\" : 0, \"door_hinge_bit\" : false, \"open_bit\" : true, \"upper_block_bit\" : true] ",
         "[\"direction\" : 1, \"door_hinge_bit\" : true, \"open_bit\" : true, \"upper_block_bit\" : true] ",
         "[\"direction\" : 2, \"door_hinge_bit\" : false, \"open_bit\" : true, \"upper_block_bit\" : true] ",
         "[\"direction\" : 3, \"door_hinge_bit\" : true, \"open_bit\" : true, \"upper_block_bit\" : true] "
            },
        mangrove_fence_gate ={
         "[\"direction\" : 0, \"in_wall_bit\" : false, \"open_bit\" : false] ",
         "[\"direction\" : 1, \"in_wall_bit\" : false, \"open_bit\" : false] ",
         "[\"direction\" : 2, \"in_wall_bit\" : false, \"open_bit\" : false] ",
         "[\"direction\" : 3, \"in_wall_bit\" : false, \"open_bit\" : false] ",
         "[\"direction\" : 0, \"in_wall_bit\" : false, \"open_bit\" : true] ",
         "[\"direction\" : 1, \"in_wall_bit\" : false, \"open_bit\" : true] ",
         "[\"direction\" : 2, \"in_wall_bit\" : false, \"open_bit\" : true] ",
         "[\"direction\" : 3, \"in_wall_bit\" : false, \"open_bit\" : true] ",
         "[\"direction\" : 0, \"in_wall_bit\" : true, \"open_bit\" : false] ",
         "[\"direction\" : 1, \"in_wall_bit\" : true, \"open_bit\" : false] ",
         "[\"direction\" : 2, \"in_wall_bit\" : true, \"open_bit\" : false] ",
         "[\"direction\" : 3, \"in_wall_bit\" : true, \"open_bit\" : false] ",
         "[\"direction\" : 0, \"in_wall_bit\" : true, \"open_bit\" : true] ",
         "[\"direction\" : 1, \"in_wall_bit\" : true, \"open_bit\" : true] ",
         "[\"direction\" : 2, \"in_wall_bit\" : true, \"open_bit\" : true] ",
         "[\"direction\" : 3, \"in_wall_bit\" : true, \"open_bit\" : true] "
            },
        mangrove_log ={
         "[\"pillar_axis\" : \"y\"] ",
         "[\"pillar_axis\" : \"x\"] ",
         "[\"pillar_axis\" : \"z\"] "
            },
        mangrove_slab ={
         "[\"top_slot_bit\" : false] ",
         "[\"top_slot_bit\" : true] "
            },
        mangrove_stairs ={
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 0] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 1] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 2] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 3] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 0] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 1] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 2] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 3] "
            },
        mangrove_standing_sign ={
         "[\"ground_sign_direction\" : 0] ",
         "[\"ground_sign_direction\" : 1] ",
         "[\"ground_sign_direction\" : 2] ",
         "[\"ground_sign_direction\" : 3] ",
         "[\"ground_sign_direction\" : 4] ",
         "[\"ground_sign_direction\" : 5] ",
         "[\"ground_sign_direction\" : 6] ",
         "[\"ground_sign_direction\" : 7] ",
         "[\"ground_sign_direction\" : 8] ",
         "[\"ground_sign_direction\" : 9] ",
         "[\"ground_sign_direction\" : 10] ",
         "[\"ground_sign_direction\" : 11] ",
         "[\"ground_sign_direction\" : 12] ",
         "[\"ground_sign_direction\" : 13] ",
         "[\"ground_sign_direction\" : 14] ",
         "[\"ground_sign_direction\" : 15] ",
         "[\"ground_sign_direction\" : 0] "
            },
        mangrove_trapdoor ={
         "[\"direction\" : 0, \"open_bit\" : false, \"upside_down_bit\" : false] ",
         "[\"direction\" : 1, \"open_bit\" : false, \"upside_down_bit\" : false] ",
         "[\"direction\" : 2, \"open_bit\" : false, \"upside_down_bit\" : false] ",
         "[\"direction\" : 3, \"open_bit\" : false, \"upside_down_bit\" : false] ",
         "[\"direction\" : 0, \"open_bit\" : false, \"upside_down_bit\" : true] ",
         "[\"direction\" : 1, \"open_bit\" : false, \"upside_down_bit\" : true] ",
         "[\"direction\" : 2, \"open_bit\" : false, \"upside_down_bit\" : true] ",
         "[\"direction\" : 3, \"open_bit\" : false, \"upside_down_bit\" : true] ",
         "[\"direction\" : 0, \"open_bit\" : true, \"upside_down_bit\" : false] ",
         "[\"direction\" : 1, \"open_bit\" : true, \"upside_down_bit\" : false] ",
         "[\"direction\" : 2, \"open_bit\" : true, \"upside_down_bit\" : false] ",
         "[\"direction\" : 3, \"open_bit\" : true, \"upside_down_bit\" : false] ",
         "[\"direction\" : 0, \"open_bit\" : true, \"upside_down_bit\" : true] ",
         "[\"direction\" : 1, \"open_bit\" : true, \"upside_down_bit\" : true] ",
         "[\"direction\" : 2, \"open_bit\" : true, \"upside_down_bit\" : true] ",
         "[\"direction\" : 3, \"open_bit\" : true, \"upside_down_bit\" : true] "
            },
        mangrove_wall_sign ={
         "[\"facing_direction\" : 0] ",
         "[\"facing_direction\" : 1] ",
         "[\"facing_direction\" : 2] ",
         "[\"facing_direction\" : 3] ",
         "[\"facing_direction\" : 4] ",
         "[\"facing_direction\" : 5] "
            },
        mangrove_wood ={
         "[\"pillar_axis\" : \"y\"] ",
         "[\"pillar_axis\" : \"x\"] ",
         "[\"pillar_axis\" : \"z\"] "
            },
        melon_stem ={
         "[\"growth\" : 0] ",
         "[\"growth\" : 1] ",
         "[\"growth\" : 2] ",
         "[\"growth\" : 3] ",
         "[\"growth\" : 4] ",
         "[\"growth\" : 5] ",
         "[\"growth\" : 6] ",
         "[\"growth\" : 7] "
            },
        monster_egg ={
         "[\"monster_egg_stone_type\" : \"stone\"] ",
         "[\"monster_egg_stone_type\" : \"cobblestone\"] ",
         "[\"monster_egg_stone_type\" : \"stone_brick\"] ",
         "[\"monster_egg_stone_type\" : \"mossy_stone_brick\"] ",
         "[\"monster_egg_stone_type\" : \"cracked_stone_brick\"] ",
         "[\"monster_egg_stone_type\" : \"chiseled_stone_brick\"] ",
         "[\"monster_egg_stone_type\" : \"stone\"] "
            },
        mossy_cobblestone_stairs ={
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 0] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 1] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 2] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 3] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 0] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 1] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 2] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 3] "
            },
        mossy_stone_brick_stairs ={
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 0] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 1] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 2] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 3] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 0] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 1] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 2] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 3] "
            },
        mud_brick_slab ={
         "[\"top_slot_bit\" : false] ",
         "[\"top_slot_bit\" : true] "
            },
        muddy_mangrove_roots ={
         "[\"pillar_axis\" : \"y\"] ",
         "[\"pillar_axis\" : \"x\"] ",
         "[\"pillar_axis\" : \"z\"] "
            },
        nether_brick_stairs ={
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 0] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 1] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 2] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 3] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 0] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 1] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 2] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 3] "
            },
        nether_wart ={
         "[\"age\" : 0] ",
         "[\"age\" : 1] ",
         "[\"age\" : 2] ",
         "[\"age\" : 3] "
            },
        normal_stone_stairs ={
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 0] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 1] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 2] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 3] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 0] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 1] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 2] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 3] "
            },
        oak_stairs ={
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 0] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 1] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 2] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 3] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 0] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 1] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 2] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 3] "
            },
        observer ={
         "[\"facing_direction\" : 0, \"powered_bit\" : false] ",
         "[\"facing_direction\" : 1, \"powered_bit\" : false] ",
         "[\"facing_direction\" : 2, \"powered_bit\" : false] ",
         "[\"facing_direction\" : 3, \"powered_bit\" : false] ",
         "[\"facing_direction\" : 4, \"powered_bit\" : false] ",
         "[\"facing_direction\" : 5, \"powered_bit\" : false] ",
         "[\"facing_direction\" : 6, \"powered_bit\" : false] ",
         "[\"facing_direction\" : 7, \"powered_bit\" : false] ",
         "[\"facing_direction\" : 0, \"powered_bit\" : true] ",
         "[\"facing_direction\" : 1, \"powered_bit\" : true] ",
         "[\"facing_direction\" : 2, \"powered_bit\" : true] ",
         "[\"facing_direction\" : 3, \"powered_bit\" : true] ",
         "[\"facing_direction\" : 4, \"powered_bit\" : true] ",
         "[\"facing_direction\" : 5, \"powered_bit\" : true] ",
         "[\"facing_direction\" : 6, \"powered_bit\" : true] ",
         "[\"facing_direction\" : 7, \"powered_bit\" : true] "
            },
        orange_candle ={
         "[\"candles\" : 0, \"lit\" : false] ",
         "[\"candles\" : 1, \"lit\" : false] ",
         "[\"candles\" : 2, \"lit\" : false] ",
         "[\"candles\" : 3, \"lit\" : false] ",
         "[\"candles\" : 0, \"lit\" : true] ",
         "[\"candles\" : 1, \"lit\" : true] ",
         "[\"candles\" : 2, \"lit\" : true] ",
         "[\"candles\" : 3, \"lit\" : true] "
            },
        orange_candle_cake ={
         "[\"lit\" : false] ",
         "[\"lit\" : true] "
            },
        orange_glazed_terracotta ={
         "[\"facing_direction\" : 0] ",
         "[\"facing_direction\" : 1] ",
         "[\"facing_direction\" : 2] ",
         "[\"facing_direction\" : 3] ",
         "[\"facing_direction\" : 4] ",
         "[\"facing_direction\" : 5] ",
         "[\"facing_direction\" : 6] ",
         "[\"facing_direction\" : 7] "
            },
        oxidized_cut_copper_slab ={
         "[\"top_slot_bit\" : false] ",
         "[\"top_slot_bit\" : true] "
            },
        pink_candle ={
         "[\"candles\" : 0, \"lit\" : false] ",
         "[\"candles\" : 1, \"lit\" : false] ",
         "[\"candles\" : 2, \"lit\" : false] ",
         "[\"candles\" : 3, \"lit\" : false] ",
         "[\"candles\" : 0, \"lit\" : true] ",
         "[\"candles\" : 1, \"lit\" : true] ",
         "[\"candles\" : 2, \"lit\" : true] ",
         "[\"candles\" : 3, \"lit\" : true] "
            },
        pink_candle_cake ={
         "[\"lit\" : false] ",
         "[\"lit\" : true] "
            },
        pink_glazed_terracotta ={
         "[\"facing_direction\" : 0] ",
         "[\"facing_direction\" : 1] ",
         "[\"facing_direction\" : 2] ",
         "[\"facing_direction\" : 3] ",
         "[\"facing_direction\" : 4] ",
         "[\"facing_direction\" : 5] ",
         "[\"facing_direction\" : 6] ",
         "[\"facing_direction\" : 7] "
            },
        piston ={
         "[\"facing_direction\" : 0] ",
         "[\"facing_direction\" : 1] ",
         "[\"facing_direction\" : 2] ",
         "[\"facing_direction\" : 3] ",
         "[\"facing_direction\" : 4] ",
         "[\"facing_direction\" : 5] ",
         "[\"facing_direction\" : 6] ",
         "[\"facing_direction\" : 7] "
            },
        piston_arm_collision ={
         "[\"facing_direction\" : 0] ",
         "[\"facing_direction\" : 1] ",
         "[\"facing_direction\" : 2] ",
         "[\"facing_direction\" : 3] ",
         "[\"facing_direction\" : 4] ",
         "[\"facing_direction\" : 5] ",
         "[\"facing_direction\" : 6] ",
         "[\"facing_direction\" : 7] "
            },
        planks ={
         "[\"wood_type\" : \"oak\"] ",
         "[\"wood_type\" : \"spruce\"] ",
         "[\"wood_type\" : \"birch\"] ",
         "[\"wood_type\" : \"jungle\"] ",
         "[\"wood_type\" : \"acacia\"] ",
         "[\"wood_type\" : \"dark_oak\"] ",
         "[\"wood_type\" : \"oak\"] "
            },
        polished_andesite_stairs ={
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 0] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 1] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 2] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 3] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 0] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 1] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 2] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 3] "
            },
        polished_basalt ={
         "[\"pillar_axis\" : \"y\"] ",
         "[\"pillar_axis\" : \"x\"] ",
         "[\"pillar_axis\" : \"z\"] "
            },
        polished_blackstone_brick_slab ={
         "[\"top_slot_bit\" : false] ",
         "[\"top_slot_bit\" : true] "
            },
        polished_blackstone_brick_stairs ={
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 0] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 1] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 2] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 3] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 0] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 1] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 2] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 3] "
            },
        polished_blackstone_button ={
         "[\"button_pressed_bit\" : false, \"facing_direction\" : 0] ",
         "[\"button_pressed_bit\" : false, \"facing_direction\" : 1] ",
         "[\"button_pressed_bit\" : false, \"facing_direction\" : 2] ",
         "[\"button_pressed_bit\" : false, \"facing_direction\" : 3] ",
         "[\"button_pressed_bit\" : false, \"facing_direction\" : 4] ",
         "[\"button_pressed_bit\" : false, \"facing_direction\" : 5] ",
         "[\"button_pressed_bit\" : false, \"facing_direction\" : 6] ",
         "[\"button_pressed_bit\" : false, \"facing_direction\" : 7] ",
         "[\"button_pressed_bit\" : true, \"facing_direction\" : 0] ",
         "[\"button_pressed_bit\" : true, \"facing_direction\" : 1] ",
         "[\"button_pressed_bit\" : true, \"facing_direction\" : 2] ",
         "[\"button_pressed_bit\" : true, \"facing_direction\" : 3] ",
         "[\"button_pressed_bit\" : true, \"facing_direction\" : 4] ",
         "[\"button_pressed_bit\" : true, \"facing_direction\" : 5] ",
         "[\"button_pressed_bit\" : true, \"facing_direction\" : 6] ",
         "[\"button_pressed_bit\" : true, \"facing_direction\" : 7] "
            },
        polished_blackstone_pressure_plate ={
         "[\"redstone_signal\" : 0] ",
         "[\"redstone_signal\" : 1] ",
         "[\"redstone_signal\" : 2] ",
         "[\"redstone_signal\" : 3] ",
         "[\"redstone_signal\" : 4] ",
         "[\"redstone_signal\" : 5] ",
         "[\"redstone_signal\" : 6] ",
         "[\"redstone_signal\" : 7] ",
         "[\"redstone_signal\" : 8] ",
         "[\"redstone_signal\" : 9] ",
         "[\"redstone_signal\" : 10] ",
         "[\"redstone_signal\" : 11] ",
         "[\"redstone_signal\" : 12] ",
         "[\"redstone_signal\" : 13] ",
         "[\"redstone_signal\" : 14] ",
         "[\"redstone_signal\" : 15] "
            },
        polished_blackstone_slab ={
         "[\"top_slot_bit\" : false] ",
         "[\"top_slot_bit\" : true] "
            },
        polished_blackstone_stairs ={
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 0] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 1] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 2] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 3] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 0] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 1] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 2] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 3] "
            },
        polished_deepslate_slab ={
         "[\"top_slot_bit\" : false] ",
         "[\"top_slot_bit\" : true] "
            },
        polished_diorite_stairs ={
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 0] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 1] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 2] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 3] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 0] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 1] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 2] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 3] "
            },
        polished_granite_stairs ={
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 0] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 1] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 2] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 3] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 0] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 1] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 2] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 3] "
            },
        portal ={
         "[\"portal_axis\" : \"unknown\"] ",
         "[\"portal_axis\" : \"x\"] ",
         "[\"portal_axis\" : \"z\"] ",
         "[\"portal_axis\" : \"unknown\"] "
            },
        potatoes ={
         "[\"growth\" : 0] ",
         "[\"growth\" : 1] ",
         "[\"growth\" : 2] ",
         "[\"growth\" : 3] ",
         "[\"growth\" : 4] ",
         "[\"growth\" : 5] ",
         "[\"growth\" : 6] ",
         "[\"growth\" : 7] "
            },
        powered_comparator ={
         "[\"direction\" : 0, \"output_lit_bit\" : false, \"output_subtract_bit\" : false] ",
         "[\"direction\" : 1, \"output_lit_bit\" : false, \"output_subtract_bit\" : false] ",
         "[\"direction\" : 2, \"output_lit_bit\" : false, \"output_subtract_bit\" : false] ",
         "[\"direction\" : 3, \"output_lit_bit\" : false, \"output_subtract_bit\" : false] ",
         "[\"direction\" : 0, \"output_lit_bit\" : false, \"output_subtract_bit\" : true] ",
         "[\"direction\" : 1, \"output_lit_bit\" : false, \"output_subtract_bit\" : true] ",
         "[\"direction\" : 2, \"output_lit_bit\" : false, \"output_subtract_bit\" : true] ",
         "[\"direction\" : 3, \"output_lit_bit\" : false, \"output_subtract_bit\" : true] ",
         "[\"direction\" : 0, \"output_lit_bit\" : true, \"output_subtract_bit\" : false] ",
         "[\"direction\" : 1, \"output_lit_bit\" : true, \"output_subtract_bit\" : false] ",
         "[\"direction\" : 2, \"output_lit_bit\" : true, \"output_subtract_bit\" : false] ",
         "[\"direction\" : 3, \"output_lit_bit\" : true, \"output_subtract_bit\" : false] ",
         "[\"direction\" : 0, \"output_lit_bit\" : true, \"output_subtract_bit\" : true] ",
         "[\"direction\" : 1, \"output_lit_bit\" : true, \"output_subtract_bit\" : true] ",
         "[\"direction\" : 2, \"output_lit_bit\" : true, \"output_subtract_bit\" : true] ",
         "[\"direction\" : 3, \"output_lit_bit\" : true, \"output_subtract_bit\" : true] "
            },
        powered_repeater ={
         "[\"direction\" : 0, \"repeater_delay\" : 0] ",
         "[\"direction\" : 1, \"repeater_delay\" : 0] ",
         "[\"direction\" : 2, \"repeater_delay\" : 0] ",
         "[\"direction\" : 3, \"repeater_delay\" : 0] ",
         "[\"direction\" : 0, \"repeater_delay\" : 1] ",
         "[\"direction\" : 1, \"repeater_delay\" : 1] ",
         "[\"direction\" : 2, \"repeater_delay\" : 1] ",
         "[\"direction\" : 3, \"repeater_delay\" : 1] ",
         "[\"direction\" : 0, \"repeater_delay\" : 2] ",
         "[\"direction\" : 1, \"repeater_delay\" : 2] ",
         "[\"direction\" : 2, \"repeater_delay\" : 2] ",
         "[\"direction\" : 3, \"repeater_delay\" : 2] ",
         "[\"direction\" : 0, \"repeater_delay\" : 3] ",
         "[\"direction\" : 1, \"repeater_delay\" : 3] ",
         "[\"direction\" : 2, \"repeater_delay\" : 3] ",
         "[\"direction\" : 3, \"repeater_delay\" : 3] "
            },
        prismarine ={
         "[\"prismarine_block_type\" : \"default\"] ",
         "[\"prismarine_block_type\" : \"dark\"] ",
         "[\"prismarine_block_type\" : \"bricks\"] ",
         "[\"prismarine_block_type\" : \"default\"] "
            },
        prismarine_bricks_stairs ={
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 0] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 1] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 2] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 3] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 0] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 1] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 2] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 3] "
            },
        prismarine_stairs ={
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 0] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 1] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 2] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 3] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 0] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 1] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 2] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 3] "
            },
        pumpkin ={
         "[\"direction\" : 0] ",
         "[\"direction\" : 1] ",
         "[\"direction\" : 2] ",
         "[\"direction\" : 3] "
            },
        pumpkin_stem ={
         "[\"growth\" : 0] ",
         "[\"growth\" : 1] ",
         "[\"growth\" : 2] ",
         "[\"growth\" : 3] ",
         "[\"growth\" : 4] ",
         "[\"growth\" : 5] ",
         "[\"growth\" : 6] ",
         "[\"growth\" : 7] "
            },
        purple_candle ={
         "[\"candles\" : 0, \"lit\" : false] ",
         "[\"candles\" : 1, \"lit\" : false] ",
         "[\"candles\" : 2, \"lit\" : false] ",
         "[\"candles\" : 3, \"lit\" : false] ",
         "[\"candles\" : 0, \"lit\" : true] ",
         "[\"candles\" : 1, \"lit\" : true] ",
         "[\"candles\" : 2, \"lit\" : true] ",
         "[\"candles\" : 3, \"lit\" : true] "
            },
        purple_candle_cake ={
         "[\"lit\" : false] ",
         "[\"lit\" : true] "
            },
        purple_glazed_terracotta ={
         "[\"facing_direction\" : 0] ",
         "[\"facing_direction\" : 1] ",
         "[\"facing_direction\" : 2] ",
         "[\"facing_direction\" : 3] ",
         "[\"facing_direction\" : 4] ",
         "[\"facing_direction\" : 5] ",
         "[\"facing_direction\" : 6] ",
         "[\"facing_direction\" : 7] "
            },
        purpur_block ={
         "[\"chisel_type\" : \"default\", \"pillar_axis\" : \"y\"] ",
         "[\"chisel_type\" : \"chiseled\", \"pillar_axis\" : \"y\"] ",
         "[\"chisel_type\" : \"lines\", \"pillar_axis\" : \"y\"] ",
         "[\"chisel_type\" : \"smooth\", \"pillar_axis\" : \"y\"] ",
         "[\"chisel_type\" : \"default\", \"pillar_axis\" : \"x\"] ",
         "[\"chisel_type\" : \"chiseled\", \"pillar_axis\" : \"x\"] ",
         "[\"chisel_type\" : \"lines\", \"pillar_axis\" : \"x\"] ",
         "[\"chisel_type\" : \"smooth\", \"pillar_axis\" : \"x\"] ",
         "[\"chisel_type\" : \"default\", \"pillar_axis\" : \"z\"] ",
         "[\"chisel_type\" : \"chiseled\", \"pillar_axis\" : \"z\"] ",
         "[\"chisel_type\" : \"lines\", \"pillar_axis\" : \"z\"] ",
         "[\"chisel_type\" : \"smooth\", \"pillar_axis\" : \"z\"] ",
         "[\"chisel_type\" : \"default\", \"pillar_axis\" : \"z\"] ",
         "[\"chisel_type\" : \"chiseled\", \"pillar_axis\" : \"z\"] ",
         "[\"chisel_type\" : \"lines\", \"pillar_axis\" : \"z\"] ",
         "[\"chisel_type\" : \"smooth\", \"pillar_axis\" : \"z\"] "
            },
        purpur_stairs ={
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 0] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 1] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 2] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 3] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 0] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 1] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 2] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 3] "
            },
        quartz_block ={
         "[\"chisel_type\" : \"default\", \"direction\" : 0] ",
         "[\"chisel_type\" : \"chiseled\", \"direction\" : 0] ",
         "[\"chisel_type\" : \"lines\", \"direction\" : 0] ",
         "[\"chisel_type\" : \"smooth\", \"direction\" : 0] ",
         "[\"chisel_type\" : \"default\", \"direction\" : 1] ",
         "[\"chisel_type\" : \"chiseled\", \"direction\" : 1] ",
         "[\"chisel_type\" : \"lines\", \"direction\" : 1] ",
         "[\"chisel_type\" : \"smooth\", \"direction\" : 1] ",
         "[\"chisel_type\" : \"default\", \"direction\" : 2] ",
         "[\"chisel_type\" : \"chiseled\", \"direction\" : 2] ",
         "[\"chisel_type\" : \"lines\", \"direction\" : 2] ",
         "[\"chisel_type\" : \"smooth\", \"direction\" : 2] ",
         "[\"chisel_type\" : \"default\", \"direction\" : 3] ",
         "[\"chisel_type\" : \"chiseled\", \"direction\" : 3] ",
         "[\"chisel_type\" : \"lines\", \"direction\" : 3] ",
         "[\"chisel_type\" : \"smooth\", \"direction\" : 3] "
            },
        quartz_stairs ={
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 0] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 1] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 2] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 3] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 0] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 1] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 2] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 3] "
            },
        rail ={
         "[\"rail_direction\" : 0] ",
         "[\"rail_direction\" : 1] ",
         "[\"rail_direction\" : 2] ",
         "[\"rail_direction\" : 3] ",
         "[\"rail_direction\" : 4] ",
         "[\"rail_direction\" : 5] ",
         "[\"rail_direction\" : 6] ",
         "[\"rail_direction\" : 7] ",
         "[\"rail_direction\" : 8] ",
         "[\"rail_direction\" : 9] ",
         "[\"rail_direction\" : 10] ",
         "[\"rail_direction\" : 11] ",
         "[\"rail_direction\" : 12] ",
         "[\"rail_direction\" : 13] ",
         "[\"rail_direction\" : 14] ",
         "[\"rail_direction\" : 15] "
            },
        red_candle ={
         "[\"candles\" : 0, \"lit\" : false] ",
         "[\"candles\" : 1, \"lit\" : false] ",
         "[\"candles\" : 2, \"lit\" : false] ",
         "[\"candles\" : 3, \"lit\" : false] ",
         "[\"candles\" : 0, \"lit\" : true] ",
         "[\"candles\" : 1, \"lit\" : true] ",
         "[\"candles\" : 2, \"lit\" : true] ",
         "[\"candles\" : 3, \"lit\" : true] "
            },
        red_candle_cake ={
         "[\"lit\" : false] ",
         "[\"lit\" : true] "
            },
        red_flower ={
         "[\"flower_type\" : \"poppy\"] ",
         "[\"flower_type\" : \"orchid\"] ",
         "[\"flower_type\" : \"allium\"] ",
         "[\"flower_type\" : \"houstonia\"] ",
         "[\"flower_type\" : \"tulip_red\"] ",
         "[\"flower_type\" : \"tulip_orange\"] ",
         "[\"flower_type\" : \"tulip_white\"] ",
         "[\"flower_type\" : \"tulip_pink\"] ",
         "[\"flower_type\" : \"oxeye\"] ",
         "[\"flower_type\" : \"cornflower\"] ",
         "[\"flower_type\" : \"lily_of_the_valley\"] ",
         "[\"flower_type\" : \"poppy\"] "
            },
        red_glazed_terracotta ={
         "[\"facing_direction\" : 0] ",
         "[\"facing_direction\" : 1] ",
         "[\"facing_direction\" : 2] ",
         "[\"facing_direction\" : 3] ",
         "[\"facing_direction\" : 4] ",
         "[\"facing_direction\" : 5] ",
         "[\"facing_direction\" : 6] ",
         "[\"facing_direction\" : 7] "
            },
        red_mushroom_block ={
         "[\"huge_mushroom_bits\" : 0] ",
         "[\"huge_mushroom_bits\" : 1] ",
         "[\"huge_mushroom_bits\" : 2] ",
         "[\"huge_mushroom_bits\" : 3] ",
         "[\"huge_mushroom_bits\" : 4] ",
         "[\"huge_mushroom_bits\" : 5] ",
         "[\"huge_mushroom_bits\" : 6] ",
         "[\"huge_mushroom_bits\" : 7] ",
         "[\"huge_mushroom_bits\" : 8] ",
         "[\"huge_mushroom_bits\" : 9] ",
         "[\"huge_mushroom_bits\" : 10] ",
         "[\"huge_mushroom_bits\" : 11] ",
         "[\"huge_mushroom_bits\" : 12] ",
         "[\"huge_mushroom_bits\" : 13] ",
         "[\"huge_mushroom_bits\" : 14] ",
         "[\"huge_mushroom_bits\" : 15] "
            },
        red_nether_brick_stairs ={
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 0] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 1] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 2] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 3] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 0] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 1] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 2] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 3] "
            },
        red_sandstone ={
         "[\"sand_stone_type\" : \"default\"] ",
         "[\"sand_stone_type\" : \"heiroglyphs\"] ",
         "[\"sand_stone_type\" : \"cut\"] ",
         "[\"sand_stone_type\" : \"smooth\"] "
            },
        red_sandstone_stairs ={
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 0] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 1] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 2] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 3] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 0] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 1] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 2] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 3] "
            },
        redstone_torch ={
         "[\"torch_facing_direction\" : \"unknown\"] ",
         "[\"torch_facing_direction\" : \"west\"] ",
         "[\"torch_facing_direction\" : \"east\"] ",
         "[\"torch_facing_direction\" : \"north\"] ",
         "[\"torch_facing_direction\" : \"south\"] ",
         "[\"torch_facing_direction\" : \"top\"] ",
         "[\"torch_facing_direction\" : \"unknown\"] "
            },
        redstone_wire ={
         "[\"redstone_signal\" : 0] ",
         "[\"redstone_signal\" : 1] ",
         "[\"redstone_signal\" : 2] ",
         "[\"redstone_signal\" : 3] ",
         "[\"redstone_signal\" : 4] ",
         "[\"redstone_signal\" : 5] ",
         "[\"redstone_signal\" : 6] ",
         "[\"redstone_signal\" : 7] ",
         "[\"redstone_signal\" : 8] ",
         "[\"redstone_signal\" : 9] ",
         "[\"redstone_signal\" : 10] ",
         "[\"redstone_signal\" : 11] ",
         "[\"redstone_signal\" : 12] ",
         "[\"redstone_signal\" : 13] ",
         "[\"redstone_signal\" : 14] ",
         "[\"redstone_signal\" : 15] "
            },
        reeds ={
         "[\"age\" : 0] ",
         "[\"age\" : 1] ",
         "[\"age\" : 2] ",
         "[\"age\" : 3] ",
         "[\"age\" : 4] ",
         "[\"age\" : 5] ",
         "[\"age\" : 6] ",
         "[\"age\" : 7] ",
         "[\"age\" : 8] ",
         "[\"age\" : 9] ",
         "[\"age\" : 10] ",
         "[\"age\" : 11] ",
         "[\"age\" : 12] ",
         "[\"age\" : 13] ",
         "[\"age\" : 14] ",
         "[\"age\" : 15] "
            },
        repeating_command_block ={
         "[\"conditional_bit\" : false, \"facing_direction\" : 0] ",
         "[\"conditional_bit\" : false, \"facing_direction\" : 1] ",
         "[\"conditional_bit\" : false, \"facing_direction\" : 2] ",
         "[\"conditional_bit\" : false, \"facing_direction\" : 3] ",
         "[\"conditional_bit\" : false, \"facing_direction\" : 4] ",
         "[\"conditional_bit\" : false, \"facing_direction\" : 5] ",
         "[\"conditional_bit\" : false, \"facing_direction\" : 6] ",
         "[\"conditional_bit\" : false, \"facing_direction\" : 7] ",
         "[\"conditional_bit\" : true, \"facing_direction\" : 0] ",
         "[\"conditional_bit\" : true, \"facing_direction\" : 1] ",
         "[\"conditional_bit\" : true, \"facing_direction\" : 2] ",
         "[\"conditional_bit\" : true, \"facing_direction\" : 3] ",
         "[\"conditional_bit\" : true, \"facing_direction\" : 4] ",
         "[\"conditional_bit\" : true, \"facing_direction\" : 5] ",
         "[\"conditional_bit\" : true, \"facing_direction\" : 6] ",
         "[\"conditional_bit\" : true, \"facing_direction\" : 7] "
            },
        respawn_anchor ={
         "[\"respawn_anchor_charge\" : 0] ",
         "[\"respawn_anchor_charge\" : 1] ",
         "[\"respawn_anchor_charge\" : 2] ",
         "[\"respawn_anchor_charge\" : 3] ",
         "[\"respawn_anchor_charge\" : 4] "
            },
        sand ={
         "[\"sand_type\" : \"normal\"] ",
         "[\"sand_type\" : \"red\"] "
            },
        sandstone ={
         "[\"sand_stone_type\" : \"default\"] ",
         "[\"sand_stone_type\" : \"heiroglyphs\"] ",
         "[\"sand_stone_type\" : \"cut\"] ",
         "[\"sand_stone_type\" : \"smooth\"] "
            },
        sandstone_stairs ={
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 0] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 1] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 2] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 3] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 0] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 1] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 2] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 3] "
            },
        sapling ={
         "[\"age_bit\" : false, \"sapling_type\" : \"oak\"] ",
         "[\"age_bit\" : false, \"sapling_type\" : \"spruce\"] ",
         "[\"age_bit\" : false, \"sapling_type\" : \"birch\"] ",
         "[\"age_bit\" : false, \"sapling_type\" : \"jungle\"] ",
         "[\"age_bit\" : false, \"sapling_type\" : \"acacia\"] ",
         "[\"age_bit\" : false, \"sapling_type\" : \"dark_oak\"] ",
         "[\"age_bit\" : false, \"sapling_type\" : \"oak\"] "
            },
        scaffolding ={
         "[\"stability\" : 0, \"stability_check\" : false] ",
         "[\"stability\" : 1, \"stability_check\" : false] ",
         "[\"stability\" : 2, \"stability_check\" : false] ",
         "[\"stability\" : 3, \"stability_check\" : false] ",
         "[\"stability\" : 4, \"stability_check\" : false] ",
         "[\"stability\" : 5, \"stability_check\" : false] ",
         "[\"stability\" : 6, \"stability_check\" : false] ",
         "[\"stability\" : 7, \"stability_check\" : false] ",
         "[\"stability\" : 0, \"stability_check\" : true] ",
         "[\"stability\" : 1, \"stability_check\" : true] ",
         "[\"stability\" : 2, \"stability_check\" : true] ",
         "[\"stability\" : 3, \"stability_check\" : true] ",
         "[\"stability\" : 4, \"stability_check\" : true] ",
         "[\"stability\" : 5, \"stability_check\" : true] ",
         "[\"stability\" : 6, \"stability_check\" : true] ",
         "[\"stability\" : 7, \"stability_check\" : true] "
            },
        sea_pickle ={
         "[\"cluster_count\" : 0, \"dead_bit\" : false] ",
         "[\"cluster_count\" : 1, \"dead_bit\" : false] ",
         "[\"cluster_count\" : 2, \"dead_bit\" : false] ",
         "[\"cluster_count\" : 3, \"dead_bit\" : false] ",
         "[\"cluster_count\" : 0, \"dead_bit\" : true] ",
         "[\"cluster_count\" : 1, \"dead_bit\" : true] ",
         "[\"cluster_count\" : 2, \"dead_bit\" : true] ",
         "[\"cluster_count\" : 3, \"dead_bit\" : true] "
            },
        seagrass ={
         "[\"sea_grass_type\" : \"default\"] ",
         "[\"sea_grass_type\" : \"double_top\"] ",
         "[\"sea_grass_type\" : \"double_bot\"] ",
         "[\"sea_grass_type\" : \"default\"] "
            },
        shulker_box ={
         "[\"color\" : \"white\"] ",
         "[\"color\" : \"orange\"] ",
         "[\"color\" : \"magenta\"] ",
         "[\"color\" : \"light_blue\"] ",
         "[\"color\" : \"yellow\"] ",
         "[\"color\" : \"lime\"] ",
         "[\"color\" : \"pink\"] ",
         "[\"color\" : \"gray\"] ",
         "[\"color\" : \"silver\"] ",
         "[\"color\" : \"cyan\"] ",
         "[\"color\" : \"purple\"] ",
         "[\"color\" : \"blue\"] ",
         "[\"color\" : \"brown\"] ",
         "[\"color\" : \"green\"] ",
         "[\"color\" : \"red\"] ",
         "[\"color\" : \"black\"] "
            },
        silver_glazed_terracotta ={
         "[\"facing_direction\" : 0] ",
         "[\"facing_direction\" : 1] ",
         "[\"facing_direction\" : 2] ",
         "[\"facing_direction\" : 3] ",
         "[\"facing_direction\" : 4] ",
         "[\"facing_direction\" : 5] ",
         "[\"facing_direction\" : 6] ",
         "[\"facing_direction\" : 7] "
            },
        skull ={
         "[\"facing_direction\" : 0] ",
         "[\"facing_direction\" : 1] ",
         "[\"facing_direction\" : 2] ",
         "[\"facing_direction\" : 3] ",
         "[\"facing_direction\" : 4] ",
         "[\"facing_direction\" : 5] ",
         "[\"facing_direction\" : 6] ",
         "[\"facing_direction\" : 7] "
            },
        smoker ={
         "[\"facing_direction\" : 0] ",
         "[\"facing_direction\" : 1] ",
         "[\"facing_direction\" : 2] ",
         "[\"facing_direction\" : 3] ",
         "[\"facing_direction\" : 4] ",
         "[\"facing_direction\" : 5] ",
         "[\"facing_direction\" : 6] ",
         "[\"facing_direction\" : 7] "
            },
        smooth_quartz_stairs ={
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 0] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 1] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 2] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 3] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 0] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 1] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 2] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 3] "
            },
        smooth_red_sandstone_stairs ={
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 0] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 1] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 2] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 3] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 0] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 1] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 2] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 3] "
            },
        smooth_sandstone_stairs ={
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 0] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 1] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 2] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 3] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 0] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 1] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 2] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 3] "
            },
        snow_layer ={
         "[\"covered_bit\" : false, \"height\" : 0] ",
         "[\"covered_bit\" : false, \"height\" : 1] ",
         "[\"covered_bit\" : false, \"height\" : 2] ",
         "[\"covered_bit\" : false, \"height\" : 3] ",
         "[\"covered_bit\" : false, \"height\" : 4] ",
         "[\"covered_bit\" : false, \"height\" : 5] ",
         "[\"covered_bit\" : false, \"height\" : 6] ",
         "[\"covered_bit\" : false, \"height\" : 7] ",
         "[\"covered_bit\" : true, \"height\" : 0] ",
         "[\"covered_bit\" : true, \"height\" : 1] ",
         "[\"covered_bit\" : true, \"height\" : 2] ",
         "[\"covered_bit\" : true, \"height\" : 3] ",
         "[\"covered_bit\" : true, \"height\" : 4] ",
         "[\"covered_bit\" : true, \"height\" : 5] ",
         "[\"covered_bit\" : true, \"height\" : 6] ",
         "[\"covered_bit\" : true, \"height\" : 7] "
            },
        soul_fire ={
         "[\"age\" : 0] ",
         "[\"age\" : 1] ",
         "[\"age\" : 2] ",
         "[\"age\" : 3] ",
         "[\"age\" : 4] ",
         "[\"age\" : 5] ",
         "[\"age\" : 6] ",
         "[\"age\" : 7] ",
         "[\"age\" : 8] ",
         "[\"age\" : 9] ",
         "[\"age\" : 10] ",
         "[\"age\" : 11] ",
         "[\"age\" : 12] ",
         "[\"age\" : 13] ",
         "[\"age\" : 14] ",
         "[\"age\" : 15] "
            },
        soul_lantern ={
         "[\"hanging\" : false] ",
         "[\"hanging\" : true] "
            },
        sponge ={
         "[\"sponge_type\" : \"dry\"] ",
         "[\"sponge_type\" : \"wet\"] "
            },
        spruce_button ={
         "[\"button_pressed_bit\" : false, \"facing_direction\" : 0] ",
         "[\"button_pressed_bit\" : false, \"facing_direction\" : 1] ",
         "[\"button_pressed_bit\" : false, \"facing_direction\" : 2] ",
         "[\"button_pressed_bit\" : false, \"facing_direction\" : 3] ",
         "[\"button_pressed_bit\" : false, \"facing_direction\" : 4] ",
         "[\"button_pressed_bit\" : false, \"facing_direction\" : 5] ",
         "[\"button_pressed_bit\" : false, \"facing_direction\" : 6] ",
         "[\"button_pressed_bit\" : false, \"facing_direction\" : 7] ",
         "[\"button_pressed_bit\" : true, \"facing_direction\" : 0] ",
         "[\"button_pressed_bit\" : true, \"facing_direction\" : 1] ",
         "[\"button_pressed_bit\" : true, \"facing_direction\" : 2] ",
         "[\"button_pressed_bit\" : true, \"facing_direction\" : 3] ",
         "[\"button_pressed_bit\" : true, \"facing_direction\" : 4] ",
         "[\"button_pressed_bit\" : true, \"facing_direction\" : 5] ",
         "[\"button_pressed_bit\" : true, \"facing_direction\" : 6] ",
         "[\"button_pressed_bit\" : true, \"facing_direction\" : 7] "
            },
        spruce_door ={
         "[\"direction\" : 0, \"door_hinge_bit\" : false, \"open_bit\" : false, \"upper_block_bit\" : false] ",
         "[\"direction\" : 1, \"door_hinge_bit\" : true, \"open_bit\" : false, \"upper_block_bit\" : false] ",
         "[\"direction\" : 2, \"door_hinge_bit\" : false, \"open_bit\" : false, \"upper_block_bit\" : false] ",
         "[\"direction\" : 3, \"door_hinge_bit\" : true, \"open_bit\" : false, \"upper_block_bit\" : false] ",
         "[\"direction\" : 0, \"door_hinge_bit\" : false, \"open_bit\" : true, \"upper_block_bit\" : false] ",
         "[\"direction\" : 1, \"door_hinge_bit\" : true, \"open_bit\" : true, \"upper_block_bit\" : false] ",
         "[\"direction\" : 2, \"door_hinge_bit\" : false, \"open_bit\" : true, \"upper_block_bit\" : false] ",
         "[\"direction\" : 3, \"door_hinge_bit\" : true, \"open_bit\" : true, \"upper_block_bit\" : false] ",
         "[\"direction\" : 0, \"door_hinge_bit\" : false, \"open_bit\" : false, \"upper_block_bit\" : true] ",
         "[\"direction\" : 1, \"door_hinge_bit\" : true, \"open_bit\" : false, \"upper_block_bit\" : true] ",
         "[\"direction\" : 2, \"door_hinge_bit\" : false, \"open_bit\" : false, \"upper_block_bit\" : true] ",
         "[\"direction\" : 3, \"door_hinge_bit\" : true, \"open_bit\" : false, \"upper_block_bit\" : true] ",
         "[\"direction\" : 0, \"door_hinge_bit\" : false, \"open_bit\" : true, \"upper_block_bit\" : true] ",
         "[\"direction\" : 1, \"door_hinge_bit\" : true, \"open_bit\" : true, \"upper_block_bit\" : true] ",
         "[\"direction\" : 2, \"door_hinge_bit\" : false, \"open_bit\" : true, \"upper_block_bit\" : true] ",
         "[\"direction\" : 3, \"door_hinge_bit\" : true, \"open_bit\" : true, \"upper_block_bit\" : true] ",
         "[\"direction\" : 0, \"door_hinge_bit\" : false, \"open_bit\" : false, \"upper_block_bit\" : false] ",
         "[\"direction\" : 1, \"door_hinge_bit\" : true, \"open_bit\" : false, \"upper_block_bit\" : false] ",
         "[\"direction\" : 2, \"door_hinge_bit\" : false, \"open_bit\" : false, \"upper_block_bit\" : false] ",
         "[\"direction\" : 3, \"door_hinge_bit\" : true, \"open_bit\" : false, \"upper_block_bit\" : false] ",
         "[\"direction\" : 0, \"door_hinge_bit\" : false, \"open_bit\" : true, \"upper_block_bit\" : false] ",
         "[\"direction\" : 1, \"door_hinge_bit\" : true, \"open_bit\" : true, \"upper_block_bit\" : false] ",
         "[\"direction\" : 2, \"door_hinge_bit\" : false, \"open_bit\" : true, \"upper_block_bit\" : false] ",
         "[\"direction\" : 3, \"door_hinge_bit\" : true, \"open_bit\" : true, \"upper_block_bit\" : false] ",
         "[\"direction\" : 0, \"door_hinge_bit\" : false, \"open_bit\" : false, \"upper_block_bit\" : true] ",
         "[\"direction\" : 1, \"door_hinge_bit\" : true, \"open_bit\" : false, \"upper_block_bit\" : true] ",
         "[\"direction\" : 2, \"door_hinge_bit\" : false, \"open_bit\" : false, \"upper_block_bit\" : true] ",
         "[\"direction\" : 3, \"door_hinge_bit\" : true, \"open_bit\" : false, \"upper_block_bit\" : true] ",
         "[\"direction\" : 0, \"door_hinge_bit\" : false, \"open_bit\" : true, \"upper_block_bit\" : true] ",
         "[\"direction\" : 1, \"door_hinge_bit\" : true, \"open_bit\" : true, \"upper_block_bit\" : true] ",
         "[\"direction\" : 2, \"door_hinge_bit\" : false, \"open_bit\" : true, \"upper_block_bit\" : true] ",
         "[\"direction\" : 3, \"door_hinge_bit\" : true, \"open_bit\" : true, \"upper_block_bit\" : true] "
            },
        spruce_fence_gate ={
         "[\"direction\" : 0, \"in_wall_bit\" : false, \"open_bit\" : false] ",
         "[\"direction\" : 1, \"in_wall_bit\" : false, \"open_bit\" : false] ",
         "[\"direction\" : 2, \"in_wall_bit\" : false, \"open_bit\" : false] ",
         "[\"direction\" : 3, \"in_wall_bit\" : false, \"open_bit\" : false] ",
         "[\"direction\" : 0, \"in_wall_bit\" : false, \"open_bit\" : true] ",
         "[\"direction\" : 1, \"in_wall_bit\" : false, \"open_bit\" : true] ",
         "[\"direction\" : 2, \"in_wall_bit\" : false, \"open_bit\" : true] ",
         "[\"direction\" : 3, \"in_wall_bit\" : false, \"open_bit\" : true] ",
         "[\"direction\" : 0, \"in_wall_bit\" : true, \"open_bit\" : false] ",
         "[\"direction\" : 1, \"in_wall_bit\" : true, \"open_bit\" : false] ",
         "[\"direction\" : 2, \"in_wall_bit\" : true, \"open_bit\" : false] ",
         "[\"direction\" : 3, \"in_wall_bit\" : true, \"open_bit\" : false] ",
         "[\"direction\" : 0, \"in_wall_bit\" : true, \"open_bit\" : true] ",
         "[\"direction\" : 1, \"in_wall_bit\" : true, \"open_bit\" : true] ",
         "[\"direction\" : 2, \"in_wall_bit\" : true, \"open_bit\" : true] ",
         "[\"direction\" : 3, \"in_wall_bit\" : true, \"open_bit\" : true] "
            },
        spruce_pressure_plate ={
         "[\"redstone_signal\" : 0] ",
         "[\"redstone_signal\" : 1] ",
         "[\"redstone_signal\" : 2] ",
         "[\"redstone_signal\" : 3] ",
         "[\"redstone_signal\" : 4] ",
         "[\"redstone_signal\" : 5] ",
         "[\"redstone_signal\" : 6] ",
         "[\"redstone_signal\" : 7] ",
         "[\"redstone_signal\" : 8] ",
         "[\"redstone_signal\" : 9] ",
         "[\"redstone_signal\" : 10] ",
         "[\"redstone_signal\" : 11] ",
         "[\"redstone_signal\" : 12] ",
         "[\"redstone_signal\" : 13] ",
         "[\"redstone_signal\" : 14] ",
         "[\"redstone_signal\" : 15] "
            },
        spruce_stairs ={
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 0] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 1] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 2] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 3] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 0] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 1] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 2] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 3] "
            },
        spruce_standing_sign ={
         "[\"ground_sign_direction\" : 0] ",
         "[\"ground_sign_direction\" : 1] ",
         "[\"ground_sign_direction\" : 2] ",
         "[\"ground_sign_direction\" : 3] ",
         "[\"ground_sign_direction\" : 4] ",
         "[\"ground_sign_direction\" : 5] ",
         "[\"ground_sign_direction\" : 6] ",
         "[\"ground_sign_direction\" : 7] ",
         "[\"ground_sign_direction\" : 8] ",
         "[\"ground_sign_direction\" : 9] ",
         "[\"ground_sign_direction\" : 10] ",
         "[\"ground_sign_direction\" : 11] ",
         "[\"ground_sign_direction\" : 12] ",
         "[\"ground_sign_direction\" : 13] ",
         "[\"ground_sign_direction\" : 14] ",
         "[\"ground_sign_direction\" : 15] "
            },
        spruce_trapdoor ={
         "[\"direction\" : 0, \"open_bit\" : false, \"upside_down_bit\" : false] ",
         "[\"direction\" : 1, \"open_bit\" : false, \"upside_down_bit\" : false] ",
         "[\"direction\" : 2, \"open_bit\" : false, \"upside_down_bit\" : false] ",
         "[\"direction\" : 3, \"open_bit\" : false, \"upside_down_bit\" : false] ",
         "[\"direction\" : 0, \"open_bit\" : false, \"upside_down_bit\" : true] ",
         "[\"direction\" : 1, \"open_bit\" : false, \"upside_down_bit\" : true] ",
         "[\"direction\" : 2, \"open_bit\" : false, \"upside_down_bit\" : true] ",
         "[\"direction\" : 3, \"open_bit\" : false, \"upside_down_bit\" : true] ",
         "[\"direction\" : 0, \"open_bit\" : true, \"upside_down_bit\" : false] ",
         "[\"direction\" : 1, \"open_bit\" : true, \"upside_down_bit\" : false] ",
         "[\"direction\" : 2, \"open_bit\" : true, \"upside_down_bit\" : false] ",
         "[\"direction\" : 3, \"open_bit\" : true, \"upside_down_bit\" : false] ",
         "[\"direction\" : 0, \"open_bit\" : true, \"upside_down_bit\" : true] ",
         "[\"direction\" : 1, \"open_bit\" : true, \"upside_down_bit\" : true] ",
         "[\"direction\" : 2, \"open_bit\" : true, \"upside_down_bit\" : true] ",
         "[\"direction\" : 3, \"open_bit\" : true, \"upside_down_bit\" : true] "
            },
        spruce_wall_sign ={
         "[\"facing_direction\" : 0] ",
         "[\"facing_direction\" : 1] ",
         "[\"facing_direction\" : 2] ",
         "[\"facing_direction\" : 3] ",
         "[\"facing_direction\" : 4] ",
         "[\"facing_direction\" : 5] ",
         "[\"facing_direction\" : 6] ",
         "[\"facing_direction\" : 7] "
            },
        stained_glass ={
         "[\"color\" : \"white\"] ",
         "[\"color\" : \"orange\"] ",
         "[\"color\" : \"magenta\"] ",
         "[\"color\" : \"light_blue\"] ",
         "[\"color\" : \"yellow\"] ",
         "[\"color\" : \"lime\"] ",
         "[\"color\" : \"pink\"] ",
         "[\"color\" : \"gray\"] ",
         "[\"color\" : \"silver\"] ",
         "[\"color\" : \"cyan\"] ",
         "[\"color\" : \"purple\"] ",
         "[\"color\" : \"blue\"] ",
         "[\"color\" : \"brown\"] ",
         "[\"color\" : \"green\"] ",
         "[\"color\" : \"red\"] ",
         "[\"color\" : \"black\"] "
            },
        stained_glass_pane ={
         "[\"color\" : \"white\"] ",
         "[\"color\" : \"orange\"] ",
         "[\"color\" : \"magenta\"] ",
         "[\"color\" : \"light_blue\"] ",
         "[\"color\" : \"yellow\"] ",
         "[\"color\" : \"lime\"] ",
         "[\"color\" : \"pink\"] ",
         "[\"color\" : \"gray\"] ",
         "[\"color\" : \"silver\"] ",
         "[\"color\" : \"cyan\"] ",
         "[\"color\" : \"purple\"] ",
         "[\"color\" : \"blue\"] ",
         "[\"color\" : \"brown\"] ",
         "[\"color\" : \"green\"] ",
         "[\"color\" : \"red\"] ",
         "[\"color\" : \"black\"] "
            },
        stained_hardened_clay ={
         "[\"color\" : \"white\"] ",
         "[\"color\" : \"orange\"] ",
         "[\"color\" : \"magenta\"] ",
         "[\"color\" : \"light_blue\"] ",
         "[\"color\" : \"yellow\"] ",
         "[\"color\" : \"lime\"] ",
         "[\"color\" : \"pink\"] ",
         "[\"color\" : \"gray\"] ",
         "[\"color\" : \"silver\"] ",
         "[\"color\" : \"cyan\"] ",
         "[\"color\" : \"purple\"] ",
         "[\"color\" : \"blue\"] ",
         "[\"color\" : \"brown\"] ",
         "[\"color\" : \"green\"] ",
         "[\"color\" : \"red\"] ",
         "[\"color\" : \"black\"] "
            },
        standing_banner ={
         "[\"ground_sign_direction\" : 0] ",
         "[\"ground_sign_direction\" : 1] ",
         "[\"ground_sign_direction\" : 2] ",
         "[\"ground_sign_direction\" : 3] ",
         "[\"ground_sign_direction\" : 4] ",
         "[\"ground_sign_direction\" : 5] ",
         "[\"ground_sign_direction\" : 6] ",
         "[\"ground_sign_direction\" : 7] ",
         "[\"ground_sign_direction\" : 8] ",
         "[\"ground_sign_direction\" : 9] ",
         "[\"ground_sign_direction\" : 10] ",
         "[\"ground_sign_direction\" : 11] ",
         "[\"ground_sign_direction\" : 12] ",
         "[\"ground_sign_direction\" : 13] ",
         "[\"ground_sign_direction\" : 14] ",
         "[\"ground_sign_direction\" : 15] "
            },
        standing_sign ={
         "[\"ground_sign_direction\" : 0] ",
         "[\"ground_sign_direction\" : 1] ",
         "[\"ground_sign_direction\" : 2] ",
         "[\"ground_sign_direction\" : 3] ",
         "[\"ground_sign_direction\" : 4] ",
         "[\"ground_sign_direction\" : 5] ",
         "[\"ground_sign_direction\" : 6] ",
         "[\"ground_sign_direction\" : 7] ",
         "[\"ground_sign_direction\" : 8] ",
         "[\"ground_sign_direction\" : 9] ",
         "[\"ground_sign_direction\" : 10] ",
         "[\"ground_sign_direction\" : 11] ",
         "[\"ground_sign_direction\" : 12] ",
         "[\"ground_sign_direction\" : 13] ",
         "[\"ground_sign_direction\" : 14] ",
         "[\"ground_sign_direction\" : 15] "
            },
        sticky_piston ={
         "[\"facing_direction\" : 0] ",
         "[\"facing_direction\" : 1] ",
         "[\"facing_direction\" : 2] ",
         "[\"facing_direction\" : 3] ",
         "[\"facing_direction\" : 4] ",
         "[\"facing_direction\" : 5] ",
         "[\"facing_direction\" : 6] ",
         "[\"facing_direction\" : 7] "
            },
        sticky_piston_arm_collision ={
         "[\"facing_direction\" : 0] ",
         "[\"facing_direction\" : 1] ",
         "[\"facing_direction\" : 2] ",
         "[\"facing_direction\" : 3] ",
         "[\"facing_direction\" : 4] ",
         "[\"facing_direction\" : 5] ",
         "[\"facing_direction\" : 6] ",
         "[\"facing_direction\" : 7] "
            },
        stone ={
         "[\"stone_type\" : \"stone\"] ",
         "[\"stone_type\" : \"granite\"] ",
         "[\"stone_type\" : \"granite_smooth\"] ",
         "[\"stone_type\" : \"diorite\"] ",
         "[\"stone_type\" : \"diorite_smooth\"] ",
         "[\"stone_type\" : \"andesite\"] ",
         "[\"stone_type\" : \"andesite_smooth\"] ",
         "[\"stone_type\" : \"stone\"] "
            },
        stone_block_slab ={
         "[\"stone_slab_type\" : \"smooth_stone\", \"top_slot_bit\" : false] ",
         "[\"stone_slab_type\" : \"sandstone\", \"top_slot_bit\" : false] ",
         "[\"stone_slab_type\" : \"wood\", \"top_slot_bit\" : false] ",
         "[\"stone_slab_type\" : \"cobblestone\", \"top_slot_bit\" : false] ",
         "[\"stone_slab_type\" : \"brick\", \"top_slot_bit\" : false] ",
         "[\"stone_slab_type\" : \"stone_brick\", \"top_slot_bit\" : false] ",
         "[\"stone_slab_type\" : \"quartz\", \"top_slot_bit\" : false] ",
         "[\"stone_slab_type\" : \"nether_brick\", \"top_slot_bit\" : false] ",
         "[\"stone_slab_type\" : \"smooth_stone\", \"top_slot_bit\" : true] ",
         "[\"stone_slab_type\" : \"sandstone\", \"top_slot_bit\" : true] ",
         "[\"stone_slab_type\" : \"wood\", \"top_slot_bit\" : true] ",
         "[\"stone_slab_type\" : \"cobblestone\", \"top_slot_bit\" : true] ",
         "[\"stone_slab_type\" : \"brick\", \"top_slot_bit\" : true] ",
         "[\"stone_slab_type\" : \"stone_brick\", \"top_slot_bit\" : true] ",
         "[\"stone_slab_type\" : \"quartz\", \"top_slot_bit\" : true] ",
         "[\"stone_slab_type\" : \"nether_brick\", \"top_slot_bit\" : true] "
            },
        stone_block_slab2 ={
         "[\"stone_slab_type_2\" : \"red_sandstone\", \"top_slot_bit\" : false] ",
         "[\"stone_slab_type_2\" : \"purpur\", \"top_slot_bit\" : false] ",
         "[\"stone_slab_type_2\" : \"prismarine_rough\", \"top_slot_bit\" : false] ",
         "[\"stone_slab_type_2\" : \"prismarine_dark\", \"top_slot_bit\" : false] ",
         "[\"stone_slab_type_2\" : \"prismarine_brick\", \"top_slot_bit\" : false] ",
         "[\"stone_slab_type_2\" : \"mossy_cobblestone\", \"top_slot_bit\" : false] ",
         "[\"stone_slab_type_2\" : \"smooth_sandstone\", \"top_slot_bit\" : false] ",
         "[\"stone_slab_type_2\" : \"red_nether_brick\", \"top_slot_bit\" : false] ",
         "[\"stone_slab_type_2\" : \"red_sandstone\", \"top_slot_bit\" : true] ",
         "[\"stone_slab_type_2\" : \"purpur\", \"top_slot_bit\" : true] ",
         "[\"stone_slab_type_2\" : \"prismarine_rough\", \"top_slot_bit\" : true] ",
         "[\"stone_slab_type_2\" : \"prismarine_dark\", \"top_slot_bit\" : true] ",
         "[\"stone_slab_type_2\" : \"prismarine_brick\", \"top_slot_bit\" : true] ",
         "[\"stone_slab_type_2\" : \"mossy_cobblestone\", \"top_slot_bit\" : true] ",
         "[\"stone_slab_type_2\" : \"smooth_sandstone\", \"top_slot_bit\" : true] ",
         "[\"stone_slab_type_2\" : \"red_nether_brick\", \"top_slot_bit\" : true] "
            },
        stone_block_slab3 ={
         "[\"stone_slab_type_3\" : \"end_stone_brick\", \"top_slot_bit\" : false] ",
         "[\"stone_slab_type_3\" : \"smooth_red_sandstone\", \"top_slot_bit\" : false] ",
         "[\"stone_slab_type_3\" : \"polished_andesite\", \"top_slot_bit\" : false] ",
         "[\"stone_slab_type_3\" : \"andesite\", \"top_slot_bit\" : false] ",
         "[\"stone_slab_type_3\" : \"diorite\", \"top_slot_bit\" : false] ",
         "[\"stone_slab_type_3\" : \"polished_diorite\", \"top_slot_bit\" : false] ",
         "[\"stone_slab_type_3\" : \"granite\", \"top_slot_bit\" : false] ",
         "[\"stone_slab_type_3\" : \"polished_granite\", \"top_slot_bit\" : false] ",
         "[\"stone_slab_type_3\" : \"end_stone_brick\", \"top_slot_bit\" : true] ",
         "[\"stone_slab_type_3\" : \"smooth_red_sandstone\", \"top_slot_bit\" : true] ",
         "[\"stone_slab_type_3\" : \"polished_andesite\", \"top_slot_bit\" : true] ",
         "[\"stone_slab_type_3\" : \"andesite\", \"top_slot_bit\" : true] ",
         "[\"stone_slab_type_3\" : \"diorite\", \"top_slot_bit\" : true] ",
         "[\"stone_slab_type_3\" : \"polished_diorite\", \"top_slot_bit\" : true] ",
         "[\"stone_slab_type_3\" : \"granite\", \"top_slot_bit\" : true] ",
         "[\"stone_slab_type_3\" : \"polished_granite\", \"top_slot_bit\" : true] "
            },
        stone_block_slab4 ={
         "[\"stone_slab_type_4\" : \"mossy_stone_brick\", \"top_slot_bit\" : false] ",
         "[\"stone_slab_type_4\" : \"smooth_quartz\", \"top_slot_bit\" : false] ",
         "[\"stone_slab_type_4\" : \"stone\", \"top_slot_bit\" : false] ",
         "[\"stone_slab_type_4\" : \"cut_sandstone\", \"top_slot_bit\" : false] ",
         "[\"stone_slab_type_4\" : \"cut_red_sandstone\", \"top_slot_bit\" : false] ",
         "[\"stone_slab_type_4\" : \"mossy_stone_brick\", \"top_slot_bit\" : false] "
            },
        stone_brick_stairs ={
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 0] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 1] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 2] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 3] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 0] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 1] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 2] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 3] "
            },
        stone_button ={
         "[\"button_pressed_bit\" : false, \"facing_direction\" : 0] ",
         "[\"button_pressed_bit\" : false, \"facing_direction\" : 1] ",
         "[\"button_pressed_bit\" : false, \"facing_direction\" : 2] ",
         "[\"button_pressed_bit\" : false, \"facing_direction\" : 3] ",
         "[\"button_pressed_bit\" : false, \"facing_direction\" : 4] ",
         "[\"button_pressed_bit\" : false, \"facing_direction\" : 5] ",
         "[\"button_pressed_bit\" : false, \"facing_direction\" : 6] ",
         "[\"button_pressed_bit\" : false, \"facing_direction\" : 7] ",
         "[\"button_pressed_bit\" : true, \"facing_direction\" : 0] ",
         "[\"button_pressed_bit\" : true, \"facing_direction\" : 1] ",
         "[\"button_pressed_bit\" : true, \"facing_direction\" : 2] ",
         "[\"button_pressed_bit\" : true, \"facing_direction\" : 3] ",
         "[\"button_pressed_bit\" : true, \"facing_direction\" : 4] ",
         "[\"button_pressed_bit\" : true, \"facing_direction\" : 5] ",
         "[\"button_pressed_bit\" : true, \"facing_direction\" : 6] ",
         "[\"button_pressed_bit\" : true, \"facing_direction\" : 7] "
            },
        stone_pressure_plate ={
         "[\"redstone_signal\" : 0] ",
         "[\"redstone_signal\" : 1] ",
         "[\"redstone_signal\" : 2] ",
         "[\"redstone_signal\" : 3] ",
         "[\"redstone_signal\" : 4] ",
         "[\"redstone_signal\" : 5] ",
         "[\"redstone_signal\" : 6] ",
         "[\"redstone_signal\" : 7] ",
         "[\"redstone_signal\" : 8] ",
         "[\"redstone_signal\" : 9] ",
         "[\"redstone_signal\" : 10] ",
         "[\"redstone_signal\" : 11] ",
         "[\"redstone_signal\" : 12] ",
         "[\"redstone_signal\" : 13] ",
         "[\"redstone_signal\" : 14] ",
         "[\"redstone_signal\" : 15] "
            },
        stone_stairs ={
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 0] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 1] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 2] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 3] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 0] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 1] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 2] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 3] "
            },
        stonebrick ={
         "[\"stone_brick_type\" : \"default\"] ",
         "[\"stone_brick_type\" : \"mossy\"] ",
         "[\"stone_brick_type\" : \"cracked\"] ",
         "[\"stone_brick_type\" : \"chiseled\"] ",
         "[\"stone_brick_type\" : \"smooth\"] ",
         "[\"stone_brick_type\" : \"default\"] "
            },
        stonecutter_block ={
         "[\"facing_direction\" : 0] ",
         "[\"facing_direction\" : 1] ",
         "[\"facing_direction\" : 2] ",
         "[\"facing_direction\" : 3] ",
         "[\"facing_direction\" : 4] ",
         "[\"facing_direction\" : 5] ",
         "[\"facing_direction\" : 6] ",
         "[\"facing_direction\" : 7] "
            },
        stripped_acacia_log ={
         "[\"direction\" : 0] ",
         "[\"direction\" : 1] ",
         "[\"direction\" : 2] ",
         "[\"direction\" : 3] "
            },
        stripped_birch_log ={
         "[\"direction\" : 0] ",
         "[\"direction\" : 1] ",
         "[\"direction\" : 2] ",
         "[\"direction\" : 3] "
            },
        stripped_crimson_hyphae ={
         "[\"pillar_axis\" : \"y\"] ",
         "[\"pillar_axis\" : \"x\"] ",
         "[\"pillar_axis\" : \"z\"] "
            },
        stripped_crimson_stem ={
         "[\"pillar_axis\" : \"y\"] ",
         "[\"pillar_axis\" : \"x\"] ",
         "[\"pillar_axis\" : \"z\"] "
            },
        stripped_dark_oak_log ={
         "[\"direction\" : 0] ",
         "[\"direction\" : 1] ",
         "[\"direction\" : 2] ",
         "[\"direction\" : 3] "
            },
        stripped_jungle_log ={
         "[\"direction\" : 0] ",
         "[\"direction\" : 1] ",
         "[\"direction\" : 2] ",
         "[\"direction\" : 3] "
            },
        stripped_mangrove_log ={
         "[\"pillar_axis\" : \"y\"] ",
         "[\"pillar_axis\" : \"x\"] ",
         "[\"pillar_axis\" : \"z\"] "
            },
        stripped_mangrove_wood ={
         "[\"pillar_axis\" : \"y\"] ",
         "[\"pillar_axis\" : \"x\"] ",
         "[\"pillar_axis\" : \"z\"] "
            },
        stripped_oak_log ={
         "[\"direction\" : 0] ",
         "[\"direction\" : 1] ",
         "[\"direction\" : 2] ",
         "[\"direction\" : 3] "
            },
        stripped_spruce_log ={
         "[\"direction\" : 0] ",
         "[\"direction\" : 1] ",
         "[\"direction\" : 2] ",
         "[\"direction\" : 3] "
            },
        stripped_warped_hyphae ={
         "[\"pillar_axis\" : \"y\"] ",
         "[\"pillar_axis\" : \"x\"] ",
         "[\"pillar_axis\" : \"z\"] "
            },
        stripped_warped_stem ={
         "[\"pillar_axis\" : \"y\"] ",
         "[\"pillar_axis\" : \"x\"] ",
         "[\"pillar_axis\" : \"z\"] "
            },
        structure_block ={
         "[\"structure_block_type\" : \"data\"] ",
         "[\"structure_block_type\" : \"save\"] ",
         "[\"structure_block_type\" : \"load\"] ",
         "[\"structure_block_type\" : \"corner\"] ",
         "[\"structure_block_type\" : \"invalid\"] ",
         "[\"structure_block_type\" : \"export\"] ",
         "[\"structure_block_type\" : \"data\"] "
            },
        structure_void ={
         "[\"structure_void_type\" : \"void\"] ",
         "[\"structure_void_type\" : \"air\"] "
            },
        sweet_berry_bush ={
         "[\"growth\" : 0] ",
         "[\"growth\" : 1] ",
         "[\"growth\" : 2] ",
         "[\"growth\" : 3] ",
         "[\"growth\" : 4] ",
         "[\"growth\" : 5] ",
         "[\"growth\" : 6] ",
         "[\"growth\" : 7] "
            },
        tallgrass ={
         "[\"tall_grass_type\" : \"default\"] ",
         "[\"tall_grass_type\" : \"tall\"] ",
         "[\"tall_grass_type\" : \"fern\"] ",
         "[\"tall_grass_type\" : \"snow\"] "
            },
        tnt ={
         "[\"allow_underwater_bit\" : false, \"explode_bit\" : false] ",
         "[\"allow_underwater_bit\" : false, \"explode_bit\" : true] ",
         "[\"allow_underwater_bit\" : true, \"explode_bit\" : false] ",
         "[\"allow_underwater_bit\" : true, \"explode_bit\" : true] "
            },
        torch ={
         "[\"torch_facing_direction\" : \"unknown\"] ",
         "[\"torch_facing_direction\" : \"west\"] ",
         "[\"torch_facing_direction\" : \"east\"] ",
         "[\"torch_facing_direction\" : \"north\"] ",
         "[\"torch_facing_direction\" : \"south\"] ",
         "[\"torch_facing_direction\" : \"top\"] ",
         "[\"torch_facing_direction\" : \"unknown\"] "
            },
        trapdoor ={
         "[\"direction\" : 0, \"open_bit\" : false, \"upside_down_bit\" : false] ",
         "[\"direction\" : 1, \"open_bit\" : false, \"upside_down_bit\" : false] ",
         "[\"direction\" : 2, \"open_bit\" : false, \"upside_down_bit\" : false] ",
         "[\"direction\" : 3, \"open_bit\" : false, \"upside_down_bit\" : false] ",
         "[\"direction\" : 0, \"open_bit\" : false, \"upside_down_bit\" : true] ",
         "[\"direction\" : 1, \"open_bit\" : false, \"upside_down_bit\" : true] ",
         "[\"direction\" : 2, \"open_bit\" : false, \"upside_down_bit\" : true] ",
         "[\"direction\" : 3, \"open_bit\" : false, \"upside_down_bit\" : true] ",
         "[\"direction\" : 0, \"open_bit\" : true, \"upside_down_bit\" : false] ",
         "[\"direction\" : 1, \"open_bit\" : true, \"upside_down_bit\" : false] ",
         "[\"direction\" : 2, \"open_bit\" : true, \"upside_down_bit\" : false] ",
         "[\"direction\" : 3, \"open_bit\" : true, \"upside_down_bit\" : false] ",
         "[\"direction\" : 0, \"open_bit\" : true, \"upside_down_bit\" : true] ",
         "[\"direction\" : 1, \"open_bit\" : true, \"upside_down_bit\" : true] ",
         "[\"direction\" : 2, \"open_bit\" : true, \"upside_down_bit\" : true] ",
         "[\"direction\" : 3, \"open_bit\" : true, \"upside_down_bit\" : true] "
            },
        trapped_chest ={
         "[\"facing_direction\" : 0] ",
         "[\"facing_direction\" : 1] ",
         "[\"facing_direction\" : 2] ",
         "[\"facing_direction\" : 3] ",
         "[\"facing_direction\" : 4] ",
         "[\"facing_direction\" : 5] ",
         "[\"facing_direction\" : 6] ",
         "[\"facing_direction\" : 7] "
            },
        trip_wire ={
         "[\"attached_bit\" : false, \"disarmed_bit\" : false, \"powered_bit\" : false, \"suspended_bit\" : false] ",
         "[\"attached_bit\" : false, \"disarmed_bit\" : false, \"powered_bit\" : true, \"suspended_bit\" : false] ",
         "[\"attached_bit\" : false, \"disarmed_bit\" : false, \"powered_bit\" : false, \"suspended_bit\" : true] ",
         "[\"attached_bit\" : false, \"disarmed_bit\" : false, \"powered_bit\" : true, \"suspended_bit\" : true] ",
         "[\"attached_bit\" : true, \"disarmed_bit\" : false, \"powered_bit\" : false, \"suspended_bit\" : false] ",
         "[\"attached_bit\" : true, \"disarmed_bit\" : false, \"powered_bit\" : true, \"suspended_bit\" : false] ",
         "[\"attached_bit\" : true, \"disarmed_bit\" : false, \"powered_bit\" : false, \"suspended_bit\" : true] ",
         "[\"attached_bit\" : true, \"disarmed_bit\" : false, \"powered_bit\" : true, \"suspended_bit\" : true] ",
         "[\"attached_bit\" : false, \"disarmed_bit\" : true, \"powered_bit\" : false, \"suspended_bit\" : false] ",
         "[\"attached_bit\" : false, \"disarmed_bit\" : true, \"powered_bit\" : true, \"suspended_bit\" : false] ",
         "[\"attached_bit\" : false, \"disarmed_bit\" : true, \"powered_bit\" : false, \"suspended_bit\" : true] ",
         "[\"attached_bit\" : false, \"disarmed_bit\" : true, \"powered_bit\" : true, \"suspended_bit\" : true] ",
         "[\"attached_bit\" : true, \"disarmed_bit\" : true, \"powered_bit\" : false, \"suspended_bit\" : false] ",
         "[\"attached_bit\" : true, \"disarmed_bit\" : true, \"powered_bit\" : true, \"suspended_bit\" : false] ",
         "[\"attached_bit\" : true, \"disarmed_bit\" : true, \"powered_bit\" : false, \"suspended_bit\" : true] ",
         "[\"attached_bit\" : true, \"disarmed_bit\" : true, \"powered_bit\" : true, \"suspended_bit\" : true] "
            },
        tripwire_hook ={
         "[\"attached_bit\" : false, \"direction\" : 0, \"powered_bit\" : false] ",
         "[\"attached_bit\" : false, \"direction\" : 1, \"powered_bit\" : false] ",
         "[\"attached_bit\" : false, \"direction\" : 2, \"powered_bit\" : false] ",
         "[\"attached_bit\" : false, \"direction\" : 3, \"powered_bit\" : false] ",
         "[\"attached_bit\" : true, \"direction\" : 0, \"powered_bit\" : false] ",
         "[\"attached_bit\" : true, \"direction\" : 1, \"powered_bit\" : false] ",
         "[\"attached_bit\" : true, \"direction\" : 2, \"powered_bit\" : false] ",
         "[\"attached_bit\" : true, \"direction\" : 3, \"powered_bit\" : false] ",
         "[\"attached_bit\" : false, \"direction\" : 0, \"powered_bit\" : true] ",
         "[\"attached_bit\" : false, \"direction\" : 1, \"powered_bit\" : true] ",
         "[\"attached_bit\" : false, \"direction\" : 2, \"powered_bit\" : true] ",
         "[\"attached_bit\" : false, \"direction\" : 3, \"powered_bit\" : true] ",
         "[\"attached_bit\" : true, \"direction\" : 0, \"powered_bit\" : true] ",
         "[\"attached_bit\" : true, \"direction\" : 1, \"powered_bit\" : true] ",
         "[\"attached_bit\" : true, \"direction\" : 2, \"powered_bit\" : true] ",
         "[\"attached_bit\" : true, \"direction\" : 3, \"powered_bit\" : true] "
            },
        turtle_egg ={
         "[\"cracked_state\" : \"no_cracks\", \"turtle_egg_count\" : \"one_egg\"] ",
         "[\"cracked_state\" : \"no_cracks\", \"turtle_egg_count\" : \"two_egg\"] ",
         "[\"cracked_state\" : \"no_cracks\", \"turtle_egg_count\" : \"three_egg\"] ",
         "[\"cracked_state\" : \"no_cracks\", \"turtle_egg_count\" : \"four_egg\"] ",
         "[\"cracked_state\" : \"cracked\", \"turtle_egg_count\" : \"one_egg\"] ",
         "[\"cracked_state\" : \"cracked\", \"turtle_egg_count\" : \"two_egg\"] ",
         "[\"cracked_state\" : \"cracked\", \"turtle_egg_count\" : \"three_egg\"] ",
         "[\"cracked_state\" : \"cracked\", \"turtle_egg_count\" : \"four_egg\"] ",
         "[\"cracked_state\" : \"max_cracked\", \"turtle_egg_count\" : \"one_egg\"] ",
         "[\"cracked_state\" : \"max_cracked\", \"turtle_egg_count\" : \"two_egg\"] ",
         "[\"cracked_state\" : \"max_cracked\", \"turtle_egg_count\" : \"three_egg\"] ",
         "[\"cracked_state\" : \"max_cracked\", \"turtle_egg_count\" : \"four_egg\"] ",
         "[\"cracked_state\" : \"no_cracks\", \"turtle_egg_count\" : \"one_egg\"] ",
         "[\"cracked_state\" : \"no_cracks\", \"turtle_egg_count\" : \"two_egg\"] ",
         "[\"cracked_state\" : \"no_cracks\", \"turtle_egg_count\" : \"three_egg\"] ",
         "[\"cracked_state\" : \"no_cracks\", \"turtle_egg_count\" : \"four_egg\"] "
            },
        twisting_vines ={
         "[\"twisting_vines_age\" : 0] ",
         "[\"twisting_vines_age\" : 1] ",
         "[\"twisting_vines_age\" : 2] ",
         "[\"twisting_vines_age\" : 3] ",
         "[\"twisting_vines_age\" : 4] ",
         "[\"twisting_vines_age\" : 5] ",
         "[\"twisting_vines_age\" : 6] ",
         "[\"twisting_vines_age\" : 7] ",
         "[\"twisting_vines_age\" : 8] ",
         "[\"twisting_vines_age\" : 9] ",
         "[\"twisting_vines_age\" : 10] ",
         "[\"twisting_vines_age\" : 11] ",
         "[\"twisting_vines_age\" : 12] ",
         "[\"twisting_vines_age\" : 13] ",
         "[\"twisting_vines_age\" : 14] ",
         "[\"twisting_vines_age\" : 15] ",
         "[\"twisting_vines_age\" : 16] ",
         "[\"twisting_vines_age\" : 17] ",
         "[\"twisting_vines_age\" : 18] ",
         "[\"twisting_vines_age\" : 19] ",
         "[\"twisting_vines_age\" : 20] ",
         "[\"twisting_vines_age\" : 21] ",
         "[\"twisting_vines_age\" : 22] ",
         "[\"twisting_vines_age\" : 23] ",
         "[\"twisting_vines_age\" : 24] ",
         "[\"twisting_vines_age\" : 25] "
            },
        underwater_torch ={
         "[\"torch_facing_direction\" : \"unknown\"] ",
         "[\"torch_facing_direction\" : \"west\"] ",
         "[\"torch_facing_direction\" : \"east\"] ",
         "[\"torch_facing_direction\" : \"north\"] ",
         "[\"torch_facing_direction\" : \"south\"] ",
         "[\"torch_facing_direction\" : \"top\"] ",
         "[\"torch_facing_direction\" : \"unknown\"] "
            },
        unlit_redstone_torch ={
         "[\"torch_facing_direction\" : \"unknown\"] ",
         "[\"torch_facing_direction\" : \"west\"] ",
         "[\"torch_facing_direction\" : \"east\"] ",
         "[\"torch_facing_direction\" : \"north\"] ",
         "[\"torch_facing_direction\" : \"south\"] ",
         "[\"torch_facing_direction\" : \"top\"] ",
         "[\"torch_facing_direction\" : \"unknown\"] "
            },
        unpowered_comparator ={
         "[\"direction\" : 0, \"output_lit_bit\" : false, \"output_subtract_bit\" : false] ",
         "[\"direction\" : 1, \"output_lit_bit\" : false, \"output_subtract_bit\" : false] ",
         "[\"direction\" : 2, \"output_lit_bit\" : false, \"output_subtract_bit\" : false] ",
         "[\"direction\" : 3, \"output_lit_bit\" : false, \"output_subtract_bit\" : false] ",
         "[\"direction\" : 0, \"output_lit_bit\" : false, \"output_subtract_bit\" : true] ",
         "[\"direction\" : 1, \"output_lit_bit\" : false, \"output_subtract_bit\" : true] ",
         "[\"direction\" : 2, \"output_lit_bit\" : false, \"output_subtract_bit\" : true] ",
         "[\"direction\" : 3, \"output_lit_bit\" : false, \"output_subtract_bit\" : true] ",
         "[\"direction\" : 0, \"output_lit_bit\" : true, \"output_subtract_bit\" : false] ",
         "[\"direction\" : 1, \"output_lit_bit\" : true, \"output_subtract_bit\" : false] ",
         "[\"direction\" : 2, \"output_lit_bit\" : true, \"output_subtract_bit\" : false] ",
         "[\"direction\" : 3, \"output_lit_bit\" : true, \"output_subtract_bit\" : false] ",
         "[\"direction\" : 0, \"output_lit_bit\" : true, \"output_subtract_bit\" : true] ",
         "[\"direction\" : 1, \"output_lit_bit\" : true, \"output_subtract_bit\" : true] ",
         "[\"direction\" : 2, \"output_lit_bit\" : true, \"output_subtract_bit\" : true] ",
         "[\"direction\" : 3, \"output_lit_bit\" : true, \"output_subtract_bit\" : true] "
            },
        unpowered_repeater ={
         "[\"direction\" : 0, \"repeater_delay\" : 0] ",
         "[\"direction\" : 1, \"repeater_delay\" : 0] ",
         "[\"direction\" : 2, \"repeater_delay\" : 0] ",
         "[\"direction\" : 3, \"repeater_delay\" : 0] ",
         "[\"direction\" : 0, \"repeater_delay\" : 1] ",
         "[\"direction\" : 1, \"repeater_delay\" : 1] ",
         "[\"direction\" : 2, \"repeater_delay\" : 1] ",
         "[\"direction\" : 3, \"repeater_delay\" : 1] ",
         "[\"direction\" : 0, \"repeater_delay\" : 2] ",
         "[\"direction\" : 1, \"repeater_delay\" : 2] ",
         "[\"direction\" : 2, \"repeater_delay\" : 2] ",
         "[\"direction\" : 3, \"repeater_delay\" : 2] ",
         "[\"direction\" : 0, \"repeater_delay\" : 3] ",
         "[\"direction\" : 1, \"repeater_delay\" : 3] ",
         "[\"direction\" : 2, \"repeater_delay\" : 3] ",
         "[\"direction\" : 3, \"repeater_delay\" : 3] "
            },
        vine ={
         "[\"vine_direction_bits\" : 0] ",
         "[\"vine_direction_bits\" : 1] ",
         "[\"vine_direction_bits\" : 2] ",
         "[\"vine_direction_bits\" : 3] ",
         "[\"vine_direction_bits\" : 4] ",
         "[\"vine_direction_bits\" : 5] ",
         "[\"vine_direction_bits\" : 6] ",
         "[\"vine_direction_bits\" : 7] ",
         "[\"vine_direction_bits\" : 8] ",
         "[\"vine_direction_bits\" : 9] ",
         "[\"vine_direction_bits\" : 10] ",
         "[\"vine_direction_bits\" : 11] ",
         "[\"vine_direction_bits\" : 12] ",
         "[\"vine_direction_bits\" : 13] ",
         "[\"vine_direction_bits\" : 14] ",
         "[\"vine_direction_bits\" : 15] "
            },
        wall_banner ={
         "[\"facing_direction\" : 0] ",
         "[\"facing_direction\" : 1] ",
         "[\"facing_direction\" : 2] ",
         "[\"facing_direction\" : 3] ",
         "[\"facing_direction\" : 4] ",
         "[\"facing_direction\" : 5] ",
         "[\"facing_direction\" : 6] ",
         "[\"facing_direction\" : 7] "
            },
        wall_sign ={
         "[\"facing_direction\" : 0] ",
         "[\"facing_direction\" : 1] ",
         "[\"facing_direction\" : 2] ",
         "[\"facing_direction\" : 3] ",
         "[\"facing_direction\" : 4] ",
         "[\"facing_direction\" : 5] ",
         "[\"facing_direction\" : 6] ",
         "[\"facing_direction\" : 7] "
            },
        warped_button ={
         "[\"button_pressed_bit\" : false, \"facing_direction\" : 0] ",
         "[\"button_pressed_bit\" : false, \"facing_direction\" : 1] ",
         "[\"button_pressed_bit\" : false, \"facing_direction\" : 2] ",
         "[\"button_pressed_bit\" : false, \"facing_direction\" : 3] ",
         "[\"button_pressed_bit\" : false, \"facing_direction\" : 4] ",
         "[\"button_pressed_bit\" : false, \"facing_direction\" : 5] ",
         "[\"button_pressed_bit\" : false, \"facing_direction\" : 6] ",
         "[\"button_pressed_bit\" : false, \"facing_direction\" : 7] ",
         "[\"button_pressed_bit\" : true, \"facing_direction\" : 0] ",
         "[\"button_pressed_bit\" : true, \"facing_direction\" : 1] ",
         "[\"button_pressed_bit\" : true, \"facing_direction\" : 2] ",
         "[\"button_pressed_bit\" : true, \"facing_direction\" : 3] ",
         "[\"button_pressed_bit\" : true, \"facing_direction\" : 4] ",
         "[\"button_pressed_bit\" : true, \"facing_direction\" : 5] ",
         "[\"button_pressed_bit\" : true, \"facing_direction\" : 6] ",
         "[\"button_pressed_bit\" : true, \"facing_direction\" : 7] "
            },
        warped_door ={
         "[\"direction\" : 0, \"door_hinge_bit\" : false, \"open_bit\" : false, \"upper_block_bit\" : false] ",
         "[\"direction\" : 1, \"door_hinge_bit\" : true, \"open_bit\" : false, \"upper_block_bit\" : false] ",
         "[\"direction\" : 2, \"door_hinge_bit\" : false, \"open_bit\" : false, \"upper_block_bit\" : false] ",
         "[\"direction\" : 3, \"door_hinge_bit\" : true, \"open_bit\" : false, \"upper_block_bit\" : false] ",
         "[\"direction\" : 0, \"door_hinge_bit\" : false, \"open_bit\" : true, \"upper_block_bit\" : false] ",
         "[\"direction\" : 1, \"door_hinge_bit\" : true, \"open_bit\" : true, \"upper_block_bit\" : false] ",
         "[\"direction\" : 2, \"door_hinge_bit\" : false, \"open_bit\" : true, \"upper_block_bit\" : false] ",
         "[\"direction\" : 3, \"door_hinge_bit\" : true, \"open_bit\" : true, \"upper_block_bit\" : false] ",
         "[\"direction\" : 0, \"door_hinge_bit\" : false, \"open_bit\" : false, \"upper_block_bit\" : true] ",
         "[\"direction\" : 1, \"door_hinge_bit\" : true, \"open_bit\" : false, \"upper_block_bit\" : true] ",
         "[\"direction\" : 2, \"door_hinge_bit\" : false, \"open_bit\" : false, \"upper_block_bit\" : true] ",
         "[\"direction\" : 3, \"door_hinge_bit\" : true, \"open_bit\" : false, \"upper_block_bit\" : true] ",
         "[\"direction\" : 0, \"door_hinge_bit\" : false, \"open_bit\" : true, \"upper_block_bit\" : true] ",
         "[\"direction\" : 1, \"door_hinge_bit\" : true, \"open_bit\" : true, \"upper_block_bit\" : true] ",
         "[\"direction\" : 2, \"door_hinge_bit\" : false, \"open_bit\" : true, \"upper_block_bit\" : true] ",
         "[\"direction\" : 3, \"door_hinge_bit\" : true, \"open_bit\" : true, \"upper_block_bit\" : true] ",
         "[\"direction\" : 0, \"door_hinge_bit\" : false, \"open_bit\" : false, \"upper_block_bit\" : false] ",
         "[\"direction\" : 1, \"door_hinge_bit\" : true, \"open_bit\" : false, \"upper_block_bit\" : false] ",
         "[\"direction\" : 2, \"door_hinge_bit\" : false, \"open_bit\" : false, \"upper_block_bit\" : false] ",
         "[\"direction\" : 3, \"door_hinge_bit\" : true, \"open_bit\" : false, \"upper_block_bit\" : false] ",
         "[\"direction\" : 0, \"door_hinge_bit\" : false, \"open_bit\" : true, \"upper_block_bit\" : false] ",
         "[\"direction\" : 1, \"door_hinge_bit\" : true, \"open_bit\" : true, \"upper_block_bit\" : false] ",
         "[\"direction\" : 2, \"door_hinge_bit\" : false, \"open_bit\" : true, \"upper_block_bit\" : false] ",
         "[\"direction\" : 3, \"door_hinge_bit\" : true, \"open_bit\" : true, \"upper_block_bit\" : false] ",
         "[\"direction\" : 0, \"door_hinge_bit\" : false, \"open_bit\" : false, \"upper_block_bit\" : true] ",
         "[\"direction\" : 1, \"door_hinge_bit\" : true, \"open_bit\" : false, \"upper_block_bit\" : true] ",
         "[\"direction\" : 2, \"door_hinge_bit\" : false, \"open_bit\" : false, \"upper_block_bit\" : true] ",
         "[\"direction\" : 3, \"door_hinge_bit\" : true, \"open_bit\" : false, \"upper_block_bit\" : true] ",
         "[\"direction\" : 0, \"door_hinge_bit\" : false, \"open_bit\" : true, \"upper_block_bit\" : true] ",
         "[\"direction\" : 1, \"door_hinge_bit\" : true, \"open_bit\" : true, \"upper_block_bit\" : true] ",
         "[\"direction\" : 2, \"door_hinge_bit\" : false, \"open_bit\" : true, \"upper_block_bit\" : true] ",
         "[\"direction\" : 3, \"door_hinge_bit\" : true, \"open_bit\" : true, \"upper_block_bit\" : true] "
            },
        warped_fence_gate ={
         "[\"direction\" : 0, \"in_wall_bit\" : false, \"open_bit\" : false] ",
         "[\"direction\" : 1, \"in_wall_bit\" : false, \"open_bit\" : false] ",
         "[\"direction\" : 2, \"in_wall_bit\" : false, \"open_bit\" : false] ",
         "[\"direction\" : 3, \"in_wall_bit\" : false, \"open_bit\" : false] ",
         "[\"direction\" : 0, \"in_wall_bit\" : false, \"open_bit\" : true] ",
         "[\"direction\" : 1, \"in_wall_bit\" : false, \"open_bit\" : true] ",
         "[\"direction\" : 2, \"in_wall_bit\" : false, \"open_bit\" : true] ",
         "[\"direction\" : 3, \"in_wall_bit\" : false, \"open_bit\" : true] ",
         "[\"direction\" : 0, \"in_wall_bit\" : true, \"open_bit\" : false] ",
         "[\"direction\" : 1, \"in_wall_bit\" : true, \"open_bit\" : false] ",
         "[\"direction\" : 2, \"in_wall_bit\" : true, \"open_bit\" : false] ",
         "[\"direction\" : 3, \"in_wall_bit\" : true, \"open_bit\" : false] ",
         "[\"direction\" : 0, \"in_wall_bit\" : true, \"open_bit\" : true] ",
         "[\"direction\" : 1, \"in_wall_bit\" : true, \"open_bit\" : true] ",
         "[\"direction\" : 2, \"in_wall_bit\" : true, \"open_bit\" : true] ",
         "[\"direction\" : 3, \"in_wall_bit\" : true, \"open_bit\" : true] "
            },
        warped_hyphae ={
         "[\"pillar_axis\" : \"y\"] ",
         "[\"pillar_axis\" : \"x\"] ",
         "[\"pillar_axis\" : \"z\"] "
            },
        warped_slab ={
         "[\"top_slot_bit\" : false] ",
         "[\"top_slot_bit\" : true] "
            },
        warped_stairs ={
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 0] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 1] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 2] ",
         "[\"upside_down_bit\" : false, \"weirdo_direction\" : 3] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 0] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 1] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 2] ",
         "[\"upside_down_bit\" : true, \"weirdo_direction\" : 3] "
            },
        warped_standing_sign ={
         "[\"ground_sign_direction\" : 0] ",
         "[\"ground_sign_direction\" : 1] ",
         "[\"ground_sign_direction\" : 2] ",
         "[\"ground_sign_direction\" : 3] ",
         "[\"ground_sign_direction\" : 4] ",
         "[\"ground_sign_direction\" : 5] ",
         "[\"ground_sign_direction\" : 6] ",
         "[\"ground_sign_direction\" : 7] ",
         "[\"ground_sign_direction\" : 8] ",
         "[\"ground_sign_direction\" : 9] ",
         "[\"ground_sign_direction\" : 10] ",
         "[\"ground_sign_direction\" : 11] ",
         "[\"ground_sign_direction\" : 12] ",
         "[\"ground_sign_direction\" : 13] ",
         "[\"ground_sign_direction\" : 14] ",
         "[\"ground_sign_direction\" : 15] "
            },
        warped_stem ={
         "[\"pillar_axis\" : \"y\"] ",
         "[\"pillar_axis\" : \"x\"] ",
         "[\"pillar_axis\" : \"z\"] "
            },
        warped_trapdoor ={
         "[\"direction\" : 0, \"open_bit\" : false, \"upside_down_bit\" : false] ",
         "[\"direction\" : 1, \"open_bit\" : false, \"upside_down_bit\" : false] ",
         "[\"direction\" : 2, \"open_bit\" : false, \"upside_down_bit\" : false] ",
         "[\"direction\" : 3, \"open_bit\" : false, \"upside_down_bit\" : false] ",
         "[\"direction\" : 0, \"open_bit\" : false, \"upside_down_bit\" : true] ",
         "[\"direction\" : 1, \"open_bit\" : false, \"upside_down_bit\" : true] ",
         "[\"direction\" : 2, \"open_bit\" : false, \"upside_down_bit\" : true] ",
         "[\"direction\" : 3, \"open_bit\" : false, \"upside_down_bit\" : true] ",
         "[\"direction\" : 0, \"open_bit\" : true, \"upside_down_bit\" : false] ",
         "[\"direction\" : 1, \"open_bit\" : true, \"upside_down_bit\" : false] ",
         "[\"direction\" : 2, \"open_bit\" : true, \"upside_down_bit\" : false] ",
         "[\"direction\" : 3, \"open_bit\" : true, \"upside_down_bit\" : false] ",
         "[\"direction\" : 0, \"open_bit\" : true, \"upside_down_bit\" : true] ",
         "[\"direction\" : 1, \"open_bit\" : true, \"upside_down_bit\" : true] ",
         "[\"direction\" : 2, \"open_bit\" : true, \"upside_down_bit\" : true] ",
         "[\"direction\" : 3, \"open_bit\" : true, \"upside_down_bit\" : true] "
            },
        warped_wall_sign ={
         "[\"facing_direction\" : 0] ",
         "[\"facing_direction\" : 1] ",
         "[\"facing_direction\" : 2] ",
         "[\"facing_direction\" : 3] ",
         "[\"facing_direction\" : 4] ",
         "[\"facing_direction\" : 5] ",
         "[\"facing_direction\" : 6] ",
         "[\"facing_direction\" : 7] "
            },
        water ={
         "[\"liquid_depth\" : 0] ",
         "[\"liquid_depth\" : 1] ",
         "[\"liquid_depth\" : 2] ",
         "[\"liquid_depth\" : 3] ",
         "[\"liquid_depth\" : 4] ",
         "[\"liquid_depth\" : 5] ",
         "[\"liquid_depth\" : 6] ",
         "[\"liquid_depth\" : 7] ",
         "[\"liquid_depth\" : 8] ",
         "[\"liquid_depth\" : 9] ",
         "[\"liquid_depth\" : 10] ",
         "[\"liquid_depth\" : 11] ",
         "[\"liquid_depth\" : 12] ",
         "[\"liquid_depth\" : 13] ",
         "[\"liquid_depth\" : 14] ",
         "[\"liquid_depth\" : 15] "
            },
        waxed_cut_copper_slab ={
         "[\"top_slot_bit\" : false] ",
         "[\"top_slot_bit\" : true] "
            },
        waxed_exposed_cut_copper_slab ={
         "[\"top_slot_bit\" : false] ",
         "[\"top_slot_bit\" : true] "
            },
        waxed_oxidized_cut_copper_slab ={
         "[\"top_slot_bit\" : false] ",
         "[\"top_slot_bit\" : true] "
            },
        waxed_weathered_cut_copper_slab ={
         "[\"top_slot_bit\" : false] ",
         "[\"top_slot_bit\" : true] "
            },
        weathered_cut_copper_slab ={
         "[\"top_slot_bit\" : false] ",
         "[\"top_slot_bit\" : true] "
            },
        weeping_vines ={
         "[\"weeping_vines_age\" : 0] ",
         "[\"weeping_vines_age\" : 1] ",
         "[\"weeping_vines_age\" : 2] ",
         "[\"weeping_vines_age\" : 3] ",
         "[\"weeping_vines_age\" : 4] ",
         "[\"weeping_vines_age\" : 5] ",
         "[\"weeping_vines_age\" : 6] ",
         "[\"weeping_vines_age\" : 7] ",
         "[\"weeping_vines_age\" : 8] ",
         "[\"weeping_vines_age\" : 9] ",
         "[\"weeping_vines_age\" : 10] ",
         "[\"weeping_vines_age\" : 11] ",
         "[\"weeping_vines_age\" : 12] ",
         "[\"weeping_vines_age\" : 13] ",
         "[\"weeping_vines_age\" : 14] ",
         "[\"weeping_vines_age\" : 15] ",
         "[\"weeping_vines_age\" : 16] ",
         "[\"weeping_vines_age\" : 17] ",
         "[\"weeping_vines_age\" : 18] ",
         "[\"weeping_vines_age\" : 19] ",
         "[\"weeping_vines_age\" : 20] ",
         "[\"weeping_vines_age\" : 21] ",
         "[\"weeping_vines_age\" : 22] ",
         "[\"weeping_vines_age\" : 23] ",
         "[\"weeping_vines_age\" : 24] ",
         "[\"weeping_vines_age\" : 25] "
            },
        wheat ={
         "[\"growth\" : 0] ",
         "[\"growth\" : 1] ",
         "[\"growth\" : 2] ",
         "[\"growth\" : 3] ",
         "[\"growth\" : 4] ",
         "[\"growth\" : 5] ",
         "[\"growth\" : 6] ",
         "[\"growth\" : 7] "
            },
        white_candle ={
         "[\"candles\" : 0, \"lit\" : false] ",
         "[\"candles\" : 1, \"lit\" : false] ",
         "[\"candles\" : 2, \"lit\" : false] ",
         "[\"candles\" : 3, \"lit\" : false] ",
         "[\"candles\" : 0, \"lit\" : true] ",
         "[\"candles\" : 1, \"lit\" : true] ",
         "[\"candles\" : 2, \"lit\" : true] ",
         "[\"candles\" : 3, \"lit\" : true] "
            },
        white_candle_cake ={
         "[\"lit\" : false] ",
         "[\"lit\" : true] "
            },
        white_glazed_terracotta ={
         "[\"facing_direction\" : 0] ",
         "[\"facing_direction\" : 1] ",
         "[\"facing_direction\" : 2] ",
         "[\"facing_direction\" : 3] ",
         "[\"facing_direction\" : 4] ",
         "[\"facing_direction\" : 5] ",
         "[\"facing_direction\" : 6] ",
         "[\"facing_direction\" : 7] "
            },
        wood ={ --                  the downloaded files didnt have stripped values so i attempted to add them though it doesnt really work
         "[\"stripped_bit\" : false, \"wood_type\" : \"oak\"] ",
         "[\"stripped_bit\" : false, \"wood_type\" : \"spruce\"] ",
         "[\"stripped_bit\" : false, \"wood_type\" : \"birch\"] ",
         "[\"stripped_bit\" : false, \"wood_type\" : \"jungle\"] ",
         "[\"stripped_bit\" : false, \"wood_type\" : \"acacia\"] ",
         "[\"stripped_bit\" : false, \"wood_type\" : \"dark_oak\"] ",
         "[\"stripped_bit\" : false, \"wood_type\" : \"oak\"] ",
         
         "[\"stripped_bit\" : true, \"wood_type\" : \"spruce\"] ",
         "[\"stripped_bit\" : true, \"wood_type\" : \"birch\"] ",
         "[\"stripped_bit\" : true, \"wood_type\" : \"jungle\"] ",
         "[\"stripped_bit\" : true, \"wood_type\" : \"acacia\"] ",
         "[\"stripped_bit\" : true, \"wood_type\" : \"oak\"] ",
         "[\"stripped_bit\" : true, \"wood_type\" : \"dark_oak\"] ",
         "[\"stripped_bit\" : true, \"wood_type\" : \"oak\"] ",
         "[\"stripped_bit\" : true, \"wood_type\" : \"oak\"] "
            },
        wooden_button ={
         "[\"button_pressed_bit\" : false, \"facing_direction\" : 0] ",
         "[\"button_pressed_bit\" : false, \"facing_direction\" : 1] ",
         "[\"button_pressed_bit\" : false, \"facing_direction\" : 2] ",
         "[\"button_pressed_bit\" : false, \"facing_direction\" : 3] ",
         "[\"button_pressed_bit\" : false, \"facing_direction\" : 4] ",
         "[\"button_pressed_bit\" : false, \"facing_direction\" : 5] ",
         "[\"button_pressed_bit\" : false, \"facing_direction\" : 6] ",
         "[\"button_pressed_bit\" : false, \"facing_direction\" : 7] ",
         "[\"button_pressed_bit\" : true, \"facing_direction\" : 0] ",
         "[\"button_pressed_bit\" : true, \"facing_direction\" : 1] ",
         "[\"button_pressed_bit\" : true, \"facing_direction\" : 2] ",
         "[\"button_pressed_bit\" : true, \"facing_direction\" : 3] ",
         "[\"button_pressed_bit\" : true, \"facing_direction\" : 4] ",
         "[\"button_pressed_bit\" : true, \"facing_direction\" : 5] ",
         "[\"button_pressed_bit\" : true, \"facing_direction\" : 6] ",
         "[\"button_pressed_bit\" : true, \"facing_direction\" : 7] "
            },
        wooden_door ={
         "[\"direction\" : 0, \"door_hinge_bit\" : false, \"open_bit\" : false, \"upper_block_bit\" : false] ",
         "[\"direction\" : 1, \"door_hinge_bit\" : true, \"open_bit\" : false, \"upper_block_bit\" : false] ",
         "[\"direction\" : 2, \"door_hinge_bit\" : false, \"open_bit\" : false, \"upper_block_bit\" : false] ",
         "[\"direction\" : 3, \"door_hinge_bit\" : true, \"open_bit\" : false, \"upper_block_bit\" : false] ",
         "[\"direction\" : 0, \"door_hinge_bit\" : false, \"open_bit\" : true, \"upper_block_bit\" : false] ",
         "[\"direction\" : 1, \"door_hinge_bit\" : true, \"open_bit\" : true, \"upper_block_bit\" : false] ",
         "[\"direction\" : 2, \"door_hinge_bit\" : false, \"open_bit\" : true, \"upper_block_bit\" : false] ",
         "[\"direction\" : 3, \"door_hinge_bit\" : true, \"open_bit\" : true, \"upper_block_bit\" : false] ",
         "[\"direction\" : 0, \"door_hinge_bit\" : false, \"open_bit\" : false, \"upper_block_bit\" : true] ",
         "[\"direction\" : 1, \"door_hinge_bit\" : true, \"open_bit\" : false, \"upper_block_bit\" : true] ",
         "[\"direction\" : 2, \"door_hinge_bit\" : false, \"open_bit\" : false, \"upper_block_bit\" : true] ",
         "[\"direction\" : 3, \"door_hinge_bit\" : true, \"open_bit\" : false, \"upper_block_bit\" : true] ",
         "[\"direction\" : 0, \"door_hinge_bit\" : false, \"open_bit\" : true, \"upper_block_bit\" : true] ",
         "[\"direction\" : 1, \"door_hinge_bit\" : true, \"open_bit\" : true, \"upper_block_bit\" : true] ",
         "[\"direction\" : 2, \"door_hinge_bit\" : false, \"open_bit\" : true, \"upper_block_bit\" : true] ",
         "[\"direction\" : 3, \"door_hinge_bit\" : true, \"open_bit\" : true, \"upper_block_bit\" : true] ",
         "[\"direction\" : 0, \"door_hinge_bit\" : false, \"open_bit\" : false, \"upper_block_bit\" : false] ",
         "[\"direction\" : 1, \"door_hinge_bit\" : true, \"open_bit\" : false, \"upper_block_bit\" : false] ",
         "[\"direction\" : 2, \"door_hinge_bit\" : false, \"open_bit\" : false, \"upper_block_bit\" : false] ",
         "[\"direction\" : 3, \"door_hinge_bit\" : true, \"open_bit\" : false, \"upper_block_bit\" : false] ",
         "[\"direction\" : 0, \"door_hinge_bit\" : false, \"open_bit\" : true, \"upper_block_bit\" : false] ",
         "[\"direction\" : 1, \"door_hinge_bit\" : true, \"open_bit\" : true, \"upper_block_bit\" : false] ",
         "[\"direction\" : 2, \"door_hinge_bit\" : false, \"open_bit\" : true, \"upper_block_bit\" : false] ",
         "[\"direction\" : 3, \"door_hinge_bit\" : true, \"open_bit\" : true, \"upper_block_bit\" : false] ",
         "[\"direction\" : 0, \"door_hinge_bit\" : false, \"open_bit\" : false, \"upper_block_bit\" : true] ",
         "[\"direction\" : 1, \"door_hinge_bit\" : true, \"open_bit\" : false, \"upper_block_bit\" : true] ",
         "[\"direction\" : 2, \"door_hinge_bit\" : false, \"open_bit\" : false, \"upper_block_bit\" : true] ",
         "[\"direction\" : 3, \"door_hinge_bit\" : true, \"open_bit\" : false, \"upper_block_bit\" : true] ",
         "[\"direction\" : 0, \"door_hinge_bit\" : false, \"open_bit\" : true, \"upper_block_bit\" : true] ",
         "[\"direction\" : 1, \"door_hinge_bit\" : true, \"open_bit\" : true, \"upper_block_bit\" : true] ",
         "[\"direction\" : 2, \"door_hinge_bit\" : false, \"open_bit\" : true, \"upper_block_bit\" : true] ",
         "[\"direction\" : 3, \"door_hinge_bit\" : true, \"open_bit\" : true, \"upper_block_bit\" : true] "
            },
        wooden_pressure_plate ={
         "[\"redstone_signal\" : 0] ",
         "[\"redstone_signal\" : 1] ",
         "[\"redstone_signal\" : 2] ",
         "[\"redstone_signal\" : 3] ",
         "[\"redstone_signal\" : 4] ",
         "[\"redstone_signal\" : 5] ",
         "[\"redstone_signal\" : 6] ",
         "[\"redstone_signal\" : 7] ",
         "[\"redstone_signal\" : 8] ",
         "[\"redstone_signal\" : 9] ",
         "[\"redstone_signal\" : 10] ",
         "[\"redstone_signal\" : 11] ",
         "[\"redstone_signal\" : 12] ",
         "[\"redstone_signal\" : 13] ",
         "[\"redstone_signal\" : 14] ",
         "[\"redstone_signal\" : 15] "
            },
        wooden_slab ={
         "[\"top_slot_bit\" : false, \"wood_type\" : \"oak\"] ",
         "[\"top_slot_bit\" : false, \"wood_type\" : \"spruce\"] ",
         "[\"top_slot_bit\" : false, \"wood_type\" : \"birch\"] ",
         "[\"top_slot_bit\" : false, \"wood_type\" : \"jungle\"] ",
         "[\"top_slot_bit\" : false, \"wood_type\" : \"acacia\"] ",
         "[\"top_slot_bit\" : false, \"wood_type\" : \"dark_oak\"] ",
         "[\"top_slot_bit\" : false, \"wood_type\" : \"oak\"] "
            },
        wool ={
         "[\"color\" : \"white\"] ",
         "[\"color\" : \"orange\"] ",
         "[\"color\" : \"magenta\"] ",
         "[\"color\" : \"light_blue\"] ",
         "[\"color\" : \"yellow\"] ",
         "[\"color\" : \"lime\"] ",
         "[\"color\" : \"pink\"] ",
         "[\"color\" : \"gray\"] ",
         "[\"color\" : \"silver\"] ",
         "[\"color\" : \"cyan\"] ",
         "[\"color\" : \"purple\"] ",
         "[\"color\" : \"blue\"] ",
         "[\"color\" : \"brown\"] ",
         "[\"color\" : \"green\"] ",
         "[\"color\" : \"red\"] ",
         "[\"color\" : \"black\"] "
            },
        yellow_candle ={
         "[\"candles\" : 0, \"lit\" : false] ",
         "[\"candles\" : 1, \"lit\" : false] ",
         "[\"candles\" : 2, \"lit\" : false] ",
         "[\"candles\" : 3, \"lit\" : false] ",
         "[\"candles\" : 0, \"lit\" : true] ",
         "[\"candles\" : 1, \"lit\" : true] ",
         "[\"candles\" : 2, \"lit\" : true] ",
         "[\"candles\" : 3, \"lit\" : true] "
            },
        yellow_candle_cake ={
         "[\"lit\" : false] ",
         "[\"lit\" : true] "
            },
        yellow_glazed_terracotta ={
         "[\"facing_direction\" : 0] ",
         "[\"facing_direction\" : 1] ",
         "[\"facing_direction\" : 2] ",
         "[\"facing_direction\" : 3] ",
         "[\"facing_direction\" : 4] ",
         "[\"facing_direction\" : 5] ",
         "[\"facing_direction\" : 6] ",
         "[\"facing_direction\" : 7] "
            }
        }
        
    if (stateTable[Nameyface]==nil)then
        return(Nameyface)
    else
       DataNEW = stateTable[Nameyface][Datay+1]
       if DataNEW == nil then 
        print(Nameyface.. " " .. Datay) 
    end
        return(Nameyface .. DataNEW)
    end
end