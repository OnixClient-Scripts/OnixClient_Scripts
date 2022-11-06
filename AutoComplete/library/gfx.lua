---@meta


---@class gfx
gfx = {}


---Sets the drawing color, values range from 0 to 255
---@param r number red
---@param g number green
---@param b number blue
---@return nil
function gfx.color(r, g, b) end

---Sets if the 3D rendering should render trough blocks
---@param phaseTroughBlocks boolean red
---@return nil
function gfx.renderBehind(phaseTroughBlocks) end

---Sets the drawing color, values range from 0 to 255
---@param r number red
---@param g number green
---@param b number blue
---@param a number Opacity
---@return nil
function gfx.color(r, g, b, a) end


---The render origin
---@return number x
---@return number y
---@return number z
function gfx.origin() end


---Renders a rectangle 
---@param x number The position X
---@param y number The position Y
---@param width number The Width of the rectangle
---@param height number The Height of the rectangle
---@return nil
function gfx.rect(x, y, width, height) end

---Renders the outline of a rectangle 
---@param x number The position X
---@param y number The position Y
---@param width number The Width of the rectangle
---@param height number The Height of the rectangle
---@param lineWidth number The width of the rectangle outline
---@return nil
function gfx.drawRect(x, y, width, height, lineWidth) end

---Renders a rectangle with round in the corners
---@param x number The position X
---@param y number The position Y
---@param width number The Width of the rectangle
---@param height number The Height of the rectangle
---@param radius number The radius of the corners's circle
---@param quality integer The amount of triangles that will form each circles
---@return nil
function gfx.roundRect(x, y, width, height, radius, quality) end

---Renders a rectangle with round in the corners or not
---@param x number The position X
---@param y number The position Y
---@param width number The Width of the rectangle
---@param height number The Height of the rectangle
---@param radius number The radius of the corners's circle
---@param quality integer The amount of triangles that will form each circles
---@param topLeft boolean Top left corner 
---@param topRight boolean Top right corner
---@param bottomLeft boolean Bottom left corner
---@param bottomRight boolean Bottom right corner
---@return nil
function gfx.roundRectex(x, y, width, height, radius, quality, topLeft, topRight, bottomLeft, bottomRight) end

---Renders a circle
---@param x number The position X
---@param y number The position Y
---@param radius number The radius of the corners's circle
---@param quality integer The amount of triangles that will the circle
---@return nil
function gfx.circle(x, y, radius, quality) end

---Renders Text
---@param x number The position X
---@param y number The position Y
---@param text string The text to render
---@return nil
function gfx.text(x, y, text) end

---Renders Text
---@param x number The position X
---@param y number The position Y
---@param text string The text to render
---@param scale number The scale of the text
---@return nil
function gfx.text(x, y, text, scale) end

---Renders an Item 
---@param x number The position X
---@param y number The position Y
---@param itemLocation number Get it from an item in the player's inventory, dont guess it
---@return nil
function gfx.item(x, y, itemLocation) end

---Renders an Item 
---@param x number The position X
---@param y number The position Y
---@param itemLocation Item Get it from an item in the player's inventory, dont guess it
---@return nil
function gfx.item(x, y, itemLocation) end

---Renders an Item 
---@param x number The position X
---@param y number The position Y
---@param itemLocation number Get it from an item in the player's inventory, dont guess it
---@param scale number The scale of the item
---@return nil
function gfx.item(x, y, itemLocation, scale) end

---Renders an Item 
---@param x number The position X
---@param y number The position Y
---@param itemLocation number Get it from an item in the player's inventory, dont guess it
---@param scale number The scale of the item
---@param renderDecorations boolean Should render the decorations (item count/durability)
---@return nil
function gfx.item(x, y, itemLocation, scale, renderDecorations) end



---Loads a gfx texture from texture pack root
---@param filepath string
---@return string GfxTexture
function gfx.loadTexture(filepath) end

---Loads a gfx image from Scripts/Data
---@param filepath string
---@return string GfxTexture
function gfx.loadImage(filepath) end


---Renders an Image 
---@param x number The position X
---@param y number The position Y
---@param width number The Width of the rectangle to render the image in
---@param height number The Height of the rectangle to render the image in
---@param filepath string From the Scripts/Data folder
---@return nil
function gfx.image(x, y, width, height, filepath) end

---Loads an Image, use gfx.fimage() to render it
---@param x number The position X
---@param y number The position Y
---@param width number The Width of the rectangle to render the image in
---@param height number The Height of the rectangle to render the image in
---@param filepath string From the Scripts/Data folder
---@param startX number The starting X position
---@param startY number The starting Y position
---@param sizeX number The X size
---@param sizeY number The Y size
---@return nil
function gfx.cimage(x, y, width, height, filepath, startX, startY, sizeX, sizeY) end

---Renders a Texture (from the game)
---@param x number The position X
---@param y number The position Y
---@param width number The Width of the rectangle to render the image in
---@param height number The Height of the rectangle to render the image in
---@param filepath string From the root of a texture pack ex: textures/blocks/stone
---@return nil
function gfx.texture(x, y, width, height, filepath) end

---Loads a Texture (from the game) use gfx.fimage() to render it
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

---Renders loaded textures from gfx.ctexture() or gfx.cimage() (needs to come from the same file)
---@param opacity number The opacity
function gfx.fimage(opacity) end

---Renders loaded textures from gfx.ctexture() or gfx.cimage() (needs to come from the same file)
function gfx.fimage() end

---Renders loaded textures with colors from gfx.ctexture() or gfx.cimage() (needs to come from the same file)
---@param r integer red
---@param g integer green
---@param b integer blue
---@param a integer opacity
function gfx.cfimage(r, g, b, a) end

---Unloads an image from memory
---@param filepath string the filepath you used in gfx.image or gfx.texture
---@return nil
function gfx.unloadimage(filepath) end


---Renders the icon of an effect
---@param x number The position X
---@param y number The position Y
---@param width number The Width of the rectangle to render the image in
---@param height number The Height of the rectangle to render the image in
---@param effectId integer From the effects, renders the icon for an effect
---@return nil
function gfx.effect(x, y, width, height, effectId) end



---Renders a line (2d, use in render)
---@param x_1 number The position X (1)
---@param y_1 number The position Y (1)
---@param x_2 number The position X (2)
---@param y_2 number The position Y (2)
---@return nil
function gfx.line(x_1, y_1, x_2, y_2) end

---Renders a line (3d, use in render3d)
---@param x_1 number The position X (1)
---@param y_1 number The position Y (1)
---@param z_1 number The position Z (1)
---@param x_2 number The position X (2)
---@param y_2 number The position Y (2)
---@param z_2 number The position Z (2)
---@return nil
function gfx.line(x_1, y_1, z_1, x_2, y_2, z_2) end


---Renders a triangle (2d, use in render)
---@param x_1 number The position X (1)
---@param y_1 number The position Y (1)
---@param x_2 number The position X (2)
---@param y_2 number The position Y (2)
---@param x_3 number The position X (3)
---@param y_3 number The position Y (3)
---@return nil
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
---@return nil
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
---@return nil
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
---@return nil
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
---@return nil
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
---@return nil
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
---@return nil
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
---@return nil
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
---@return nil
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
---@return nil
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
---@return nil
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
---@return nil
function gfx.tquad(x_1, y_1, z_1, uvx_1, uvy_1, x_2, y_2, z_2, uvx_2, uvy_2, x_3, y_3, z_3, uvx_3, uvy_3, x_4, y_4, z_4, uvx_4, uvy_4, texturePath, bothSides) end


---Pushes transformation(s)
---@param transformations table
function gfx.pushTransformation(transformations) end

---Pops transformation(s)
function gfx.popTransformation() end

---Pops transformation(s)
---@param count integer Number of transformations to pop
function gfx.popTransformation(count) end



