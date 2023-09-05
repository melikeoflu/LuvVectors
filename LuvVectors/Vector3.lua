-- << VECTOR3 >> --
-- A simple, fast Vector3 module for Lua
-- Github: cgl4de (@GalladeR475)

---@class Vector3
---@field X number
---@field Y number
---@field Z number
local Vector3 = ({});
Vector3.__index = Vector3;

-- A quantity having x, y and z axis.
---@param x number
---@param y number
---@param z number
---@return Vector3
Vector3.new = function(x, y, z)
    local self = setmetatable({
        X = x or 0;
        Y = y or 0;
        Z = z or 0;
    }, Vector3);

    return self;
end;

-- << VECTOR CONSTANTS >> --
Vector3.zero        = function() return Vector3.new(0, 0, 0); end;
Vector3.one         = function() return Vector3.new(1, 1, 1); end;
Vector3.xAxis       = function() return Vector3.new(1, 0, 0); end;
Vector3.yAxis       = function() return Vector3.new(0, 1, 0); end;
Vector3.zAxis       = function() return Vector3.new(0, 0, 1); end;
Vector3.XZ          = function() return Vector3.new(1, 0, 1); end;
Vector3.XY          = function() return Vector3.new(1, 1, 0); end;
Vector3.YZ          = function() return Vector3.new(0, 1, 1); end;

-- << VECTOR ARITHMETIC >> --
function Vector3:__add(v2)
    if (type(v2) ~= "number") and (type(v2) ~= "table" and not (v2.X and v2.Y and v2.Z)) then
        error(CreateError("add", type(v2)));
    end;

    if (type(v2) == "number") then
        return Vector3.new(self.X + v2, self.Y + v2, self.Z + v2);
    elseif (v2.X and v2.Y and v2.Z) then
        return Vector3.new(self.X + v2.X, self.Y + v2.Y, self.Z + v2.Z);
    end;
end;

function Vector3:__sub(v2)
    if (type(v2) ~= "number") and (type(v2) ~= "table" and not (v2.X and v2.Y and v2.Z)) then
        error(CreateError("sub", type(v2)));
    end;

    if (type(v2) == "number") then
        return Vector3.new(self.X - v2, self.Y - v2, self.Z - v2);
    elseif (v2.X and v2.Y and v2.Z) then
        return Vector3.new(self.X - v2.X, self.Y - v2.Y, self.Z - v2.Z);
    end;
end

function Vector3:__mul(v2)
    if (type(v2) ~= "number") and (type(v2) ~= "table" and not (v2.X and v2.Y and v2.Z)) then
        error(CreateError("mul", type(v2)));
    end;

    if (type(v2) == "number") then
        return Vector3.new(self.X * v2, self.Y * v2, self.Z * v2);
    elseif (v2.X and v2.Y and v2.Z) then
        return Vector3.new(self.X * v2.X, self.Y * v2.Y, self.Z * v2.Z);
    end;
end

function Vector3:__div(v2)
    if (type(v2) ~= "number") and (type(v2) ~= "table" and not (v2.X and v2.Y and v2.Z)) then
        error(CreateError("div", type(v2)));
    end;

    if (type(v2) == "number") then
        return Vector3.new(self.X / v2, self.Y / v2, self.Z / v2);
    elseif (v2.X and v2.Y and v2.Z) then
        return Vector3.new(self.X / v2.X, self.Y / v2.Y, self.Z / v2.Z);
    end;
end;

---@param v2 Vector3
function Vector3:__eq(v2)
    if (type(v2) ~= "table" and not (v2.X and v2.Y and v2.Z)) then
        error(CreateError(nil, type(v2), "eq"));
    end;
    return (self.X == v2.X and self.Y == v2.Y and self.Z == v2.Z);
end;

---@param v2 Vector3
function Vector3:__le(v2)
    if (type(v2) ~= "table" and not (v2.X and v2.Y and v2.Z)) then
        error(CreateError(nil, type(v2), "eq"));
    end;
    return (self.X <= v2.X and self.Y <= v2.Y and self.Z <= v2.Z);
end

---@param v2 Vector3
function Vector3:__ge(v2)
    if (type(v2) ~= "table" and not (v2.X and v2.Y and v2.Z)) then
        error(CreateError(nil, type(v2), "eq"));
    end;
    return (self.X >= v2.X and self.Y >= v2.Y and self.Z >= v2.Z);
end

---@param v2 Vector3
function Vector3:__g(v2)
    if (type(v2) ~= "table" and not (v2.X and v2.Y and v2.Z)) then
        error(CreateError(nil, type(v2), "eq"));
    end;
    return (self.X > v2.X and self.Y > v2.Y and self.Z > v2.Z);
end

-- << GLOBAL FUNCTIONS >> --
function CreateError(operator, type_, a)
    if (a == "ar") then
        return ("WARNING: Attempted to perform arithmetic ("..operator..") on Vector3 and "..type_)
    elseif (a == "eq") then
        return ("WARNING: tried to compare Vector3 and "..type_)
    end
end;

function Lerp(a, b, alpha)
    return a + (b - a) * alpha;
end;

-- << VECTOR FUNCTIONS >> --
function Vector3:__tostring()
    return "Vector3["..self.X..", "..self.Y..", "..self.Z.."]";
end;

function Vector3:ToString()
    return "Vector3["..self.X..", "..self.Y..", "..self.Z.."]";
end;

function Vector3:Magnitude()
    return math.sqrt(math.pow(self.X, 2) + math.pow(self.Y, 2) + math.pow(self.Z, 2));
end;

function Vector3:Normalize()
    self = self/self:Magnitude();
end;

function Vector3:Unit()
    local Unit = Vector3.new(self.X, self.Y, self.Z);
    Unit:Normalize();
    return Unit;
end;

function Vector3:Dot(v2)
    return self.X * v2.X + self.Y * v2.Y + self.Z * v2.Z;
end;

function Vector3:Cross(v2)
    return Vector3.new(
        self.Y * v2.Z - self.Z * v2.Y,
        self.Z * v2.X - self.X * v2.Z,
        self.X * v2.Y - self.Y * v2.X
    );
end;

function Vector3:Lerp(goal, alpha)
    return Vector3.new(
        Lerp(self.X, goal.X, alpha),
        Lerp(self.Y, goal.Y, alpha),
        Lerp(self.Z, goal.Z, alpha)
    );
end;

function Vector3:Max(v2)
    return Vector3.new(
        math.max(self.X, v2.X),
        math.max(self.Y, v2.Y),
        math.max(self.Z, v2.Z)
    );
end;

function Vector3:Min(v2)
    return Vector3.new(
        math.min(self.X, v2.X),
        math.min(self.Y, v2.Y),
        math.min(self.Z, v2.Z)
    );
end;

function Vector3:Angle(v2, axis)
    local cos = self:Dot(v2) / (self:Magnitude() / v2:Magnitude());
    local angle = math.acos(math.min(1, math.max(-1, cos)));

    if (axis) then
        if (axis:Dot(axis:Cross(self, v2)) < 0) then
            angle = -angle;
        end;
    end;

    return angle;
end;

return Vector3;
