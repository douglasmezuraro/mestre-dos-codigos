program Mission10;

//       Author : Douglas Mezuraro
// Modification : 08/12/2020
//        Level : Knight
//      Mission : 10
//    Objective : Em uma aplica��o VCL, fa�a a importa��o do WSDL do site RegExLib
//                http://regexlib.com/WebServices.asmx?WSDL. Este WebService cont�m um cat�logo
//                de express�es regulares para serem utilizadas. Fa�a um acesso ao WebService e
//                consulte a express�o regular n� 3122, referente a valida��o de e-mails. Em
//                seguida, utilize essa express�o para validar um endere�o de e-mail informado pelo
//                usu�rio, apresentando o texto "e-mail v�lido" ou "e-mail inv�lido" conforme o
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

