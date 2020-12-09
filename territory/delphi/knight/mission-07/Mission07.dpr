program Mission07;

uses
  Vcl.Forms,
  Form.Main in 'Form.Main.pas' {Main},
  Email.Sender in 'src\Email\Email.Sender.pas',
  Impl.Cryptography in 'Impl.Cryptography.pas',
  Email.DTO in 'src\Email\Email.DTO.pas',
  Email.Wrapper in 'src\Email\Email.Wrapper.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMain, Main);
  Application.Run;
end.
