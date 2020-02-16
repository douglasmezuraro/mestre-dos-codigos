program Mission02;

// Mission: 02
// Objective: build a VCL application that lists the data of the installed programs in a TDBGrid.
// The grid must contain the name, version and company of the program.

uses
  Vcl.Forms,
  Form.Main in 'Form.Main.pas' {Main},
  Impl.ProgramList in 'Impl.ProgramList.pas',
  Impl.ProgramInfo in 'Impl.ProgramInfo.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMain, Main);
  Application.Run;

  ReportMemoryLeaksOnShutdown := True;
end.
