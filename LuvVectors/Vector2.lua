-- << VECTOR2 >> --
-- A simple, fast Vector2 module for Lua
-- Github: cgl4de (@GalladeR475)

---@class Vector2
---@field X number
---@field Y number
local Vector2 = ({});
Vector2.__index = Vector2;

-- A quantity having x and y axis.
---@param x number
---@param y number
---@return Vector2
Vector2.new = function(x, y)
    local self = setmetatable({
        X = x or 0;
        Y = y or 0;
    }, Vector2);
    return self;
end;

-- << VECTOR CONSTANTS >> --
Vector2.zero        = function() return Vector2.new(0, 0); end;
Vector2.one         = function() return Vector2.new(1, 1); end;
Vector2.xAxis       = function() return Vector2.new(1, 0); end;
Vector2.yAxis       = function() return Vector2.new(0, 1); end;

-- << VECTOR ARITHMETIC >> --
function Vector2:__add(v2)
    if (type(v2) ~= "number") and (type(v2) ~= "table" and not (v2.X and v2.Y)) then
        error(CreateError("add", type(v2), "ar"));
    end;

    if (type(v2) == "number") then
        return Vector2.new(self.X + v2, self.Y + v2);
    elseif (type(v2) == "table" and v2.X and v2.Y) then
        return Vector2.new(self.X + v2.X, self.Y + v2.Y);
    end;
end;

function Vector2:__sub(v2)
    if (type(v2) ~= "number") and (type(v2) ~= "table" and not (v2.X and v2.Y)) then
        error(CreateError("sub", type(v2), "ar"));
    end;

    if (type(v2) == "number") then
        return Vector2.new(self.X - v2, self.Y - v2);
    elseif (type(v2) == "table" and v2.X and v2.Y) then
        return Vector2.new(self.X - v2.X, self.Y - v2.Y);
    end;
end

function Vector2:__mul(v2)
    if (type(v2) ~= "number") and (type(v2) ~= "table" and not (v2.X and v2.Y)) then
        error(CreateError("mul", type(v2), "ar"));
    end;

    if (type(v2) == "number") then
        return Vector2.new(self.X * v2, self.Y * v2);
    elseif (type(v2) == "table" and v2.X and v2.Y) then
        return Vector2.new(self.X * v2.X, self.Y * v2.Y);
    end;
end

function Vector2:__div(v2)
    if (type(v2) ~= "number") and (type(v2) ~= "table" and not (v2.X and v2.Y)) then
        error(CreateError("div", type(v2), "ar"));
    end;

    if (type(v2) == "number") then
        return Vector2.new(self.X / v2, self.Y / v2);
    elseif (type(v2) == "table" and v2.X and v2.Y) then
        return Vector2.new(self.X / v2.X, self.Y / v2.Y);
    end;
end;

-- << VECTOR LOGIC >> --

---@param v2 Vector2
function Vector2:__eq(v2)
    if (type(v2) ~= "table" and not (v2.X and v2.Y)) then
        error(CreateError(nil, type(v2), "eq"));
    end;
    return (self.X == v2.X and self.Y == v2.Y);
end;

---@param v2 Vector2
function Vector2:__le(v2)
    if (type(v2) ~= "table" and not (v2.X and v2.Y)) then
        error(CreateError(nil, type(v2), "eq"));
    end;
    return (self.X <= v2.X and self.Y <= v2.Y);
end

---@param v2 Vector2
function Vector2:__ge(v2)
    if (type(v2) ~= "table" and not (v2.X and v2.Y)) then
        error(CreateError(nil, type(v2), "eq"));
    end;
    return (self.X <= v2.X and self.Y <= v2.Y);
end

---@param v2 Vector2
function Vector2:__g(v2)
    if (type(v2) ~= "table" and not (v2.X and v2.Y)) then
        error(CreateError(nil, type(v2), "eq"));
    end;
    return (self.X > v2.X and self.Y > v2.Y);
end

-- << GLOBAL FUNCTIONS >> --
function CreateError(operator, type_, a)
    if (a == "ar") then
        return ("WARNING: Attempted to perform arithmetic ("..operator..") on Vector2 and "..type_)
    elseif (a == "eq") then
        return ("WARNING: tried to compare Vector2 and "..type_)
    end
end;

function Lerp(a, b, alpha)
    return a + (b - a) * alpha;
end;

-- << VECTOR FUNCTIONS >> --
function Vector2:__tostring()
    return "Vector2["..self.X..", "..self.Y.."]";
end;

function Vector2:ToString()
    return "Vector2["..self.X..", "..self.Y.."]";
end;

function Vector2:Magnitude()
    return math.sqrt(math.pow(self.X, 2) + math.pow(self.Y, 2));
end;

function Vector2:Normalize()
    self = self/self:Magnitude();
end;

function Vector2:OnX()
    return self * Vector2.xAxis();
end;

function Vector2:OnY()
    return self * Vector2.yAxis();
end;

function Vector2:Unit()
    local Unit = Vector2.new(self.X, self.Y);
    Unit:Normalize();
    return Unit;
end;

function Vector2:Dot(v2)
    return self.X * v2.X + self.Y * v2.Y;
end; 

function Vector2:Lerp(goal, alpha)
    return Vector2.new(
        Lerp(self.X, goal.X, alpha),
        Lerp(self.Y, goal.Y, alpha)
    );
end;

function Vector2:Max(v2)
    return Vector2.new(
        math.max(self.X, v2.X),
        math.max(self.Y, v2.Y)
    );
end;

function Vector2:Min(v2)
    return Vector2.new(
        math.min(self.X, v2.X),
        math.min(self.Y, v2.Y)
    );
end;

---Calculates the angle (in degrees) of 2 vectors
---@param v2 Vector2
---@return number
function Vector2:Angle(v2)
    local cos = self:Dot(v2)/(self:Magnitude() * v2:Magnitude());
    cos = math.min(1, math.max(-1, cos));
    return math.deg(math.acos(cos)) or 0;
end;

return Vector2;