unit GeometricCalculator.Calculator;

interface

{ Square }
function SquareArea(const Side: Extended): Extended; stdcall;
function SquarePerimeter(const Side: Extended): Extended; stdcall;

{ Circle }
function CircleArea(const Radius: Extended): Extended; stdcall;
function CirclePerimeter(const Radius: Extended): Extended; stdcall;

{ Rhombus }
function RhombusArea(const DiagonalA, DiagonalB: Extended): Extended; stdcall;
function RhombusPerimeter(const DiagonalA, DiagonalB: Extended): Extended; stdcall;

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
  NumberOfSides = 4;
begin
  Result := Side * NumberOfSides;
end;

function CircleArea(const Radius: Extended): Extended;
begin
  Result := Pi * Sqr(Radius);
end;

function CirclePerimeter(const Radius: Extended): Extended;
begin
  Result := 2 * Radius * Pi ;
end;

function RhombusArea(const DiagonalA, DiagonalB: Extended): Extended;
begin
  Result := (DiagonalA * DiagonalB) / 2;
end;

function RhombusPerimeter(const DiagonalA, DiagonalB: Extended): Extended;
begin
  Result := DiagonalA * 4;
end;

function EquilateralTriangleArea(const Side: Extended): Extended;
const
  NumberOfSides = 3;
begin
  Result := Sqr(Side) / Sqrt(NumberOfSides);
end;

function EquilateralTrianglePerimeter(const Side: Extended): Extended;
const
  NumberOfSides = 3;
begin
  Result := NumberOfSides * ((2 * Side) / Sqrt(NumberOfSides));
end;

exports
  SquareArea,
  SquarePerimeter,
  CircleArea,
  CirclePerimeter,
  RhombusArea,
  RhombusPerimeter,
  EquilateralTriangleArea,
  EquilateralTrianglePerimeter;

end.

