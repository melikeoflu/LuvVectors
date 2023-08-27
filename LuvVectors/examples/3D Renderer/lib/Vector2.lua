-- << VECTOR2 >> --
-- A simple, fast Vector2 module for Lua
-- Github: cgl4de (@GalladeR475)

local graphics = require("graphics-wrapper");
local Vector3 = require("lib.Vector3");

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
function Vector2:__add(other)
    if (type(other) ~= "number") and (type(other) ~= "table" and not (other.X and other.Y)) then
        error(CreateError("add", type(other), "ar"));
    end;

    if (type(other) == "number") then
        return Vector2.new(self.X + other, self.Y + other);
    elseif (type(other) == "table" and other.X and other.Y) then
        return Vector2.new(self.X + other.X, self.Y + other.Y);
    end;
end;

function Vector2:__sub(other)
    if (type(other) ~= "number") and (type(other) ~= "table" and not (other.X and other.Y)) then
        error(CreateError("sub", type(other), "ar"));
    end;

    if (type(other) == "number") then
        return Vector2.new(self.X - other, self.Y - other);
    elseif (type(other) == "table" and other.X and other.Y) then
        return Vector2.new(self.X - other.X, self.Y - other.Y);
    end;
end

function Vector2:__mul(other)
    if (type(other) ~= "number") and (type(other) ~= "table" and not (other.X and other.Y)) then
        error(CreateError("mul", type(other), "ar"));
    end;

    if (type(other) == "number") then
        return Vector2.new(self.X * other, self.Y * other);
    elseif (type(other) == "table" and other.X and other.Y) then
        return Vector2.new(self.X * other.X, self.Y * other.Y);
    end;
end

function Vector2:__div(other)
    if (type(other) ~= "number") and (type(other) ~= "table" and not (other.X and other.Y)) then
        error(CreateError("div", type(other), "ar"));
    end;

    if (type(other) == "number") then
        return Vector2.new(self.X / other, self.Y / other);
    elseif (type(other) == "table" and other.X and other.Y) then
        return Vector2.new(self.X / other.X, self.Y / other.Y);
    end;
end;

-- << VECTOR LOGIC >> --

---@param other Vector2
function Vector2:__eq(other)
    if (type(other) ~= "table" and not (other.X and other.Y)) then
        error(CreateError(nil, type(other), "eq"));
    end;
    return (self.X == other.X and self.Y == other.Y);
end;

---@param other Vector2
function Vector2:__le(other)
    if (type(other) ~= "table" and not (other.X and other.Y)) then
        error(CreateError(nil, type(other), "eq"));
    end;
    return (self.X <= other.X and self.Y <= other.Y);
end

---@param other Vector2
function Vector2:__ge(other)
    if (type(other) ~= "table" and not (other.X and other.Y)) then
        error(CreateError(nil, type(other), "eq"));
    end;
    return (self.X <= other.X and self.Y <= other.Y);
end

---@param other Vector2
function Vector2:__g(other)
    if (type(other) ~= "table" and not (other.X and other.Y)) then
        error(CreateError(nil, type(other), "eq"));
    end;
    return (self.X > other.X and self.Y > other.Y);
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
    return string.format("Vector2[%.3f, %.3f]", self.X, self.Y);
end;

function Vector2:ToString()
    return string.format("Vector2[%.3f, %.3f]", self.X, self.Y);
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

function Vector2:Dot(other)
    return self.X * other.X + self.Y * other.Y;
end; 

function Vector2:Lerp(goal, alpha)
    return Vector2.new(
        Lerp(self.X, goal.X, alpha),
        Lerp(self.Y, goal.Y, alpha)
    );
end;

function Vector2:Max(other)
    return Vector2.new(
        math.max(self.X, other.X),
        math.max(self.Y, other.Y)
    );
end;

function Vector2:Min(other)
    return Vector2.new(
        math.min(self.X, other.X),
        math.min(self.Y, other.Y)
    );
end;

---Draws a line from `self` to `other`
---@param other Vector2
---@param color Color3
function Vector2:DrawLineTo(other, color)
    graphics.setColor(color);
    graphics.line(self, other);
end;

---Calculates the angle (in degrees) of 2 vectors
---@param other Vector2
---@return number
function Vector2:Angle(other)
    local cos = self:Dot(other)/(self:Magnitude() * other:Magnitude());
    cos = math.min(1, math.max(-1, cos));
    return math.deg(math.acos(cos));
end;

--Creates a copy of the Vector2 as a Vector3
---@return Vector3
function Vector2:AsVector3()
    return Vector3.new(self.X, self.Y, 0);
end;

--Sets the value as a Vector3
---@return nil
function Vector2:ToVector3()
    self = Vector3.new(self.X, self.Y, 0);
end;

---Sets `X` to `X + n`
---@param n number
---@return Vector2
function Vector2:AddX(n)
    self.X = self.X + n;
    return self;
end;

---Sets `Y` to `Y + n`
---@param n number
---@return Vector2
function Vector2:AddY(n)
    self.Y = self.Y + n;
    return self;
end;

---Sets `X` to `n`
---@param n number
---@return Vector2
function Vector2:SetX(n)
    self.X = n;
    return self;
end

---Sets `Y` to `n`
---@param n number
---@return Vector2
function Vector2:SetY(n)
    self.Y = n;
    return self;
end

return Vector2;