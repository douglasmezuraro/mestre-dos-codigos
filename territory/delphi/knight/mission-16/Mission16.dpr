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
  System.SysUtils;

begin
  try
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
