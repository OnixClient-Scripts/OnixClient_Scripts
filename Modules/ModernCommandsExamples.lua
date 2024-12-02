name="Modern Commands Examples"
description="A mod containing example commands for the new command system"


registerCommand("exampleseparated", function (arguments)
    local intellisenseHelper = MakeIntellisenseHelper(arguments)
    local parser = intellisenseHelper:addOverload()

    local slot = parser:matchInt("slot")
    if slot == nil then
        print("§cSlot number is required!")
        return
    end

    local telemetry = parser:matchEnum("telemetry", "YesNo", {"yes", "no"})
    if telemetry == nil then
        print("§cTelemetry option (yes/no) is required!")
        return
    end

    local scale = parser:matchFloat("scale")
    if scale == nil then
        print("§cScale value is required!")
        return
    end

    print("§aSlot: " .. slot .. ", Telemetry: " .. telemetry .. " at scale: " .. scale)
end, 
function (intellisense)
    local overload = intellisense:addOverload()
    overload:matchInt("slot")
    overload:matchEnum("telemetry", "YesNo", {"yes", "no"})
    overload:matchFloat("scale")
end, "This is an example of a separated command")

registerCommand("exampleseparated2", function (arguments)
    local intellisenseHelper = MakeIntellisenseHelper(arguments)
    local parser = intellisenseHelper:addOverload()

    local slot = parser:matchInt("slot")
    if slot == nil then
        print("§cSlot number is required!")
        return
    end

    local telemetry = parser:matchEnum("telemetry", "YesNo", {"yes", "no"})
    if telemetry == nil then
        print("§cTelemetry option (yes/no) is required!")
        return
    end

    if telemetry == "yes" then
        local favItem = parser:matchItem("favItem")
        if favItem == nil then
            print("§cFavorite item is required!")
            return
        end
        print(string.format("§aSlot %d has telemetry enabled with favorite item: %s", 
            slot, favItem.displayName))
    elseif telemetry == "no" then
        local why = parser:matchString("why")
        if why == nil or why == "" then
            print("§cReason is required when telemetry is disabled!")
            return
        end
        print("§aSlot " .. slot .. " has telemetry disabled because: " .. why)
    else
        print("§cValid telemetry option is required!")
    end
end, 
function (intellisense)
    local overload1 = intellisense:addOverload()
    overload1:matchInt("slot")
    overload1:matchEnum("telemetry", "YesNo", {"yes"})
    overload1:matchItem("favItem")

    local overload2 = intellisense:addOverload()
    overload2:matchInt("slot")
    overload2:matchEnum("telemetry", "YesNo", {"no"})
    overload2:matchString("why")
end, "This is an example of a separated command")

registerCommand("exampleseparated3", function (arguments)
    local intellisenseHelper = MakeIntellisenseHelper(arguments)
    local parser = intellisenseHelper:addOverload()
    local slot = parser:matchInt("slot")
    if slot == nil then
        print("§cSlot is required!")
        return
    end
    local path = parser:matchEnum("path", "path", {"first", "second"})
    if path == nil then
        print("§cValid path is required!")
        return
    end
    if path == "first" then
        local favItem = parser:matchItem("favItem")
        if favItem == nil then
            print("§cFavItem is required!")
            return
        end
        print("§aYour favorite item is " .. favItem.displayName .. " in slot " .. slot)
    elseif path == "second" then
        local isReal = parser:matchBool("isReal")
        if isReal == nil then
            print("§cIsReal is required!")
            return
        end
        print("§aSlot " .. slot .. " is  " .. (isReal and "real" or "fake"))
    else
        print("§cValid path is required!")
    end
end, 
function (intellisense)
    local overload1 = intellisense:addOverload()
    overload1:matchInt("slot")
    overload1:matchPath("first")
    overload1:matchItem("favItem")

    local overload2 = intellisense:addOverload()
    overload2:matchInt("slot")
    overload2:matchPath("second")
    overload2:matchBool("isReal")
end, "This is an example of a separated command")


registerCombinedCommand("examplecombined", function(intellisense, isExecuted)
    local overload = intellisense:addOverload()
    local slot = overload:matchInt("slot")
    local telemetry = overload:matchEnum("telemetry", "YesNo", {"yes", "no"})
    local scale = overload:matchFloat("scale")

    if isExecuted then
        if slot == nil then
            print("§cSlot number is required!")
            return
        end

        if telemetry == nil then
            print("§cTelemetry option (yes/no) is required!")
            return
        end

        if scale == nil then
            print("§cScale value is required!")
            return
        end

        print("§aSlot: " .. slot .. ", Telemetry: " .. telemetry .. " at scale: " .. scale)
    end
end, "This is an example of a combined command")

registerCombinedCommand("examplecombined2", function(intellisense, isExecuted)
    local overload1 = intellisense:addOverload()
    overload1:matchInt("slot")
    local isYes = overload1:matchPath("yes", "telemetry")
    local favItem = overload1:matchItem("favItem")

    local overload2 = intellisense:addOverload()
    local slot = overload2:matchInt("slot")
    local isNo = overload2:matchPath("no", "telemetry")
    local whyNot = overload2:matchString("why")

    if isExecuted then
        if slot == nil then 
            print("§cSlot is required!")
            return
        end

        if isYes then
            if favItem == nil then
                print("§cFavorite item is required!")
                return
            end
            print("§aSlot " .. slot .. " has telemetry enabled with favorite item: " .. favItem.displayName)
        elseif isNo then
            if whyNot == nil or whyNot == "" then
                print("§cReason is required when telemetry is disabled in slot " .. slot)
                return
            end
            print("§aSlot " .. slot .. " has telemetry disabled because: " .. whyNot)
        else
            print("§cValid path is required!")
        end
    end
end, "This is an example of a combined command")

registerCombinedCommand("examplecombined3", function(intellisense, isExecuted)
    local overload1 = intellisense:addOverload()
    overload1:matchInt("slot")
    local isFirst = overload1:matchPath("first")
    local favItem = overload1:matchItem("favItem")

    local overload2 = intellisense:addOverload()
    local slot = overload2:matchInt("slot")
    local isSecond = overload2:matchPath("second")
    local isReal = overload2:matchBool("isReal")

    if isExecuted then
        if slot == nil then
            print("§cSlot is required!")
            return
        end

        if isFirst then
            if favItem == nil then
                print("§cFavItem is required!")
                return
            end
            print("§aYour favorite item is " .. favItem.displayName .. " in slot " .. slot)
        elseif isSecond then
            if isReal == nil then
                print("§cIsReal is required!")
                return
            end
            print("§aSlot " .. slot .. " is " .. (isReal and "real" or "fake"))
        else
            print("§cValid path is required!")
        end
    end
end, "This is an example of a combined command with two paths")