local Vector2 = require "lib.Vector2"

---@class Mouse
---@field Position Vector2
---@field Previous Vector2
---@field Derivative Vector2
local Mouse = {};
Mouse.__index = Mouse;

---Creates a new `Mouse` Instance 
---@return Mouse
function Mouse.new()
    local self = setmetatable({
        Position = Vector2.zero();
        Previous = Vector2.zero();
        Derivative = Vector2.zero();
    }, Mouse);
    return self;
end;

---Updates the `Mouse` Instance
---@param x number
---@param y number
---@param dx number
---@param dy number
function Mouse:Update(x, y, dx, dy)
    self.Previous = self.Position;
    self.Position = Vector2.new(x, y);
    self.Derivative = Vector2.new(dx, dy);
end;

return Mouse;
