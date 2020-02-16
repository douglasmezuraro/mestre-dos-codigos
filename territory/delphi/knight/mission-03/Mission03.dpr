program Mission03;

// Author: Douglas Mezuraro
// Last modification: 16/02/2020
// Level: Knight
// Mission: 03
// Objective: Build a VCL application that uses a "TZipFile" class to compress files that the user
// chooses. The user will be able to choose the name and location where the compressed file will be
// saved and will not be able to choose files with ".exe" extensions. The progress should be displayed
// on a progress bar.

uses
  Vcl.Forms,
  Form.Main in 'Form.Main.pas' {Main},
  Helper.ZipFile in 'Helper.ZipFile.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMain, Main);
  Application.Run;

  ReportMemoryLeaksOnShutdown := True;
end.
