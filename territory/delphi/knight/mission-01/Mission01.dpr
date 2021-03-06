program Mission01;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  MidasLib,
  System.SysUtils,
  Repository.Cloud.API in 'src\Repository\Repository.Cloud.API.pas',
  Repository.Files.API in 'src\Repository\Repository.Files.API.pas',
  Repository.Impl in 'src\Repository\Repository.Impl.pas';

procedure SaveData;
var
  LData: TData;
begin
  LData := TData.Create;
  try
    LData.SaveCloudData;
    LData.SaveFileData;
  finally
    LData.Free;
  end;
end;

begin
  SaveData;

  Writeln(string.Empty);
  Writeln('Press any key to exit.');
  Readln;

{$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown := DebugHook.ToBoolean;
{$WARN SYMBOL_PLATFORM DEFAULT}
end.

