program MestreDosCodigos;

uses
  Vcl.Forms,
  Database.Config in 'src\database\Database.Config.pas',
  Database.DataModule in 'src\database\Database.DataModule.pas' {Global: TDataModule},
  Collections.API in 'src\collections\Collections.API.pas',
  Collections.DynamicArray in 'src\collections\Collections.DynamicArray.pas',
  Helper.DateTime in 'src\helper\Helper.DateTime.pas',
  Helper.WinControl in 'src\helper\Helper.WinControl.pas',
  Model.Gender in 'src\model\Model.Gender.pas',
  Model.Person in 'src\model\Model.Person.pas',
  Util.Messages in 'src\util\Util.Messages.pas',
  Form.Crud in 'src\form\Form.Crud.pas' {Crud},
  Form.Exercise1 in 'src\form\Form.Exercise1.pas' {Exercise1},
  Form.Main in 'src\form\Form.Main.pas' {Main},
  Helper.StringGrid in 'src\helper\Helper.StringGrid.pas';

{$R *.res}

var
  Main: TMain;
  Global: TGlobal;

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMain, Main);
  Application.CreateForm(TGlobal, Global);
  Application.Run;

  ReportMemoryLeaksOnShutdown := True;
end.

