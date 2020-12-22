program Mission16;

//       Author : Douglas Mezuraro
// Modification : 10/12/2020
//        Level : Knight
//      Mission : 16
//    Objective : Na aplicação do exercício 13, a unit uPessoa está emitindo um warning. Sem alterar
//                o código da classe, faça com que o warning não seja mais emitido e adicione um
//                comentário explicando o que o causava e de qual forma o código poderia ser reescrito
//                para que ele não fosse emitido.

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  uPessoa in '..\mission-13\src\3rdParty\AppDesktop\uPessoa.pas';

begin
  try
    Writeln('O warning acontecia devido a class "TPessoa" ter a section "published".');
    Writeln('Para corrigir o warning deve ser incluído a diretiva {$M+} na classe para que o RTTI');
    Writeln('consiga ler as propriedades/métodos da seção "published".');
    Readln;
  except
    on Exception: Exception do
    begin
      Writeln(Exception.ClassName, ': ', Exception.Message);
    end;
  end;

{$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown := DebugHook.ToBoolean;
{$WARN SYMBOL_PLATFORM DEFAULT}
end.

