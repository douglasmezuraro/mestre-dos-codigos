program Mission03;

// Author: Douglas Mezuraro
// Modification: 21/12/2020
// Level: Knight
// Mission: 03

uses
  MidasLib,
  Vcl.Forms,
  System.SysUtils,
  Form.Main in 'src\Form\Form.Main.pas' {Main},
  Helper.ZipFile in 'src\Helper\Helper.ZipFile.pas',
  Zip.Wrapper in 'src\Zip\Zip.Wrapper.pas';

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

