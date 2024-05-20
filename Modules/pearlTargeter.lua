-- Made By O2Flash20 🙂

name = "Ender Pearl Targeter"
description = "Shows you where you have to look to hit a target with an ender pearl."

INITIALVEL = 45
GRAVACC = -22.26

tx = nil
ty = nil
tz = nil
tf = nil

client.settings.addAir(3)
setTargetKey = client.settings.addNamelessKeybind("Set Target", 73)
removeTargetKey = client.settings.addNamelessKeybind("Remove Target", 74)
upTargetKey = client.settings.addNamelessKeybind("Set Target to Top Block", 75)
client.settings.addAir(3)
aim1Color = client.settings.addNamelessColor("Aim Target 1", { 255, 100, 255, 255 })
aim2Color = client.settings.addNamelessColor("Aim Target 2", { 200, 0, 200, 255 })
client.settings.addAir(3)
groundTargetGood = client.settings.addNamelessColor("Selected Target Color", { 0, 255, 60, 255 })
groundTargetBad = client.settings.addNamelessColor("Selected Target Color Too Far", { 97, 2, 0, 255 })
client.settings.addAir(3)
client.settings.addInfo("Tip: Zooming in lets you line up your cursor with the target better.")
client.settings.addTitle("I DONT GUARANTEE THIS WORKS ON SERVERS")

event.listen("KeyboardInput", function(key, down)
    if key == setTargetKey.value and down then
        local ex, ey, ez = player.forwardPosition(500)
        local target = dimension.raycast(px, py, pz, ex, ey, ez)
        tx = target.px
        ty = target.py
        tz = target.pz
        tf = target.blockFace
    end

    if key == removeTargetKey.value and down then
        tx = nil
        ty = nil
        tz = nil
        tf = nil
    end

    if key == upTargetKey.value and down and tx and ty and tz and tf then
        if tf == 0 then ty = ty + 0.5 end
        if tf == 1 then return end
        if tf == 2 then tz = tz + 0.5 end
        if tf == 3 then tz = tz - 0.5 end
        if tf == 4 then tx = tx + 0.5 end
        if tf == 5 then tx = tx - 0.5 end

        while not (dimension.getBlock(math.floor(tx), math.floor(ty), math.floor(tz)).id == 0) do
            ty = math.floor(ty + 1)
            tf = 1
        end
    end
end)

function render()
    px, py, pz = player.forwardPosition(0)

    if not (tx and ty and tz) then return end

    local Dx = tx - px
    local Dy = ty - py
    local Dz = tz - pz
    local Dd = math.sqrt(Dx ^ 2 + Dy ^ 2 + Dz ^ 2)

    local s1 = GRAVACC * Dy + INITIALVEL ^ 2
    local s2 = math.sqrt((-GRAVACC * Dy - INITIALVEL ^ 2) ^ 2 - (Dd * GRAVACC) ^ 2)
    local denominator = math.sqrt(2) * Dd / Dx

    local vx1 = math.sqrt(s1 + s2) / denominator
    local vx2 = math.sqrt(s1 - s2) / denominator

    local vy1 = (Dy / Dx) * vx1 - 0.5 * GRAVACC * Dx / vx1
    local vy2 = (Dy / Dx) * vx2 - 0.5 * GRAVACC * Dx / vx2

    local vz1 = vx1 * Dz / Dx
    local vz2 = vx2 * Dz / Dx

    local time1 = Dx / vx1
    local time2 = Dx / vx2

    -- draw the selected target
    local targetDisplayX, targetDisplayY = gfx.worldToScreen(tx, ty, tz)
    if (-45 < vx1 and vx1 < 45) or (-45 < vx2 and vx2 < 45) then --check if its a valid solution
        gfx.color(groundTargetGood.value.r, groundTargetGood.value.g, groundTargetGood.value.b, groundTargetGood.value.a)
    else
        gfx.color(groundTargetBad.value.r, groundTargetBad.value.g, groundTargetBad.value.b, groundTargetBad.value.a)
    end
    if targetDisplayX and targetDisplayY then
        gfx.quad(
            targetDisplayX - 1, targetDisplayY - 1,
            targetDisplayX + 1, targetDisplayY - 1,
            targetDisplayX + 1, targetDisplayY - 10,
            targetDisplayX - 1, targetDisplayY - 10
        )
        gfx.quad(
            targetDisplayX, targetDisplayY,
            targetDisplayX + 4, targetDisplayY - 4,
            targetDisplayX, targetDisplayY - 3,
            targetDisplayX - 4, targetDisplayY - 4
        )
    end

    if not (tf == 1 and Dy > 0) then
        local x1, y1 = gfx.worldToScreen(
            vx1 / INITIALVEL + px,
            vy1 / INITIALVEL + py,
            vz1 / INITIALVEL + pz
        )
        if x1 and y1 then
            gfx.color(aim1Color.value.r, aim1Color.value.g, aim1Color.value.b, aim1Color.value.a)
            gfx.rect(x1 - 3, y1 - 0.5, 6, 1)
            gfx.rect(x1 - 0.5, y1 - 3, 1, 6)
            gfx.text(x1 + 4, y1 - 3, math.floor(time1 * 100) / 100 .. " sec")
        end
    end

    local x2, y2 = gfx.worldToScreen(
        vx2 / INITIALVEL + px,
        vy2 / INITIALVEL + py,
        vz2 / INITIALVEL + pz
    )
    if x2 and y2 then
        gfx.color(aim2Color.value.r, aim2Color.value.g, aim2Color.value.b, aim2Color.value.a)
        gfx.rect(x2 - 3, y2 - 0.5, 6, 1)
        gfx.rect(x2 - 0.5, y2 - 3, 1, 6)
        gfx.text(x2 + 4, y2 - 3, math.floor(time2 * 100) / 100 .. " sec")
    end
end
