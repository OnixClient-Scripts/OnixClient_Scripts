command = "sleep"
help_message = "sleep for <arg>ms"

--[[

]]--

function sleep(ms)
    local time = os.clock()
    
    while os.clock() - time <= ms do
    end
end

function execute(arg)
    if tonumber(arg) then
        sleep(arg)
    else
        print(arg .. " is not number!")
    end
end
