program Mission11;

//       Author : Douglas Mezuraro
// Modification : 08/12/2020
//        Level : Knight
//      Mission : 11
//    Objective : Crie uma aplica��o VCL que permita a consulta dos dados de endere�o atrav�s do CEP.
//                Para isso, importe o WSDL dos Correios
//                https://apps.correios.com.br/SigepMasterJPA/AtendeClienteService/AtendeCliente?wsdl.
//                No formul�rio, adicione um campo de texto para informar o CEP e apresente os dados
//                do endere�o (logradouro, bairro, cidade e UF).

uses
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
