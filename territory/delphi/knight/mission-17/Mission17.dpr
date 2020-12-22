program Mission17;

//       Author : Douglas Mezuraro
// Modification : 10/12/2020
//        Level : Knight
//      Mission : 17
//    Objective : Na aplicação do exercício 13, a classe TfrmSalvadorDePessoas possui o método
//                PegarPessoaService, que devolve o serviço criado e com o repositório já injetado.
//                Crie uma nova classe que implemente IPessoaRepository, dando-lhe o nome que
//                preferir. Implemente o método PersistirDados de modo que os dados sempre sejam
//                salvos. Uma vez que a classe tenha sido escrita, utilizando Diretivas de compilação,
//                altere o fluxo do sistema. Quando o sistema estiver compilando com a diretiva
//                PERSISTENCIA_PADRAO, o sistema utilizará a versão do repository original. Do
//                contrário, o sistema utilizará a persistência escrita por você.

uses
  System.SysUtils,
  Vcl.Forms;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Run;

{$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown := DebugHook.ToBoolean;
{$WARN SYMBOL_PLATFORM DEFAULT}
end.
