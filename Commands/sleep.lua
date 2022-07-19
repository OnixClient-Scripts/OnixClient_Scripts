command = "sleep"
help_message = "sleep for <arg>ms"

--[[

]]--

function sleep(ms)
    local time = os.clock()
    local ms = ms / 1000
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
