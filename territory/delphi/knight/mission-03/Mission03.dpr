program Mission03;

// Author: Douglas Mezuraro
// Modification: 21/12/2020
// Level: Knight
// Mission: 03

uses
  MidasLib,
  Vcl.Forms,
  Form.Main in 'src\Form\Form.Main.pas' {Main},
  Helper.ZipFile in 'src\Helper\Helper.ZipFile.pas',
  Impl.Zip in 'src\Impl\Impl.Zip.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMain, Main);
  Application.Run;

  ReportMemoryLeaksOnShutdown := True;
end.

