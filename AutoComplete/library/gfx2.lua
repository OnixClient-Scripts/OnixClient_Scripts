---@meta


---@class Gfx2RenderTarget
---@field width integer The width of the render target
---@field height integer The height of the render target
local _acp__gfx2Render_Target_ = {}
---Changes the size of the render target (will clear it)
---@param width integer The new width of the render target
---@param height integer The new height of the render target
function _acp__gfx2Render_Target_:resize(width, height) end

---Clears the render target to the active gfx2.color
function _acp__gfx2Render_Target_:clear() end

---Saves the content of the render target to a file
---@param filepath string The path to save the file to
---@return boolean saved If the file was saved or not
function _acp__gfx2Render_Target_:save(filepath) end
---Saves the content of the render target to a file and potentially to clipboard after
---@param filepath string The path to save the file to
---@param toClipboardAswell boolean If it should also copy the image to the clipboard (default false)
---@return boolean saved If the file was saved or not
function _acp__gfx2Render_Target_:save(filepath, toClipboardAswell) end


---@class Gfx2CpuRenderTarget : Gfx2RenderTarget
---@field cpuTexture Gfx2Texture Please cache this as it needs to extract and copy the entire thing 

---@class Gfx2GpuRenderTarget : Gfx2RenderTarget



---@class gfx2
gfx2 = {}

---Changes the color of what will be rendered using a setting
---@param setting Setting client color(pls or u crash) setting
function gfx2.color(setting) end

---Changes the color of what will be rendered using a ColorSetting table
---@param colorTable ColorSetting
function gfx2.color(colorTable) end

---Changes the color of what will be rendered
---@param r number 0-255 color code
---@param g number 0-255 color code
---@param b number 0-255 color code
function gfx2.color(r, g, b) end
---Changes the color of what will be rendered with opacity
---@param r number 0-255 color code
---@param g number 0-255 color code
---@param b number 0-255 color code
---@param opacity number 0-255 color code
function gfx2.color(r, g, b, opacity) end

---Changes the tint color of images that will be rendered using a setting
---@param setting Setting client color(pls or u crash) setting
function gfx2.tcolor(setting) end

---Changes the tint color of images that will be rendered using a ColorSetting table
---@param colorTable ColorSetting
function gfx2.tcolor(colorTable) end

---Changes the tint color of images that will be rendered
---@param r number 0-255 color code
---@param g number 0-255 color code
---@param b number 0-255 color code
function gfx2.tcolor(r, g, b) end

---Changes the tint color of images that will be rendered with opacity
---@param r number 0-255 color code
---@param g number 0-255 color code
---@param b number 0-255 color code
---@param opacity number 0-255 color code
function gfx2.tcolor(r, g, b, opacity) end



---Gives you the width of the current render target
---@return integer width the width of the current render target
function gfx2.width() end

---Gives you the height of the current render target
---@return integer height the height of the current render target
function gfx2.height() end


---Fills a rectangle
---@param x number Position on the X axis
---@param y number Position on the Y axis
---@param width number Width of the rectangle
---@param height number Height of the rectangle
function gfx2.fillRect(x, y, width, height) end

---Fills a blurred potentially rounded rectangle
---Note that if the user disabled blur module background this will not blur anything.
---@param x number Position on the X axis
---@param y number Position on the Y axis
---@param width number Width of the rectangle
---@param height number Height of the rectangle
---@param opacity number The opacity of the blurred rectangle
---@param roundedCornerRadius number The radius of the corners if you want a rounded corner blur
---@return boolean blurred If the area was blurred or not
function gfx2.blur(x, y, width, height, opacity, roundedCornerRadius) end

---Draws the outline of a rectangle (outline)
---@param x number Position on the X axis
---@param y number Position on the Y axis
---@param width number Width of the rectangle
---@param height number Height of the rectangle
---@param lineWidth number How large is the line
function gfx2.drawRect(x, y, width, height, lineWidth) end

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
function gfx2.drawRoundRect(x, y, width, height, radius, lineWidth) end


---Fills a circle since you do not have a radiusY 
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
---@param TopRightX number X axis posiiton of the top right point
---@param TopRightY number Y axis posiiton of the top right point
---@param BottomLeftX number X axis posiiton of the top left point
---@param BottomLeftY number Y axis posiiton of the top left point
---@param BottomRightX number X axis posiiton of the top right point
---@param BottomRightY number Y axis posiiton of the top right point
function gfx2.fillQuad(TopLeftX, TopLeftY, TopRightX, TopRightY, BottomLeftX, BottomLeftY, BottomRightX, BottomRightY) end

---Fills a triangle
---@param TrianglePoint1X number X axis posiiton of the top left point
---@param TrianglePoint1Y number Y axis posiiton of the top left point
---@param TrianglePoint2X number X axis posiiton of the bottom left point
---@param TrianglePoint2Y number Y axis posiiton of the bottom left point
---@param TrianglePoint3X number X axis posiiton of the bottom right point
---@param TrianglePoint3Y number Y axis posiiton of the bottom right point
function gfx2.fillTriangle(TrianglePoint1X, TrianglePoint1Y, TrianglePoint2X, TrianglePoint2Y, TrianglePoint3X, TrianglePoint3Y) end


---Renders text on the Minecraft: Bedrock Edition Screen
---@param x number X axis posiiton of the text
---@param y number Y axis posiiton of the text
---@param text string The text to be rendered on the Minecraft: Bedrock Edition Screen
function gfx2.text(x, y, text) end

---Renders text on the Minecraft: Bedrock Edition Screen with scale
---@param x number X axis posiiton of the text
---@param y number Y axis posiiton of the text
---@param text string The text to be rendered on the Minecraft: Bedrock Edition Screen
---@param scale number the scale(size) of the text (2 makes it twice as big)
function gfx2.text(x, y, text, scale) end

---Gets the size of text on (Can be used outside of render2) with scale
---@param text string The text to measure
---@param scale number the scale(size) of the text (2 makes it twice as big)
---@return number width the width of the text
---@return number height the height of the text
function gfx2.textSize(text, scale) end

---Gets the size of text (Can be used outside of render2)
---@param text string The text to measure
---@return number width the width of the text
---@return number height the height of the text
function gfx2.textSize(text) end


---@class Gfx2Texture
---@field width integer The width of the texture
---@field height integer The height of the texture
---@field stringForm string The string representation of the texture
local _acp__Gfx2Texture_ = {}

---Gets the color of a pixel in the texture
---@param x integer X position of the pixel to get
---@param y integer Y position of the pixel to get
---@return iColor color The color of the pixel
function _acp__Gfx2Texture_:getPixel(x, y) end

---Sets the color of a pixel in the texture, you must unload if you used it for changes to apply
---@param x integer X position of the pixel to get
---@param y integer Y position of the pixel to get
---@param r integer new red color value (0-255)
---@param g integer new green color value (0-255)
---@param b integer new blue color value (0-255)
---@diagnostic disable-next-line: duplicate-set-field
function _acp__Gfx2Texture_:setPixel(x, y, r, g, b) end

---Sets the color of a pixel in the texture, you must unload if you used it for changes to apply with opacity
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
---@return boolean saved Did the texture successfully save
function _acp__Gfx2Texture_:save(path) end

---Unloads the texture when you no longer need it or to reload its content
function _acp__Gfx2Texture_:unload() end


---Loads a texture from base64 text (can be used outside of render2)
---@param width integer the width of the texture
---@param height integer the height of the texture
---@param Base64Texture string The texture itself, convert with https://cdn.discordapp.com/attachments/877878499749289984/1029113574406242405/ImgToBase64.exe
---@return Gfx2Texture|nil texture The loaded texture or nil
function gfx2.loadImage(width, height, Base64Texture) end

---Loads a texture from a file (can be used outside of render2)
---@param filepath string The path relative to the Scripts/Data folder
---@return Gfx2Texture|nil texture The loaded texture or nil
function gfx2.loadImage(filepath) end

---Loads the texture from its string representation
---@param stringForm string The string representation of the texture
---@return Gfx2Texture texture The loaded texture
function gfx2.loadImageFromStringForm(stringForm) end

---Loads a texture from a url, great for things that render images that changes
---Note that while the texture is loading, drawing it will draw a gfx2.color() colored rectangle
---@param url string The url to download the image from
---@return Gfx2Texture texture The texture that will be loaded from the web
function gfx2.loadImageFromUrl(url) end

---Loads a texture from a url, great for things that render images that changes
---Note that while the texture is loading, drawing it will draw a gfx2.color() colored rectangle
---Please don't use this for static images that don't change.
---@param url string The url to download the image from
---@param headers string[] Headers if needed to get access to the image
---@return Gfx2Texture texture The texture that will be loaded from the web
function gfx2.loadImageFromUrl(url, headers) end

---Creates a texture with the specified width and height
---@param width integer the width of the texture
---@param height integer the height of the texture
---@return Gfx2Texture|nil texture The created texture or nil
function gfx2.createImage(width, height) end



---Renders an image to the Minecraft: Bedrock Edition Screen
---@param x number The position on the x axis
---@param y number The position on the y axis
---@param width number Width of the image to render
---@param height number Height of the image to render
---@param image Gfx2Texture|Gfx2GpuRenderTarget image to render
function gfx2.drawImage(x, y, width, height, image) end

---Renders an image to the Minecraft: Bedrock Edition Screen with different opacity
---@param x number The position on the x axis
---@param y number The position on the y axis
---@param width number Width of the image to render
---@param height number Height of the image to render
---@param image Gfx2Texture|Gfx2GpuRenderTarget image to render
---@param opacity number Opactity at which to render the image at (0.0 to 1.0)
function gfx2.drawImage(x, y, width, height, image, opacity) end

---Renders an image to the Minecraft: Bedrock Edition Screen with different opacity or scaling method
---@param x number The position on the x axis
---@param y number The position on the y axis
---@param width number Width of the image to render
---@param height number Height of the image to render
---@param image Gfx2Texture|Gfx2GpuRenderTarget Image to render
---@param opacity number Opactity at which to render the image at (0.0 to 1.0)
---@param isLinear boolean Should the scaling be linear or is it gonna be nearest neighbor
function gfx2.drawImage(x, y, width, height, image, opacity, isLinear) end



---Renders an image to the Minecraft: Bedrock Edition Screen
---@param x number The position on the x axis
---@param y number The position on the y axis
---@param width number Width of the image to render
---@param height number Height of the image to render
---@param image Gfx2Texture|Gfx2GpuRenderTarget image to render
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
---@param image Gfx2Texture|Gfx2GpuRenderTarget image to render
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
---@param image Gfx2Texture|Gfx2GpuRenderTarget image to render
---@param srcStartX number Where in the source should we start taking the image
---@param srcStartY number Where in the source should we start taking the image
---@param srcSizeX number what size in the source image are we taking
---@param srcSizeY number what size in the source image are we taking
---@param opacity number Opactity at which to render the image at (0.0 to 1.0)
---@param isLinear boolean Should the scaling be linear or is it gonna be nearest neighbor
function gfx2.cdrawImage(x, y, width, height, image, srcStartX, srcStartY, srcSizeX, srcSizeY, opacity, isLinear) end





---Creates a cpu render target, you can basically use most gfx2 things on it.
---Except that you can then save it to disk or do whatever you want with the texture cpu or gpu side
---@param width integer The width of the render target
---@param height integer The height of the render target
---@return Gfx2CpuRenderTarget target The created render target
function gfx2.createCpuRenderTarget(width, height) end

---Creates a gpu render target, you can basically use most gfx2 things on it.
---@param width integer The width of the render target
---@param height integer The height of the render target
---@return Gfx2GpuRenderTarget target The created render target
function gfx2.createRenderTarget(width, height) end

---Choses which render target to use
---Chosing nil will result in going back to default/normal
---@param target nil|Gfx2RenderTarget The render target to use
function gfx2.bindRenderTarget(target) end

---Pushes a clipping rectangle, you cannot draw outside of these
---If you need to do that again you may consider poping the clipping rectangle
---@param x number The position on the x axis
---@param y number The position on the y axis
---@param width number Width of the clipping rectangle
---@param height number Height of the clipping rectangle
function gfx2.pushClipArea(x, y, width, height) end

---Pops the last pushed clipping rectangle
function gfx2.popClipArea() end
---Pops the last pushed clipping rectangle but specified amount
---@param amount integer How many clipping rectangles to pop (you cant pop enough to crash so to reset just put a high number)
function gfx2.popClipArea(amount) end

---Pushes a transformation
---@param matrices table The transformation matrices typed parameter
function gfx2.pushTransformation(matrices) end

---Pops the last pushed transformation
function gfx2.popTransformation() end
---Pops the last pushed transformation but specified amount
---@param amount integer How many transformations to pop (you cant pop enough to crash so to reset just put a high number)
function gfx2.popTransformation(amount) end



