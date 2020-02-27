program Mission06;

uses
  Vcl.Forms,
  Form.Main in 'Form.Main.pas' {Main},
  Impl.Downloader in 'Impl.Downloader.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMain, Main);
  Application.Run;

  ReportMemoryLeaksOnShutdown := True;
end.

