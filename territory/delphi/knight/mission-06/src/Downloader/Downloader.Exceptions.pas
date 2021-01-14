unit Downloader.Exceptions;

interface

uses
  System.SysUtils;

type
  EDownloaderArgumentException = class abstract(EArgumentException);
  EDownloaderSourceCannotBeEmpty = class sealed(EDownloaderArgumentException);
  EDownloaderTargetCannotBeEmpty = class sealed(EDownloaderArgumentException);

implementation

end.
