program Mission08;

uses
  Vcl.Forms,
  Main.Form in 'Main.Form.pas' {Main},
  Helper.DBGrid in 'Helper.DBGrid.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMain, Main.Form.Main);
  Application.Run;

{$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown := WordBool(DebugHook);
{$WARN SYMBOL_PLATFORM DEFAULT}
end.

