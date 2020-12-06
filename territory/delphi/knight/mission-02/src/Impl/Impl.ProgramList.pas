unit Impl.ProgramList;

interface

uses
  Impl.ProgramInfo, System.Classes, System.Generics.Collections, System.SysUtils, System.Win.Registry,
  Winapi.Windows;

type
  TProgramList = class sealed
  strict private
    FRegistry: TRegistry;
    FPrograms: TList<TProgramInfo>;
  private
    function GetPath: string;
    function GetPrograms: TArray<string>;
  public
    constructor Create;
    destructor Destroy; override;
    function ToArray: TArray<TProgramInfo>;
  end;

implementation

constructor TProgramList.Create;
begin
  FRegistry := TRegistry.Create;
  FPrograms := TObjectList<TProgramInfo>.Create;
end;

destructor TProgramList.Destroy;
begin
  FPrograms.Free;
  FRegistry.Free;
  inherited;
end;

function TProgramList.GetPrograms: TArray<string>;
var
  LPrograms: TStringList;
begin
  LPrograms := TStringList.Create;
  try
    FRegistry.RootKey := Winapi.Windows.HKEY_LOCAL_MACHINE;
    FRegistry.OpenKeyReadOnly(GetPath);
    FRegistry.GetKeyNames(LPrograms);

    Result := LPrograms.ToStringArray;
  finally
    FRegistry.CloseKey;
    LPrograms.Free;
  end;
end;

function TProgramList.GetPath: string;
begin
  Result := 'Software\Microsoft\Windows\CurrentVersion\Uninstall';
end;

function TProgramList.ToArray: TArray<TProgramInfo>;
var
  LProgram: string;
begin
  for LProgram in GetPrograms do
  begin
    FRegistry.OpenKeyReadOnly(GetPath + '\' + LProgram);
    try
      FPrograms.Add(TProgramInfo.Create(
        FRegistry.GetDataAsString('DisplayName'),
        FRegistry.GetDataAsString('DisplayVersion'),
        FRegistry.GetDataAsString('Publisher')));
    finally
      FRegistry.CloseKey;
    end;
  end;

  Result := FPrograms.ToArray;
end;

end.

