unit Calculator;

interface

{ Square }
function SquareArea(const Side: Extended): Extended; stdcall;
function SquarePerimeter(const Side: Extended): Extended; stdcall;

{ Circle }
function CircleArea(const Radius: Extended): Extended; stdcall;
function CirclePerimeter(const Radius: Extended): Extended; stdcall;

{ Rectangle }
function RectangleArea(const SideA, SideB: Extended): Extended; stdcall;
function RectanglePerimeter(const SideA, SideB: Extended): Extended; stdcall;

{ Equilateral Triangle }
function EquilateralTriangleArea(const Side: Extended): Extended; stdcall;
function EquilateralTrianglePerimeter(const Side: Extended): Extended; stdcall;

implementation

function SquareArea(const Side: Extended): Extended;
begin
  Result := Side * Side;
end;

function SquarePerimeter(const Side: Extended): Extended;
const
  Sides = 4;
begin
  Result := Side * Sides;
end;

function CircleArea(const Radius: Extended): Extended;
begin
  Result := Pi * Sqr(Radius);
end;

function CirclePerimeter(const Radius: Extended): Extended;
var
  Diameter: Extended;
begin
  Diameter := 2 * Radius;
  Result := Pi * Diameter;
end;

function RectangleArea(const SideA, SideB: Extended): Extended;
begin
  Result := SideA * SideB;
end;

function RectanglePerimeter(const SideA, SideB: Extended): Extended;
const
  Sides = 2;
begin
  Result := Sides * (SideA + SideB);
end;

function EquilateralTriangleArea(const Side: Extended): Extended;
const
  Sides = 3;
begin
  Result := (Sqr(Side) * Sqrt(Sides)) / 4;
end;

function EquilateralTrianglePerimeter(const Side: Extended): Extended;
const
  Sides = 3;
begin
  Result := Side * Sides;
end;

exports
  SquareArea,
  SquarePerimeter,
  CircleArea,
  CirclePerimeter,
  RectangleArea,
  RectanglePerimeter,
  EquilateralTriangleArea,
  EquilateralTrianglePerimeter;

end.

