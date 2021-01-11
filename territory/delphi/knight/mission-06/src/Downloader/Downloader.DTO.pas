unit Downloader.DTO;

interface

uses
  IdComponent;

type
  TDownloaderDTO = record
  public
    Source: string;
    Target: string;
    OnWork: TWorkEvent;
    OnWorkBegin: TWorkBeginEvent;
  end;

implementation

end.

