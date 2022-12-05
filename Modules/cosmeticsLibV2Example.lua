name = "Cosmetics v2 Example"
description = "An example script for the cosmetics library."

importLib("cosmeticTools")

enableShading() -- enables shading mode for this module
setLightDirectionSun() -- sets the light to come from the direction of the sun

-- adds a couple texture sources, from minecraft
woodTexture = Texture:newSource("textures/blocks/log_big_oak", 16, 16)
netheriteTexture = Texture:newSource("textures/blocks/netherite_block", 16, 16)

-- an animated texture with two frames of different length
capeTexture = Texture:new()
    :addImage(woodTexture, 0, 0, 10, 16)--crop the textures, making it the aspect ratio of the cape (not a square)
    :addImage(netheriteTexture, 3, 0, 13, 16)
    :addFrame(1, 0.5)
    :addFrame(2, 1)

capeTextureBack = Texture:new()
    :addImage(woodTexture, 0, 0, 10, 16) --there is only one image, so addFrame is not necessary

capeTextureSides = Texture:new()
    :addImage(netheriteTexture, 0, 0, 1, 16)

function update()
    updateCapes() -- needed for the cape
    updateTextures() -- needed for textures
end

function render3d()
    if player.perspective() == 0 then return end -- doesn't render the cosmetics if you're in first person
    updateCosmeticTools() -- updates useful globals

    local Cape = Object:new(0, 0, 0)
        :attachAsCape()
    Cube:newCape(Cape)
        :renderTexture(

        --front (I call it back because it's the back side of the cape, even though it faces forward)
            capeTextureBack.texture,
            capeTexture.texture, --back
            capeTextureSides.texture, --left
            capeTextureSides.texture, --right
            capeTextureSides.texture, --top
            capeTextureSides.texture--bottom
        )

    local OnixPlanet = Object:new(0, 1, 0)
        -- create a new object that's attached to the player's position and one block above their head
        :attachToPlayer()
    Sphere:new(OnixPlanet, 0, 0, 0, 0.5)
        -- create a new sphere at the center of the object that rotates on itself and renders blue
        :rotateSelf(t / 5, t, 0)
        :render({ 0, 0, 255 })

    for i = 1, 8, 1 do -- the ring around the planet are made of 8 cubes, so instead of doing them all manually, i used a for loop
        Cube:new(OnixPlanet, 1, 0, 0, 0.1, 0.1, 0.851)
            -- The cubes are originally all in the same spot, so to spread them out into a ring, they all get rotated 45 degrees from one another. The first one is rotated 45 (i*45 -> 1*45 -> 45), the second is rotated 90 (i*45 -> 2*45 -> 90), and so on.
            :rotateObject(0, math.rad(i * 45), 0)
            :rotateObject(0, t, 0)-- this makes the ring constantly rotate around the planet
            :rotateObject(0, 0, -0.7)-- this changes angle of the ring so that it isn't parallel to the ground
            :render({ 0, 255, 255 }) -- the rings are rendered in cyan
    end

    Sphere:new(OnixPlanet, 2, 0, 0, 0.2)
        :setDetail("Low")-- to help performance, this sphere is rendered with low detail
        :rotateSelf(0, -t * 5, 0)-- the moon rotates around itself
        :rotateObject(0, t * 2, 0)-- the moon rotates around the planet
        :rotateObject(0, 0, 0.5)-- changes the angle of the moon's orbit
        :renderTexture("textures/blocks/cobblestone") -- renders the sphere with the cobblestone texture
end
