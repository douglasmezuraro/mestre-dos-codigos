unit GeometricCalculator.CalculationType;

interface

type
  TCalculationType = (ctArea, ctPerimeter);

const
  CalculationTypeMap: array[TCalculationType] of string = (
    'Área',
    'Perímetro');

implementation

end.

