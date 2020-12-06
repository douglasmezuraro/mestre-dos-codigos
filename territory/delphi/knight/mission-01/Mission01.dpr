program Mission01;

// Author: Douglas Mezuraro
// Last modification: 06/12/2020
// Level: Knight
// Mission: 01
// Objective: Build a console application where a concrete class implements two interfaces that have
// a method with the same name using the "method resolution clause" concept to resolve the conflict.

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  API.CloudRepository in 'src\API.CloudRepository.pas',
  API.FileRepository in 'src\API.FileRepository.pas',
  Impl.Data in 'src\Impl.Data.pas';

procedure PrintHeader;
begin
  Writeln('Author: Douglas Mezuraro');
  Writeln('Modification date: 06/12/2020');
  WriteLn('Level: Knight');
  Writeln('Mission: 01');

  Writeln(string.Empty);
end;

procedure SaveData;
var
  LData: TData;
begin
  LData := TData.Create;
  try
    LData.Save;
  finally
    LData.Free;
  end;
end;

begin
  PrintHeader;
  SaveData;
  Writeln('The data was successfully saved.');
  Writeln('Press any key to exit.');
  Readln;

{$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown := DebugHook.ToBoolean;
{$WARN SYMBOL_PLATFORM DEFAULT}
end.
