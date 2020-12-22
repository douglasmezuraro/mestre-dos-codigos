program Mission16;

//       Author : Douglas Mezuraro
// Modification : 10/12/2020
//        Level : Knight
//      Mission : 16
//    Objective : Na aplica��o do exerc�cio 13, a unit uPessoa est� emitindo um warning. Sem alterar
//                o c�digo da classe, fa�a com que o warning n�o seja mais emitido e adicione um
//                coment�rio explicando o que o causava e de qual forma o c�digo poderia ser reescrito
//                para que ele n�o fosse emitido.

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  uPessoa in '..\mission-13\src\3rdParty\AppDesktop\uPessoa.pas';

begin
  try
    Writeln('O warning acontecia devido a class "TPessoa" ter a section "published".');
    Writeln('Para corrigir o warning deve ser inclu�do a diretiva {$M+} na classe para que o RTTI');
    Writeln('consiga ler as propriedades/m�todos da se��o "published".');
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

