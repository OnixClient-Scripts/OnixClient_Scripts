

function getModule(name, script)
    for k, v in pairs(client.modules()) do
        if string.find(v.name, name) and (script == nil or script == v.isScript) then
            return v
        end
    end
end


function getSetting(module, name)
    for k, v in pairs(module.settings) do
        if string.find(v.saveName, name) or string.find(v.name, name) then
            return v
        end
    end
end
