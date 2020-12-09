program Mission07;

//       Author : Douglas Mezuraro
// Modification : 09/12/2020
//        Level : Knight
//      Mission : 07
//    Objective : Neste exerc�cio, voc� dever� criar uma aplica��o VCL para envio de e-mails
//                utilizando o Indy. O formul�rio dever� disponibilizar campos de texto para informar
//                o endere�o SMTP, usu�rio, senha, porta e configura��es de SSL. Al�m disso, adicione
//                tamb�m um campo para informar o anexo e um componente TMemo para informar o corpo
//                da mensagem, no qual poder� aceitar comandos HTML. Fa�a a chamada do envio do e-mail
//                em uma Anonymous Thread.


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

