program Mission04;

uses
  Vcl.Forms,
  Form.Main in 'Form.Main.pas' {Main},
  Impl.Utils in 'Impl.Utils.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMain, Main);
  Application.Run;

  ReportMemoryLeaksOnShutdown := True;
end.
