program Mission13;

//       Author : Douglas Mezuraro
// Modification : 09/12/2020
//        Level : Knight
//      Mission : 13
//    Objective : Sistemas, para serem test�veis, precisam possuir baixo acoplamento. Assim, durante
//                a etapa de testes, � poss�vel, por exemplo, substituir a camada de persist�ncia de
//                dados por um mock que �far� de conta� que os dados foram salvos com sucesso. Ou ainda,
//                emitir uma exce��o simulando um erro na camada de infraestrutura. Para constru��o de
//                mocks e stubs, existe uma biblioteca gratuita chamada Delphi-Mocks
//                https://github.com/VSoftTechnologies/Delphi-Mocks. Utilizando a biblioteca
//                Delphi-Mocks, escreva os teste unit�rios para a classe TPessoaService. Utilize o
//                framework Delphi-Mocks para mockar o reposit�rio. N�o ser�o aceitos c�digos implementados
//                com classes fake. Os testes devem incluir:
//                  - O comportamento de quando TPessoa est� inv�lido;
//                  - Garantir que o m�todo de TPessoaRepository n�o ser� chamado quando TPessoa n�o estiver v�lida;
//                  - Garantir que o m�todo de TPessoaRepository ser� chamado quando TPessoa estiver v�lido;
//                  - O comportamento de TPessoaService quando TPessoaRepository emite uma exce��o EDatabaseError;
//                  - O comportamento de TPessoaService, caso TPessoaRepository emita qualquer outra exce��o que n�o seja EDatabaseError;
//                O c�digo para esta resolu��o est� dispon�vel em:
//                https://github.com/db1group/mestre-dos-codigos/tree/master/docs/files/cavaleiro-delphi/projeto

{$IFNDEF TESTINSIGHT}
{$APPTYPE CONSOLE}
{$ENDIF}{$STRONGLINKTYPES ON}
{$WARN DUPLICATE_CTOR_DTOR OFF}

uses
  System.SysUtils,
{$IFDEF TESTINSIGHT}
  TestInsight.DUnitX,
{$ENDIF }
  DUnitX.Loggers.Console,
  DUnitX.Loggers.Xml.NUnit,
  DUnitX.TestFramework,
  Test.Service.Person in 'src\Test\Test.Service.Person.pas',
  uPessoa in 'src\3rdParty\AppDesktop\uPessoa.pas',
  uPessoaRepository.Impl in 'src\3rdParty\AppDesktop\uPessoaRepository.Impl.pas',
  uPessoaRepository in 'src\3rdParty\AppDesktop\uPessoaRepository.pas',
  uPessoaService.Impl in 'src\3rdParty\AppDesktop\uPessoaService.Impl.pas',
  uPessoaService in 'src\3rdParty\AppDesktop\uPessoaService.pas',
  Delphi.Mocks.AutoMock in 'src\3rdParty\Delphi-Mocks\Delphi.Mocks.AutoMock.pas',
  Delphi.Mocks.Behavior in 'src\3rdParty\Delphi-Mocks\Delphi.Mocks.Behavior.pas',
  Delphi.Mocks.Expectation in 'src\3rdParty\Delphi-Mocks\Delphi.Mocks.Expectation.pas',
  Delphi.Mocks.Helpers in 'src\3rdParty\Delphi-Mocks\Delphi.Mocks.Helpers.pas',
  Delphi.Mocks.Interfaces in 'src\3rdParty\Delphi-Mocks\Delphi.Mocks.Interfaces.pas',
  Delphi.Mocks.MethodData in 'src\3rdParty\Delphi-Mocks\Delphi.Mocks.MethodData.pas',
  Delphi.Mocks.ObjectProxy in 'src\3rdParty\Delphi-Mocks\Delphi.Mocks.ObjectProxy.pas',
  Delphi.Mocks.ParamMatcher in 'src\3rdParty\Delphi-Mocks\Delphi.Mocks.ParamMatcher.pas',
  Delphi.Mocks in 'src\3rdParty\Delphi-Mocks\Delphi.Mocks.pas',
  Delphi.Mocks.Proxy in 'src\3rdParty\Delphi-Mocks\Delphi.Mocks.Proxy.pas',
  Delphi.Mocks.Proxy.TypeInfo in 'src\3rdParty\Delphi-Mocks\Delphi.Mocks.Proxy.TypeInfo.pas',
  Delphi.Mocks.ReturnTypePatch in 'src\3rdParty\Delphi-Mocks\Delphi.Mocks.ReturnTypePatch.pas',
  Delphi.Mocks.Utils in 'src\3rdParty\Delphi-Mocks\Delphi.Mocks.Utils.pas',
  Delphi.Mocks.Validation in 'src\3rdParty\Delphi-Mocks\Delphi.Mocks.Validation.pas',
  Delphi.Mocks.VirtualInterface in 'src\3rdParty\Delphi-Mocks\Delphi.Mocks.VirtualInterface.pas',
  Delphi.Mocks.VirtualMethodInterceptor in 'src\3rdParty\Delphi-Mocks\Delphi.Mocks.VirtualMethodInterceptor.pas',
  Delphi.Mocks.WeakReference in 'src\3rdParty\Delphi-Mocks\Delphi.Mocks.WeakReference.pas',
  Delphi.Mocks.When in 'src\3rdParty\Delphi-Mocks\Delphi.Mocks.When.pas';

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