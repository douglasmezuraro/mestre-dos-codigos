program Mission04;

// Author: Douglas Mezuraro
// Last modification: 17/02/2020
// Level: Knight
// Mission: 04
// Objective: Build a VCL application where you list all files contained in three directories
// chosen by the user, where the file names must be loaded using an "TTasks" array.

uses
  Vcl.Forms,
  Form.Main in 'Form.Main.pas' {Main},
  Impl.Utils in 'Impl.Utils.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMain, Main);
  Application.Run;

  ReportMemoryLeaksOnShutdown := True;
end.
