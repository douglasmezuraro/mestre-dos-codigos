program MestreDosCodigos;

uses
  Vcl.Forms,
  Forms.Main in 'form\Forms.Main.pas' {Main},
  Forms.Crud in 'form\Forms.Crud.pas' {Crud},
  Forms.Exercise1 in 'form\Forms.Exercise1.pas' {Exercise1},
  Utils.Collections.API in 'util\Utils.Collections.API.pas',
  Helpers.DateTime in 'helper\Helpers.DateTime.pas',
  Utils.Collections.DynamicArray in 'util\Utils.Collections.DynamicArray.pas',
  Utils.Messages in 'util\Utils.Messages.pas',
  Model.Person in 'model\Model.Person.pas',
  Model.Gender in 'model\Model.Gender.pas',
  Helpers.WinControl in 'helper\Helpers.WinControl.pas',
  DataModule.Connection in 'data\DataModule.Connection.pas' {Global: TDataModule},
  Classes.DataBase.Config in 'classes\database\Classes.DataBase.Config.pas';

{$R *.res}

var
  Main: TMain;

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMain, Main);
  Application.CreateForm(TGlobal, Global);
  Application.Run;

  ReportMemoryLeaksOnShutdown := True;
end.

