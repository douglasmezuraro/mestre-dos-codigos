program Mission07;

uses
  Vcl.Forms,
  Form.Main in 'Form.Main.pas' {Main},
  Impl.EmailSender in 'Impl.EmailSender.pas',
  Impl.Cryptography in 'Impl.Cryptography.pas',
  Impl.EmailSender.Types in 'Impl.EmailSender.Types.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMain, Main);
  Application.Run;
end.
