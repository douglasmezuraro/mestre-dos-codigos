program Mission01;

// Author: Douglas Mezuraro
// Last modification: 16/02/2020
// Level: Knight
// Mission: 01
// Objective: Build a console application where a concrete class implements two interfaces that have
// a method with the same name using the "method resolution clause" concept to resolve the conflict.

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Impl.Config.API in 'Impl.Config.API.pas',
  Impl.Config in 'Impl.Config.pas';

procedure PrintHeader;
begin
  Writeln('Author: Douglas Mezuraro');
  Writeln('Modification date: 16/02/2020');
  WriteLn('Level: Knight');
  Writeln('Mission: 01');

  Writeln(string.Empty);
end;

procedure SaveData;
var
  Config: TConfig;
begin
  Config := TConfig.Create;
  try
    WriteLn('The path of the file is "', Config.FILE_PATH, '".');

    Config.SaveDataServer;
    Writeln('The "Server" section was successfully saved.');

    Config.SaveDataDatabase;
    Writeln('The "Database" section was sucessfully saved.');

    Writeln('Press any key to exit.');
    Readln;
  finally
    Config.Free;
  end;
end;

begin
  PrintHeader;
  SaveData;

  ReportMemoryLeaksOnShutdown := True;
end.
