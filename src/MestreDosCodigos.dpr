program MestreDosCodigos;

uses
  Vcl.Forms,
  Forms.Main in 'form\Forms.Main.pas' {Main},
  Forms.Crud in 'form\Forms.Crud.pas' {Crud},
  Forms.Exercise1 in 'form\Forms.Exercise1.pas' {Exercise1},
  Utils.Collections.API in 'util\Utils.Collections.API.pas',
  Utils.Constants in 'util\Utils.Constants.pas',
  Helpers.DateTime in 'helper\Helpers.DateTime.pas',
  Utils.Collections.DynamicArray in 'util\Utils.Collections.DynamicArray.pas',
  Utils.Messages in 'util\Utils.Messages.pas',
  Helpers.Form in 'helper\Helpers.Form.pas',
  Model.Person in 'model\Model.Person.pas',
  Model.Gender in 'model\Model.Gender.pas',
  Helpers.Component in 'helper\Helpers.Component.pas',
  Utils.TagRole in 'util\Utils.TagRole.pas',
  Helpers.WinControl in 'helper\Helpers.WinControl.pas',
  Helpers.CustomControl in 'helper\Helpers.CustomControl.pas',
  Helpers.DateTimePicker in 'helper\Helpers.DateTimePicker.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMain, Main);
  Application.Run;

  ReportMemoryLeaksOnShutdown := True;
end.
