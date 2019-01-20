unit GeometricCalculator.API;

interface

{ Square }
function SquareArea(const Side: Extended): Extended; stdcall; external 'GeometricCalculator.dll';
function SquarePerimeter(const Side: Extended): Extended; stdcall; external 'GeometricCalculator.dll';

{ Circle }
function CircleArea(const Radius: Extended): Extended; stdcall; external 'GeometricCalculator.dll';
function CirclePerimeter(const Radius: Extended): Extended; stdcall; external 'GeometricCalculator.dll';

{ Rhombus }
function RhombusArea(const DiagonalA, DiagonalB: Extended): Extended; stdcall; external 'GeometricCalculator.dll';
function RhombusPerimeter(const DiagonalA, DiagonalB: Extended): Extended; stdcall; external 'GeometricCalculator.dll';

{ Equilateral Triangle }
function EquilateralTriangleArea(const Side: Extended): Extended; stdcall; external 'GeometricCalculator.dll';
function EquilateralTrianglePerimeter(const Side: Extended): Extended; stdcall; external 'GeometricCalculator.dll';

implementation

end.

