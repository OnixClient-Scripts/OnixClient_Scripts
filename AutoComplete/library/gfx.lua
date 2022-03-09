---@meta


---@class gfx
gfx = {}


---Sets the drawing color, values range from 0 to 255
---@param r number red
---@param g number green
---@param b number blue
---@return nil
function gfx.color(r, g, b) end

---Sets the drawing color, values range from 0 to 255
---@param r number red
---@param g number green
---@param b number blue
---@param a number Opacity
---@return nil
function gfx.color(r, g, b, a) end


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
function gfx.roundrect(x, y, width, height, radius, quality) end

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
---@param itemLocation number Get it from an item in the player's inventory, dont guess it
---@param scale number The scale of the item
---@return nil
function gfx.item(x, y, itemLocation, scale) end



---Renders an Image 
---@param x number The position X
---@param y number The position Y
---@param width number The Width of the rectangle to render the image in
---@param height number The Height of the rectangle to render the image in
---@param filepath string From the Scripts/Data folder
---@return nil
function gfx.image(x, y, width, height, filepath) end

---Renders a Texture (from the game)
---@param x number The position X
---@param y number The position Y
---@param width number The Width of the rectangle to render the image in
---@param height number The Height of the rectangle to render the image in
---@param filepath string From the root of a texture pack ex: textures/blocks/stone
---@return nil
function gfx.texture(x, y, width, height, filepath) 

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



---Renders a triangle (2d, use in render)
---@param x_1 number The position X (1)
---@param y_1 number The position Y (1)
---@param x_2 number The position X (2)
---@param y_2 number The position Y (2)
---@param x_3 number The position X (3)
---@param y_3 number The position Y (3)
---@return nil
function gfx.triangle(x_1, y_1, x_2, y_2, x_3, y_3) end

---Renders a triangle (2d, use in render)
---@param x_1 number The position X (1)
---@param y_1 number The position Y (1)
---@param x_2 number The position X (2)
---@param y_2 number The position Y (2)
---@param x_3 number The position X (3)
---@param y_3 number The position Y (3)
---@param bothSides boolean Should render both sides (would be visible from only one side if set to false) not really useful in 2d but if you mess up ordering it will still maybe show
---@return nil
function gfx.triangle(x_1, y_1, x_2, y_2, x_3, y_3, bothSides) end


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

---Renders a quad (2d, use in render)
---@param x_1 number The position X (1)
---@param y_1 number The position Y (1)
---@param x_2 number The position X (2)
---@param y_2 number The position Y (2)
---@param x_3 number The position X (3)
---@param y_3 number The position Y (3)
---@param x_4 number The position X (4)
---@param y_4 number The position Y (4)
---@param bothSides boolean Should render both sides (would be visible from only one side if set to false) not really useful in 2d but if you mess up ordering it will still maybe show
---@return nil
function gfx.quad(x_1, y_1, x_2, y_2, x_3, y_3, x_4, y_4, bothSides) end

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

