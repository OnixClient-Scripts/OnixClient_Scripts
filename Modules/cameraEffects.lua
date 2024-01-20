-- Made By O2Flash20 🙂
name = "Camera Effects"
description = "Adds auto exposure and lens flares to the game."

importLib("vectors")
importLib("scripting-repo")

client.settings.addAir(1)
sunBloomSetting = client.settings.addNamelessBool("Show Sun Bloom", true)
bloomDim = client.settings.addNamelessFloat("Sun Bloom Dimming", 0, 100, 0)
client.settings.addAir(1)
showFlaresSetting = client.settings.addNamelessBool("Show Flares", true)
flareDim = client.settings.addNamelessFloat("Flares Dimming", 0, 100, 0)
client.settings.addAir(1)
timeSetting = client.settings.addNamelessFloat("Exposure transition time (seconds)", 0.1, 10, 0.3)
client.settings.addAir(1)
note =
    [[For auto exposure to work, the post processing mod MUST be enabled,]] ..
    "\n" .. [[and the "Brightness" and "Contrast" toggles MUST be ON!]]
client.settings.addTitle(note)

function findSettings()
    local mods = client.modules()
    local ppMod
    for i = 1, #mods, 1 do
        if mods[i].name == "Post Processing" then
            ppMod = mods[i]
        end
    end

    local brightnessSetting
    for i = 1, #ppMod.settings, 1 do
        if ppMod.settings[i].name == "Brightness Strength" then
            brightnessSetting = ppMod.settings[i]
        end
    end
    local contrastSetting
    for i = 1, #ppMod.settings, 1 do
        if ppMod.settings[i].name == "Contrast Strength" then
            contrastSetting = ppMod.settings[i]
        end
    end

    return brightnessSetting, contrastSetting
end

brightnessSetting = nil
contrastSetting = nil
function onEnable()
    brightnessSetting, contrastSetting = findSettings()
    ppx, ppy, ppz = player.pposition()
    px, py, pz = player.position()
end

function postInit()
    if not fs.isdir("cameraEffects") then
        fs.mkdir("cameraEffects")
        scriptingRepo.downloadDataFile("cameraEffects/squareFlare.png")
        scriptingRepo.downloadDataFile("cameraEffects/sunFlares.png")
    end
end

function onNetworkData(code, identifier, data)
end

nextBrightness = 1
nextContrast = 0
timeSinceUpdate = 0
i = 0
changeSlowness = 3
function update()
    if dimension.id() ~= 1 then return end

    changeSlowness = math.floor(timeSetting.value * 10)
    i = i + 1
    if i % changeSlowness ~= 0 then return end
    timeSinceUpdate = 0

    local px, py, pz = player.pposition()
    local ex, ey, ez = player.forwardPosition(1000)
    local hit = dimension.raycast(px, py, pz, ex, ey, ez, 100, false, false, true)
    local brightCheckVec = vec:new(hit.px - px, hit.py - py, hit.pz - pz)
    brightCheckVec:setMag(brightCheckVec:mag() - 1)

    local combinedBrightness = getVisualBrightness(
        math.floor(brightCheckVec.x + px),
        math.floor(brightCheckVec.y + py),
        math.floor(brightCheckVec.z + pz)
    )
    local maxBright = 1.8
    local maxCont = 0.5

    thisBrightness = nextBrightness
    thisContrast = nextContrast

    nextBrightness = ((1 - maxBright) / 14) * combinedBrightness + maxBright
    nextContrast = -(maxCont / 14) * combinedBrightness + maxCont
end

thisBrightness = 1
thisContrast = 1
function render(dt)
    if dimension.id() ~= 1 then
        brightnessSetting.value = 1
        contrastSetting.value = 0
        return
    end

    ppx, ppy, ppz = player.pposition()
    px, py, pz    = player.position()

    if not timeSinceUpdate or not changeSlowness then return end
    timeSinceUpdate = timeSinceUpdate + dt
    brightnessSetting.value = map(timeSinceUpdate, 0, 0.11 * changeSlowness, thisBrightness, nextBrightness)
    contrastSetting.value = map(timeSinceUpdate, 0, 0.11 * changeSlowness, thisContrast, nextContrast)

    local sunDir = getSunDir()
    local midX, midY = gfx.worldToScreen(sunDir[1] * 1000000000, sunDir[2] * 1000000000, 0)

    local sunCoords = getSunCoords()

    -- dimming the lens flares if the sun is partially blocked
    local flareOpacityMult = 1
    if dimension.raycast(ppx, ppy, ppz, ppx + sunCoords.mid[1] * 1000000, ppy + sunCoords.mid[2] * 1000000, ppz, 1000, false, false, true).isBlock then
        flareOpacityMult = flareOpacityMult - 0.2
    end
    if dimension.raycast(ppx, ppy, ppz, ppx + sunCoords.topRight[1] * 1000000, ppy + sunCoords.topRight[2] * 1000000, ppz, 1000, false, false, true).isBlock then
        flareOpacityMult = flareOpacityMult - 0.2
    end
    if dimension.raycast(ppx, ppy, ppz, ppx + sunCoords.topLeft[1] * 1000000, ppy + sunCoords.topLeft[2] * 1000000, ppz, 1000, false, false, true).isBlock then
        flareOpacityMult = flareOpacityMult - 0.2
    end
    if dimension.raycast(ppx, ppy, ppz, ppx + sunCoords.bottomLeft[1] * 1000000, ppy + sunCoords.bottomLeft[2] * 1000000, ppz, 1000, false, false, true).isBlock then
        flareOpacityMult = flareOpacityMult - 0.2
    end
    if dimension.raycast(ppx, ppy, ppz, ppx + sunCoords.bottomRight[1] * 1000000, ppy + sunCoords.bottomRight[2] * 1000000, ppz, 1000, false, false, true).isBlock then
        flareOpacityMult = flareOpacityMult - 0.2
    end

    -- converting the sun's 3d coordinates to screen coordinates
    local trX, trY = gfx.worldToScreen(
        sunCoords.topRight[1] * 1000000000,
        sunCoords.topRight[2] * 1000000000,
        sunCoords.topRight[3] * 1000000000
    )
    local tlX, tlY = gfx.worldToScreen(
        sunCoords.topLeft[1] * 1000000000,
        sunCoords.topLeft[2] * 1000000000,
        sunCoords.topLeft[3] * 1000000000
    )
    local brX, brY = gfx.worldToScreen(
        sunCoords.bottomRight[1] * 1000000000,
        sunCoords.bottomRight[2] * 1000000000,
        sunCoords.bottomRight[3] * 1000000000
    )
    local blX, blY = gfx.worldToScreen(
        sunCoords.bottomLeft[1] * 1000000000,
        sunCoords.bottomLeft[2] * 1000000000,
        sunCoords.bottomLeft[3] * 1000000000
    )

    local w = gui.width()
    local h = gui.height()
    if midX and midY and trX and trY and tlX and tlY and brX and brY and blX and blY then
        if sunBloomSetting.value == true then
            gfx.tcolor(255, 255, 255, 200 * flareOpacityMult * (1 - bloomDim.value / 100))
            gfx.tquad(
                (tlX - midX) * 6 + midX, (tlY - midY) * 6 + midY, 0, 0,
                (trX - midX) * 6 + midX, (trY - midY) * 6 + midY, 1, 0,
                (brX - midX) * 6 + midX, (brY - midY) * 6 + midY, 1, 1,
                (blX - midX) * 6 + midX, (blY - midY) * 6 + midY, 0, 1,
                "cameraEffects/sunFlares.png"
            )
        end

        if showFlaresSetting.value == true then
            gfx.tcolor(0, 0, 100, 100 * flareOpacityMult * (1 - flareDim.value / 100))
            gfx.tquad(
                (tlX - w / 2) / 2 + w / 2, (tlY - h / 2) / 2 + h / 2,
                0, 0,
                (trX - w / 2) / 2 + w / 2, (trY - h / 2) / 2 + h / 2,
                1, 0,
                (brX - w / 2) / 2 + w / 2, (brY - h / 2) / 2 + h / 2,
                1, 1,
                (blX - w / 2) / 2 + w / 2, (blY - h / 2) / 2 + h / 2,
                0, 1,
                "cameraEffects/squareFlare.png"
            )
            gfx.tcolor(0, 0, 100, 100 * flareOpacityMult * (1 - flareDim.value / 100))
            gfx.tquad(
                (((tlX - midX) * 0.3 + midX) - w / 2) * 0.6 + w / 2, (((tlY - midY) * 0.3 + midY) - h / 2) * 0.6 + h / 2,
                0, 0,
                (((trX - midX) * 0.3 + midX) - w / 2) * 0.6 + w / 2, (((trY - midY) * 0.3 + midY) - h / 2) * 0.6 + h / 2,
                1, 0,
                (((brX - midX) * 0.3 + midX) - w / 2) * 0.6 + w / 2, (((brY - midY) * 0.3 + midY) - h / 2) * 0.6 + h / 2,
                1, 1,
                (((blX - midX) * 0.3 + midX) - w / 2) * 0.6 + w / 2, (((blY - midY) * 0.3 + midY) - h / 2) * 0.6 + h / 2,
                0, 1,
                "cameraEffects/squareFlare.png"
            )

            gfx.tcolor(100, 255, 100, 255 * flareOpacityMult * (1 - flareDim.value / 100))
            gfx.tquad(
                (((tlX - midX) * 0.9 + midX) - w / 2) * 0.35 + w / 2,
                (((tlY - midY) * 0.9 + midY) - h / 2) * 0.35 + h / 2,
                0, 0,
                (((trX - midX) * 0.9 + midX) - w / 2) * 0.35 + w / 2,
                (((trY - midY) * 0.9 + midY) - h / 2) * 0.35 + h / 2,
                1, 0,
                (((brX - midX) * 0.9 + midX) - w / 2) * 0.35 + w / 2,
                (((brY - midY) * 0.9 + midY) - h / 2) * 0.35 + h / 2,
                1, 1,
                (((blX - midX) * 0.9 + midX) - w / 2) * 0.35 + w / 2,
                (((blY - midY) * 0.9 + midY) - h / 2) * 0.35 + h / 2,
                0, 1,
                "cameraEffects/squareFlare.png"
            )

            gfx.tcolor(181, 113, 17, 150 * flareOpacityMult * (1 - flareDim.value / 100))
            gfx.tquad(
                -tlX + w, -tlY + h,
                0, 0,
                -trX + w, -trY + h,
                1, 0,
                -brX + w, -brY + h,
                1, 1,
                -blX + w, -blY + h,
                0, 1,
                "cameraEffects/squareFlare.png"
            )
            gfx.tcolor(181, 113, 17, 100 * flareOpacityMult * (1 - flareDim.value / 100))
            gfx.tquad(
                -((tlX - midX) * 3 + midX) + w, -((tlY - midY) * 3 + midY) + h,
                0, 0,
                -((trX - midX) * 3 + midX) + w, -((trY - midY) * 3 + midY) + h,
                1, 0,
                -((brX - midX) * 3 + midX) + w, -((brY - midY) * 3 + midY) + h,
                1, 1,
                -((blX - midX) * 3 + midX) + w, -((blY - midY) * 3 + midY) + h,
                0, 1,
                "cameraEffects/squareFlare.png"
            )

            gfx.tcolor(52, 152, 17, 150 * flareOpacityMult * (1 - flareDim.value / 100))
            gfx.tquad(
                -(tlX - w / 2) * 3 + w / 2, -(tlY - h / 2) * 3 + h / 2,
                0, 0,
                -(trX - w / 2) * 3 + w / 2, -(trY - h / 2) * 3 + h / 2,
                1, 0,
                -(brX - w / 2) * 3 + w / 2, -(brY - h / 2) * 3 + h / 2,
                1, 1,
                -(blX - w / 2) * 3 + w / 2, -(blY - h / 2) * 3 + h / 2,
                0, 1,
                "cameraEffects/squareFlare.png"
            )
            gfx.tcolor(52, 152, 17, 50 * flareOpacityMult * (1 - flareDim.value / 100))
            gfx.tquad(
                -(((tlX - midX) * 2.5 + midX) - w / 2) * 10 + w / 2, -(((tlY - midY) * 2.5 + midY) - h / 2) * 10 + h / 2,
                0, 0,
                -(((trX - midX) * 2.5 + midX) - w / 2) * 10 + w / 2, -(((trY - midY) * 2.5 + midY) - h / 2) * 10 + h / 2,
                1, 0,
                -(((brX - midX) * 2.5 + midX) - w / 2) * 10 + w / 2, -(((brY - midY) * 2.5 + midY) - h / 2) * 10 + h / 2,
                1, 1,
                -(((blX - midX) * 2.5 + midX) - w / 2) * 10 + w / 2, -(((blY - midY) * 2.5 + midY) - h / 2) * 10 + h / 2,
                0, 1,
                "cameraEffects/squareFlare.png"
            )
        end
    end
end

function getSunDir()
    local time = -dimension.time() * 2 * math.pi
    return { math.sin(time), math.cos(time), 0 }
end

function getSunCoords()
    local time = -dimension.time() * 2 * math.pi
    return {
        mid = { math.sin(time), math.cos(time), 0 },
        topRight = { math.sin(time + 0.085), math.cos(time + 0.085), 0.085 },
        topLeft = { math.sin(time + 0.085), math.cos(time + 0.085), -0.085 },
        bottomRight = { math.sin(time - 0.085), math.cos(time - 0.085), 0.085 },
        bottomLeft = { math.sin(time - 0.085), math.cos(time - 0.085), -0.085 },
    }
end

function getVisualBrightness(x, y, z)
    local t = math.abs(dimension.time() - 0.5) * 2
    local sunBrightness
    if t < 0.45 then
        sunBrightness = 3.5
    elseif t > 0.6 then
        sunBrightness = 14
    else
        sunBrightness = 70 * t - 28
    end

    local blockLight, skyLight = dimension.getBrightness(
        math.floor(x),
        math.floor(y),
        math.floor(z)
    )

    skyLight = math.min(sunBrightness, skyLight)
    return math.clamp(blockLight + skyLight, 0, 14)
end

-- maps a value from one range to another
function map(val, min1, max1, min2, max2)
    return (val - min1) * (max2 - min2) / (max1 - min1) + min2
end
