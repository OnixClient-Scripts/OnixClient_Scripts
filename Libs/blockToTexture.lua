-- Made By O2Flash20 🙂

btt = {}

btt.blocks = {}
btt.terrain_texture = {}

function postInit()
    network.get(
        "https://raw.githubusercontent.com/Mojang/bedrock-samples/main/resource_pack/blocks.json",
        "blocks.json"
    )

    network.get(
        "https://raw.githubusercontent.com/Mojang/bedrock-samples/main/resource_pack/textures/terrain_texture.json",
        "terrain_texture.json"
    )

    if not fs.isdir("textures") then
        print([[
§8|§bINFO§8| §cOne of your enabled mods uses the Block to Texture lib, which requires some manual setup. Please follow these steps to use the mod:
        -If you are NOT using a resource pack:
            *Go to https://github.com/mojang/bedrock-samples
            *Click on |< > Code| and "Download ZIP"
            *Inside the ZIP, navigate to "resource_pack"
            *Type ".lua path" into Minecraft chat, it should open File Explorer
            *Copy the "textures" folder from inside "resource_pack" into the "Data" folder of the window that opened after ".lua path"

        -If you ARE using a resource pack that changes all of the games blocks:
            *Find the resource pack that you are using
            *If it is a .mcpack, rename the file to end with .zip instead
            *Inside the zip, find the "textures" folder
            *Type ".lua path" into Minecraft chat, it should open File Explorer.
            *Copy the "textures" folder from the resource pack into the "Data" folder of the window that opened after ".lua path"
            ]])
    end
end

function btt.getTexture(x, y, z, face)
    if not fs.isdir("textures") then
        print(
            [[§cA script is currently using the Block to Texture library. For it to work, you must follow these steps:
    -If you are not using a resource pack:
        *Go to https://github.com/mojang/bedrock-samples
        *Click on |< > Code| and "Download ZIP"
        *Inside the ZIP, navigate to "resource_pack"
        *Type ".lua path" into Minecraft chat, it should open File Explorer
        *Copy the "textures" folder from inside "resource_pack" into the "Data" folder of the window that opened after ".lua path"

    -If you are using a resource pack that changes all of the games blocks:
        *Find the resource pack that you are using
        *If it is a .mcpack, rename the file to end with .zip instead
        *Inside the zip, find the "textures" folder
        *Type ".lua path" into Minecraft chat, it should open File Explorer.
        *Copy the "textures" folder from the resource pack into the "Data" folder of the window that opened after ".lua path"
            ]])
    end
    local blockSelected = dimension.getBlock(x, y, z)
    local blockName = blockSelected.name
    local direction = btt.faceToDirection[face]

    if blockName == "air" or blockName == "client_request_placeholder_block" then return end

    if btt.toBlocksTranslations[blockName] then
        blockName = btt.toBlocksTranslations[blockName]
    end

    local textureFrom_blocks
    if btt.blocks[blockName].carried_textures then
        textureFrom_blocks = btt.blocks[blockName].carried_textures
    else
        textureFrom_blocks = btt.blocks[blockName].textures
    end
    if type(textureFrom_blocks) == "table" then
        if textureFrom_blocks.side then
            if btt.dataAndFaceToTextureSide[blockSelected.data] then
                textureFrom_blocks = textureFrom_blocks[btt.dataAndFaceToTextureSide[blockSelected.data][face]]
            else
                textureFrom_blocks = textureFrom_blocks["up"]
            end
        else
            textureFrom_blocks = textureFrom_blocks[direction]
        end
    end

    local finalTextures
    if btt.terrain_texture[textureFrom_blocks] == nil then
        finalTextures = "textures/blocks/" .. textureFrom_blocks
    else
        if textureFrom_blocks == "grass_carried" then
            finalTextures = "textures/blocks/grass_carried.png"
        else
            finalTextures = btt.terrain_texture[textureFrom_blocks].textures
        end
    end

    local output = ""
    if type(finalTextures) == "table" then
        if blockName == "log" then
            output = finalTextures[btt.logIDToNumber[blockSelected.id]]
        elseif blockName == "log2" then
            output = finalTextures[btt.log2IDToNumber[blockSelected.id]]
        else
            output = finalTextures[blockSelected.data + 1]
        end
    else
        output = finalTextures
    end

    return output
end

function onNetworkData(code, identifier, data)
    if identifier == "blocks.json" then
        btt.blocks = jsonToTable(data)
    end
    if identifier == "terrain_texture.json" then
        btt.terrain_texture = jsonToTable(data).texture_data
    end
end

btt.toBlocksTranslations = {
    concrete_powder = "concretePowder",
    birch_log = "log",
    oak_log = "log",
    spruce_log = "log",
    jungle_log = "log",
    acacia_log = "log2",
    dark_oak_log = "log2"
}

btt.logIDToNumber = {}
btt.logIDToNumber[17] = 1
btt.logIDToNumber[824] = 2
btt.logIDToNumber[825] = 3
btt.logIDToNumber[826] = 4

btt.log2IDToNumber = {}
btt.log2IDToNumber[162] = 1
btt.log2IDToNumber[827] = 2

btt.faceToDirection = {}
btt.faceToDirection[0] = "down"
btt.faceToDirection[1] = "up"
btt.faceToDirection[2] = "north"
btt.faceToDirection[3] = "south"
btt.faceToDirection[4] = "west"
btt.faceToDirection[5] = "east"

btt.dataAndFaceToTextureSide = {}

btt.dataAndFaceToTextureSide[0] = {}
btt.dataAndFaceToTextureSide[0][0] = "down"
btt.dataAndFaceToTextureSide[0][1] = "up"
btt.dataAndFaceToTextureSide[0][2] = "side"
btt.dataAndFaceToTextureSide[0][3] = "side"
btt.dataAndFaceToTextureSide[0][4] = "side"
btt.dataAndFaceToTextureSide[0][5] = "side"

btt.dataAndFaceToTextureSide[1] = {}
btt.dataAndFaceToTextureSide[1][0] = "side"
btt.dataAndFaceToTextureSide[1][1] = "side"
btt.dataAndFaceToTextureSide[1][2] = "side"
btt.dataAndFaceToTextureSide[1][3] = "side"
btt.dataAndFaceToTextureSide[1][4] = "down"
btt.dataAndFaceToTextureSide[1][5] = "up"

btt.dataAndFaceToTextureSide[2] = {}
btt.dataAndFaceToTextureSide[2][0] = "side"
btt.dataAndFaceToTextureSide[2][1] = "side"
btt.dataAndFaceToTextureSide[2][2] = "down"
btt.dataAndFaceToTextureSide[2][3] = "up"
btt.dataAndFaceToTextureSide[2][4] = "side"
btt.dataAndFaceToTextureSide[2][5] = "side"
