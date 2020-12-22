program Mission17;

//       Author : Douglas Mezuraro
// Modification : 10/12/2020
//        Level : Knight
//      Mission : 17
//    Objective : Na aplica��o do exerc�cio 13, a classe TfrmSalvadorDePessoas possui o m�todo
//                PegarPessoaService, que devolve o servi�o criado e com o reposit�rio j� injetado.
//                Crie uma nova classe que implemente IPessoaRepository, dando-lhe o nome que
//                preferir. Implemente o m�todo PersistirDados de modo que os dados sempre sejam
//                salvos. Uma vez que a classe tenha sido escrita, utilizando Diretivas de compila��o,
//                altere o fluxo do sistema. Quando o sistema estiver compilando com a diretiva
//                PERSISTENCIA_PADRAO, o sistema utilizar� a vers�o do repository original. Do
//                contr�rio, o sistema utilizar� a persist�ncia escrita por voc�.

uses
  System.SysUtils,
  Vcl.Forms,
  uPessoa in '..\mission-13\src\3rdParty\AppDesktop\uPessoa.pas',
  uPessoaForm in '..\mission-13\src\3rdParty\AppDesktop\uPessoaForm.pas' {frmSalvadorDePessoas},
  uPessoaJsonRepository.Impl in '..\mission-13\src\3rdParty\AppDesktop\uPessoaJsonRepository.Impl.pas',
  uPessoaRepository.Impl in '..\mission-13\src\3rdParty\AppDesktop\uPessoaRepository.Impl.pas',
  uPessoaRepository in '..\mission-13\src\3rdParty\AppDesktop\uPessoaRepository.pas',
  uPessoaService.Impl in '..\mission-13\src\3rdParty\AppDesktop\uPessoaService.Impl.pas',
  uPessoaService in '..\mission-13\src\3rdParty\AppDesktop\uPessoaService.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmSalvadorDePessoas, frmSalvadorDePessoas);
  Application.Run;

{$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown := DebugHook.ToBoolean;
{$WARN SYMBOL_PLATFORM DEFAULT}
end.

