program MestreDosCodigos;

uses
  Vcl.Forms,
  Forms.Main in 'forms\Forms.Main.pas' {Main},
  Utils.DynamicArray in 'utils\Utils.DynamicArray.pas',
  Model.Person in 'models\Model.Person.pas',
  Utils.DynamicArrayInterface in 'utils\Utils.DynamicArrayInterface.pas',
  Model.Gender in 'models\Model.Gender.pas',
  Utils.Vcl in 'utils\Utils.Vcl.pas',
  Forms.Crud in 'forms\Forms.Crud.pas' {Crud},
  Forms.Exercise1 in 'forms\Forms.Exercise1.pas' {Exercise1},
  Utils.Messages in 'utils\Utils.Messages.pas',
  Utils.Constants in 'utils\Utils.Constants.pas',
  Utils.Date in 'utils\Utils.Date.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMain, Main);
  Application.Run;

  ReportMemoryLeaksOnShutdown := True;
end.
