unit GeometricCalculator.GeometricForm;

interface

type
  TGeometricForm = (gfSquare, gfCircle, gfRectangle, gfEquilateralTriangle);

const
  GeometricFormMap: array[TGeometricForm] of string = (
    'Quadrado',
    'Círculo',
    'Retângulo',
    'Triângulo equilátero');

  GeometricInputCaptionMap: array[TGeometricForm] of string = (
    'Lado',
    'Raio',
    'Lado',
    'Lado');

implementation

end.

