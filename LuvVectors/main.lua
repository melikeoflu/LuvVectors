local Vector2 = require("Vector2");
local Vector3 = require("Vector3");
local graphics = require("graphics-wrapper");

function love.load()
    Player = {
        Position = Vector2.zero();
        MoveDirection = Vector2.zero();
        Speed = 5;
        Radius = 50;
    };
    XColor = Vector3.xAxis();           -- Vector3[1, 0, 0] -> Red
    YColor = Vector3.yAxis();           -- Vector3[0, 1, 0] -> Green
    WColor = Vector3.XY();              -- Vector3[1, 1, 0] -> Red + Green = Yellow
    MDColor = Vector3.new(1/2, 1/2, 1);
end;

function love.update(dt)
    Player.MoveDirection = Vector2.zero();
    
    if love.keyboard.isDown("a") then
        Player.Position.X = Player.Position.X - Player.Speed;
        Player.MoveDirection.X = -1;
    end;
    if love.keyboard.isDown("s") then
        Player.Position.Y = Player.Position.Y + Player.Speed;
        Player.MoveDirection.Y = 1;
    end;
    if love.keyboard.isDown("d") then
        Player.Position.X = Player.Position.X + Player.Speed;
        Player.MoveDirection.X = 1;
    end;
    if love.keyboard.isDown("w") then
        Player.Position.Y = Player.Position.Y - Player.Speed;
        Player.MoveDirection.Y = -1;
    end;

    Player.Position:Normalize();
end;

function love.draw()
    graphics.circle("line", Player.Position, Player.Radius);
    graphics.print("Position: "..Player.Position:ToString(), Vector2.zero());
    graphics.print("MoveDirection: "..Player.MoveDirection:ToString(), Vector2.yAxis() * 15);
 
    graphics.setColor(XColor);

    graphics.line(Vector2.zero(), Player.Position:OnX());
    graphics.line(Player.Position:OnY(), Player.Position);

    graphics.setColor(YColor);

    graphics.line(Vector2.zero(), Player.Position:OnY());
    graphics.line(Player.Position:OnX(), Player.Position);

    graphics.setColor(MDColor);
    graphics.line(Player.Position, (Player.Position + (Player.MoveDirection * Player.Radius)/Player.MoveDirection:Magnitude()));
    
    graphics.setColor(WColor);

    graphics.line(Vector2.zero(), Player.Position);
    
    graphics.setColor(Vector3.one());
end;