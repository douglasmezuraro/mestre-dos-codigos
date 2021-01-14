unit Zip.Wrapper;

interface

uses
  Helper.ZipFile, System.IOUtils, System.SysUtils, System.Zip, Zip.DTO, Zip.Exceptions;

type
  TZipWrapper = class sealed
  strict private
    FFileName: string;
    FFiles: TArray<string>;
    FZipFile: TZipFile;
    FInvalidExtensions: TArray<string>;
  public
    constructor Create(const AZipDTO: TZipDTO);
    destructor Destroy; override;
    procedure AfterConstruction; override;
    procedure Compress;
  end;

implementation

constructor TZipWrapper.Create(const AZipDTO: TZipDTO);
begin
  FZipFile := TZipFile.Create;
  FZipFile.OnProgress := AZipDTO.OnProgress;
  FFiles := AZipDTO.Files;
  FFileName := AZipDTO.FileName;
  FInvalidExtensions := AZipDTO.InvalidExtensions;
end;

destructor TZipWrapper.Destroy;
begin
  FZipFile.Free;
  inherited;
end;

procedure TZipWrapper.AfterConstruction;
var
  LFileName: TFileName;
  LExtension: string;
begin
  inherited;
  if FFiles = nil then
  begin
    raise EZipMustSelectAtLeastOneFile.Create('You must select at least one file.');
  end;

  if FFileName.Trim.IsEmpty then
  begin
    raise EZipMustSelectTheFileToBeSaved.Create('You must select the file to be saved.');
  end;

  for LFileName in FFiles do
  begin
    for LExtension in FInvalidExtensions do
    begin
      if TPath.GetExtension(LFileName).Equals(LExtension) then
      begin
        raise EZipInvalidFileExtension.CreateFmt('Files with the extension "%s" are not allowed.', [LExtension]);
      end;
    end;
  end;
end;

procedure TZipWrapper.Compress;
begin
  FZipFile.Open(FFileName, TZipMode.zmWrite);
  try
    FZipFile.Add(FFiles);
  finally
    FZipFile.Close;
  end;
end;

end.

