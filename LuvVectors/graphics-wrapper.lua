-- THIS IS JUST A BASIC WRAPPER OF LOVE'S GRAPHICS LIBRARY
-- JUST TO PROVIDE YOU WITH SOME GRAPHICAL FUNCTIONS COMPATIBLE WITH VECTORS

local graphics = ({});
local lvGraphics = love.graphics;

---Draws an Arc
---@param drawmode "fill"|"line"
---@param position Vector2
---@param radius number
---@param angle1 number
---@param angle2 number
---@param segments? number
function graphics.arc(drawmode, position, radius, angle1, angle2, segments)
    lvGraphics.arc(drawmode, position.X, position.Y, radius, angle1, angle2, segments);
end;

---Draws a circle
---@param mode "fill"|"line"
---@param position Vector2
---@param radius number
---@param segments? number
function graphics.circle(mode, position, radius, segments)
    lvGraphics.circle(mode, position.X, position.Y, radius, segments);
end;

---Draws a line between points
---@param pos1 Vector2
---@param pos2 Vector2
function graphics.line(pos1, pos2)
    lvGraphics.line(pos1.X, pos1.Y, pos2.X, pos2.Y);
end;

---Prints text
---@param text string
---@param position Vector2
function graphics.print(text, position)
    lvGraphics.print(text, position.X, position.Y);
end;

---comment
---@param rgb Vector3 Temporarily
---@return nil
function graphics.setColor(rgb)
    lvGraphics.setColor(rgb.X, rgb.Y, rgb.Z);
end

return graphics;