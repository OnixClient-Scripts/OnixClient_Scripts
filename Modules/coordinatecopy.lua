name = "Coordinate Copy"
description = "Copy coordinates in one press of a button!"



--[[
  you can find the keys's value there
  https://docs.microsoft.com/en-us/windows/win32/inputdev/virtual-key-codes


  its an example for new keyboard function
  made by Onix86
--]]

Get_Player_Position_Key = 0x4F --or the 'O' key
Get_Selected_Block_Position_Key = 0x4A --or the 'J' key


--script start

function keyboard(key, isDown)
    if (isDown == true) then
        if (key == Get_Player_Position_Key) then
            local x,y,z = player.position()
            setClipboard(x .. " " .. y .. " " .. z)
            client.notification("Your player coordinates are now in your clipboard!")
        else if (key == Get_Selected_Block_Position_Key) then
            if (player.facingBlock()) then
                local x,y,z = player.selectedPos()
                setClipboard(x .. " " .. y .. " " .. z)
                client.notification("Your selected coordinates are now in your clipboard!")
            else
                client.notification("You do not have a selected block.")
            end
            end
        end
    end
end
