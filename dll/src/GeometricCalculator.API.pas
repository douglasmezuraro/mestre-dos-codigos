unit GeometricCalculator.API;

interface

const
  DLLName = 'GeometricCalculatorDLL.dll';

{ Square }
function SquareArea(const Side: Extended): Extended; stdcall; external DLLName;
function SquarePerimeter(const Side: Extended): Extended; stdcall; external DLLName;

{ Circle }
function CircleArea(const Radius: Extended): Extended; stdcall; external DLLName;
function CirclePerimeter(const Radius: Extended): Extended; stdcall; external DLLName;

{ Rectangle }
function RectangleArea(const SideA, SideB: Extended): Extended; stdcall; external DLLName;
function RectanglePerimeter(const SideA, SideB: Extended): Extended; stdcall; external DLLName;

{ Equilateral Triangle }
function EquilateralTriangleArea(const Side: Extended): Extended; stdcall; external DLLName;
function EquilateralTrianglePerimeter(const Side: Extended): Extended; stdcall; external DLLName;

implementation

end.

