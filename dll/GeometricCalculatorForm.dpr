program GeometricCalculatorForm;

uses
  Vcl.Forms,
  GeometricCalculator.API in 'src\GeometricCalculator.API.pas',
  GeometricCalculator.GeometricForm in 'src\GeometricCalculator.GeometricForm.pas',
  GeometricCalculator.CalculationType in 'src\GeometricCalculator.CalculationType.pas',
  Form.GeometricCalculator in 'src\Form.GeometricCalculator.pas' {GeometricCalculator};

{$R *.res}

var
  MainForm: TGeometricCalculator;

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TGeometricCalculator, MainForm);
  Application.Run;
end.
