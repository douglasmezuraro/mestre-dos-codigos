program Mission10;

uses
  Vcl.Forms,
  Form.Main in 'Form.Main.pas' {Main},
  WebServices in 'WebServices.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMain, Main);
  Application.Run;

{$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown := WordBool(DebugHook);
{$WARN SYMBOL_PLATFORM DEFAULT}
end.
