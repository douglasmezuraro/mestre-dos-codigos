program MestreDosCodigos;

uses
  Vcl.Forms,
  Collections.API in 'src\collections\Collections.API.pas',
  Collections.DynamicArray in 'src\collections\Collections.DynamicArray.pas',
  Helper.DateTime in 'src\helper\Helper.DateTime.pas',
  Vcl.Helpers in 'src\helper\Vcl.Helpers.pas',
  Model.Gender in 'src\model\Model.Gender.pas',
  Model.Person in 'src\model\Model.Person.pas',
  Util.Messages in 'src\util\Util.Messages.pas',
  Form.Crud in 'src\form\Form.Crud.pas' {Crud},
  Form.Exercise1 in 'src\form\Form.Exercise1.pas' {Exercise1},
  Form.Main in 'src\form\Form.Main.pas' {Main},
  Form.GeometricCalculator in 'src\form\Form.GeometricCalculator.pas' {GeometricCalculator},
  GeometricCalculator.API in 'src\3rdParty\GeometricCalculator\src\GeometricCalculator.API.pas',
  GeometricCalculator.GeometricForm in 'src\3rdParty\GeometricCalculator\src\GeometricCalculator.GeometricForm.pas',
  GeometricCalculator.CalculationType in 'src\3rdParty\GeometricCalculator\src\GeometricCalculator.CalculationType.pas',
  Util in 'src\util\Util.pas';

{$R *.res}

var
  Main: TMain;

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMain, Main);
  Application.Run;

  ReportMemoryLeaksOnShutdown := True;
end.

