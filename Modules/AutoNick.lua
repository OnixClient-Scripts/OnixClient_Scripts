name = "Auto Nick"
description = "Automatically sets your nickname! Requires .autonick"

--[[
    auto nick script
    by VastraKai#0001 ;D
]]--



function saveNickname(text)
    local file = io.open("Nickname.txt", 'w')
    file:write(text)
    io.close(file)
end

function loadNickname()
    autoNick = player.name()
    local file = io.open("Nickname.txt", 'r')
    if file == nil then return end
  
    local filelines = file:lines()
    for line in filelines do
        autoNick = line
    end
    io.close(file)

end



if autoNick ~= nil then
    client.settings.addInfo("§aCurrent nickname: §r§f" .. autoNick)
end

function apply()
        if autoNick == nil then 
            return 
        end
        client.execute("nick " .. autoNick)
end

function applyB()   
    loadNickname()
    if autoNick == nil then 
        return 
    end
    client.execute("nick " .. autoNick)
end

function onLocalData(identifier, content)
    if identifier == "1b0944f1-d18f-4fbb-9e8f-6ac940735ff7" then 
        autoNick = content
        saveNickname(content)
        loadNickname()
        apply()
        print("Nickname set.")
    elseif identifier == "4bc36f30-fb14-4c94-b935-73fe271503c0" then
        client.execute("resetnick")
        saveNickname(player.name())
        loadNickname()
    end
end
event.listen("LocalDataReceived", onLocalData)

client.settings.addFunction("apply", "applyB", "Apply")

function update(dt)
    loadNickname()
    if (autoNick ~= player.name()) then
        loadNickname()
        apply()
    end
end
