local Vector2   = require("lib.Vector2");
local Vector3   = require("lib.Vector3");
local Color3    = require("lib.Color3");
local Mouse     = require("lib.Mouse")
local wrapper   = require("graphics-wrapper")
local Camera    = require("lib.Camera");

function love.load()
    Vertices = {
        Vector3.new(-1, -1, -1),
        Vector3.new( 1, -1, -1),
        Vector3.new( 1,  1, -1),
        Vector3.new(-1,  1, -1),
        Vector3.new(-1, -1,  1),
        Vector3.new( 1, -1,  1),
        Vector3.new( 1,  1,  1),
        Vector3.new(-1,  1,  1),
    };
    Edges = {
        Vector2.new(0, 1); Vector2.new(1, 2); Vector2.new(2, 3); Vector2.new(3, 0);
        Vector2.new(4, 5); Vector2.new(5, 6); Vector2.new(6, 7); Vector2.new(7, 4);
        Vector2.new(0, 4); Vector2.new(1, 5); Vector2.new(2, 6); Vector2.new(3, 7);
    };
    EdgeColors = {
        Color3.Red(), Color3.Green(), Color3.Red(), Color3.Green(),
        Color3.Red(), Color3.Green(), Color3.Red(), Color3.Green(),
        Color3.Blue(), Color3.Blue(), Color3.Blue(), Color3.Blue()
    }
    Origin = Vector2.new(
        math.floor(love.graphics.getWidth()/2), math.floor(love.graphics.getWidth()/2)
    );
    Cam = Camera.new(Vector3.new(0, 0, -5));
    Mouse = Mouse.new();
    love.mouse.setRelativeMode(true);
end;

function love.update(dt)               Cam:Update(dt, Mouse);     end;
function love.mousemoved(x, y, dx, dy) Mouse:Update(x, y, dx, dy) end;

function love.draw()
    for i, edge in ipairs(Edges) do
        local vertex1 = Vertices[edge.X + 1];
        local vertex2 = Vertices[edge.Y + 1];

        local X1 = vertex1.X - Cam.Position.X;
        local Y1 = vertex1.Y - Cam.Position.Y;
        local Z1 = vertex1.Z - Cam.Position.Z;

        local X2 = vertex2.X - Cam.Position.X;
        local Y2 = vertex2.Y - Cam.Position.Y;
        local Z2 = vertex2.Z - Cam.Position.Z;

        X1, Z1 = Cam.Rotate2D(X1, Z1, Cam.Rotation.Y);
        X2, Z2 = Cam.Rotate2D(X2, Z2, Cam.Rotation.Y);

        Y1, Z1 = Cam.Rotate2D(Y1, Z1, Cam.Rotation.X);
        Y2, Z2 = Cam.Rotate2D(Y2, Z2, Cam.Rotation.X);

        local FOV1 = Origin.X / Z1;
        local FOV2 = Origin.X / Z2;
        
        X1 = FOV1 * X1;
        Y1 = FOV1 * Y1;

        X2 = FOV2 * X2;
        Y2 = FOV2 * Y2;

        Vector2.new(Origin.X + X1, Origin.Y + Y1):DrawLineTo(Vector2.new(Origin.X + X2, Origin.Y + Y2), EdgeColors[i]);
        wrapper.setColor();
    end;
    wrapper.print("Position: "..(Cam.Position:ToString()), Vector2.zero());
    wrapper.print("Rotation: "..(Cam.Rotation:ToString()), Vector2.yAxis() * 15);
    wrapper.print("FPS: "..love.timer.getFPS(), Vector2.yAxis() * 30);
    wrapper.print("X: Red", Vector2.yAxis() * 60);
    wrapper.print("Y: Green", Vector2.yAxis() * 75);
    wrapper.print("Z: Blue", Vector2.yAxis() * 90);
end;
