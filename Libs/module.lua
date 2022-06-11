

function getModule(name)
    for k, v in pairs(client.modules()) do
        if string.find(v.name, name) then
            return v
        end
    end
end


function getSetting(module, name)
    for k, v in pairs(module.settings) do
        if string.find(v.saveName, name) then
            return v
        end
    end
end
