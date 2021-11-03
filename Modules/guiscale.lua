name = "guiscale"
description = "changes and save your custom guiscale"




targetGuiscale = gui.scale()
client.settings.addFloat("Guiscale", "targetGuiscale", 0.25, 15)

function apply()
    client.execute("guiscale " .. targetGuiscale)
end

function roundd()
    targetGuiscale = math.floor(targetGuiscale+0.5)
    client.execute("guiscale " .. targetGuiscale)
    client.settings.update()
end

client.settings.addFunction("You need to apply as your in the gui.", "apply", "Apply")
client.settings.addFunction("Round the current guiscale", "roundd", "Round")

function update(dt)
    if (gui.scale() ~= targetGuiscale) then
        client.execute("guiscale " .. targetGuiscale)
    end
end
