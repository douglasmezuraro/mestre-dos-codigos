unit GeometricCalculator.GeometricForm;

interface

type
  TGeometricForm = (gfSquare, gfCircle, gfRectangle, gfEquilateralTriangle);

const
  GeometricFormMap: array[TGeometricForm] of string = (
    'Quadrado',
    'C�rculo',
    'Ret�ngulo',
    'Tri�ngulo equil�tero');

  GeometricInputCaptionMap: array[TGeometricForm] of string = (
    'Lado',
    'Raio',
    'Lado',
    'Lado');

implementation

end.

