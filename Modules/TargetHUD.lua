name = "Target HUD"
description = "Displays a HUD with the target's name, distance, head."

---use to render a cube in a world at predermined position and size
---@param x number x position of the cube
---@param y number y position of the cube
---@param z number z position of the cube
---@param sx number x size of the cube
---@param sy number y size of the cube
---@param sz number z size of the cube
---@return nil
function cubexyz(x, y, z, sx, sy, sz)
	gfx.quad(x, y, z, x + sx, y, z, x + sx, y + sy, z, x, y + sy, z, true)
	gfx.quad(x, y, z + sz, x + sx, y, z + sz, x + sx, y + sy, z + sz, x, y + sy, z + sz, true)
	gfx.quad(x, y, z, x, y, z + sz, x, y + sy, z + sz, x, y + sy, z, true)
	gfx.quad(x + sx, y, z, x + sx, y, z + sz, x + sx, y + sy, z + sz, x + sx, y + sy, z, true)
	gfx.quad(x, y, z, x + sx, y, z, x + sx, y, z + sz, x, y, z + sz, true)
	gfx.quad(x, y + sy, z, x + sx, y + sy, z, x + sx, y + sy, z + sz, x, y + sy, z + sz, true)
end

displayBox = client.settings.addNamelessBool("Display Box", true)
client.settings.addInfo("Displays a box around the selected player.")
hitboxColor = client.settings.addNamelessColor("Hitbox Color", {r = 255, g = 255, b = 255, a = 25})
client.settings.addAir(5)
renderOnTheLeft = client.settings.addNamelessBool("Render On The Left", false)

workingDir = "RoamingState/OnixClient/Scripts/Data/TargetHUD"
fs.mkdir("Skins")
username = ""

positionX = 0
positionY = 0
sizeX = 64
sizeY = 64

function extractHiveUsername()
    local p = player.selectedEntity()
    if p.username ~= nil then
        local playerName = string.split(p.username, "\n")
        if string.find(playerName[1],"§.") then
            username = string.gsub(playerName[1],"§.","")
            if string.find(username,"%[") then username = string.gsub(username," %[.*%]","") end
        else
            username = p.username
        end
    else
        playerName = p.type
    end
    return username
end

lastSelectedEntity = ""
finishedGrabbingTargetsInfo = false

facingEntity = {
    name = "",
    skin = nil,
    x = 0,
    y = 0,
    z = 0,
    distance = 0
}


function getTargetsInfo()
    if isFacingPlayer() then
        if lastSelectedEntity ~= player.selectedEntity().username then
            lastSelectedEntity = player.selectedEntity().username
            facingEntity.name = extractHiveUsername()
            facingEntity.skin = player.selectedEntity().skin()
            facingEntity.x = player.selectedEntity().ppx
            facingEntity.y = player.selectedEntity().ppy
            facingEntity.z = player.selectedEntity().ppz
            local posX, posY, posZ = player.pposition()
            facingEntity.distance = distance(posX, posY, posZ, facingEntity.x, facingEntity.y, facingEntity.z)

            finishedGrabbingTargetsInfo = true
        end
    end
end

shouldRender64 = false
shouldRender128 = false

local playerHead

function distance(x1, y1, z1, x2, y2, z2)
    return math.sqrt((x2-x1)^2 + (y2-y1)^2 + (z2-z1)^2)
end

function updateTargetInfo()
    if isFacingPlayer() then
        facingEntity.x = player.selectedEntity().ppx
        facingEntity.y = player.selectedEntity().ppy
        facingEntity.z = player.selectedEntity().ppz
        local posX, posY, posZ = player.pposition()
        facingEntity.distance = distance(posX, posY, posZ, facingEntity.x, facingEntity.y, facingEntity.z)
    end
end

function isFacingPlayer()
    if player.facingEntity() and player.selectedEntity().type == "player" and player.selectedEntity().username ~= nil and player.selectedEntity().username ~= "" then
        local serverList = server.players()
        for i, v in pairs(serverList) do
            if v == extractHiveUsername() then
                return true
            end
        end
    else
        return false
    end
end

function deleteUnusedSkins()
    local skinList = fs.files("Skins")
    for i, v in pairs(skinList) do
        if v ~= facingEntity.name .. ".png" then
            fs.delete(v)
        end
    end
end

function update()
    getTargetsInfo()
    if finishedGrabbingTargetsInfo then
        local skin = facingEntity.skin
        deleteUnusedSkins()
        skin.save("Skins/" .. facingEntity.name .. ".png")
        if fs.exist("Skins/" .. facingEntity.name .. ".png") then
            playerHead = gfx2.loadImage("Skins/" .. facingEntity.name .. ".png")
        end
        if playerHead == nil then return true end
        if playerHead.height == 64 and playerHead.width == 64 then
            shouldRender64 = true
            shouldRender128 = false
        elseif playerHead.height == 128 and playerHead.width == 128 then
            shouldRender64 = false
            shouldRender128 = true
        end
        finishedGrabbingTargetsInfo = false
    end
    if isFacingPlayer() then
        shouldRender = true
    else
        shouldRender = false
    end
    updateTargetInfo()
end

function render3d()
    gfx.color(255,255,255,255)
    if displayBox.value then
        if isFacingPlayer() then
            updateTargetInfo()
            gfx.renderBehind(true)
            gfx.color(hitboxColor)
            cubexyz(facingEntity.x-0.3, facingEntity.y-1.62, facingEntity.z-0.3, 0.6,1.8,0.6)
        end
    end
end

sizeTemplate = {
    head = {
        x = positionX,
        y = positionY,
        width = 64,
        height = 64,
    },
    hat = {
        x = positionX - 5,
        y = positionY - 5,
        width = 64 + 10,
        height = 64 + 10,
    },
    text = {
        nametag = {
            x = positionX - 75,
            y = positionY,
        },
        position = {
            x = positionX - 75,
            y = positionY + 15,
        },
        distance = {
            x = positionX - 75,
            y = positionY + 30,
        },
    }
}

function render2()
    if shouldRender then
        if shouldRender64 then
            gfx2.cdrawImage(sizeTemplate.head.x, sizeTemplate.head.y, sizeTemplate.head.width, sizeTemplate.head.height, playerHead, 8, 8, 8, 8)
            gfx2.cdrawImage(sizeTemplate.hat.x, sizeTemplate.hat.y, sizeTemplate.hat.width, sizeTemplate.hat.height, playerHead, 40, 8, 8, 8)
        end
        if shouldRender128 then
            gfx2.cdrawImage(sizeTemplate.head.x, sizeTemplate.head.y, sizeTemplate.head.width, sizeTemplate.head.height,playerHead,16,16,16,16)
            gfx2.cdrawImage(sizeTemplate.hat.x, sizeTemplate.hat.y, sizeTemplate.hat.width, sizeTemplate.hat.height,playerHead,80,16,16,16)
        end
        gfx2.color(255, 255, 255)
        --name tag
        gfx2.text(sizeTemplate.text.nametag.x, sizeTemplate.text.nametag.y, facingEntity.name, 2)
        nameSize = gfx2.textSize(facingEntity.name, 2)
        sizeTemplate.text.nametag.x = -7 - nameSize
        --position
        gfx2.text(sizeTemplate.text.position.x, sizeTemplate.text.position.y, "X: " .. math.floor(facingEntity.x*100)/100 .. " Y: " .. math.floor(facingEntity.y*100)/100 .. " Z: " .. math.floor(facingEntity.z*100)/100, 2)
        positionSizeX, positionSizeY, positionSizeZ = gfx2.textSize("X: " .. math.floor(facingEntity.x*100)/100 .. " Y: " .. math.floor(facingEntity.y*100)/100 .. " Z: " .. math.floor(facingEntity.z*100)/100, 2)
        sizeTemplate.text.position.x = -7 - positionSizeX
        --distance
        gfx2.text(sizeTemplate.text.distance.x, sizeTemplate.text.distance.y, "Distance: " .. math.floor(facingEntity.distance*100)/100, 2)
        distanceSize = gfx2.textSize("Distance: " .. math.floor(facingEntity.distance*100)/100, 2)
        sizeTemplate.text.distance.x = -7 - distanceSize
    end
end

-- ---Renders a quad (3d, use in render)
-- ---@param x_1 number The position X (1)
-- ---@param y_1 number The position Y (1)
-- ---@param z_1 number The position Z (1)
-- ---@param x_2 number The position X (2)
-- ---@param y_2 number The position Y (2)
-- ---@param z_2 number The position Z (2)
-- ---@param x_3 number The position X (3)
-- ---@param y_3 number The position Y (3)
-- ---@param z_3 number The position Z (3)
-- ---@param x_4 number The position X (4)
-- ---@param y_4 number The position Y (4)
-- ---@param z_4 number The position Z (4)
-- function gfx.quad(x_1, y_1, z_1, x_2, y_2, z_2, x_3, y_3, z_3, x_4, y_4, z_4) end