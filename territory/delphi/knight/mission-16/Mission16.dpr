program Mission16;

// Author: Douglas Mezuraro
// Modification: 21/12/2020
// Level: Knight
// Mission: 16

{$APPTYPE CONSOLE}

{$R *.res}

uses
  MidasLib,
  System.SysUtils,
  uPessoa in '..\mission-13\src\3rdParty\AppDesktop\uPessoa.pas';

begin
  Writeln('O warning acontecia devido a class "TPessoa" ter a section "published".');
  Writeln('Para corrigir o warning deve ser incluído a diretiva {$M+} na classe para que o RTTI');
  Writeln('consiga ler as propriedades/métodos da seção "published".');
  Writeln(string.Empty);
  Writeln('Press any key to exit.');
  Readln;

{$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown := DebugHook.ToBoolean;
{$WARN SYMBOL_PLATFORM DEFAULT}
end.

