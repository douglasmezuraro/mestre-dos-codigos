unit Impl.ProgramList;

interface

uses
  Impl.ProgramInfo, System.Classes, System.Generics.Collections, System.SysUtils, System.Win.Registry,
  Winapi.Windows;

type
  TProgramList = class sealed
  private
    FRegistry: TRegistry;
    FPrograms: TList<TProgramInfo>;
    function Path: string;
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
  Programs: TStringList;
begin
  Programs := TStringList.Create;
  try
    FRegistry.RootKey := HKEY_LOCAL_MACHINE;
    FRegistry.OpenKeyReadOnly(Path);
    FRegistry.GetKeyNames(Programs);

    Result := Programs.ToStringArray;
  finally
    FRegistry.CloseKey;
    Programs.Free;
  end;
end;

function TProgramList.Path: string;
begin
  Result := 'Software\Microsoft\Windows\CurrentVersion\Uninstall';
end;

function TProgramList.ToArray: TArray<TProgramInfo>;
var
  Name: string;
begin
  for Name in GetPrograms do
  begin
    FRegistry.OpenKeyReadOnly(Path + '\' + Name);
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

