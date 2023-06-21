name = "Enabled Filter"
description = "Only shows enabled modules in the module list."

function onEnable()
    local modules = client.modules()
    for i,v in pairs(modules) do
        if v.enabled then
            v.visible = true
        else
            v.visible = false
        end
    end
end

function onDisable()
    local modules = client.modules()
    for i,v in pairs(modules) do
        v.visible = true
    end
end