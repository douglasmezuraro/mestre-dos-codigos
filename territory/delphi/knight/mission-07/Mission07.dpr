program Mission07;

uses
  MidasLib,
  System.SysUtils,
  Vcl.Forms,
  Form.Main in 'src\Form\Form.Main.pas' {Main},
  Email.Sender in 'src\Email\Email.Sender.pas',
  Email.DTO in 'src\Email\Email.DTO.pas',
  Email in 'src\Email\Email.pas',
  Email.Cryptography in 'src\Email\Email.Cryptography.pas',
  Email.Exceptions in 'src\Email\Email.Exceptions.pas';

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

