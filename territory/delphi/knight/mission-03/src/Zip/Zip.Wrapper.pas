unit Zip.Wrapper;

interface

uses
  Helper.ZipFile, System.IOUtils, System.SysUtils, System.Zip;

type
  TZipWrapper = class sealed
  strict private
    FFileName: string;
    FFiles: TArray<string>;
    FZipFile: TZipFile;
  private
    function GetOnProgress: TZipProgressEvent;
    procedure SetOnProgress(const AZipProgressEvent: TZipProgressEvent);
    procedure Validate;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Compress;
    property Files: TArray<string> read FFiles write FFiles;
    property FileName: string read FFileName write FFileName;
    property OnProgress: TZipProgressEvent read GetOnProgress write SetOnProgress;
  end;

implementation

constructor TZipWrapper.Create;
begin
  FZipFile := TZipFile.Create;
end;

destructor TZipWrapper.Destroy;
begin
  FZipFile.Free;
  inherited;
end;

procedure TZipWrapper.Compress;
begin
  Validate;
  FZipFile.Open(FFileName, TZipMode.zmWrite);
  try
    FZipFile.Add(FFiles);
  finally
    FZipFile.Close;
  end;
end;

function TZipWrapper.GetOnProgress: TZipProgressEvent;
begin
  Result := FZipFile.OnProgress;
end;

procedure TZipWrapper.SetOnProgress(const AZipProgressEvent: TZipProgressEvent);
begin
  FZipFile.OnProgress := AZipProgressEvent;
end;

procedure TZipWrapper.Validate;
var
  LFileName: TFileName;
begin
  if FFiles = nil then
  begin
    raise EArgumentException.Create('You must select at least one file.');
  end;

  if FFileName.Trim.IsEmpty then
  begin
    raise EArgumentException.Create('It is necessary to select the file to be saved.');
  end;

  for LFileName in FFiles do
  begin
    if TPath.GetExtension(LFileName).Equals('.exe') then
    begin
      raise EArgumentException.Create('Files with the extension ".exe" are not allowed.');
    end;
  end;
end;

end.

