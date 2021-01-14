unit Downloader;

interface

uses
  Downloader.DTO, Downloader.Exceptions, Downloader.Thread, IdComponent;

type
  TWorkMode = IdComponent.TWorkMode;
  TDownloaderDTO = Downloader.DTO.TDownloaderDTO;
  TDownloader = Downloader.Thread.TThreadDownloader;

  EDownloaderArgumentException = Downloader.Exceptions.EDownloaderArgumentException;
  EDownloaderSourceCannotBeEmpty = Downloader.Exceptions.EDownloaderSourceCannotBeEmpty;
  EDownloaderTargetCannotBeEmpty = Downloader.Exceptions.EDownloaderTargetCannotBeEmpty;

implementation

end.

