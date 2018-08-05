program MestreDosCodigos;

uses
  Vcl.Forms,
  MainForm in 'forms\MainForm.pas' {Form1},
  Utils.DynamicArray in 'utils\Utils.DynamicArray.pas',
  Model.Person in 'models\Model.Person.pas',
  Forms.ExerciseOne in 'forms\Forms.ExerciseOne.pas' {ExerciseOne},
  Utils.DynamicArrayInterface in 'utils\Utils.DynamicArrayInterface.pas',
  Model.Gender in 'models\Model.Gender.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;

  ReportMemoryLeaksOnShutdown := True;
end.
