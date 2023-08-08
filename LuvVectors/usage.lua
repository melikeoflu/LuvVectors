local Vector2 = require("Vector2");
local Vector3 = require("Vector3");

-- << VECTOR2 >> --
local a = Vector2.new(1, 4);
local b = Vector2.new(3, 2);

b.X = 5;

print(("\n %s \n"):format("VECTOR2"));

print("a: "..a:ToString());
print("b: "..b:ToString());

print("Magnitude: "..a:Magnitude());
print("Unit: "..a:Unit():ToString());

print("Dot: "..a:Dot(b));
print("Cross: "..a:Cross(b):ToString());

print(("\n %s \n"):format("VECTOR3"));

-- << VECTOR3 >> --
local a = Vector3.new(1, 2, 0);     -- Creates a new Vector and assigns to "a"
local b = Vector3.new(2, 4, 1);     -- Creates a new Vector and assigns to "b"
local c = Vector3.zero();             -- Zero vector

local n = 2;

local result = a + b;               -- Arithmetic (add) with vector
local result = a - b;               -- Arithmetic (sub) with vector
local result = a * b;               -- Arithmetic (mul) with vector
local result = a / b;               -- Arithmetic (div) with vector

local result = a + n;               -- Arithmetic (add) with number
local result = a - n;               -- Arithmetic (sub) with number
local result = a * n;               -- Arithmetic (mul) with number
local result = a / n;               -- Arithmetic (div) with number

print("a: "..a:ToString());
print("b: "..b:ToString());

print("Max: "..a:Max(b):ToString());            -- Returns Max Values of the 2 Vectors
print("Min: "..a:Min(b):ToString());            -- Returns Min Values of the 2 Vectors

print("ToString: "..(result:ToString()));       -- ToString method
print("tostring(): "..tostring(result));        -- Same as ToString

print("Magnitude: "..a:Magnitude());            -- Magnitude of A
print("Unit: "..a:Unit():ToString());           -- Unit Vector of B

print("Dot: "..a:Dot(b));                       -- Dot   product of A and B = A.B -> Scalar
print("Cross: "..a:Cross(b):ToString());        -- Cross product of A and B = AxB -> Vector

print("Angle: "..a:Angle(b, Vector3.xAxis));    -- Returns Angle b/w the 2 vectors (in radians)
print("Lerp: "..a:Lerp(b, .75):ToString());     -- Linear Interpretation of "a"