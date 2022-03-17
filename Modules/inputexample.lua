name = "Input Example"
description = "Keyboard, Mouse input example module script"

--[[
    Keyboard, Mouse input example module script
    
    you can find key value here
    https://docs.microsoft.com/en-us/windows/win32/inputdev/virtual-key-codes
    
    made by Quoty0
]]

function keyboard(key, isDown)
    if isDown then
        print("Key pressed: " .. key)
    end
end
event.listen("KeyboardInput", keyboard)

function mouse(button, isDown)
    if isDown then
        print("Mouse Button pressed: " .. button)
    end
end
event.listen("MouseInput", mouse)

function update(deltaTime)
    
end


function render(deltaTime)

end
