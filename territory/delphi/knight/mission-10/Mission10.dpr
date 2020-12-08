program Mission10;

//       Author : Douglas Mezuraro
// Modification : 08/12/2020
//        Level : Knight
//      Mission : 10
//    Objective : Em uma aplicação VCL, faça a importação do WSDL do site RegExLib
//                http://regexlib.com/WebServices.asmx?WSDL. Este WebService contém um catálogo
//                de expressões regulares para serem utilizadas. Faça um acesso ao WebService e
//                consulte a expressão regular nº 3122, referente a validação de e-mails. Em
//                seguida, utilize essa expressão para validar um endereço de e-mail informado pelo
//                usuário, apresentando o texto "e-mail válido" ou "e-mail inválido" conforme o
//                resultado.

uses
  Vcl.Forms,
  System.SysUtils,
  WebService.RegExLib in 'src\WebService\WebService.RegExLib.pas',
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

