program Mission02;

// Author: Douglas Mezuraro
// Last modification: 06/12/2020
// Level: Knight
// Mission: 02
// Objective: Desenvolva uma aplicação VCL capaz de listar os programas instalados no computador
// através da leitura do registro do Windows. Para isso, utilize a classe TRegistry e apresente,
// em uma TDBGrid, o nome do programa, versão e a empresa.

uses
  MidasLib,
  Vcl.Forms,
  System.SysUtils,
  Form.Main in 'src\Form\Form.Main.pas' {Main},
  Impl.ProgramInfo in 'src\Impl\Impl.ProgramInfo.pas',
  Impl.ProgramList in 'src\Impl\Impl.ProgramList.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMain, Main);
  Application.Run;

{$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown := DebugHook.ToBoolean;
{$WARN SYMBOL_PLATFORM DEFAULT}
end.

