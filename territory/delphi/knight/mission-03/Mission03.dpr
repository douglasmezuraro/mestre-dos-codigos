program Mission03;

uses
  MidasLib,
  System.SysUtils,
  Vcl.Forms,
  Form.Main in 'src\Form\Form.Main.pas' {Main},
  Helper.ZipFile in 'src\Helper\Helper.ZipFile.pas',
  Zip in 'src\Zip\Zip.pas',
  Zip.DTO in 'src\Zip\Zip.DTO.pas',
  Zip.Exceptions in 'src\Zip\Zip.Exceptions.pas',
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

