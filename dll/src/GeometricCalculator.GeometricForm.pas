unit GeometricCalculator.GeometricForm;

interface

uses
  System.SysUtils;

type
  TGeometricForm = (gfSquare, gfCircle, gfRhombus, gfEquilateralTriangle);

const
  GeometricFormMap: array[TGeometricForm] of string = (
    'Quadrado',
    'Círculo',
    'Losango',
    'Triângulo equilátero');

  GeometricInputCaptionMap: array[TGeometricForm] of string = (
    'Lado',
    'Raio',
    'Diagonal',
    'Lado');

implementation

end.

