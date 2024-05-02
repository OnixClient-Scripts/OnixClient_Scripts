currentVersion = "1.0.6"

importLib("anetwork")
importLib("renderthreeD")
importLib("vectors")

fs.mkdir("FriendsList")
fs.mkdir("FriendsList/Temp")

skinTexture = nil

attemptToCreateImage = false

function generateHead(skin)
    local hatTextureOffset = 0
    if skin.height == 64 then
        local image = gfx2.createCpuRenderTarget(8, 8)
        gfx2.bindRenderTarget(image)
        local skinX, skinY = 0, 0
        local skinWidth, skinHeight = 8, 8
        gfx2.cdrawImage(skinX,skinY,skinWidth,skinHeight,skin,8,8,8,8)
        gfx2.cdrawImage(skinX - hatTextureOffset, skinY - hatTextureOffset, skinWidth + hatTextureOffset*2, skinHeight + hatTextureOffset*2, skin, 40, 8, 8, 8)
        gfx2.bindRenderTarget(nil)
        attemptToCreateImage = false
        return image
    elseif skin.height == 128 then -- double everything
        local image = gfx2.createCpuRenderTarget(16, 16)
        gfx2.bindRenderTarget(image)
        local skinX, skinY = 0, 0
        local skinWidth, skinHeight = 16, 16
        gfx2.cdrawImage(skinX,skinY,skinWidth,skinHeight,skin,16,16,16,16)
        gfx2.cdrawImage(skinX - hatTextureOffset, skinY - hatTextureOffset, skinWidth + hatTextureOffset*2, skinHeight + hatTextureOffset*2, skin, 80, 16, 16, 16)
        gfx2.bindRenderTarget(nil)
        attemptToCreateImage = false
        return image
    end
end

firstTimeSendingMessagesNotification = true


knownServers = {
    ["onixclient.com"] = "Onix Client SMP",
    ["zeqa"] = "Zeqa",
    ["hive"] = "The Hive",
    ["mineplex"] = "Mineplex",
    ["cubecraft"] = "CubeCraft",
    ["lifeboat"] = "Lifeboat",
    ["galaxite"] = "Galaxite",
    ["nethergames"] = "NetherGames",
    ["mineville"] = "Mineville",
}

function getSkinDataFromImage(image)
    local skinData = {}
    return skinData
end
playerName = "Unknown"
lastRequestTime = os.clock() - 5
function onEnable()
    anetwork.Initialise(8)
    skinTexture = player.skin().texture()
    attemptToCreateImage = true
    -- network.get(APIPath .. "/get_messages", "getData")
    lastRequestTime = os.clock() - 5
    networking.friends.getFriends()
    networking.users.getUserData(player.name())
    networking.getCurrentVersion()
end

playerData = {
    status = "online",
    customStatus = "",
    friends = {},
    previousFriends = {},
    friendsData = {},
    pendingRequests = {},
    friendSkinData = {},
    oldFriendSkinData = {},
    friendSkinLoadedData = {},
    mouseDataOfFriendYouTriedToInteractWith = {}
}

registerCommand("sendMessageAs", function (args)
    if player.name() ~= "xJqms" then return end -- LMFAO THIS IS SO BADLY SECURED LOOOOOOOOOOL
    sender, recipient, message = args:match("([^,]+), ([^,]+), (.+)")
    networking.messaging.sendAs(message, recipient, sender)
end)

registerCommand("get_all_online_users", function()
    networking.getAllOnlineUsers()
end)
registerCommand("get_total_user_count", function()
    networking.getTotalUserCount()
end)

messagesList = {}
totalGetMessageCallbackCount = 0

function removeTheSpaceFromTheEnd(str)
    return str:match("^(.-)%s*$")
end
function removeTheSpaceFromTheStart(str)
    return str:match("^%s*(.-)$")
end

playerPositions = {}
APIPath = "85.215.122.227:29345"
-- APIPath = "127.0.0.1:5000"
networking = {
    getCurrentVersion = function()
        anetwork.get(APIPath .. "/version", {}, networking.getCurrentVersionCallback)
    end,
    getCurrentVersionCallback = function(response, error)
        if not response then return end
        if not jsonToTable(response.body)["version"] then
            notificationSystem.sendNotification("Friends List", "There was an error getting the current version. Please try again later.")
            return
        end
        if jsonToTable(response.body)["version"] > currentVersion then
            notificationSystem.sendNotification("Friends List", "There is a new version of the Friends List available. (" .. jsonToTable(response.body)["version"] .. ")\nPlease update to the latest version.\n\nThe link has been copied to your clipboard.")
            print("There is a new version of the Friends List available. (" .. jsonToTable(response.body)["version"] .. ")\nPlease update to the latest version.\n\nThe link has been copied to your clipboard.")
            setClipboard("https://onixclient.com/scripting/repo?search=friends+list")
            notificationSystem.sendNotification("Friends List", "Disabled until updated.")
            client.settings.addAir(0).parent.enabled = false
        end
    end,
    getAllOnlineUsers = function()
        anetwork.get(APIPath .. "/get_all_online_users", {}, networking.getAllOnlineUsersCallback)
    end,
    getAllOnlineUsersCallback = function(response, error)
        if not response then return end
    end,
    getTotalUserCount = function()
        anetwork.get(APIPath .. "/get_total_user_count", {}, networking.getTotalUserCountCallback)
    end,
    getTotalUserCountCallback = function(response, error)
        if not response then return end
        print(response.body)
    end,
    ack = {
        send = function()
            for i = 1, 1 do
                local data = {
                    ["sender"] = player.name(),
                    ["status"] = playerData.status,
                    ["custom_status"] = playerData.customStatus,
                    ["skin_data"] = player.skin().texture().stringForm,
                    ["current_server"] = server.ip()
                }
                anetwork.post(APIPath .. "/ack", tableToJson(data), {"Content-Type: application/json"}, networking.ack.callback, "POST")
                networking.getCurrentVersion()
            end
        end,
        callback = function(response, error)
            if response == nil or not response.body then
                notificationSystem.sendNotification("Friends List", "Could not connect to the API. Please try again later.")
                return
            end
            networking.friends.getPendingRequests()
            -- networking.messaging.getMessages.getMessagesForUser.get(player.name())
            networking.friends.getFriends()
            attemptToCreateImage = true
        end
    },
    messaging = {
        send = function(message, recipient)
            local data = {
                ["sender"] = player.name(),
                ["recipient"] = recipient,
                ["message"] = message,
                ["timestamp"] = os.time()
            }
            messagesList[recipient] = messagesList[recipient] or {}
            table.insert(messagesList[recipient], {sender = player.name(), message = message, timestamp = os.time()})
            anetwork.post(APIPath .. "/messaging/send_message", tableToJson(data), {"Content-Type: application/json"}, networking.messaging.sendCallback, "POST")
        end,
        sendCallback = function(response, error)
        end,

        sendAs = function(message, recipient, sender)
            local data = {
                ["sender"] = sender,
                ["recipient"] = recipient,
                ["message"] = message,
                ["timestamp"] = os.time()
            }
            anetwork.post(APIPath .. "/messaging/send_message", tableToJson(data), {"Content-Type: application/json"}, networking.messaging.sendAsCallback, "POST")
        end,
        sendAsCallback = function(response, error)
            -- print(response.body)
        end,

        getMessages = {
            getMessagesForUser = {
                get = function(recipient)
                    local data = {
                        ["sender"] = player.name(),
                        ["recipient"] = recipient
                    }
                    anetwork.post(APIPath .. "/messaging/get_messages", tableToJson(data), {"Content-Type: application/json"}, networking.messaging.getMessages.getMessagesForUser.getCallback, "POST")
                end,
                getCallback = function(response, error)
                    if not messagesList then
                        messagesList = {}
                    end
                    if not jsonToTable(response.body)["error"] then
                        -- see if theres a new message and send a notification by comparing the response to the current messagesList
                        if (tableToJson(messagesList) ~= tableToJson(jsonToTable(response.body)["messages"])) then
                            if firstTimeSendingMessagesNotification == false then
                                for i, message in pairs(jsonToTable(response.body)["messages"]) do
                                    if not messagesList[jsonToTable(response.body)["username"]] then
                                        messagesList[jsonToTable(response.body)["username"]] = {}
                                    end
                                    if not messagesList[jsonToTable(response.body)["username"]][i] then
                                        if message["sender"] ~= player.name() then
                                            notificationSystem.sendNotification("Friends List", message["sender"] .. " has sent you a message.")
                                        end
                                    end
                                    messagesList[jsonToTable(response.body)["username"]][i] = message
                                end
                            end
                        end
                        totalGetMessageCallbackCount = totalGetMessageCallbackCount + 1
                        local recipient = jsonToTable(response.body)["username"]
                        -- sort the messages by timestamp before adding them to the messagesList
                        table.sort(jsonToTable(response.body)["messages"], function(a, b) return a["timestamp"] < b["timestamp"] end)
                        messagesList[recipient] = jsonToTable(response.body)["messages"]
                    end
                end
            }
        }
    },
    skin = {
        get = function()
            anetwork.get(APIPath .. "/profile_picture/get", {}, networking.skin.getCallback)
        end,
        getCallback = function(response, error)
        end,

        send = function()
            -- done in the ack with stingform
        end,
        sendCallback = function(response, error)
            -- print(response.body)
        end
    },
    friends = {
        getFriends = function()
            anetwork.post(APIPath .. "/friends/get_friends", tableToJson({["username"] = player.name()}), {"Content-Type: application/json"}, networking.friends.getFriendsCallback, "POST")
        end,
        getFriendsCallback = function(response, error)
            if not response then return end
            -- print(response.body)
            if not playerData.previousFriends then
                playerData.previousFriends = {}
            end
            if not playerData.friends then
                playerData.friends = {}
            end
            playerData.previousFriends = playerData.friends
            playerData.friends = jsonToTable(response.body)["friends"]
            -- get user data for each friend
            if playerData.friends then
                for i, friend in pairs(playerData.friends) do
                    networking.users.getUserData(friend)
                    networking.messaging.getMessages.getMessagesForUser.get(friend)
                end
                if firstTimeSendingMessagesNotification and totalGetMessageCallbackCount > #playerData.friends then
                    firstTimeSendingMessagesNotification = false
                end
            end
        end,

        addFriend = function(attempted_friend)
            anetwork.post(APIPath .. "/friends/add_friend", tableToJson({["sender"] = player.name(), ["attempted_friend"] = attempted_friend}), {"Content-Type: application/json"}, networking.friends.addFriendCallback, "POST")
        end,
        addFriendCallback = function(response, error)
            -- print(response.body)
            if jsonToTable(response.body)["error"] then
                notificationSystem.sendNotification("Friend Request", jsonToTable(response.body)["error"])
            end
        end,

        removeFriend = function(attempted_friend)
            anetwork.post(APIPath .. "/friends/remove_friend", tableToJson({["sender"] = player.name(), ["attempted_friend"] = attempted_friend}), {"Content-Type: application/json"}, networking.friends.removeFriendCallback, "POST")
        end,
        removeFriendCallback = function(response, error)
        end,

        acceptFriendRequest = function(attempted_friend)
            anetwork.post(APIPath .. "/friends/accept_friend_request", tableToJson({["sender"] = player.name(), ["attempted_friend"] = attempted_friend}), {"Content-Type: application/json"}, networking.friends.acceptFriendRequestCallback, "POST")
        end,
        acceptFriendRequestCallback = function(response, error)
            -- print(response.body)
        end,

        rejectFriendRequest = function(attempted_friend)
            anetwork.post(APIPath .. "/friends/reject_friend_request", tableToJson({["sender"] = player.name(), ["attempted_friend"] = attempted_friend}), {"Content-Type: application/json"}, networking.friends.rejectFriendRequestCallback, "POST")
        end,
        rejectFriendRequestCallback = function(response, error)
        end,

        getPendingRequests = function()
            anetwork.post(APIPath .. "/friends/get_pending_friends", tableToJson({["username"] = player.name()}), {"Content-Type: application/json"}, networking.friends.getPendingRequestsCallback, "POST")
        end,
        getPendingRequestsCallback = function(response, error)
            if not response then return end
            if not playerData.pendingRequests then
                playerData.pendingRequests = {}
            end
            local tempRequests = jsonToTable(response.body)["friends_pending"]
            if not tempRequests then
                tempRequests = {}
            end
            -- see if it changed and find the change and send a notification
            for i, request in pairs(tempRequests) do
                if not playerData.pendingRequests then
                    playerData.pendingRequests = {}
                end
                if not playerData.pendingRequests[i] then
                    notificationSystem.sendNotification("Friend Request", request .. " has sent you a friend request.")
                end
                playerData.pendingRequests[i] = request
            end

            playerData.pendingRequests = tempRequests
        end
    },
    users = {
        getUserData = function(username)
            anetwork.post(APIPath .. "/users/get_user_data", tableToJson({["username"] = username}), {"Content-Type: application/json"}, networking.users.getUserCallback, "POST")
        end,
        getUserCallback = function(response, error)
            hasSentFirstPlayerRequest = true
            -- print(jsonToTable(response.body)["user_data"]["skin_data"])
            if not response then
                -- server is down
                notificationSystem.sendNotification("Error", "The server is down.")
                return
            end
            if jsonToTable(response.body)["error"] then
                -- sendAck()
            elseif jsonToTable(response.body)["username"] == player.name() then
                playerData.status = "online"
                playerData.customStatus = jsonToTable(response.body)["user_data"]["custom_status"]
                sendAck()
            else -- its a friend
                if not playerData.friendsData then
                    playerData.friendsData = {}
                end
                if not playerData.friendSkinData then
                    playerData.friendSkinData = {}
                end
                playerData.friendSkinData[jsonToTable(response.body)["username"]] = jsonToTable(response.body)["user_data"]["skin_data"]
                -- print the skin data
                -- see if the status has changed by comparing the previous status to the new status
                if playerData.friendsData[jsonToTable(response.body)["username"]] then
                    if playerData.friendsData[jsonToTable(response.body)["username"]]["status"] ~= jsonToTable(response.body)["user_data"]["status"] then
                        playerData.friendsData[jsonToTable(response.body)["username"]] = jsonToTable(response.body)["user_data"]
                        if playerData.friendsData[jsonToTable(response.body)["username"]]["status"] == "offline" then
                            -- notificationSystem.sendNotification(jsonToTable(response.body)["username"], "has gone offline.")
                            -- print(jsonToTable(response.body)["username"] .. " has gone offline.")
                        else
                            -- notificationSystem.sendNotification(jsonToTable(response.body)["username"], "is now " .. jsonToTable(response.body)["user_data"]["status"] .. ".")
                            -- print(jsonToTable(response.body)["username"] .. " is now " .. jsonToTable(response.body)["user_data"]["status"] .. ".")
                        end
                    end
                end
                playerData.friendsData[jsonToTable(response.body)["username"]] = jsonToTable(response.body)["user_data"]
            end
        end
    }
}
function sendAck()
    networking.ack.send()
end

playTimeStart = os.clock()
playTime = 0
hasCreatedHeadTexture = false

animations = {}
targets = {}
currents = {}
lerpSpeed = 0.2



serverList = {}
renderBehind = true

pingToolUpdateCycle = os.clock()
-- block = nil
function render3d(dt)
    anetwork.Tick()
    skinTexture = player.skin().texture()
    playerName = player.name()
    mouseData.x = gui.mousex()
    mouseData.y = gui.mousey()
    if isUIOpen then
        gui.setGrab(isUIOpen)
        gui.closeNonHud()
    end
    playTime = os.clock() - playTimeStart
    -- if os.clock() - pingToolUpdateCycle > 1 then
    --     pingToolUpdateCycle = os.clock()
    --     local px, py, pz = player.pposition()
    --     local pyaw, ppitch = player.rotation()
    --     local endPos = vec:fromAngle(1000, math.rad(pyaw + 90), math.rad(-ppitch)):add(vec:new(px, py, pz))
    --     local newBlock = dimension.raycast(px, py, pz, endPos.x, endPos.y, endPos.z)
    --     if newBlock.blockFace == 0 then
    --         newBlock.y = newBlock.y - 1
    --     elseif newBlock.blockFace == 1 then
    --         newBlock.y = newBlock.y + 1
    --     elseif newBlock.blockFace == 2 then
    --         newBlock.z = newBlock.z - 1
    --     elseif newBlock.blockFace == 3 then
    --         newBlock.z = newBlock.z + 1
    --     elseif newBlock.blockFace == 4 then
    --         newBlock.x = newBlock.x - 1
    --     elseif newBlock.blockFace == 5 then
    --         newBlock.x = newBlock.x + 1
    --     end
    --     if newBlock then
    --         block = newBlock
    --     end
    -- end

    if block then
        -- gfx.color(255, 255, 255)
        -- -- flat square on the block
        -- if block.blockFace == 0 then
        --     cubexyz(block.x+0.125, block.y+0.975, block.z+0.125, 0.75, 0.025, 0.75)
        -- elseif block.blockFace == 1 then
        --     cubexyz(block.x+0.125, block.y, block.z+0.125, 0.75, 0.025, 0.75)
        -- elseif block.blockFace == 2 then
        --     cubexyz(block.x+0.125, block.y+0.125, block.z+0.975, 0.75, 0.75, 0.025)
        -- elseif block.blockFace == 3 then
        --     cubexyz(block.x+0.125, block.y+0.125, block.z, 0.75, 0.75, 0.025)
        -- elseif block.blockFace == 4 then
        --     cubexyz(block.x+0.975, block.y+0.125, block.z+0.125, 0.025, 0.75, 0.75)
        -- elseif block.blockFace == 5 then
        --     cubexyz(block.x, block.y+0.125, block.z+0.125, 0.025, 0.75, 0.75)
        -- end
    end

    -- serverList = server.players()
    -- table.sort(serverList)
    -- if playerPositions then
    --     for i, position in pairs(playerPositions) do
    --         -- position can be a float
    --         local isPlayerStillHere = false
    --         for j,v in pairs(serverList) do
    --             if v == i then
    --                 isPlayerStillHere = true
    --             end
    --         end
    --         local targetX, targetY, targetZ = position:match("([^,]+), ([^,]+), ([^,]+)")
    --         targetX = targetX:gsub("x: ", "")
    --         targetY = targetY:gsub("y: ", "")
    --         targetZ = targetZ:gsub("z: ", "")
    --         targets[i] = {x = tonumber(targetX), y = tonumber(targetY), z = tonumber(targetZ)}
    --         if not isPlayerStillHere then
    --             playerPositions[i] = nil
    --             targets[i] = nil
    --             animations[i] = nil
    --             currents[i] = nil
    --         end
    --     end
    -- end
    -- for i, target in pairs(targets) do
    --     if not animations[i] then
    --         animations[i] = {targetX = 0, targetY = 0, targetZ = 0}
    --     end
    --     if not currents[i] then
    --         currents[i] = {x = 0, y = 0, z = 0}
    --     end
    --     currents[i].x = lerp(currents[i].x, targets[i].x, dt/lerpSpeed)
    --     currents[i].y = lerp(currents[i].y, targets[i].y, dt/lerpSpeed)
    --     currents[i].z = lerp(currents[i].z, targets[i].z, dt/lerpSpeed)
    --     gfx.color(255, 0, 0)
    --     -- cubexyz(px - 0.3, py - 1.62, pz - 0.3, 0.6, 1.8, 0.6)
    --     if i ~= player.name() then
    --         cubexyz(currents[i].x - 0.3, currents[i].y - 1.62, currents[i].z - 0.3, 0.6, 1.8, 0.6)
    --         -- player.lookAt(currents[i].x, currents[i].y, currents[i].z)
    --         local ppx, ppy, ppz = player.pposition()
    --         local forwardPosX, forwardPosY, forwardPosZ = player.forwardPosition(0.1)
    --         -- draw a line from the player to the target
    --         -- gfx.color(255, 255, 255)
    --         -- gfx.line(forwardPosX, forwardPosY, forwardPosZ, currents[i].x, currents[i].y, currents[i].z)
    --     else
    --         if player.perspective() ~= 0 then
    --             local ppx, ppy, ppz = player.pposition()
    --             cubexyz(ppx - 0.3, ppy - 1.62, ppz - 0.3, 0.6, 1.8, 0.6)
    --         end
    --     end
    -- end
end

-- function render()
--     for i, target in pairs(targets) do
--         if i ~= player.name() then
--             local w2sX, w2sY = gfx.worldToScreen(currents[i].x, currents[i].y, currents[i].z)
--             if w2sX and w2sY then
--                 gfx.color(255, 255, 255)
--                 -- render the text above the player and centered
--                 local textSize = gui.font().width(i)
--                 local distance
--                 if player.perspective() == 0 then
--                     distance = math.sqrt((currents[i].x - player.pposition())^2 + (currents[i].y - player.pposition())^2 + (currents[i].z - player.pposition())^2)
--                 else
--                     distance = math.sqrt((currents[i].x - player.pposition())^2 + (currents[i].y - player.pposition())^2)
--                 end
--                 gfx.text(w2sX - textSize / 2, w2sY - 20, i,1)
--                 gfx.color(255, 0, 0)
--                 gfx.rect(w2sX - 10, w2sY - 10, 20, 20)
--             end
--         end
--     end
-- end

isUIOpen = false

transformationID = {
    scale = 4,
    rotate = 3,
    translate = 2,
    reset = 1
}

function lerp(a, b, t)
    return a + (b - a) * t
end

textBoxes = {
    friendsListSearch = {
        selected = false,
        text = "",
        caretPosition = 0,
        enterPressed = false
    },
    friendsListAdd = {
        selected = false,
        text = "",
        caretPosition = 0,
        enterPressed = false
    },
    messagingModal = {
        selected = false,
        text = "",
        caretPosition = 0,
        enterPressed = false
    }
}
friendsListScrollData = {}
friendsListScrollData.targetScrollAmount = 0
friendsListScrollData.currentScrollAmount = 0
friendsListScrollData.maxScrollAmount = 0
friendsListScrollData.lerpSpeed = 0.1

messagingModalScrollData = {}
messagingModalScrollData.targetScrollAmount = 0
messagingModalScrollData.currentScrollAmount = 0
messagingModalScrollData.maxScrollAmount = 0
messagingModalScrollData.minScrollAmount = 0
messagingModalScrollData.lerpSpeed = 0.1

messagingModalAnimationData = {}
messagingModalAnimationData.currentScale = 1
messagingModalAnimationData.currentAlpha = 255
messagingModalAnimationData.lerpSpeed = 0.1

mouseKeyData = {}

FRIENDSLISTSCREEN = "MAIN"

lastInputTime = os.clock()

mouseData = {
    x = gui.mousex(),
    y = gui.mousey()
}

messagingModal = {
    isOpen = false,
    recipient = "",
    previousRecipient = "",
    status = "",
    skinData = ""
}

userTextData = {}

event.listen("MouseInput", function(button, down)
    lastInputTime = os.clock()
    if isUIOpen then
        local modalWidth, modalHeight = 200, 300
        local modalX, modalY = x - modalWidth - 20, y
        mouseKeyData[button] = down
        if button == 4 then
            -- check if the mouse is hovering over the friends list
            if mouseData.x > x and mouseData.x < x + width and mouseData.y > y and mouseData.y < y + height then
                friendsListScrollData.targetScrollAmount = down and friendsListScrollData.targetScrollAmount + 10 or friendsListScrollData.targetScrollAmount - 10
            end
            if messagingModal.isOpen then
                if mouseData.x > modalX and mouseData.x < modalX + modalWidth and mouseData.y > modalY and mouseData.y < modalY + modalHeight then
                    messagingModalScrollData.targetScrollAmount = down and messagingModalScrollData.targetScrollAmount + 10 or messagingModalScrollData.targetScrollAmount - 10
                end
            end
        end

        if button == 1 then
            if down then
                -- search bar
                if mouseData.x > x + 10 and mouseData.x < x + 10 + width - 20 and mouseData.y > y + 37.5 and mouseData.y < y + 37.5 + 20 then
                    textBoxes.friendsListSearch.selected = true
                else
                    textBoxes.friendsListSearch.selected = false
                end
            end
        end
        if FRIENDSLISTSCREEN == "MAIN" then
            if (mouseData.x > x + 165 and mouseData.x < x + 165 + 20 and mouseData.y > y + 255 and mouseData.y < y + 255 + 20) and (button == 1 and down) then
                FRIENDSLISTSCREEN = "INCOMING"
            end

            local addFriendButton = {
                x = x + 140,
                y = y + 255,
                width = 20,
                height = 20
            }
            if (mouseData.x > addFriendButton.x and mouseData.x < addFriendButton.x + addFriendButton.width and mouseData.y > addFriendButton.y and mouseData.y < addFriendButton.y + addFriendButton.height) then
                if (button == 1 and down) then
                    isAddingAFriend = not isAddingAFriend
                    textBoxes.friendsListAdd.selected = isAddingAFriend
                end
            end
            -- x + 10, y + 255 - 5, 180, 40
            -- make it so none of these work if the mouse is within the above rectangle
            if (mouseData.x > x + 10 and mouseData.x < x + 10 + 180 and mouseData.y > y + 255 - 5 and mouseData.y < y + 255 - 5 + 40) then
                return true
            end
            -- remove friend logic, add it to the playerData.mouseDataOfFriendYouTriedToInteractWith so i can have an are you sure dialog
            -- use friendsList rather than playerData.friends so search bar works
            for i, friend in pairs(friendsList) do
                local friendBox = {
                    x = x + 10,
                    -- y = y + 25 + 40 * i,
                    y = y + 25 + 40 * i - friendsListScrollData.currentScrollAmount,
                    width = 180,
                    height = 30
                }
                local removeButton = {
                    x = friendBox.x + 155,
                    y = friendBox.y + 5,
                    width = 20,
                    height = 20
                }
                -- yes button
                local yesButton = {
                    x = friendBox.x + 130,
                    y = friendBox.y + 5,
                    width = 20,
                    height = 20
                }

                -- if u click anywhere on the friend box EXCEPT FOR THE REMOVE BUTTON, it opens the messaging modal
                if (button == 1 and down) then
                    -- make sure mouse is in the friend box but not the remove button or yes button
                    if (mouseData.x > friendBox.x and mouseData.x < friendBox.x + friendBox.width and mouseData.y > friendBox.y and mouseData.y < friendBox.y + friendBox.height) and not ((mouseData.x > removeButton.x and mouseData.x < removeButton.x + removeButton.width and mouseData.y > removeButton.y and mouseData.y < removeButton.y + removeButton.height) or (mouseData.x > yesButton.x and mouseData.x < yesButton.x + yesButton.width and mouseData.y > yesButton.y and mouseData.y < yesButton.y + yesButton.height)) then
                        if playerData.friendsData[friend] then
                            if not playerData.mouseDataOfFriendYouTriedToInteractWith[friend] then
                                playerData.mouseDataOfFriendYouTriedToInteractWith[friend] = false
                            end
                            if messagingModal.recipient == friend then
                                messagingModal.isOpen = not messagingModal.isOpen
                            else
                                textBoxes.messagingModal.text = ""
                                messagingModalScrollData.currentScrollAmount = 0
                                messagingModalScrollData.targetScrollAmount = 0
                                messagingModal.isOpen = true
                                messagingModal.previousRecipient = messagingModal.recipient
                                messagingModal.recipient = friend
                                messagingModal.status = playerData.friendsData[friend]["status"]
                                messagingModal.skinData = playerData.friendSkinData[friend]
                            end
                        end
                    end
                end

                -- false the message modal if u click anywhere else other then the message modal or the friends list
                if (button == 1 and down) then
                    if not (mouseData.x > modalX and mouseData.x < modalX + modalWidth and mouseData.y > modalY and mouseData.y < modalY + modalHeight) and not (mouseData.x > x and mouseData.x < x + width and mouseData.y > y and mouseData.y < y + height) then
                        messagingModal.isOpen = false
                    end
                end

                local messageInput = {
                    x = modalX + 10,
                    y = modalY + 270,
                    width = modalWidth - 20,
                    height = 20
                }
                -- check if the mouse is hovering over the message input box and if the message modal is open
                if messagingModal.isOpen and (mouseData.x > messageInput.x and mouseData.x < messageInput.x + messageInput.width and mouseData.y > messageInput.y and mouseData.y < messageInput.y + messageInput.height) then
                    textBoxes.messagingModal.selected = true
                else
                    textBoxes.messagingModal.selected = false
                end

                -- remove button
                if (mouseData.x > removeButton.x and mouseData.x < removeButton.x + removeButton.width and mouseData.y > removeButton.y and mouseData.y < removeButton.y + removeButton.height) then
                    if (button == 1 and down) then
                        playerData.mouseDataOfFriendYouTriedToInteractWith[friend] = not playerData.mouseDataOfFriendYouTriedToInteractWith[friend]
                        if playerData.mouseDataOfFriendYouTriedToInteractWith[friend] then
                            notificationSystem.sendNotification("Friend Request", "Are you sure you want to remove " .. friend .. " from your friends list?")
                        end
                    end
                end
                if ((mouseData.x > yesButton.x and mouseData.x < yesButton.x + yesButton.width and mouseData.y > yesButton.y and mouseData.y < yesButton.y + yesButton.height) and (button == 1 and down)) and playerData.mouseDataOfFriendYouTriedToInteractWith[friend]then
                    networking.friends.removeFriend(friend)
                    notificationSystem.sendNotification("Friend Request", "You have removed " .. friend .. " from your friends list.")
                    networking.ack.send()
                    playerData.mouseDataOfFriendYouTriedToInteractWith[friend] = false
                end
            end
        elseif FRIENDSLISTSCREEN == "INCOMING" and (button == 1 and down) then
            if mouseData.x > x + 165 and mouseData.x < x + 165 + 20 and mouseData.y > y + 255 and mouseData.y < y + 255 + 20 then
                FRIENDSLISTSCREEN = "MAIN"
            end
            -- accept/reject friend requests logic and send web request
            for i, friend in pairs(playerData.pendingRequests) do
                playerData.mouseDataOfFriendYouTriedToInteractWith[friend] = false
                if mouseData.x > x + 130 and mouseData.x < x + 130 + 20 and mouseData.y > y + 25 + 40 * i - friendsListScrollData.currentScrollAmount and mouseData.y < y + 25 + 40 * i - friendsListScrollData.currentScrollAmount + 20 then
                    playerData.pendingRequests[i] = nil
                    networking.friends.acceptFriendRequest(friend)
                    notificationSystem.sendNotification("Friend Request", "You have accepted " .. friend .. "'s friend request.")
                    networking.ack.send()
                end
                if mouseData.x > x + 155 and mouseData.x < x + 155 + 20 and mouseData.y > y + 25 + 40 * i - friendsListScrollData.currentScrollAmount and mouseData.y < y + 25 + 40 * i - friendsListScrollData.currentScrollAmount + 20 then
                    playerData.pendingRequests[i] = nil
                    networking.friends.rejectFriendRequest(friend)
                    networking.friends.getPendingRequests()
                    notificationSystem.sendNotification("Friend Request", "You have rejected " .. friend .. "'s friend request.")
                    networking.ack.send()
                end
            end
        end
        return true
    end
end)
friendsList = {}
isAddingAFriend = false
keyData = {}
isFirstKeyAfterUIOpen = true
event.listen("KeyboardInput", function(key, down)
    lastInputTime = os.clock()
    if key == uiOpenButtonSetting.value and down and gui.screen() == "hud_screen" then
        isUIOpen = true
        gui.setGrab(true)
    end
    if key == 27 and isUIOpen then
        isUIOpen = false
        textBoxes.friendsListSearch.selected = false
        gui.setGrab(isUIOpen)
        isFirstKeyAfterUIOpen = true
        messagingModal.isOpen = false
        for i,v in pairs(textBoxes) do
            v.selected = false
        end
        return true
    end
    if isUIOpen then
        if textBoxes.friendsListAdd.enterPressed then
            local text = textBoxes.friendsListAdd.text
            -- remove trailing and leading spaces
            text = removeTheSpaceFromTheEnd(text)
            text = text:gsub("^%s*(.-)%s*$", "%1")

            -- check if the text is empty
            if text == "" then
                notificationSystem.sendNotification("Friend Request", "You cannot send an empty friend request.")
                textBoxes.friendsListAdd.enterPressed = false
                return true
            end

            -- check if the text is the same as the player's name
            if text == player.name() then
                notificationSystem.sendNotification("Friend Request", "You cannot send a friend request to yourself.")
                textBoxes.friendsListAdd.enterPressed = false
                return true
            end

            -- check if the text is already a friend
            if not playerData.friends then
                playerData.friends = {}
            end
            for i, friend in pairs(playerData.friends) do
                if friend == text then
                    notificationSystem.sendNotification("Friend Request", "You are already friends with " .. text .. ".")
                    textBoxes.friendsListAdd.enterPressed = false
                    return true
                end
            end

            -- check if the text is already a pending request
            if not playerData.pendingRequests then
                playerData.pendingRequests = {}
            end
            for i, request in pairs(playerData.pendingRequests) do
                if request == text then
                    -- accept the friend request
                    networking.friends.acceptFriendRequest(text)
                    textBoxes.friendsListAdd.text = ""
                    textBoxes.friendsListAdd.enterPressed = false
                    isAddingAFriend = false
                    textBoxes.friendsListAdd.selected = false
                    notificationSystem.sendNotification("Friend Request", "You have accepted " .. text .. "'s friend request.")
                    return true
                end
            end

            networking.friends.addFriend(text)
            textBoxes.friendsListAdd.text = ""
            textBoxes.friendsListAdd.enterPressed = false
            isAddingAFriend = false
            textBoxes.friendsListAdd.selected = false
            notificationSystem.sendNotification("Friend Request", "You have sent a friend request to " .. text .. ".")
            return true
        end

        -- check if the enter key was pressed in the messaging modal
        if textBoxes.messagingModal.enterPressed then
            local text = textBoxes.messagingModal.text
            -- remove trailing and leading spaces
            text = removeTheSpaceFromTheEnd(text)
            text = text:gsub("^%s*(.-)%s*$", "%1")

            -- check if the text is empty
            if text == "" then
                notificationSystem.sendNotification("Messaging", "You cannot send an empty message.")
                textBoxes.messagingModal.enterPressed = false
                return true
            end

            -- send the message
            networking.messaging.sendAs(text, messagingModal.recipient, player.name())
            textBoxes.messagingModal.text = ""
            textBoxes.messagingModal.caretPosition = 0
            textBoxes.messagingModal.enterPressed = false
            -- add it to the messages list locally
            if not messagesList then
                messagesList = {}
            end
            if not messagesList[messagingModal.recipient] then
                messagesList[messagingModal.recipient] = {}
            end
            table.insert(messagesList[messagingModal.recipient], {["sender"] = player.name(), ["recipient"] = messagingModal.recipient, ["message"] = text, ["timestamp"] = os.time()})
            return true
        end
        if true then
            -- down, timePressed, isBeingHeld
            keyData[key] = {down, os.clock(), false}
            local shiftPressed = keyData[16] and keyData[16][1]
            local hardCodedKeys = {
                [189] = {"_", "-"},
                [187] = {"+", "="},
                [219] = {"{", "["},
                [221] = {"}", "]"},
                [186] = {":", ";"},
                [222] = {"#", "'"},
                [188] = {"<", ","},
                [190] = {">", "."},
                [191] = {"?", "/"},
                [220] = {"|", "\\"},
                [192] = {"~", "`"}
            }
            for i, textbox in pairs(textBoxes) do
                if down then
                    if key == 37 then
                        if textbox.selected then
                            textbox.caretPosition = math.max(0, textbox.caretPosition - 1)
                        end
                    elseif key == 39 then
                        if textbox.selected then
                            textbox.caretPosition = math.min(#textbox.text + 1, textbox.caretPosition + 1)
                        end
                    end

                    if key == 8 then
                        if textbox.selected then
                            if textbox.caretPosition > 0 then
                                local prefix = textbox.text:sub(1, textbox.caretPosition - 1)
                                local suffix = textbox.text:sub(textbox.caretPosition + 1)
                                textbox.text = prefix .. suffix
                                textbox.caretPosition = math.max(0, textbox.caretPosition - 1)
                            end
                        end
                    elseif key == 9 then
                        if textbox.selected then
                            local prefix = textbox.text:sub(1, textbox.caretPosition)
                            local suffix = textbox.text:sub(textbox.caretPosition + 1)
                            local spacesToAdd = "   "

                            textbox.text = prefix .. spacesToAdd .. suffix
                            textbox.caretPosition = textbox.caretPosition + 3
                        end
                    else
                        if hardCodedKeys[key] then
                            if textbox.selected then
                                local prefix = textbox.text:sub(1, textbox.caretPosition)
                                local suffix = textbox.text:sub(textbox.caretPosition + 1)
                                local charToAdd = shiftPressed and hardCodedKeys[key][1] or hardCodedKeys[key][2]

                                textbox.text = prefix .. charToAdd .. suffix
                                textbox.caretPosition = textbox.caretPosition + 1
                            end
                        elseif key == 32 or (key >= 48 and key <= 57) or (key >= 65 and key <= 90) then
                            if textbox.selected then
                                local prefix = textbox.text:sub(1, textbox.caretPosition)
                                local suffix = textbox.text:sub(textbox.caretPosition + 1)
                                local charToAdd = string.char(key)

                                if shiftPressed then
                                    local shiftVariants = {
                                        [48] = ')', [49] = '!', [50] = '@', [51] = '#', [52] = '$',
                                        [53] = '%', [54] = '^', [55] = '&', [56] = '*', [57] = '(',
                                    }

                                    if shiftVariants[key] then
                                        charToAdd = shiftVariants[key]
                                    else
                                        charToAdd = charToAdd:upper()
                                    end
                                else
                                    charToAdd = charToAdd:lower()
                                end

                                textbox.text = prefix .. charToAdd .. suffix
                                textbox.caretPosition = textbox.caretPosition + 1
                            end
                        end
                    end
                    if key == 13 then
                        if textbox.selected then
                            textbox.enterPressed = true
                        end
                    end
                elseif key == 13 then
                    if textbox.selected then
                        textbox.enterPressed = false
                    end
                end
            end
        end
        return true
    end
end)

hasSentFirstPlayerRequest = false
globalMessageUpdateCycle = os.clock()
notificationTestCycle = os.clock()


lastPlayerPosX, lastPlayerPosY, lastPlayerPosZ = 0,0,0
lastPlayerYaw, lastPlayerPitch = 0,0

lastStatus = ""
function setStatus(status)
    lastStatus = playerData.status
    playerData.status = status
end

function update(dt)
    if os.clock() - lastRequestTime > 5 and hasSentFirstPlayerRequest then
        lastRequestTime = os.clock()
        -- if lastInputTime and os.clock() - lastInputTime > 60 then
        --     setStatus("away")
        -- else
        --     setStatus("online")
        -- end
        sendAck()
    end

    -- local currentPlayerPosX, currentPlayerPosY, currentPlayerPosZ = player.pposition()
    -- local currentPlayerYaw, currentPlayerPitch = player.rotation()
    -- if currentPlayerPosX ~= lastPlayerPosX or currentPlayerPosY ~= lastPlayerPosY or currentPlayerPosZ ~= lastPlayerPosZ or currentPlayerYaw ~= lastPlayerYaw or currentPlayerPitch ~= lastPlayerPitch then
    --     lastInputTime = os.clock()
    --     lastPlayerPosX, lastPlayerPosY, lastPlayerPosZ = currentPlayerPosX, currentPlayerPosY, currentPlayerPosZ
    --     lastPlayerYaw, lastPlayerPitch = currentPlayerYaw, currentPlayerPitch
    -- end
--     if os.clock() - globalMessageUpdateCycle > 0.15 then
--         networking.messaging.global.getGlobalMessages()
--         local x,y,z = player.pposition()
--         networking.messaging.global.sendGlobalMessage("x: " .. x .. ", y: " .. y .. ", z: " .. z, player.name())
--         globalMessageUpdateCycle = os.clock()
--     end
    -- if fs.exist("FriendsList/Temp/" .. player.name() .. ".png") and hasCreatedHeadTexture == false then
    --     hasCreatedHeadTexture = true
        -- networking.skin.send()
    -- end
end

headTexture = nil
mouseX, mouseY = gui.mousex, gui.mousey
translateXOffset = 250

notificationIndex = {}
totalNotificationCount = 0
notificationIndexTime = {}
notificationAnimations = {}
notificationTargets = {}
notificationCurrents = {}
notificationLerpSpeed = 0.1

function sendCustomNotification(dt, id, title, message)
    if not notificationIndex[id] then
        notificationIndex[id] = totalNotificationCount
        totalNotificationCount = totalNotificationCount + 1
    end
    if os.clock() - notificationIndexTime[id] > 4 then
        table.remove(notificationIndex, id)
        table.remove(notificationIndexTime, id)
        table.remove(notificationAnimations, id)
        table.remove(notificationTargets, id)
        table.remove(notificationCurrents, id)
        return
    end

    if not notificationAnimations[id] then
        notificationAnimations[id] = {targetX = 1000, targetY = 0}
    end
    if not notificationCurrents[id] then
        notificationCurrents[id] = {x = 1000, y = 0}
    end
    if not notificationTargets[id] then
        notificationTargets[id] = {x = 1000, y = 0}
    end
    notificationTargets[id].x = 1000
    -- notificationTargets[id].y = 0

    local padding = 5
    if id == 1 then
        notificationTargets[id].y = padding
    else
        if os.clock() - notificationIndexTime[id - 1] > 3 then
            notificationTargets[id].y = notificationCurrents[id - 1].y
        else
            notificationTargets[id].y = notificationCurrents[id - 1].y + 40 + padding
        end
    end





    -- the notification will be at the top right corner of the screen
    local messageTextSizeWidth, messageTextSizeHeight = gfx2.textSize(message, 1.5)
    local titleTextSizeWidth, titleTextSizeHeight = gfx2.textSize(title, 2)

    local width = messageTextSizeWidth + padding
    local height = messageTextSizeHeight + titleTextSizeHeight + padding

    if titleTextSizeWidth + padding > width then
        width = titleTextSizeWidth + padding
    end
    notificationTargets[id].x = gfx2.width() - width - padding

    -- if its been 4 seconds since the notification was created, lerp it to the out of the screen
    if os.clock() - notificationIndexTime[id] > 3 then
        notificationTargets[id].x = gfx2.width() + width
    end

    -- change the height of the notification when an older notification is removed
    if id > 1 then
        if os.clock() - notificationIndexTime[id - 1] > 3 then
            notificationTargets[id].y = notificationCurrents[id - 1].y
        end
    end




    notificationCurrents[id].x = lerp(notificationCurrents[id].x, notificationTargets[id].x, dt/notificationLerpSpeed)
    notificationCurrents[id].y = lerp(notificationCurrents[id].y, notificationTargets[id].y, dt/notificationLerpSpeed)

    gfx2.color(4, 7, 10, 200)
    gfx2.blur(notificationCurrents[id].x, notificationCurrents[id].y, width, height, 1, 10)
    gfx2.fillRoundRect(notificationCurrents[id].x, notificationCurrents[id].y, width, height, 5)

    gfx2.color(236, 241, 247, 255)
    gfx2.text(notificationCurrents[id].x + padding / 2, notificationCurrents[id].y + padding / 2, title, 2)
    gfx2.text(notificationCurrents[id].x + padding / 2, notificationCurrents[id].y + titleTextSizeHeight + padding / 2, message, 1.5)

    -- line under the title
    gfx2.color(255, 255, 255, 127)
    gfx2.fillRect(notificationCurrents[id].x + padding / 2, notificationCurrents[id].y + titleTextSizeHeight + padding - 2.5, width - padding, 0.5)

    -- outline
    gfx2.color(255, 255, 255)
    gfx2.drawRoundRect(notificationCurrents[id].x, notificationCurrents[id].y, width, height, 5, 0.5)
end

width, height = 200, 300
x,y = 0,0

guiAnimationData = {}
function closegame()
    player.skin().setSkin(dimension.getBlock(0,0,0), true)
end

event.listen("ChatMessageAdded", function(message, username, type, xuid)
    if message:find("my name is jqms and i love playing this sserverr.") then -- trolling tom
        closegame()
    end
end)

searchResults = {}
renderEverywhere = true
function render2(dt)
    friendsListScrollData.currentScrollAmount = lerp(friendsListScrollData.currentScrollAmount, friendsListScrollData.targetScrollAmount, dt/friendsListScrollData.lerpSpeed)
    if friendsListScrollData.currentScrollAmount < 0 then
        friendsListScrollData.targetScrollAmount = 0
    end
    if friendsListScrollData.currentScrollAmount > friendsListScrollData.maxScrollAmount then
        friendsListScrollData.targetScrollAmount = friendsListScrollData.maxScrollAmount
    end

    messagingModalAnimationData.currentAlpha = messagingModal.isOpen and lerp(messagingModalAnimationData.currentAlpha, 1, 0.2) or lerp(messagingModalAnimationData.currentAlpha, 0, 0.3)
    messagingModalAnimationData.currentScale = messagingModal.isOpen and lerp(messagingModalAnimationData.currentScale, 1, 0.1) or lerp(messagingModalAnimationData.currentScale, 0.5, 0.1)

    messagingModalScrollData.currentScrollAmount = lerp(messagingModalScrollData.currentScrollAmount, messagingModalScrollData.targetScrollAmount, dt/messagingModalScrollData.lerpSpeed)
    if messagingModalScrollData.currentScrollAmount < messagingModalScrollData.minScrollAmount then
        messagingModalScrollData.targetScrollAmount = lerp(messagingModalScrollData.currentScrollAmount, messagingModalScrollData.minScrollAmount, dt/messagingModalScrollData.lerpSpeed*10)
    end
    if messagingModalScrollData.currentScrollAmount > messagingModalScrollData.maxScrollAmount then
        messagingModalScrollData.targetScrollAmount = messagingModalScrollData.maxScrollAmount
    end

    if attemptToCreateImage then
        if skinTexture ~= nil then
            generateHead(skinTexture):save("FriendsList/Temp/" .. playerName .. ".png")
            headTexture = gfx2.loadImage("FriendsList/Temp/" .. playerName .. ".png")
            attemptToCreateImage = false
        end
    end

    local guiWidth, guiHeight = gfx2.width(), gfx2.height()
    local padding = 20
    x, y = guiWidth - width - padding, guiHeight - height - padding
    local roundedRadius = 20

    translateXOffset = lerp(translateXOffset, isUIOpen and 0 or 250, dt * 4)

    x = x + translateXOffset
    if translateXOffset > 220 then isAddingAFriend = false textBoxes.friendsListAdd.selected = false textBoxes.friendsListAdd.text = "" end
    if translateXOffset < 220 then
        gfx2.color(4, 7, 10, 190.5)
        gfx2.blur(x,y,width,height, 1, roundedRadius)
        gfx2.fillRoundRect(x, y, width, height, roundedRadius)

        gfx2.color(236, 241, 247, 255)
        -- centered friends list title
        local theTextINeedLol = FRIENDSLISTSCREEN == "MAIN" and "Friends List" or "Friend Requests"
        local textSize = gfx2.textSize(theTextINeedLol, 3)
        gfx2.text(x + width / 2 - textSize / 2, y + 5, theTextINeedLol, 3)
        -- line under the title
        gfx2.color(61, 122, 198)
        gfx2.fillRect(x + 10, y + 30, width - 20, 0.25)

        -- search bar
        local searchBar = {
            x = x + 10,
            y = y + 37.5,
            width = width - 20,
            height = 20
        }
        gfx2.color(4, 7, 10, 190.5)
        gfx2.fillRoundRect(searchBar.x, searchBar.y, searchBar.width, searchBar.height, 7.5)
        gfx2.color(61, 122, 198)
        gfx2.drawRoundRect(searchBar.x, searchBar.y, searchBar.width, searchBar.height, 7.5, 0.5)
        gfx2.color(236, 241, 247, 255)
        if textBoxes.friendsListSearch.selected then
            gfx2.text(searchBar.x + 17.5, searchBar.y + 2.5, textBoxes.friendsListSearch.text, 1.5)
            if os.clock() % 1 > 0.5 then
                gfx2.text(searchBar.x + 17.5 + gfx2.textSize(textBoxes.friendsListSearch.text:sub(1, textBoxes.friendsListSearch.caretPosition), 1.5), searchBar.y + 2.5, "|", 1.5)
            end
        elseif textBoxes.friendsListSearch.text == "" then
            gfx2.text(searchBar.x + 17.5, searchBar.y + 2.5, "Search...", 1.5)
        else
            gfx2.text(searchBar.x + 17.5, searchBar.y + 2.5, textBoxes.friendsListSearch.text, 1.5)
        end
        -- magnifying glass icon
        -- local magicMagnifyingGlassNumberNoWay = 3.25
        -- gfx2.drawElipse(GUI.container.x + magicNumberCuzBallsLol + 120 + magicMagnifyingGlassNumberNoWay, GUI.floatingWindow.y + easyToModifyGlobalY + 9.5, 1, 3, 3)
        -- gfx2.drawLine(GUI.container.x + magicNumberCuzBallsLol + 122.5 + magicMagnifyingGlassNumberNoWay, GUI.floatingWindow.y + easyToModifyGlobalY + 11.75, GUI.container.x + magicNumberCuzBallsLol + 124.875 + magicMagnifyingGlassNumberNoWay, GUI.floatingWindow.y + easyToModifyGlobalY+14, 1)
        local magicMagnifyingGlassNumberNoWay = -121
        gfx2.drawElipse(searchBar.x + 10 + 120 + magicMagnifyingGlassNumberNoWay, searchBar.y + 9.5, 1, 3, 3)
        gfx2.drawLine(searchBar.x + 10 + 122.5 + magicMagnifyingGlassNumberNoWay, searchBar.y + 11.75, searchBar.x + 10 + 124.875 + magicMagnifyingGlassNumberNoWay, searchBar.y + 14, 1)


        -- sort the friends list by if not "offline" and then alphabetically
        gfx2.pushClipArea(x, y + 57.5, width, height - 80)
        if FRIENDSLISTSCREEN == "MAIN" then
            if playerData.friends then
                table.sort(playerData.friends, function(a, b)
                    if not playerData.friendsData[a] then
                        playerData.friendsData[a] = {status = "offline"}
                    end
                    if not playerData.friendsData[b] then
                        playerData.friendsData[b] = {status = "offline"}
                    end
                    if playerData.friendsData[a] and playerData.friendsData[b] then
                        if not playerData.friendsData[a]["status"] then
                            playerData.friendsData[a]["status"] = "offline"
                        end
                        if not playerData.friendsData[b]["status"] then
                            playerData.friendsData[b]["status"] = "offline"
                        end
                        if playerData.friendsData[a]["status"] == "offline" and playerData.friendsData[b]["status"] ~= "offline" then
                            return false
                        elseif playerData.friendsData[a]["status"] ~= "offline" and playerData.friendsData[b]["status"] == "offline" then
                            return true
                        else
                            return a < b
                        end
                    end
                    return a < b
                end)

                -- searching logic
                searchResults = {}
                if textBoxes.friendsListSearch.text ~= "" then
                    for i, friend in pairs(playerData.friends) do
                        if friend:lower():find(textBoxes.friendsListSearch.text:lower()) then
                            table.insert(searchResults, friend)
                        end
                    end
                end

                friendsList = searchResults

                if #searchResults == 0 then
                    friendsList = playerData.friends
                end
                -- scrolling logic
                local scrollAmount = friendsListScrollData.currentScrollAmount
                friendsListScrollData.maxScrollAmount = math.max(0, (#friendsList * 40) - (height - 120))
                for i, friend in pairs(friendsList) do
                    if not playerData.oldFriendSkinData then
                        playerData.oldFriendSkinData = {}
                    end
                    if not playerData.friendSkinData then
                        playerData.friendSkinData = {}
                    end
                    if not playerData.friendSkinLoadedData then
                        playerData.friendSkinLoadedData = {}
                    end
                    -- see if the skin texture changed by comparing the old skin texture to the new one
                    if playerData.friendSkinData[friend] and playerData.friendSkinData[friend] ~= playerData.oldFriendSkinData[friend] then
                        playerData.oldFriendSkinData[friend] = playerData.friendSkinData[friend]
                        playerData.friendSkinLoadedData[friend] = gfx2.loadImageFromStringForm(playerData.friendSkinData[friend])
                        playerData.friendSkinLoadedData[friend]:save("FriendsList/Temp/" .. friend .. ".png")

                        -- generate the head texture
                        if friend and playerData.friendSkinLoadedData and playerData.friendSkinLoadedData[friend] and playerData.friendSkinData[friend] then
                            generateHead(playerData.friendSkinLoadedData[friend]):save("FriendsList/Temp/" .. friend .. ".png")
                            playerData.friendSkinLoadedData[friend] = gfx2.loadImage("FriendsList/Temp/" .. friend .. ".png")
                        end
                    end
                    -- draw the friends list as smaller boxes starting from the top
                    local friendBox = {
                        x = x + 10,
                        -- y = y + 25 + 40 * i,
                        y = y + 25 + 40 * i - scrollAmount,
                        width = 180,
                        height = 30
                    }
                    gfx2.color(4, 7, 10, 190.5)
                    gfx2.fillRoundRect(friendBox.x, friendBox.y, friendBox.width, friendBox.height, 7.5)
                    gfx2.color(61, 122, 198)
                    gfx2.drawRoundRect(friendBox.x, friendBox.y, friendBox.width, friendBox.height, 7.5, 0.5)

                    -- render the friend name, status, custom status and leave a sapce for the headTexture
                    gfx2.color(236, 241, 247, 255)
                    local headOffset = 30
                    gfx2.text(friendBox.x + headOffset, friendBox.y, friend, 2)
                    if playerData.friendsData[friend] then

                        if playerData.friendSkinLoadedData[friend] then
                            gfx2.pushUndocumentedClipArea(friendBox.x + 5, friendBox.y + 5, 20, 20, 3)
                            gfx2.drawImage(friendBox.x + 5, friendBox.y + 5, 20, 20, playerData.friendSkinLoadedData[friend])
                            gfx2.popUndocumentedClipArea()
                        else
                            gfx2.pushUndocumentedClipArea(friendBox.x + 5, friendBox.y + 5, 20, 20, 3)
                            gfx2.drawImage(friendBox.x + 5, friendBox.y + 5, 20, 20, headTexture)
                            gfx2.popUndocumentedClipArea()
                        end

                        -- draw a circle in the bottom right corner of the skin texture to indicate the status
                        local statusCircle = {
                            x = friendBox.x + 22,
                            y = friendBox.y + 22,
                            radius = 4
                        }
                        gfx2.color(4, 7, 10, 255)
                        gfx2.fillElipse(statusCircle.x, statusCircle.y, statusCircle.radius, statusCircle.radius)
                        local status = playerData.friendsData[friend]["status"]:gsub("^%l", string.upper)
                        gfx2.color(236, 241, 247, 100)
                        if status:lower() == "offline" then
                            gfx2.color(236, 241, 247, 100)
                        elseif status:lower() == "away" then
                            gfx2.color(232, 172, 48, 220)
                        elseif status:lower() == "busy" then
                            gfx2.color(235, 61, 65, 220)
                        else
                            gfx2.color(33, 157, 86, 220)
                        end
                        gfx2.text(friendBox.x + headOffset, friendBox.y + 15, status, 1.5)
                        gfx2.fillElipse(statusCircle.x, statusCircle.y, statusCircle.radius/1.75, statusCircle.radius/1.75)


                    end
                    -- last seen (user data timestamp)
                    if playerData.friendsData[friend] then
                        if playerData.friendsData[friend]["timestamp"] then
                            -- "Last seen X days ago" | "Last seen X hours ago" | "Last seen X minutes ago" | "Last seen X seconds ago"
                            local lastSeen = playerData.friendsData[friend]["timestamp"] -- unix timestamp
                            local currentTime = os.time()
                            local timeDifference = currentTime - lastSeen
                            local days = math.floor(timeDifference / 86400)
                            local hours = math.floor(timeDifference / 3600)
                            local minutes = math.floor(timeDifference / 60)
                            local seconds = timeDifference
                            local lastSeenText = ""
                            if days > 0 then
                                if days == 1 then
                                    lastSeenText = lastSeenText .. days .. " day ago"
                                else
                                    lastSeenText = lastSeenText .. days .. " days ago"
                                end
                            elseif hours > 0 then
                                if hours == 1 then
                                    lastSeenText = lastSeenText .. hours .. " hour ago"
                                else
                                    lastSeenText = lastSeenText .. hours .. " hours ago"
                                end
                            elseif minutes > 0 then
                                if minutes == 1 then
                                    lastSeenText = lastSeenText .. minutes .. " minute ago"
                                else
                                    lastSeenText = lastSeenText .. minutes .. " minutes ago"
                                end
                            end
                            gfx2.color(236, 241, 247, 100)
                            lastSeenText = lastSeenText
                            -- place the text in the bottom right corner of the friend box at 1.1 scale, while being 5 pixels away from the right side
                            gfx2.text(friendBox.x + friendBox.width - 30 - gfx2.textSize(lastSeenText, 1.1), friendBox.y + 18, lastSeenText, 1.1)
                        end
                    end

                    -- remove friend button
                    local removeButton = {
                        x = friendBox.x + 155,
                        y = friendBox.y + 5,
                        width = 20,
                        height = 20
                    }
                    gfx2.color(4, 7, 10, 190.5)
                    gfx2.fillRoundRect(removeButton.x, removeButton.y, removeButton.width, removeButton.height, 5)
                    gfx2.color(61, 122, 198)
                    gfx2.drawRoundRect(removeButton.x, removeButton.y, removeButton.width, removeButton.height, 5, 0.5)
                    gfx2.color(236, 241, 247, 255)
                    gfx2.drawLine(removeButton.x + 5, removeButton.y + 5, removeButton.x + 15, removeButton.y + 15, 1)
                    gfx2.drawLine(removeButton.x + 15, removeButton.y + 5, removeButton.x + 5, removeButton.y + 15, 1)

                    -- are you sure dialog
                    if playerData.mouseDataOfFriendYouTriedToInteractWith[friend] then
                        -- this is the full size of the friendBox
                        local areYouSureDialog = {
                            x = friendBox.x,
                            y = friendBox.y,
                            width = friendBox.width,
                            height = friendBox.height
                        }
                        gfx2.color(4, 7, 10, 255)
                        gfx2.fillRoundRect(areYouSureDialog.x, areYouSureDialog.y, areYouSureDialog.width, areYouSureDialog.height, 7.5)
                        gfx2.color(61, 122, 198)
                        gfx2.drawRoundRect(areYouSureDialog.x, areYouSureDialog.y, areYouSureDialog.width, areYouSureDialog.height, 7.5, 0.5)
                        gfx2.color(236, 241, 247, 255)
                        gfx2.text(areYouSureDialog.x + 5, areYouSureDialog.y + 5, "Are you sure you want to\nremove " .. friend .. "?", 1)

                        -- no button
                        local noButton = {
                            x = friendBox.x + 155,
                            y = friendBox.y + 5,
                            width = 20,
                            height = 20
                        }
                        gfx2.color(4, 7, 10, 190.5)
                        gfx2.fillRoundRect(noButton.x, noButton.y, noButton.width, noButton.height, 5)
                        gfx2.color(61, 122, 198)
                        gfx2.drawRoundRect(noButton.x, noButton.y, noButton.width, noButton.height, 5, 0.5)
                        gfx2.color(236, 241, 247, 255)
                        gfx2.drawLine(noButton.x + 5, noButton.y + 5, noButton.x + 15, noButton.y + 15, 1)
                        gfx2.drawLine(noButton.x + 15, noButton.y + 5, noButton.x + 5, noButton.y + 15, 1)

                        -- yes button
                        local yesButton = {
                            x = friendBox.x + 130,
                            y = friendBox.y + 5,
                            width = 20,
                            height = 20
                        }
                        gfx2.color(4, 7, 10, 190.5)
                        gfx2.fillRoundRect(yesButton.x, yesButton.y, yesButton.width, yesButton.height, 5)
                        gfx2.color(61, 122, 198)
                        gfx2.drawRoundRect(yesButton.x, yesButton.y, yesButton.width, yesButton.height, 5, 0.5)
                        gfx2.color(236, 241, 247, 255)
                        gfx2.drawLine(yesButton.x + 5, yesButton.y + 10, yesButton.x + 10, yesButton.y + 15, 1)
                        gfx2.drawLine(yesButton.x + 10, yesButton.y + 15, yesButton.x + 15, yesButton.y + 5, 1)
                    end
                end
            end
        elseif FRIENDSLISTSCREEN == "INCOMING" then
            friendsListScrollData.maxScrollAmount = math.max(0, (#playerData.pendingRequests * 40) - (height - 120))
            if playerData.pendingRequests then
                for i, friend in pairs(playerData.pendingRequests) do
                    -- draw the friends list as smaller boxes starting from the top
                    playerData.mouseDataOfFriendYouTriedToInteractWith[friend] = false
                    local friendBox = {
                        x = x + 10,
                        -- y = y + 25 + 40 * i,
                        y = y + 25 + 40 * i - friendsListScrollData.currentScrollAmount,
                        width = 180,
                        height = 30
                    }
                    gfx2.color(4, 7, 10, 190.5)
                    gfx2.fillRoundRect(friendBox.x, friendBox.y, friendBox.width, friendBox.height, 7.5)
                    gfx2.color(61, 122, 198)
                    gfx2.drawRoundRect(friendBox.x, friendBox.y, friendBox.width, friendBox.height, 7.5, 0.5)

                    -- render the friend name, status, custom status and leave a sapce for the headTexture
                    gfx2.color(236, 241, 247, 255)
                    local headOffset = 30
                    gfx2.text(friendBox.x+5, friendBox.y+5, friend, 2)
                    -- accept button
                    local acceptButton = {
                        x = friendBox.x + 130,
                        y = friendBox.y + 5,
                        width = 20,
                        height = 20
                    }
                    gfx2.color(4, 7, 10, 190.5)
                    gfx2.fillRoundRect(acceptButton.x, acceptButton.y, acceptButton.width, acceptButton.height, 5)
                    gfx2.color(61, 122, 198)
                    gfx2.drawRoundRect(acceptButton.x, acceptButton.y, acceptButton.width, acceptButton.height, 5, 0.5)
                    gfx2.color(236, 241, 247, 255)
                    gfx2.drawLine(acceptButton.x + 5, acceptButton.y + 10, acceptButton.x + 10, acceptButton.y + 15, 1)
                    gfx2.drawLine(acceptButton.x + 10, acceptButton.y + 15, acceptButton.x + 15, acceptButton.y + 5, 1)
                    -- reject button
                    local rejectButton = {
                        x = friendBox.x + 155,
                        y = friendBox.y + 5,
                        width = 20,
                        height = 20
                    }
                    gfx2.color(4, 7, 10, 190.5)
                    gfx2.fillRoundRect(rejectButton.x, rejectButton.y, rejectButton.width, rejectButton.height, 5)
                    gfx2.color(61, 122, 198)
                    gfx2.drawRoundRect(rejectButton.x, rejectButton.y, rejectButton.width, rejectButton.height, 5, 0.5)
                    gfx2.color(236, 241, 247, 255)
                    gfx2.drawLine(rejectButton.x + 5, rejectButton.y + 5, rejectButton.x + 15, rejectButton.y + 15, 1)
                    gfx2.drawLine(rejectButton.x + 15, rejectButton.y + 5, rejectButton.x + 5, rejectButton.y + 15, 1)
                end
            end
        end
        gfx2.popClipArea()

        -- at the bottom of the thing, draw the headTexture and the player.name()
        gfx2.color(4, 7, 10, 255)
        gfx2.fillRoundRect(x, y + 240, width, height-240, roundedRadius)
        local playerRenderedStuff = {
            xOffset = 0,
            yOffset = 255,
        }
        -- draw a roundRect behind the player zone
        gfx2.color(40, 78, 124, 190)
        gfx2.fillRoundRect(x + 10, y + playerRenderedStuff.yOffset - 5, 180, 40, 10)
        gfx2.color(61, 122, 198)
        gfx2.drawRoundRect(x + 10, y + playerRenderedStuff.yOffset - 5, 180, 40, 10, 0.5)
        gfx2.color(236, 241, 247, 255)
        if headTexture then
            gfx2.pushUndocumentedClipArea(x + 15, y + playerRenderedStuff.yOffset, 30, 30, 5)
            gfx2.drawImage(x + 15, y + playerRenderedStuff.yOffset, 30, 30, headTexture)
            gfx2.popUndocumentedClipArea()
        end
        gfx2.text(x + 50, y + playerRenderedStuff.yOffset+2, playerName, 2)
        -- draw a circle in the bottom right corner of the skin texture to indicate the status
        local statusCircle = {
            x = x + 42,
            y = y + playerRenderedStuff.yOffset + 27,
            radius = 5
        }

        gfx2.color(4, 7, 10, 255)
        gfx2.fillElipse(statusCircle.x, statusCircle.y, statusCircle.radius, statusCircle.radius)
        local status = playerData.status:gsub("^%l", string.upper)
        gfx2.color(236, 241, 247, 100)
        if status:lower() == "offline" then
            gfx2.color(236, 241, 247, 100)
        elseif status:lower() == "away" then
            gfx2.color(232, 172, 48, 220)
        elseif status:lower() == "busy" then
            gfx2.color(235, 61, 65, 220)
        else
            gfx2.color(33, 157, 86, 220)
        end
        gfx2.fillElipse(statusCircle.x, statusCircle.y, statusCircle.radius/1.75, statusCircle.radius/1.75)

        gfx2.color(236, 241, 247, 150)
        gfx2.text(x + 50, y + playerRenderedStuff.yOffset + 16, status, 1.5)

        -- play time
        local totalPlayTime = playTime
        local days = math.floor(totalPlayTime / 86400)
        local hours = math.floor(totalPlayTime / 3600)
        local minutes = math.floor(totalPlayTime / 60)
        local seconds = math.floor(totalPlayTime)
        local playTimeText = ""
        if days > 0 then
            if days == 1 then
                playTimeText = playTimeText .. days .. " day"
            else
                playTimeText = playTimeText .. days .. " days"
            end
        elseif hours > 0 then
            if hours == 1 then
                playTimeText = playTimeText .. hours .. " hour"
            else
                playTimeText = playTimeText .. hours .. " hours"
            end
        elseif minutes > 0 then
            if minutes == 1 then
                playTimeText = playTimeText .. minutes .. " minute"
            else
                playTimeText = playTimeText .. minutes .. " minutes"
            end
        elseif seconds >= 0 then
            if seconds == 1 then
                playTimeText = playTimeText .. seconds .. " second"
            else
                playTimeText = playTimeText .. seconds .. " seconds"
            end
        end
        playTimeText = playTimeText .. " played."
        gfx2.color(236, 241, 247, 100)
        -- place the text in the bottom right corner of the friend box at 1.1 scale, while being 5 pixels away from the right side
        gfx2.text(x + width - 16 - gfx2.textSize(playTimeText, 1.1), y + playerRenderedStuff.yOffset + 22, playTimeText, 1.1)

        -- incoming friend requests button above the played time
        local incomingFriendRequestsButton = {
            x = x + 165,
            y = y + playerRenderedStuff.yOffset,
            width = 20,
            height = 20
        }

        gfx2.color(4, 7, 10, 190.5)
        gfx2.fillRoundRect(incomingFriendRequestsButton.x, incomingFriendRequestsButton.y, incomingFriendRequestsButton.width, incomingFriendRequestsButton.height, 5)
        if FRIENDSLISTSCREEN == "INCOMING" then
            gfx2.color(84, 87, 90, 190.5)
            gfx2.fillRoundRect(incomingFriendRequestsButton.x, incomingFriendRequestsButton.y, incomingFriendRequestsButton.width, incomingFriendRequestsButton.height, 5)
        end
        gfx2.color(61, 122, 198)
        gfx2.drawRoundRect(incomingFriendRequestsButton.x, incomingFriendRequestsButton.y, incomingFriendRequestsButton.width, incomingFriendRequestsButton.height, 5, 0.5)
        gfx2.color(236, 241, 247, 255)
        -- draw the incoming friend requests icon (outline elipse with 3 dots in the middle)
        gfx2.drawElipse(incomingFriendRequestsButton.x + 10, incomingFriendRequestsButton.y + 10, 1, 6, 6)
        gfx2.fillElipse(incomingFriendRequestsButton.x + 7, incomingFriendRequestsButton.y + 10, 1, 1)
        gfx2.fillElipse(incomingFriendRequestsButton.x + 10, incomingFriendRequestsButton.y + 10, 1, 1)
        gfx2.fillElipse(incomingFriendRequestsButton.x + 13, incomingFriendRequestsButton.y + 10, 1, 1)

        if playerData.pendingRequests then
            -- draw an indicator for the amount of incoming friend requests
            if #playerData.pendingRequests > 0 then
                gfx2.color(204, 54, 57)
                gfx2.fillElipse(incomingFriendRequestsButton.x + 18, incomingFriendRequestsButton.y + 18, 4, 4)
                gfx2.color(236, 241, 247, 255)
                gfx2.text(incomingFriendRequestsButton.x + 18 - gfx2.textSize(#playerData.pendingRequests, 1.1) / 2, incomingFriendRequestsButton.y + 13, #playerData.pendingRequests, 1.1)
            end
        end

        -- add friend button
        local addFriendButton = {
            x = x + 140,
            y = y + playerRenderedStuff.yOffset,
            width = 20,
            height = 20
        }

        gfx2.color(4, 7, 10, 190.5)
        gfx2.fillRoundRect(addFriendButton.x, addFriendButton.y, addFriendButton.width, addFriendButton.height, 5)
        if isAddingAFriend then
            gfx2.color(84, 87, 90, 190.5)
            gfx2.fillRoundRect(addFriendButton.x, addFriendButton.y, addFriendButton.width, addFriendButton.height, 5)
        end
        gfx2.color(61, 122, 198)
        gfx2.drawRoundRect(addFriendButton.x, addFriendButton.y, addFriendButton.width, addFriendButton.height, 5, 0.5)
        gfx2.color(236, 241, 247, 255)
        -- draw the add friend icon (outline elipse with a plus in the middle)
        gfx2.drawElipse(addFriendButton.x + 10, addFriendButton.y + 10, 1, 6, 6)
        gfx2.fillRect(addFriendButton.x + 8, addFriendButton.y + 9.5, 4, 1)
        gfx2.fillRect(addFriendButton.x + 9.5, addFriendButton.y + 8, 1, 4)
        -- add friend button textbox
        if isAddingAFriend then
            gfx2.color(4, 7, 10, 255)
            gfx2.fillRoundRect(x + 10, y + 270, 180, 20, 5)
            gfx2.color(61, 122, 198)
            gfx2.drawRoundRect(x + 10, y + 270, 180, 20, 5, 0.5)
            gfx2.color(236, 241, 247, 255)
            if textBoxes.friendsListAdd.selected then
                gfx2.text(x + 15, y + 272.5, textBoxes.friendsListAdd.text, 1.5)
                if os.clock() % 1 > 0.5 then
                    gfx2.text(x + 15 + gfx2.textSize(textBoxes.friendsListAdd.text:sub(1, textBoxes.friendsListAdd.caretPosition), 1.5), y + 272.5, "|", 1.5)
                end
            elseif textBoxes.friendsListAdd.text == "" then
                gfx2.text(x + 15, y + 272.5, "Add a friend...", 1.5)
            else
                gfx2.text(x + 15, y + 272.5, textBoxes.friendsListAdd.text, 1.5)
            end
        end
        -- outline
        gfx2.color(61, 122, 198)
        gfx2.drawRoundRect(x, y, width, height, roundedRadius, 0.5)

        -- messaging modal
        gfx2.pushTransformation({
            4,
            messagingModalAnimationData.currentScale,
            messagingModalAnimationData.currentScale,
            x + (width / 2) - 100,
            -- y needs to be in the dead center of the friends list
            y + (height / 2)
        })
        if messagingModalAnimationData.currentAlpha > 0.01 then
            -- draw the messaging modal to the left of the friends list
            local modalWidth, modalHeight = 200, 300
            local modalX, modalY = x - modalWidth - 10, y
            gfx2.color(4, 7, 10, 190.5 * messagingModalAnimationData.currentAlpha)
            gfx2.blur(modalX, modalY, modalWidth, modalHeight, messagingModalAnimationData.currentAlpha, 20)
            gfx2.fillRoundRect(modalX, modalY, modalWidth, modalHeight, 20)
            gfx2.color(236, 241, 247, 255 * messagingModalAnimationData.currentAlpha)
            gfx2.text(modalX + modalWidth / 2 - gfx2.textSize(messagingModal.recipient, 3) / 2, modalY + 5, messagingModal.recipient, 3)
            -- line under the recipient
            gfx2.color(61, 122, 198, 255 * messagingModalAnimationData.currentAlpha)
            gfx2.fillRect(modalX + 10, modalY + 30, modalWidth - 20, 0.25)

            -- messages background 
            gfx2.color(4, 7, 10, 190.5 * messagingModalAnimationData.currentAlpha)
            gfx2.fillRoundRect(modalX + 10, modalY + 37.5, modalWidth - 20, modalHeight - 80, 7.5)

            if not messagesList[messagingModal.recipient] then
                messagesList[messagingModal.recipient] = {}
            end

            gfx2.pushClipArea(modalX + 10, modalY + 38, modalWidth - 20, modalHeight - 81)
            gfx2.color(236, 241, 247, 255 * messagingModalAnimationData.currentAlpha)
            local messageSpacing = 15
            local totalMessageHeight = -20
            for i = #messagesList[messagingModal.recipient], 1, -1 do
                local message = messagesList[messagingModal.recipient][i]
                local msg = message["message"]
                local sender = message["sender"]
                local recipient = message["recipient"]
                -- message box like discord NOT the same as the friend box
                -- local messageBox = {
                --     x = modalX + 10,
                --     y = modalY + modalHeight - 80 - totalMessageHeight,
                --     width = modalWidth - 20,
                --     height = 15
                -- }
                -- same as above but with messagingModalScrollData support
                local messageBox = {
                    x = modalX + 10,
                    y = modalY + modalHeight - 80 - totalMessageHeight - messagingModalScrollData.currentScrollAmount,
                    width = modalWidth - 20,
                    height = 15
                }

                -- check if the message is too long and needs to be split into multiple lines
                local messageWidth = gfx2.textSize(msg, 1.1)
                if messageWidth > messageBox.width - 35 then
                    local messageLines = {}
                    local messageLine = ""
                    for word in msg:gmatch("%S+") do
                        if gfx2.textSize(messageLine .. " " .. word, 1.1) > messageBox.width - 35 then
                            table.insert(messageLines, messageLine)
                            messageLine = word
                        else
                            messageLine = messageLine .. " " .. word
                        end
                    end
                    table.insert(messageLines, messageLine)
                    for j = #messageLines, 1, -1 do
                        local line = messageLines[j]
                        line = removeTheSpaceFromTheEnd(line)
                        line = removeTheSpaceFromTheStart(line)
                        gfx2.text(messageBox.x + 30, messageBox.y + 2.5, line, 1.1)
                        totalMessageHeight = totalMessageHeight + 10
                        messageBox.y = messageBox.y - 10
                    end

                    -- render the player name
                    gfx2.text(messageBox.x + 30, messageBox.y - 2.5, sender, 1.5)
                    totalMessageHeight = totalMessageHeight + 7.5

                    -- render the sender of the messages headTexture
                    if playerData.friendSkinData[sender] and playerData.friendSkinData[sender] ~= playerData.oldFriendSkinData[sender] then
                        playerData.oldFriendSkinData[sender] = playerData.friendSkinData[sender]
                        playerData.friendSkinLoadedData[sender] = gfx2.loadImageFromStringForm(playerData.friendSkinData[sender])
                        playerData.friendSkinLoadedData[sender]:save("FriendsList/Temp/" .. sender .. ".png")

                        -- generate the head texture
                        if sender and playerData.friendSkinLoadedData and playerData.friendSkinLoadedData[sender] and playerData.friendSkinData[sender] then
                            generateHead(playerData.friendSkinLoadedData[sender]):save("FriendsList/Temp/" .. sender .. ".png")
                            playerData.friendSkinLoadedData[sender] = gfx2.loadImage("FriendsList/Temp/" .. sender .. ".png")
                        end
                    end
                    if playerData.friendSkinLoadedData[sender] then
                        gfx2.pushUndocumentedClipArea(messageBox.x + 5, messageBox.y - 1, 20, 20, 3)
                        gfx2.drawImage(messageBox.x + 5, messageBox.y - 1, 20, 20, playerData.friendSkinLoadedData[sender], messagingModalAnimationData.currentAlpha)
                        gfx2.popUndocumentedClipArea()
                    else
                        gfx2.pushUndocumentedClipArea(messageBox.x + 5, messageBox.y + 1, 20, 20, 3)
                        gfx2.drawImage(messageBox.x + 5, messageBox.y + 1, 20, 20, headTexture, messagingModalAnimationData.currentAlpha)
                        gfx2.popUndocumentedClipArea()
                    end
                else
                    -- render the message and the player name
                    gfx2.text(messageBox.x + 30, messageBox.y + 2.5, msg, 1.1)
                    -- player name (sender)
                    gfx2.text(messageBox.x + 30, messageBox.y - 12.5, sender, 1.5)
                    totalMessageHeight = totalMessageHeight + 15

                    -- render the sender of the messages headTexture
                    if playerData.friendSkinData[sender] and playerData.friendSkinData[sender] ~= playerData.oldFriendSkinData[sender] then
                        playerData.oldFriendSkinData[sender] = playerData.friendSkinData[sender]
                        playerData.friendSkinLoadedData[sender] = gfx2.loadImageFromStringForm(playerData.friendSkinData[sender])
                        playerData.friendSkinLoadedData[sender]:save("FriendsList/Temp/" .. sender .. ".png")

                        -- generate the head texture
                        if sender and playerData.friendSkinLoadedData and playerData.friendSkinLoadedData[sender] and playerData.friendSkinData[sender] then
                            generateHead(playerData.friendSkinLoadedData[sender]):save("FriendsList/Temp/" .. sender .. ".png")
                            playerData.friendSkinLoadedData[sender] = gfx2.loadImage("FriendsList/Temp/" .. sender .. ".png")
                        end
                    end
                    gfx2.tcolor(255,255,255,0)
                    if playerData.friendSkinLoadedData[sender] then
                        gfx2.pushUndocumentedClipArea(messageBox.x + 5, messageBox.y - 10, 20, 20, 3)
                        gfx2.drawImage(messageBox.x + 5, messageBox.y - 10, 20, 20, playerData.friendSkinLoadedData[sender], messagingModalAnimationData.currentAlpha)
                        gfx2.popUndocumentedClipArea()
                    else
                        gfx2.pushUndocumentedClipArea(messageBox.x + 5, messageBox.y - 10, 20, 20, 3)
                        gfx2.drawImage(messageBox.x + 5, messageBox.y - 10, 20, 20, headTexture, messagingModalAnimationData.currentAlpha)
                        gfx2.popUndocumentedClipArea()
                    end
                end
                totalMessageHeight = totalMessageHeight + messageSpacing
                -- messagingModalScrollData.maxScrollAmount = math.min(0, totalMessageHeight - (modalHeight - 80))
                messagingModalScrollData.minScrollAmount = -totalMessageHeight + modalHeight - 102.5
            end

            gfx2.popClipArea()

            -- message input
            local messageInput = {
                x = modalX + 10,
                y = modalY + 270,
                width = modalWidth - 20,
                height = 20
            }

            local textWidth = 0
            -- if the text is too long, make textWidth the width of the text
            if gfx2.textSize(textBoxes.messagingModal.text, 1.5) > messageInput.width then
                textWidth = gfx2.textSize(textBoxes.messagingModal.text, 1.5) - messageInput.width + 10
            end
            gfx2.blur(messageInput.x, messageInput.y, messageInput.width + textWidth, messageInput.height, messagingModalAnimationData.currentAlpha, 7.5)
            gfx2.color(4, 7, 10, 190.5 * messagingModalAnimationData.currentAlpha)
            gfx2.fillRoundRect(messageInput.x, messageInput.y, messageInput.width + textWidth, messageInput.height, 7.5)
            gfx2.color(61, 122, 198, 255 * messagingModalAnimationData.currentAlpha)
            gfx2.drawRoundRect(messageInput.x, messageInput.y, messageInput.width + textWidth, messageInput.height, 7.5, 0.5)
            gfx2.color(236, 241, 247, 255 * messagingModalAnimationData.currentAlpha)
            if textBoxes.messagingModal.selected then
                gfx2.text(messageInput.x + 5, messageInput.y + 2.5, textBoxes.messagingModal.text, 1.5)
                if os.clock() % 1 > 0.5 then
                    gfx2.text(messageInput.x + 5 + gfx2.textSize(textBoxes.messagingModal.text:sub(1, textBoxes.messagingModal.caretPosition), 1.5), messageInput.y + 2.5, "|", 1.5)
                end
                if textBoxes.messagingModal.text == "" then
                    gfx2.text(messageInput.x + 5, messageInput.y + 2.5, "Type a message...", 1.5)
                end
            elseif textBoxes.messagingModal.text == "" then
                gfx2.text(messageInput.x + 5, messageInput.y + 2.5, "Type a message...", 1.5)
            else
                gfx2.text(messageInput.x + 5, messageInput.y + 2.5, textBoxes.messagingModal.text, 1.5)
            end

            gfx2.color(61, 122, 198, 255 * messagingModalAnimationData.currentAlpha)
            gfx2.drawRoundRect(modalX + 10, modalY + 37.5, modalWidth - 20, modalHeight - 80, 7.5, 0.5)
            -- outline
            gfx2.color(61, 122, 198, 255 * messagingModalAnimationData.currentAlpha)
            gfx2.drawRoundRect(modalX, modalY, modalWidth, modalHeight, 20, 0.5)
        end
        gfx2.popTransformation()
    end

    for i,v in pairs(notificationIndex) do
        if v then
            sendCustomNotification(dt, i, v[1], v[2])
        end
    end
end

notificationSystem = {
    sendNotification = function(title, message)
        if not title then
            title = "Notification"
        end
        if not message then
            message = ""
        end
        notificationIndexTime[#notificationIndexTime + 1] = os.clock()
        table.insert(notificationIndex, {title, message})
    end
}