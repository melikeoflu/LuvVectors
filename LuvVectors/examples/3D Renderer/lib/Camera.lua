local Vector3 = require "lib.Vector3"

---@class Camera
---@field Position Vector3
---@field Rotation Vector3
---@field Velocity Vector3
---@field InMotion boolean
local Camera = ({});
Camera.__index = Camera;

---Creates a new `Camera` Instance
---@param pos? Vector3
---@param rot? Vector3
---@return Camera
function Camera.new(pos, rot)
    local self = setmetatable({
        Position = pos or Vector3.zero();
        Rotation = rot or Vector3.zero();
        Velocity = Vector3.zero();
        InMotion = false;
    }, Camera);
    return self;
end;

---Updates the Camera
---@param dt number
---@param mouse Mouse
function Camera:Update(dt, mouse)
    local speed = dt * 10;

    self.InMotion = false;

    local speedX = speed * math.sin(self.Rotation.Y);
    local speedY = speed * math.cos(self.Rotation.Y);

    if love.keyboard.isDown("w") then
        self.Position.X = self.Position.X + speedX;
        self.Position.Z = self.Position.Z + speedY;
        self.InMotion = true;
    end;
    if love.keyboard.isDown("a") then 
        self.Position.X = self.Position.X - speedY;
        self.Position.Z = self.Position.Z + speedX;
        self.InMotion = true; 
    end;
    if love.keyboard.isDown("d") then 
        self.Position.X = self.Position.X + speedY;
        self.Position.Z = self.Position.Z - speedX;
        self.InMotion = true;
    end; 
    if love.keyboard.isDown("s") then
        self.Position.X = self.Position.X - speedX;
        self.Position.Z = self.Position.Z - speedY;
        self.InMotion = true;
    end;
    
    if love.keyboard.isDown("q") then self.Position.Y = self.Position.Y + speed; self.InMotion = true; end;
    if love.keyboard.isDown("e") then self.Position.Y = self.Position.Y - speed; self.InMotion = true; end;


    local derivative = mouse.Derivative / 300;
    self.Rotation = Ternary((derivative.X ~= 0 and derivative.Y ~= 0), 
        Vector2.new(
            self.Rotation.X + derivative.Y,
            self.Rotation.Y + derivative.X
        ),
        self.Rotation
    );
end;

---Returns `a, b` with axis
---@param radian number
---@return number
---@return number
function Camera.Rotate2D(a, b, radian)
    local sin, cos = math.sin(radian), math.cos(radian);
    return (a * cos) - (b * sin), (a * sin) + (b * cos);
end

---Ternary Operator for Lua
---@param cond boolean
---@param T any
---@param F any
---@return any
function Ternary(cond, T, F)
    if (cond) then return T; else return F; end;
end;

return Camera;
