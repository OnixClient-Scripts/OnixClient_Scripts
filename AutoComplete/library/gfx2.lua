---@meta


---@class gfx2
gfx2 = {}

---Changes the color of what will be rendered
---@param setting Setting client color(pls or u crash) setting
function gfx2.color(setting) end

---Changes the color of what will be rendered
---@param colorTable ColorSetting
function gfx2.color(colorTable) end

---Changes the color of what will be rendered
---@param r number 0-255 color code
---@param g number 0-255 color code
---@param b number 0-255 color code
function gfx2.color(r, g, b) end

---Changes the color of what will be rendered
---@param r number 0-255 color code
---@param g number 0-255 color code
---@param b number 0-255 color code
---@param a number 0-255 color code
function gfx2.color(r, g, b, a) end


---Fills a rectangle
---@param x number Position on the X axis
---@param y number Position on the Y axis
---@param width number Width of the rectangle
---@param height number Height of the rectangle
function gfx2.fillRect(x, y, width, height) end

---Draws a rectangle (outline)
---@param x number Position on the X axis
---@param y number Position on the Y axis
---@param width number Width of the rectangle
---@param height number Height of the rectangle
---@param lineWidth number How large is the line
function gfx2.fillRect(x, y, width, height, lineWidth) end

---Fills a rectangle with rounded corners
---@param x number Position on the X axis
---@param y number Position on the Y axis
---@param width number Width of the rectangle
---@param height number Height of the rectangle
---@param radius number Radius of the rounded corners
function gfx2.fillRoundRect(x, y, width, height, radius) end

---Draws a rectangle (outline) with rounded corners
---@param x number Position on the X axis
---@param y number Position on the Y axis
---@param width number Width of the rectangle
---@param height number Height of the rectangle
---@param radius number Radius of the rounded corners
---@param lineWidth number How large is the line
function gfx2.fillRoundRect(x, y, width, height, lineWidth, radius) end


---Fills an elipse (circle but possibly wider)
---@param centerX number The X axis center position of the elipse
---@param centerY number The Y axis center position of the elipse
---@param radius number How big is the circle 
function gfx2.fillElipse(centerX, centerY, radius) end

---Fills an elipse (circle but possibly wider)
---@param centerX number The X axis center position of the elipse
---@param centerY number The Y axis center position of the elipse
---@param radiusX number How Wide is the elipse
---@param radiusY number how High is the elipse
function gfx2.fillElipse(centerX, centerY, radiusX, radiusY) end

---Draws an elipse (circle but possibly wider)
---@param centerX number The X axis center position of the elipse
---@param centerY number The Y axis center position of the elipse
---@param radius number How big is the circle 
---@param width number How wide is the outline
function gfx2.drawElipse(centerX, centerY, radius, width) end

---Draws an elipse (circle but possibly wider)
---@param centerX number The X axis center position of the elipse
---@param centerY number The Y axis center position of the elipse
---@param radiusX number How Wide is the elipse
---@param radiusY number how High is the elipse
---@param width number How wide is the outline
function gfx2.drawElipse(centerX, centerY, radiusX, radiusY, width) end

---Draws a line between point1 and point2
---@param Point1X number X axis posiiton of the first point
---@param Point1Y number Y axis posiiton of the first point
---@param Point2X number X axis posiiton of the second point
---@param Point2Y number Y axis posiiton of the second point
---@param Width number The width of the line
function gfx2.drawLine(Point1X, Point1Y, Point2X, Point2Y, Width) end

---Fills a quad
---@param TopLeftX number X axis posiiton of the top left point
---@param TopLeftY number Y axis posiiton of the top left point
---@param TopRightX number X axis posiiton of the top left point
---@param TopRightY number Y axis posiiton of the top left point
---@param BottomLeftX number X axis posiiton of the top left point
---@param BottomLeftY number Y axis posiiton of the top left point
---@param BottomRightX number X axis posiiton of the top left point
---@param BottomRightY number Y axis posiiton of the top left point
function gfx2.fillQuad(TopLeftX, TopLeftY, TopRightX, TopRightY, BottomLeftX, BottomLeftY, BottomRightX, BottomRightY) end

---Fills a triangle
---@param TrianglePoint1X number X axis posiiton of the top left point
---@param TrianglePoint1Y number Y axis posiiton of the top left point
---@param TrianglePoint2X number X axis posiiton of the top left point
---@param TrianglePoint2Y number Y axis posiiton of the top left point
---@param TrianglePoint3X number X axis posiiton of the top left point
---@param TrianglePoint3Y number Y axis posiiton of the top left point
function gfx2.fillTriangle(TrianglePoint1X, TrianglePoint1Y, TrianglePoint2X, TrianglePoint2Y, TrianglePoint3X, TrianglePoint3Y) end


---Renders text on the Minecraft: Bedrock Edition Screen
---@param x number X axis posiiton of the text
---@param y number Y axis posiiton of the text
---@param text string The text to be rendered on the Minecraft: Bedrock Edition Screen
function gfx2.text(x, y, text) end

---Renders text on the Minecraft: Bedrock Edition Screen
---@param x number X axis posiiton of the text
---@param y number Y axis posiiton of the text
---@param text string The text to be rendered on the Minecraft: Bedrock Edition Screen
---@param scale number the scale(size) of the text
function gfx2.text(x, y, text, scale) end

---Gets the size of text on (Can be used outside of render2)
---@param text string The text to measure
---@param scale number the scale(size) of the text
---@return number width
---@return number height
function gfx2.textSize(text, scale) end

---Gets the size of text (Can be used outside of render2)
---@param text string The text to measure
---@return number width
---@return number height
function gfx2.textSize(text) end



---@class Gfx2Texture
---@field width integer The width of the texture
---@field height integer The height of the texture
local _acp__Gfx2Texture_ = {}

---Gets the color of a pixel in the texture
---@param x integer X position of the pixel to get
---@param y integer Y position of the pixel to get
---@return iColor
function _acp__Gfx2Texture_:getPixel(x, y) end

---Sets the color of a pixel in the texture, you must unload if you used it for changes to apply
---@param x integer X position of the pixel to get
---@param y integer Y position of the pixel to get
---@param r integer new red color value (0-255)
---@param g integer new green color value (0-255)
---@param b integer new blue color value (0-255)
---@diagnostic disable-next-line: duplicate-set-field
function _acp__Gfx2Texture_:setPixel(x, y, r, g, b) end

---Sets the color of a pixel in the texture, you must unload if you used it for changes to apply
---@param x integer X position of the pixel to get
---@param y integer Y position of the pixel to get
---@param r integer new red color value (0-255)
---@param g integer new green color value (0-255)
---@param b integer new blue color value (0-255)
---@param a integer new alpha value (0-255)
---@diagnostic disable-next-line: duplicate-set-field
function _acp__Gfx2Texture_:setPixel(x, y, r, g, b ,a) end

---Saves the texture to a png file (for if you wana draw to it using setPixel)
---@param path string Where to save this
---@return boolean saved
function _acp__Gfx2Texture_:save(path) end

---Unloads the texture when you no longer need it or to reload its content
function _acp__Gfx2Texture_:unload() end



---Loads a texture from base64 text (can be used outside of render2)
---@param width integer
---@param height integer
---@param Base64Texture string The texture itself, convert with https://cdn.discordapp.com/attachments/877878499749289984/1029113574406242405/ImgToBase64.exe
---@return Gfx2Texture|nil The loaded texture or nil
function gfx2.loadImage(width, height, Base64Texture) end

---Loads a texture from base64 text (can be used outside of render2)
---@param filepath string The path relative to the Scripts/Data folder
---@return Gfx2Texture|nil The loaded texture or nil
function gfx2.loadImage(filepath) end



---Renders an image to the Minecraft: Bedrock Edition Screen
---@param x number The position on the x axis
---@param y number The position on the y axis
---@param width number Width of the image to render
---@param height number Height of the image to render
---@param image Gfx2Texture image to render
function gfx2.drawImage(x, y, width, height, image) end

---Renders an image to the Minecraft: Bedrock Edition Screen
---@param x number The position on the x axis
---@param y number The position on the y axis
---@param width number Width of the image to render
---@param height number Height of the image to render
---@param image Gfx2Texture image to render
---@param opacity number Opactity at which to render the image at (0.0 to 1.0)
function gfx2.drawImage(x, y, width, height, image, opacity) end

---Renders an image to the Minecraft: Bedrock Edition Screen
---@param x number The position on the x axis
---@param y number The position on the y axis
---@param width number Width of the image to render
---@param height number Height of the image to render
---@param image Gfx2Texture image to render
---@param opacity number Opactity at which to render the image at (0.0 to 1.0)
---@param isLinear boolean Should the scaling be linear or is it gonna be nearest neighbor
function gfx2.drawImage(x, y, width, height, image, opacity, isLinear) end




---Renders an image to the Minecraft: Bedrock Edition Screen
---@param x number The position on the x axis
---@param y number The position on the y axis
---@param width number Width of the image to render
---@param height number Height of the image to render
---@param image Gfx2Texture image to render
---@param srcStartX number Where in the source should we start taking the image
---@param srcStartY number Where in the source should we start taking the image
---@param srcSizeX number what size in the source image are we taking
---@param srcSizeY number what size in the source image are we taking
function gfx2.cdrawImage(x, y, width, height, image, srcStartX, srcStartY, srcSizeX, srcSizeY) end

---Renders an image to the Minecraft: Bedrock Edition Screen
---@param x number The position on the x axis
---@param y number The position on the y axis
---@param width number Width of the image to render
---@param height number Height of the image to render
---@param image Gfx2Texture image to render
---@param srcStartX number Where in the source should we start taking the image
---@param srcStartY number Where in the source should we start taking the image
---@param srcSizeX number what size in the source image are we taking
---@param srcSizeY number what size in the source image are we taking
---@param opacity number Opactity at which to render the image at (0.0 to 1.0)
function gfx2.cdrawImage(x, y, width, height, image, srcStartX, srcStartY, srcSizeX, srcSizeY, opacity) end

---Renders an image to the Minecraft: Bedrock Edition Screen
---@param x number The position on the x axis
---@param y number The position on the y axis
---@param width number Width of the image to render
---@param height number Height of the image to render
---@param image Gfx2Texture image to render
---@param srcStartX number Where in the source should we start taking the image
---@param srcStartY number Where in the source should we start taking the image
---@param srcSizeX number what size in the source image are we taking
---@param srcSizeY number what size in the source image are we taking
---@param opacity number Opactity at which to render the image at (0.0 to 1.0)
---@param isLinear boolean Should the scaling be linear or is it gonna be nearest neighbor
function gfx2.cdrawImage(x, y, width, height, image, srcStartX, srcStartY, srcSizeX, srcSizeY, opacity, isLinear) end
