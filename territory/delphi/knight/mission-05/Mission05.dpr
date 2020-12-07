program Mission05;

//       Author : Douglas Mezuraro
// Modification : 07/12/2020
//        Level : Knight
//      Mission : 05
//    Objective : Em uma aplicação console ou VCL, faça um laço de repetição de 1 até 1 milhão
//                listando os números primos encontrados, utilizando o TParallel da biblioteca 
//                System.Threading para paralelizar as iterações.

{$APPTYPE CONSOLE}

{$R *.res}

uses
  MidasLib,
  System.SysUtils,
  Impl.Methods in 'src\Impl.Methods.pas';

procedure PrintPrimeNumbers;
var
  LNumber: Int64;
begin  
  for LNumber in TMethods.ListPrimeNumbers(1, 1000000) do
  begin
    Writeln(LNumber);
  end;
end;

begin  
  WriteLn('Processing prime numbers');
  PrintPrimeNumbers;
  Readln;

{$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown := DebugHook.ToBoolean;
{$WARN SYMBOL_PLATFORM DEFAULT}
end.

