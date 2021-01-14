unit Zip.DTO;

interface

uses
  System.Zip;

type
  TZipDTO = record
  public
    Files: TArray<string>;
    FileName: string;
    OnProgress: TZipProgressEvent;
    InvalidExtensions: TArray<string>;
  end;

implementation

end.

