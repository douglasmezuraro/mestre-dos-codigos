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
  end;

implementation

end.

