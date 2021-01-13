program Mission11;

// Author: Douglas Mezuraro
// Modification: 21/12/2020
// Level: Knight
// Mission: 11

uses
  MidasLib,
  Vcl.Forms,
  System.SysUtils,
  WebService.Correios in 'src\WebService\WebService.Correios.pas',
  Form.Main in 'src\Form\Form.Main.pas' {Main};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMain, Main);
  Application.Run;

{$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown := DebugHook.ToBoolean;
{$WARN SYMBOL_PLATFORM DEFAULT}
end.

