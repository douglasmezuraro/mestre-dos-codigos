program Mission12;

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
  Test.Operations in 'Test.Operations.pas',
  Impl.Operations in 'Impl.Operations.pas';

procedure Run;
var
  Runner: ITestRunner;
  Results: IRunResults;
  Logger: ITestLogger;
  NUnitLogger: ITestLogger;
begin
  TDUnitX.CheckCommandLine;
  Runner := TDUnitX.CreateRunner;
  Runner.UseRTTI := True;
  Logger := TDUnitXConsoleLogger.Create(true);
  Runner.AddLogger(Logger);
  NUnitLogger := TDUnitXXMLNUnitFileLogger.Create(TDUnitX.Options.XMLOutputFile);
  Runner.AddLogger(NUnitLogger);
  Runner.FailsOnNoAsserts := True;

  Results := Runner.Execute;
  if not Results.AllPassed then
    System.ExitCode := EXIT_ERRORS;

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
  except
    on E: Exception do
      System.Writeln(E.ClassName, ': ', E.Message);
  end;
end.
