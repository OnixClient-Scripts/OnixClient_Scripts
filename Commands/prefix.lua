command = 'prefix'
help_message = 'Sets your prefix to whatever you want, enable the module so you don\'t look like dumb'


function execute(args)
    f = io.open('prefix.txt', 'r')
    local prefix = f:read('*a')
    f:close()
    local argslist = {}
    for token in string.gmatch(args, "[^%s]+") do
        table.insert(argslist, token)
    end
    if #argslist == 0 then
        print('Your prefix is ' .. prefix)
    else
        if argslist[1] == 'set' then
            if argslist[2] ~= nil then
                f2 = io.open('prefix.txt', 'w')
                f2:write(argslist[2])
                f2:close()
                print('Your prefix is now ' .. argslist[2])
            else
                print('You need to specify a prefix')
            end
        elseif argslist[1] == 'reset' then
            f2 = io.open('prefix.txt', 'w')
            f2:write('.')
            f2:close()
            print('Your prefix is now reset to \'.\'')
        else
            print('Invalid arguments')
        end
    end
end