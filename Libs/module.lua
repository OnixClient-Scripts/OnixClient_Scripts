

function getModule(name, script)
    for k, v in pairs(client.modules()) do
        if string.find(v.name, name) and (script == nil or script == v.isScript) then
            return v
        end
    end
end


function getSetting(module, name)
    for k, v in pairs(module.settings) do
        if string.lower(v.saveName) == string.lower(name) or string.lower(v.name) == string.lower(name) then
            return v
        end
    end
end
