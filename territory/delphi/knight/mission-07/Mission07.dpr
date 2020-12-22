program Mission07;

// Author: Douglas Mezuraro
// Modification: 21/12/2020
// Level: Knight
// Mission: 07

uses
  System.SysUtils,
  Vcl.Forms,
  Form.Main in 'src\Form\Form.Main.pas' {Main},
  Email.Sender in 'src\Email\Email.Sender.pas',
  Email.DTO in 'src\Email\Email.DTO.pas',
  Email.Wrapper in 'src\Email\Email.Wrapper.pas',
  Impl.Cryptography in 'src\Impl\Impl.Cryptography.pas';

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

