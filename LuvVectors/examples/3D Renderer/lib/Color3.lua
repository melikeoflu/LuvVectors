-- << Color3 >> --
-- A simple, fast Color module for Lua
-- Github: cgl4de (@GalladeR475)

---@class Color3
---@field R number
---@field G number
---@field B number
local Color3 = ({});
Color3.__index = Color3;

-- A quantity having x, y and z axis.
---@param r number
---@param g number
---@param b number
---@return Color3
Color3.new = function(r, g, b)
    local self = setmetatable({
        R = r > 1 and r/255 or r or 0;
        G = g > 1 and g/255 or g or 0;
        B = b > 1 and b/255 or b or 0;
    }, Color3);

    return self;
end;

-- << COLOR CONSTANTS >> --
Color3.Black        = function() return Color3.new(0, 0, 0); end;
Color3.White        = function() return Color3.new(1, 1, 1); end;
Color3.Red          = function() return Color3.new(1, 0, 0); end;
Color3.Green        = function() return Color3.new(0, 1, 0); end;
Color3.Blue         = function() return Color3.new(0, 0, 1); end;
Color3.Magenta      = function() return Color3.new(1, 0, 1); end;
Color3.Yellow       = function() return Color3.new(1, 1, 0); end;
Color3.Cyan         = function() return Color3.new(0, 1, 1); end;

-- << COLOR ARITHMETIC >> --
function Color3:__add(other)
    if (type(other) ~= "number") and (type(other) ~= "table" and not (other.R and other.G and other.B)) then
        error(CreateError("add", type(other)));
    end;

    if (type(other) == "number") then
        return Color3.new(self.R + other, self.G + other, self.B + other);
    elseif (other.R and other.G and other.B) then
        return Color3.new(self.R + other.R, self.G + other.G, self.B + other.B);
    end;
end;

function Color3:__sub(other)
    if (type(other) ~= "number") and (type(other) ~= "table" and not (other.R and other.G and other.B)) then
        error(CreateError("sub", type(other)));
    end;

    if (type(other) == "number") then
        return Color3.new(self.R - other, self.G - other, self.B - other);
    elseif (other.R and other.G and other.B) then
        return Color3.new(self.R - other.R, self.G - other.G, self.B - other.B);
    end;
end

function Color3:__mul(other)
    if (type(other) ~= "number") and (type(other) ~= "table" and not (other.R and other.G and other.B)) then
        error(CreateError("mul", type(other)));
    end;

    if (type(other) == "number") then
        return Color3.new(self.R * other, self.G * other, self.B * other);
    elseif (other.R and other.G and other.B) then
        return Color3.new(self.R * other.R, self.G * other.G, self.B * other.B);
    end;
end

function Color3:__div(other)
    if (type(other) ~= "number") and (type(other) ~= "table" and not (other.R and other.G and other.B)) then
        error(CreateError("div", type(other)));
    end;

    if (type(other) == "number") then
        return Color3.new(self.R / other, self.G / other, self.B / other);
    elseif (other.R and other.G and other.B) then
        return Color3.new(self.R / other.R, self.G / other.G, self.B / other.B);
    end;
end;

---@param other Color3
function Color3:__eq(other)
    if (type(other) ~= "table" and not (other.R and other.G and other.B)) then
        error(CreateError(nil, type(other), "eq"));
    end;
    return (self.R == other.R and self.G == other.G and self.B == other.B);
end;

---@param other Color3
function Color3:__le(other)
    if (type(other) ~= "table" and not (other.R and other.G and other.B)) then
        error(CreateError(nil, type(other), "eq"));
    end;
    return (self.R <= other.R and self.G <= other.G and self.B <= other.B);
end

---@param other Color3
function Color3:__ge(other)
    if (type(other) ~= "table" and not (other.R and other.G and other.B)) then
        error(CreateError(nil, type(other), "eq"));
    end;
    return (self.R >= other.R and self.G >= other.G and self.B >= other.B);
end

---@param other Color3
function Color3:__g(other)
    if (type(other) ~= "table" and not (other.R and other.G and other.B)) then
        error(CreateError(nil, type(other), "eq"));
    end;
    return (self.R > other.R and self.G > other.G and self.B > other.B);
end

-- << GLOBAL FUNCTIONS >> --
function CreateError(operator, type_, a)
    if (a == "ar") then
        return ("WARNING: Attempted to perform arithmetic ("..operator..") on Color3 and "..type_)
    elseif (a == "eq") then
        return ("WARNING: tried to compare Color3 and "..type_)
    end
end;

function Lerp(a, b, alpha)
    return a + (b - a) * alpha;
end;

-- << COLOR FUNCTIONS >> --
function Color3:__tostring()
    return "Color3["..self.R..", "..self.G..", "..self.B.."]";
end;

function Color3:ToString()
    return "Color3["..self.R..", "..self.G..", "..self.B.."]";
end;

function Color3:Lerp(goal, alpha)
    return Color3.new(
        Lerp(self.R, goal.X, alpha),
        Lerp(self.G, goal.Y, alpha),
        Lerp(self.B, goal.Z, alpha)
    );
end;

function Color3:Max(other)
    return Color3.new(
        math.max(self.R, other.R),
        math.max(self.G, other.G),
        math.max(self.B, other.B)
    );
end;

function Color3:Min(other)
    return Color3.new(
        math.min(self.R, other.R),
        math.min(self.G, other.G),
        math.min(self.B, other.B)
    );
end;

return Color3;