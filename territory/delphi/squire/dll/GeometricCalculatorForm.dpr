program GeometricCalculatorForm;

uses
  Vcl.Forms,
  API in 'src\API.pas',
  GeometricForm in 'src\GeometricForm.pas',
  CalculationType in 'src\CalculationType.pas',
  Form in 'src\Form.pas' {MainForm},
  ExtensiveNumber in 'src\ExtensiveNumber.pas';

{$R *.res}

var
  MainForm: TMainForm;

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
