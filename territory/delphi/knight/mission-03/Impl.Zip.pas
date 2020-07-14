unit Impl.Zip;

interface

uses
  Helper.ZipFile, System.SysUtils, System.Zip;

type
  TZip = class sealed
  private
    FFileName: string;
    FFiles: TArray<string>;
    FZipFile: TZipFile;
    function GetOnProgress: TZipProgressEvent;
    procedure SetOnProgress(const Value: TZipProgressEvent);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Compress;
    property Files: TArray<string> read FFiles write FFiles;
    property FileName: string read FFileName write FFileName;
    property OnProgress: TZipProgressEvent read GetOnProgress write SetOnProgress;
  end;

implementation

constructor TZip.Create;
begin
  FZipFile := TZipFile.Create;
end;

destructor TZip.Destroy;
begin
  FZipFile.Free;
  inherited;
end;

procedure TZip.Compress;
begin
  FZipFile.Open(FFileName, TZipMode.zmWrite);
  try
    FZipFile.Add(FFiles);
  finally
    FZipFile.Close;
  end;
end;

function TZip.GetOnProgress: TZipProgressEvent;
begin
  Result := FZipFile.OnProgress;
end;

procedure TZip.SetOnProgress(const Value: TZipProgressEvent);
begin
  FZipFile.OnProgress := Value;
end;

end.

