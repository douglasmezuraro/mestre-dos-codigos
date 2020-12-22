program Mission04;

// Author: Douglas Mezuraro
// Modification: 21/12/2020
// Level: Knight
// Mission: 04

uses
  Vcl.Forms,
  Form.Main in 'src\Form\Form.Main.pas' {Main};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMain, Main);
  Application.Run;

  ReportMemoryLeaksOnShutdown := True;
end.
