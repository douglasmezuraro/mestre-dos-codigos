unit GeometricCalculator.GeometricForm;

interface

uses
  System.SysUtils;

type
  TGeometricForm = (gfSquare, gfCircle, gfRhombus, gfEquilateralTriangle);

const
  GeometricFormMap: array[TGeometricForm] of string = (
    'Quadrado',
    'C�rculo',
    'Losango',
    'Tri�ngulo equil�tero');

  GeometricInputCaptionMap: array[TGeometricForm] of string = (
    'Lado',
    'Raio',
    'Diagonal',
    'Lado');

implementation

end.

