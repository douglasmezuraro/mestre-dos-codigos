program Mission01;

// Author: Douglas Mezuraro
// Modification: 21/12/2020
// Level: Knight
// Mission: 01

{$APPTYPE CONSOLE}

{$R *.res}

uses
  MidasLib,
  System.SysUtils,
  API.CloudRepository in 'src\API.CloudRepository.pas',
  API.FileRepository in 'src\API.FileRepository.pas',
  Impl.Data in 'src\Impl.Data.pas';

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
