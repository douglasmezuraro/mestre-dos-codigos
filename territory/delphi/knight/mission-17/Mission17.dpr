program Mission17;

uses
  MidasLib,
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

