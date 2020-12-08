program Mission12;

//       Author : Douglas Mezuraro
// Modification : 08/12/2020
//        Level : Knight
//      Mission : 12
//    Objective : Em uma aplicação console, defina uma classe chamada TOperacoes que contenha os
//                seguintes métodos:
//                  - OrdenarLetras: receba uma palavra como parâmetro e retorne um texto com as
//                                   letras ordenadas em ordem alfabética, sem espaços;
//                  - ContarOcorrencias: receba dois parâmetros (uma palavra e uma letra), e conte a
//                                       quantidade de ocorrências que a letra é encontrada na palavra,
//                                       retornando um número. Caso a palavra ou a letra estejam vazios,
//                                       levante uma exceção;
//                  - RemoverAcentos: receba uma palavra como parâmetro e remova todos os acentos
//                                    (por exemplo: "órgão" para "orgao"). Caso exista algum caracter
//                                    que não seja alfanumérico, uma exceção deve ser gerada.
//                Em seguida, implemente testes unitários para essa classe, testando inclusive as exceções.

{$IFNDEF TESTINSIGHT}
{$APPTYPE CONSOLE}
{$ENDIF}{$STRONGLINKTYPES ON}

uses
  System.SysUtils,
  {$IFDEF TESTINSIGHT}
  TestInsight.DUnitX,
  {$ENDIF }
  DUnitX.Loggers.Console,
  DUnitX.Loggers.Xml.NUnit,
  DUnitX.TestFramework,
  Impl.Operations in 'src\Impl\Impl.Operations.pas',
  Test.Operations in 'src\Test\Test.Operations.pas';

procedure Run;
var
  LRunner: ITestRunner;
  LResults: IRunResults;
  LLogger: ITestLogger;
  LUnitLogger: ITestLogger;
begin
  TDUnitX.CheckCommandLine;
  LRunner := TDUnitX.CreateRunner;
  LRunner.UseRTTI := True;
  LLogger := TDUnitXConsoleLogger.Create(true);
  LRunner.AddLogger(LLogger);
  LUnitLogger := TDUnitXXMLNUnitFileLogger.Create(TDUnitX.Options.XMLOutputFile);
  LRunner.AddLogger(LUnitLogger);
  LRunner.FailsOnNoAsserts := True;

  LResults := LRunner.Execute;
  if not LResults.AllPassed then
  begin
    System.ExitCode := EXIT_ERRORS;
  end;

{$IFNDEF CI}
  if TDUnitX.Options.ExitBehavior = TDUnitXExitBehavior.Pause then
  begin
    System.Write('Done.. press <Enter> key to quit.');
    System.Readln;
  end;
{$ENDIF}
end;

begin
{$IFDEF TESTINSIGHT}
  TestInsight.DUnitX.RunRegisteredTests;
  Exit;
{$ENDIF}
  try
    Run;
  {$WARN SYMBOL_PLATFORM OFF}
    ReportMemoryLeaksOnShutdown := DebugHook.ToBoolean;
  {$WARN SYMBOL_PLATFORM DEFAULT}
  except
    on Error: Exception do
    begin
      System.Writeln(Error.ClassName, ': ', Error.Message);
    end;
  end;
end.
