program Mission01;

// Author: Douglas Mezuraro
// Last modification: 06/12/2020
// Level: Knight
// Mission: 01
// Objective: Em uma aplicação console, defina duas Interfaces, chamadas IRepositorioNuvem e
// IRepositorioArquivo. Ambas devem declarar o método "SalvarDados". Em seguida, declare uma classe
// que implemente as duas Interfaces e codifique o método "SalvarDados" de cada Interface. Use o
// conceito de Method Resolution Clause para tratar o conflito de nomes de métodos iguais.

{$APPTYPE CONSOLE}

{$R *.res}

uses
  MidasLib,
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
    LData.SaveCloudData;
    LData.SaveFileData;
  finally
    LData.Free;
  end;
end;

begin
  PrintHeader;
  SaveData;

  Writeln(string.Empty);
  Writeln('Press any key to exit.');
  Readln;

{$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown := DebugHook.ToBoolean;
{$WARN SYMBOL_PLATFORM DEFAULT}
end.
