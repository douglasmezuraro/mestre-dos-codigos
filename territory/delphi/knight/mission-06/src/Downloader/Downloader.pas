unit Downloader;

interface

uses
  Downloader.DTO, Downloader.Exceptions, Downloader.Thread, IdComponent;

type
  TWorkMode = IdComponent.TWorkMode;
  TDownloaderDTO = Downloader.DTO.TDownloaderDTO;
  TDownloader = Downloader.Thread.TThreadDownloader;
  EDownloaderArgumentException = Downloader.Exceptions.EDownloaderArgumentException;
  ESourceCannotBeEmpty = Downloader.Exceptions.ESourceCannotBeEmpty;
  ETargetCannotBeEmpty = Downloader.Exceptions.ETargetCannotBeEmpty;

implementation

end.

