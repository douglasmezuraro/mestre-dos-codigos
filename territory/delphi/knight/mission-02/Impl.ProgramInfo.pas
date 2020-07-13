unit Impl.ProgramInfo;

interface

uses
  System.SysUtils;

type
  TProgramInfo = class sealed
  private
    FVersion: string;
    FName: string;
    FPublisher: string;
  public
    constructor Create(const Name, Version, Publisher: string);
    function IsEmpty: Boolean;
    property Name: string read FName write FName;
    property Version: string read FVersion write FVersion;
    property Publisher: string read FPublisher write FPublisher;
  end;

implementation

constructor TProgramInfo.Create(const Name, Version, Publisher: string);
begin
  FName := Name;
  FVersion := Version;
  FPublisher := Publisher;
end;

function TProgramInfo.IsEmpty: Boolean;
begin
  Result := FName.Trim.IsEmpty and FVersion.Trim.IsEmpty and FPublisher.Trim.IsEmpty;
end;

end.

