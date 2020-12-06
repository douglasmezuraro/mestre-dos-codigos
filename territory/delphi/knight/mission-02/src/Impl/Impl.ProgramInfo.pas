unit Impl.ProgramInfo;

interface

uses
  System.SysUtils;

type
  TProgramInfo = class sealed
  strict private
    FVersion: string;
    FName: string;
    FPublisher: string;
  public
    constructor Create(const AName, AVersion, APublisher: string);
    function IsEmpty: Boolean;
    property Name: string read FName write FName;
    property Version: string read FVersion write FVersion;
    property Publisher: string read FPublisher write FPublisher;
  end;

implementation

constructor TProgramInfo.Create(const AName, AVersion, APublisher: string);
begin
  FName := AName;
  FVersion := AVersion;
  FPublisher := APublisher;
end;

function TProgramInfo.IsEmpty: Boolean;
begin
  Result := FName.Trim.IsEmpty and FVersion.Trim.IsEmpty and FPublisher.Trim.IsEmpty;
end;

end.

