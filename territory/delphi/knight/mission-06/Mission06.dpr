program Mission06;

// Author: Douglas Mezuraro
// Modification: 21/12/2020
// Level: Knight
// Mission: 06

uses
  MidasLib,
  Vcl.Forms,
  System.SysUtils,
  Form.Main in 'src\Form\Form.Main.pas' {Main},
  Downloader.Thread in 'src\Downloader\Downloader.Thread.pas',
  Downloader.DTO in 'src\Downloader\Downloader.DTO.pas',
  Downloader in 'src\Downloader\Downloader.pas',
  Downloader.Exceptions in 'src\Downloader\Downloader.Exceptions.pas';

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

