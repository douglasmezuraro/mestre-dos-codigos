program Mission14;

// Author: Douglas Mezuraro
// Modification: 21/12/2020
// Level: Knight
// Mission: 14

{$R *.dres}

uses
  Vcl.Forms,
  System.SysUtils,
  Form.Main in 'src\Form\Form.Main.pas' {Main},
  DataModule.Global in 'src\DataModule\DataModule.Global.pas' {DM};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMain, Main);
  Application.CreateForm(TDM, DM);
  Application.Run;

{$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown := DebugHook.ToBoolean;
{$WARN SYMBOL_PLATFORM DEFAULT}
end.
