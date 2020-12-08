program Mission11;

//       Author : Douglas Mezuraro
// Modification : 08/12/2020
//        Level : Knight
//      Mission : 11
//    Objective : Crie uma aplicação VCL que permita a consulta dos dados de endereço através do CEP.
//                Para isso, importe o WSDL dos Correios
//                https://apps.correios.com.br/SigepMasterJPA/AtendeClienteService/AtendeCliente?wsdl.
//                No formulário, adicione um campo de texto para informar o CEP e apresente os dados
//                do endereço (logradouro, bairro, cidade e UF).

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
