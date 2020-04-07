unit Impl.ProgramList;

interface

uses
  Impl.ProgramInfo,
  System.Classes,
  System.Generics.Collections,
  System.SysUtils,
  System.Win.Registry,
  Winapi.Windows;

type
  TProgramList = class sealed
  private
    FRegistry: TRegistry;
    FPrograms: TList<TProgramInfo>;
    const PATH = 'Software\Microsoft\Windows\CurrentVersion\Uninstall';
    function GetPrograms: TArray<string>;
  public
    constructor Create;
    destructor Destroy; override;
  public
    function List: TArray<TProgramInfo>;
  end;

implementation

constructor TProgramList.Create;
begin
  FRegistry := TRegistry.Create;
  FPrograms := TList<TProgramInfo>.Create;
end;

destructor TProgramList.Destroy;
begin
  FPrograms.Free;
  FRegistry.Free;
  inherited;
end;

function TProgramList.GetPrograms: TArray<string>;
var
  List: TStringList;
begin
  List := TStringList.Create;
  try
    FRegistry.RootKey := HKEY_LOCAL_MACHINE;
    FRegistry.OpenKeyReadOnly(PATH);
    FRegistry.GetKeyNames(List);

    Result := List.ToStringArray;
  finally
    FRegistry.CloseKey;
    List.Free;
  end;
end;

function TProgramList.List: TArray<TProgramInfo>;
var
  Name: string;
  ProgramInfo: TProgramInfo;
begin
  for Name in GetPrograms do
  begin
    FRegistry.OpenKeyReadOnly(PATH + '\' + Name);
    try
      ProgramInfo.Name := FRegistry.GetDataAsString('DisplayName');
      ProgramInfo.Version := FRegistry.GetDataAsString('DisplayVersion');
      ProgramInfo.Publisher := FRegistry.GetDataAsString('Publisher');

      if ProgramInfo.Name.IsEmpty and
         ProgramInfo.Version.IsEmpty and
         ProgramInfo.Publisher.IsEmpty then
      begin
        Continue;
      end;

      FPrograms.Add(ProgramInfo);
    finally
      FRegistry.CloseKey;
    end;
  end;

  Result := FPrograms.ToArray;
end;

end.

