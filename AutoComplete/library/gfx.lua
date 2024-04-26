---@meta


---@class gfx
gfx = {}


---Sets the drawing color, values range from 0 to 255
---Gfx drawing functions will use this color
---@param r number red
---@param g number green
---@param b number blue
function gfx.color(r, g, b) end

---Sets the texture drawing color, values range from 0 to 255
---Gfx texture drawing functions will tint using this color
---@param r number red
---@param g number green
---@param b number blue
function gfx.tcolor(r, g, b) end

---Sets the texture drawing color, values range from 0 to 255
---Gfx texture drawing functions will tint using this color
---@param r number red
---@param g number green
---@param b number blue
---@param a number Opacity
function gfx.tcolor(r, g, b, a) end

---Sets if the 3D rendering should render trough blocks
---@param phaseTroughBlocks boolean red
---@return nil
function gfx.renderBehind(phaseTroughBlocks) end

---Sets the drawing color, values range from 0 to 255
---Gfx drawing functions will use this color
---@param r number red
---@param g number green
---@param b number blue
---@param a number Opacity
function gfx.color(r, g, b, a) end


---The render origin (the player's eyes for first person)
---@return number x
---@return number y
---@return number z
function gfx.origin() end

---Gets screen position from world position
---Getting nil means that the position is not on screen
---@param x number The world position X
---@param y number The world position Y
---@param z number The world position Z
---@return number|nil x The screen position X
---@return number|nil y The screen position Y
function gfx.worldToScreen(x, y, z) end

---Gets screen position from world position and gives you a table of number with a size of 2
---Getting nil means that the position is not on screen
---@param x number The world position X
---@param y number The world position Y
---@param z number The world position Z
---@return number[]|nil x The screen position X
function gfx.worldToScreen2(x, y, z) end

---Renders a rectangle 
---@param x number The position X
---@param y number The position Y
---@param width number The Width of the rectangle
---@param height number The Height of the rectangle
function gfx.rect(x, y, width, height) end

---Renders the outline of a rectangle 
---@param x number The position X
---@param y number The position Y
---@param width number The Width of the rectangle
---@param height number The Height of the rectangle
---@param lineWidth number The width of the rectangle outline
function gfx.drawRect(x, y, width, height, lineWidth) end

---Renders a rectangle with round in the corners
---@param x number The position X
---@param y number The position Y
---@param width number The Width of the rectangle
---@param height number The Height of the rectangle
---@param radius number The radius of the corners's circle
---@param quality integer The amount of triangles that will form each quarter circles
function gfx.roundRect(x, y, width, height, radius, quality) end

---Renders a rectangle with round in the corners or not
---@param x number The position X
---@param y number The position Y
---@param width number The Width of the rectangle
---@param height number The Height of the rectangle
---@param radius number The radius of the corners's circle
---@param quality integer The amount of triangles that will form each circles
---@param topLeft boolean Top left corner should be round
---@param topRight boolean Top right corner should be round
---@param bottomLeft boolean Bottom left corner should be round
---@param bottomRight boolean Bottom right corner should be round
function gfx.roundRectex(x, y, width, height, radius, quality, topLeft, topRight, bottomLeft, bottomRight) end

---Renders a circle
---@param x number The position X
---@param y number The position Y
---@param radius number The radius of the corners's circle
---@param quality integer The amount of triangles that will the circle
function gfx.circle(x, y, radius, quality) end

---Renders Text
---@param x number The position X
---@param y number The position Y
---@param text string The text to render
function gfx.text(x, y, text) end

---Renders Text with scale
---@param x number The position X
---@param y number The position Y
---@param text string The text to render
---@param scale number The scale of the text (2x will be two times as big)
function gfx.text(x, y, text, scale) end

---Renders an Item from its location
---@param x number The position X
---@param y number The position Y
---@param itemLocation number Get it from an item in the player's inventory, dont guess it
function gfx.item(x, y, itemLocation) end

---Renders an Item  from an item
---@param x number The position X
---@param y number The position Y
---@param item Item The item to render
function gfx.item(x, y, item) end

---Renders an Item 
---@param x number The position X
---@param y number The position Y
---@param itemLocation number Get it from an item in the player's inventory, dont guess it
---@param scale number The scale of the item
function gfx.item(x, y, itemLocation, scale) end

---Renders an Item 
---@param x number The position X
---@param y number The position Y
---@param itemLocation number Get it from an item in the player's inventory, dont guess it
---@param scale number The scale of the item
---@param renderDecorations boolean Should render the decorations (item count/durability)
function gfx.item(x, y, itemLocation, scale, renderDecorations) end


---Loads a gfx texture from texture pack root
---@param filepath string
---@return string GfxTexture The texture (not actually a string but its for the autocomplete to not have yellow lines)
function gfx.loadTexture(filepath) end

---Loads a gfx texture from texture pack root
---@param filepath string --if starting with textures/ will take from the game's pack, otherwise will be from Data
---@return Gfx2Texture texture  The gfx2 texture
function gfx.extractTexture(filepath) end

---Loads a gfx image from Scripts/Data
---@param filepath string
---@return string GfxTexture the image (not actually a string but its for the autocomplete to not have yellow lines)
function gfx.loadImage(filepath) end


---Uploads a Gfx2Texture into gfx to later be used by gfx.image
---You can then do gfx.image with the filepath you used here and it should render the texture
---@param filepath string Which filepath is it being uploaded as
---@param texture Gfx2Texture The texture to upload
function gfx.uploadImage(filepath, texture) end


---Renders an Image 
---@param x number The position X
---@param y number The position Y
---@param width number The Width of the rectangle to render the image in
---@param height number The Height of the rectangle to render the image in
---@param filepath string From the Scripts/Data folder
function gfx.image(x, y, width, height, filepath) end

---Draws a part of the source image
---@param x number The position X
---@param y number The position Y
---@param width number The Width of the rectangle to render the image in
---@param height number The Height of the rectangle to render the image in
---@param filepath string From the Scripts/Data folder
---@param startX number The starting X position
---@param startY number The starting Y position
---@param sizeX number The X size
---@param sizeY number The Y size
function gfx.cimage(x, y, width, height, filepath, startX, startY, sizeX, sizeY) end

---Renders a Texture (from the game)
---@param x number The position X
---@param y number The position Y
---@param width number The Width of the rectangle to render the image in
---@param height number The Height of the rectangle to render the image in
---@param filepath string From the root of a texture pack ex: textures/blocks/stone
function gfx.texture(x, y, width, height, filepath) end

---Draws a part of the source texture
---@param x number The position X
---@param y number The position Y
---@param width number The Width of the rectangle to render the image in
---@param height number The Height of the rectangle to render the image in
---@param filepath string From the root of a texture pack ex: textures/blocks/stone
---@param startX number The starting X position
---@param startY number The starting Y position
---@param sizeX number The X size
---@param sizeY number The Y size
---@return nil
function gfx.ctexture(x, y, width, height, filepath, startX, startY, sizeX, sizeY) end


---@param filepath string the filepath you used in gfx.image or gfx.texture
function gfx.unloadimage(filepath) end


---Renders the icon of an effect
---@param x number The position X
---@param y number The position Y
---@param width number The Width of the rectangle to render the image in
---@param height number The Height of the rectangle to render the image in
---@param effectId integer you can get it from player.effects()'s effects
function gfx.effect(x, y, width, height, effectId) end



---Renders a line (2d, use in render)
---@param x_1 number The position X (1)
---@param y_1 number The position Y (1)
---@param x_2 number The position X (2)
---@param y_2 number The position Y (2)
function gfx.line(x_1, y_1, x_2, y_2) end

---Renders a line (3d, use in render3d)
---@param x_1 number The position X (1)
---@param y_1 number The position Y (1)
---@param z_1 number The position Z (1)
---@param x_2 number The position X (2)
---@param y_2 number The position Y (2)
---@param z_2 number The position Z (2)
function gfx.line(x_1, y_1, z_1, x_2, y_2, z_2) end


---Renders a triangle (2d, use in render)
---@param x_1 number The position X (1)
---@param y_1 number The position Y (1)
---@param x_2 number The position X (2)
---@param y_2 number The position Y (2)
---@param x_3 number The position X (3)
---@param y_3 number The position Y (3)
function gfx.triangle(x_1, y_1, x_2, y_2, x_3, y_3) end


---Renders a triangle (3d, use in render3d)
---@param x_1 number The position X (1)
---@param y_1 number The position Y (1)
---@param z_1 number The position Z (1)
---@param x_2 number The position X (2)
---@param y_2 number The position Y (2)
---@param z_2 number The position Z (2)
---@param x_3 number The position X (3)
---@param y_3 number The position Y (3)
---@param z_3 number The position Z (3)
function gfx.triangle(x_1, y_1, z_1, x_2, y_2, z_2, x_3, y_3, z_3) end

---Renders a triangle (3d, use in render3d)
---@param x_1 number The position X (1)
---@param y_1 number The position Y (1)
---@param z_1 number The position Z (1)
---@param x_2 number The position X (2)
---@param y_2 number The position Y (2)
---@param z_2 number The position Z (2)
---@param x_3 number The position X (3)
---@param y_3 number The position Y (3)
---@param z_3 number The position Z (3)
---@param bothSides boolean Should render both sides (would be visible from only one side if set to false)
function gfx.triangle(x_1, y_1, z_1, x_2, y_2, z_2, x_3, y_3, z_3, bothSides) end



---Renders a quad (2d, use in render)
---@param x_1 number The position X (1)
---@param y_1 number The position Y (1)
---@param x_2 number The position X (2)
---@param y_2 number The position Y (2)
---@param x_3 number The position X (3)
---@param y_3 number The position Y (3)
---@param x_4 number The position X (4)
---@param y_4 number The position Y (4)
function gfx.quad(x_1, y_1, x_2, y_2, x_3, y_3, x_4, y_4) end

---Renders a quad (3d, use in render)
---@param x_1 number The position X (1)
---@param y_1 number The position Y (1)
---@param z_1 number The position Z (1)
---@param x_2 number The position X (2)
---@param y_2 number The position Y (2)
---@param z_2 number The position Z (2)
---@param x_3 number The position X (3)
---@param y_3 number The position Y (3)
---@param z_3 number The position Z (3)
---@param x_4 number The position X (4)
---@param y_4 number The position Y (4)
---@param z_4 number The position Z (4)
function gfx.quad(x_1, y_1, z_1, x_2, y_2, z_2, x_3, y_3, z_3, x_4, y_4, z_4) end

---Renders a quad (3d, use in render)
---@param x_1 number The position X (1)
---@param y_1 number The position Y (1)
---@param z_1 number The position Z (1)
---@param x_2 number The position X (2)
---@param y_2 number The position Y (2)
---@param z_2 number The position Z (2)
---@param x_3 number The position X (3)
---@param y_3 number The position Y (3)
---@param z_3 number The position Z (3)
---@param x_4 number The position X (4)
---@param y_4 number The position Y (4)
---@param z_4 number The position Z (4)
---@param bothSides boolean Should render both sides (would be visible from only one side if set to false)
function gfx.quad(x_1, y_1, z_1, x_2, y_2, z_2, x_3, y_3, z_3, x_4, y_4, z_4, bothSides) end













---Renders a textured triangle (2d, use in render)
---@param x_1 number The position X (1)
---@param y_1 number The position Y (1)
---@param uvx_1 number The position X (1)
---@param uvy_1 number The position Y (1)
---@param x_2 number The position X (2)
---@param y_2 number The position Y (2)
---@param uvx_2 number The position X (2)
---@param uvy_2 number The position Y (2)
---@param x_3 number The position X (3)
---@param y_3 number The position Y (3)
---@param uvx_3 number The position X (3)
---@param uvy_3 number The position Y (3)
---@param texturePath string the texture file (starting with "textures" will be taken from the resource pack otherwise data folder)
function gfx.ttriangle(x_1, y_1, uvx_1, uvy_1, x_2, y_2, uvx_2, uvy_2, x_3, y_3, uvx_3, uvy_3, texturePath) end

---Renders a textured triangle (3d, use in render3d)
---@param x_1 number The position X (1)
---@param y_1 number The position Y (1)
---@param z_1 number The position Z (1)
---@param uvx_1 number The position X (1)
---@param uvy_1 number The position Y (1)
---@param x_2 number The position X (2)
---@param y_2 number The position Y (2)
---@param z_2 number The position Z (2)
---@param uvx_2 number The position X (2)
---@param uvy_2 number The position Y (2)
---@param x_3 number The position X (3)
---@param y_3 number The position Y (3)
---@param z_3 number The position Z (3)
---@param uvx_3 number The position X (3)
---@param uvy_3 number The position Y (3)
---@param texturePath string the texture file (starting with "textures" will be taken from the resource pack otherwise data folder)
function gfx.ttriangle(x_1, y_1, z_1, uvx_1, uvy_1, x_2, y_2, z_2, uvx_2, uvy_2, x_3, y_3, z_3, uvx_3, uvy_3, texturePath) end

---Renders a textured triangle (3d, use in render3d)
---@param x_1 number The position X (1)
---@param y_1 number The position Y (1)
---@param z_1 number The position Z (1)
---@param uvx_1 number The position X (1)
---@param uvy_1 number The position Y (1)
---@param x_2 number The position X (2)
---@param y_2 number The position Y (2)
---@param z_2 number The position Z (2)
---@param uvx_2 number The position X (2)
---@param uvy_2 number The position Y (2)
---@param x_3 number The position X (3)
---@param y_3 number The position Y (3)
---@param z_3 number The position Z (3)
---@param uvx_3 number The position X (3)
---@param uvy_3 number The position Y (3)
---@param texturePath string the texture file (starting with "textures" will be taken from the resource pack otherwise data folder)
---@param bothSides boolean Should render both sides (would be visible from only one side if set to false)
function gfx.ttriangle(x_1, y_1, z_1, uvx_1, uvy_1, x_2, y_2, z_2, uvx_2, uvy_2, x_3, y_3, z_3, uvx_3, uvy_3, texturePath, bothSides) end



---Renders a textured quad (2d, use in render)
---@param x_1 number The position X (1)
---@param y_1 number The position Y (1)
---@param uvx_1 number The position X (1)
---@param uvy_1 number The position Y (1)
---@param x_2 number The position X (2)
---@param y_2 number The position Y (2)
---@param uvx_2 number The position X (2)
---@param uvy_2 number The position Y (2)
---@param x_3 number The position X (3)
---@param y_3 number The position Y (3)
---@param uvx_3 number The position X (3)
---@param uvy_3 number The position Y (3)
---@param x_4 number The position X (4)
---@param y_4 number The position Y (4)
---@param uvx_4 number The position X (4)
---@param uvy_4 number The position Y (4)
---@param texturePath string the texture file (starting with "textures" will be taken from the resource pack otherwise data folder)
function gfx.tquad(x_1, y_1, uvx_1, uvy_1, x_2, y_2, uvx_2, uvy_2, x_3, y_3, uvx_3, uvy_3, x_4, y_4, uvx_4, uvy_4, texturePath) end

---Renders a textured quad (3d, use in render)
---@param x_1 number The position X (1)
---@param y_1 number The position Y (1)
---@param z_1 number The position Z (1)
---@param uvx_1 number The position X (1)
---@param uvy_1 number The position Y (1)
---@param x_2 number The position X (2)
---@param y_2 number The position Y (2)
---@param z_2 number The position Z (2)
---@param uvx_2 number The position X (2)
---@param uvy_2 number The position Y (2)
---@param x_3 number The position X (3)
---@param y_3 number The position Y (3)
---@param z_3 number The position Z (3)
---@param uvx_3 number The position X (3)
---@param uvy_3 number The position Y (3)
---@param x_4 number The position X (4)
---@param y_4 number The position Y (4)
---@param z_4 number The position Z (4)
---@param uvx_4 number The position X (4)
---@param uvy_4 number The position Y (4)
---@param texturePath string the texture file (starting with "textures" will be taken from the resource pack otherwise data folder)
function gfx.tquad(x_1, y_1, z_1, uvx_1, uvy_1, x_2, y_2, z_2, uvx_2, uvy_2, x_3, y_3, z_3, uvx_3, uvy_3, x_4, y_4, z_4, uvx_4, uvy_4, texturePath) end

---Renders a textured quad (3d, use in render)
---@param x_1 number The position X (1)
---@param y_1 number The position Y (1)
---@param z_1 number The position Z (1)
---@param uvx_1 number The position X (1)
---@param uvy_1 number The position Y (1)
---@param x_2 number The position X (2)
---@param y_2 number The position Y (2)
---@param z_2 number The position Z (2)
---@param uvx_2 number The position X (2)
---@param uvy_2 number The position Y (2)
---@param x_3 number The position X (3)
---@param y_3 number The position Y (3)
---@param z_3 number The position Z (3)
---@param uvx_3 number The position X (3)
---@param uvy_3 number The position Y (3)
---@param x_4 number The position X (4)
---@param y_4 number The position Y (4)
---@param z_4 number The position Z (4)
---@param uvx_4 number The position X (4)
---@param uvy_4 number The position Y (4)
---@param texturePath string the texture file (starting with "textures" will be taken from the resource pack otherwise data folder)
---@param bothSides boolean Should render both sides (would be visible from only one side if set to false)
function gfx.tquad(x_1, y_1, z_1, uvx_1, uvy_1, x_2, y_2, z_2, uvx_2, uvy_2, x_3, y_3, z_3, uvx_3, uvy_3, x_4, y_4, z_4, uvx_4, uvy_4, texturePath, bothSides) end

---Renders a lot of textured quads
---This allows it to do it much quicker as it batches it instead of having one draw call per texture quad like tquad
---You can use parts of a texture with uv to have more textures in one draw
---You should sort the quads by color and texture to call this function less times, but with as much data as possible each time.
---quads is a table of table containing 20 numbers
---you have 4 corners, each corner has 5 numbers (x, y, z, uvx, uvy)
---exemple order: top left, bottom left, bottom right, top right
---@param quads number[][] The quads to render
---@param texturePath string the texture file (starting with "textures" will be taken from the resource pack otherwise data folder)
---@param bothSides boolean|nil Should render both sides (would be visible from only one side if set to false/nil)
function gfx.tquadbatch(quads, texturePath, bothSides) end


---Changes the lighting parameters for future gfx calls (3d only)
---@param AreaStartX number The starting X position of the area
---@param AreaStartY number The starting Y position of the area
---@param AreaStartZ number The starting Z position of the area
---@param AreaEndX number The ending X position of the area
---@param AreaEndY number The ending Y position of the area
---@param AreaEndZ number The ending Z position of the area
---@return nil
function gfx.setupLights(AreaStartX, AreaStartY, AreaStartZ, AreaEndX, AreaEndY, AreaEndZ) end

---Changes the lighting parameters for future gfx calls (3d only)
---@param AreaStartX number The starting X position of the area
---@param AreaStartY number The starting Y position of the area
---@param AreaStartZ number The starting Z position of the area
---@param AreaEndX number The ending X position of the area
---@param AreaEndY number The ending Y position of the area
---@param AreaEndZ number The ending Z position of the area
---@param minimumBrightness integer The minimum brightness
function gfx.setupLights(AreaStartX, AreaStartY, AreaStartZ, AreaEndX, AreaEndY, AreaEndZ, minimumBrightness) end

---Changes the lighting parameters for future gfx calls (3d only)
---@param AreaStartX number The starting X position of the area
---@param AreaStartY number The starting Y position of the area
---@param AreaStartZ number The starting Z position of the area
---@param AreaEndX number The ending X position of the area
---@param AreaEndY number The ending Y position of the area
---@param AreaEndZ number The ending Z position of the area
---@param CenterX number The center X of the area, you can uncenter it if it gives an effect you prefer
---@param CenterY number The center Y of the area, you can uncenter it if it gives an effect you prefer
---@param CenterZ number The center Z of the area, you can uncenter it if it gives an effect you prefer
function gfx.setupLights(AreaStartX, AreaStartY, AreaStartZ, AreaEndX, AreaEndY, AreaEndZ, CenterX, CenterY, CenterZ) end

---Changes the lighting parameters for future gfx calls (3d only)
---@param AreaStartX number The starting X position of the area
---@param AreaStartY number The starting Y position of the area
---@param AreaStartZ number The starting Z position of the area
---@param AreaEndX number The ending X position of the area
---@param AreaEndY number The ending Y position of the area
---@param AreaEndZ number The ending Z position of the area
---@param CenterX number The center X of the area, you can uncenter it if it gives an effect you prefer
---@param CenterY number The center Y of the area, you can uncenter it if it gives an effect you prefer
---@param CenterZ number The center Z of the area, you can uncenter it if it gives an effect you prefer
---@param minimumBrightness integer The minimum brightness
function gfx.setupLights(AreaStartX, AreaStartY, AreaStartZ, AreaEndX, AreaEndY, AreaEndZ, CenterX, CenterY, CenterZ, minimumBrightness) end


---@param filepath string Filepath to the .obj file
---@return userdata
function gfx.objLoad(filepath) end

---@param content string Filepath to the .obj file
---@param isFilepath boolean use 'content' as filepath or obj file content
---@return userdata
function gfx.objLoad(content, isFilepath) end

---Renders a obj mesh (you can move scale and rotate it with gfx.pushTransformation)
---@param mesh userdata
function gfx.objRender(mesh) end

---Renders a obj mesh with texture (you can move scale and rotate it with gfx.pushTransformation)
---@param mesh userdata
---@param texture string
function gfx.objRender(mesh, texture) end


---@class JsonGeometry
---@field name string

---Loads minecraft geometries from json
---@param geometryJson string The geometry json string, you can get from a file with: jsonFromFile
---@return JsonGeometry[] geometries
---@return string error
function gfx.geometryLoad(geometryJson) end

---Loads minecraft geometries from json
---@param geometryJson string The geometry json string, you can get from a file with: jsonFromFile
---@param desiredGeometry string The name of the desired geometry.
---@return JsonGeometry geometry
---@return string error
function gfx.geometryLoad(geometryJson, desiredGeometry) end

---Renders a json geometry model
---@param model JsonGeometry the model to render
---@param texture string the texture to render the model with
function gfx.geometryRender(model, texture) end

---Renders a json geometry model
---@param model JsonGeometry the model to render
---@param texture string the texture to render the model with
---@param x number The position X
---@param y number The position Y
---@param z number The position Z
function gfx.geometryRender(model, texture, x, y, z) end

---Renders a json geometry model
---@param model JsonGeometry the model to render
---@param texture string the texture to render the model with
---@param x number The position X
---@param y number The position Y
---@param z number The position Z
---@param rotationX number The rotation X
---@param rotationY number The rotation Y
---@param rotationZ number The rotation Z
function gfx.geometryRender(model, texture, x, y, z, rotationX, rotationY, rotationZ) end

---Renders a json geometry model
---@param model JsonGeometry the model to render
---@param texture string the texture to render the model with
---@param x number The position X
---@param y number The position Y
---@param z number The position Z
---@param rotationX number The rotation X
---@param rotationY number The rotation Y
---@param rotationZ number The rotation Z
---@param lightEmission integer The light emission (0-15)
function gfx.geometryRender(model, texture, x, y, z, rotationX, rotationY, rotationZ, lightEmission) end

---Renders a json geometry model
---@param model JsonGeometry the model to render
---@param texture string the texture to render the model with
---@param x number The position X
---@param y number The position Y
---@param z number The position Z
---@param rotationX number The rotation X
---@param rotationY number The rotation Y
---@param rotationZ number The rotation Z
---@param lightEmission integer The light emission (0-15)
---@param scaleX number The scale X
---@param scaleY number The scale Y
---@param scaleZ number The scale Z
function gfx.geometryRender(model, texture, x, y, z, rotationX, rotationY, rotationZ, lightEmission, scaleX, scaleY, scaleZ) end

---Renders a json geometry model
---@param model JsonGeometry the model to render
---@param texture string the texture to render the model with
---@param x number The position X
---@param y number The position Y
---@param z number The position Z
---@param rotationX number The rotation X
---@param rotationY number The rotation Y
---@param rotationZ number The rotation Z
---@param lightEmission integer The light emission (0-15)
---@param scaleX number The scale X
---@param scaleY number The scale Y
---@param scaleZ number The scale Z
---@param renderInsideFaces boolean Should render the inside faces
function gfx.geometryRender(model, texture, x, y, z, rotationX, rotationY, rotationZ, lightEmission, scaleX, scaleY, scaleZ, renderInsideFaces) end

---Pushes transformation(s)
---@param transformations table
function gfx.pushTransformation(transformations) end

---Pops transformation(s)
function gfx.popTransformation() end

---Pops transformation(s)
---@param count integer Number of transformations to pop
function gfx.popTransformation(count) end

