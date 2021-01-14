unit Downloader.Exceptions;

interface

uses
  System.SysUtils;

type
  EDownloaderArgumentException = class abstract(EArgumentException);
  ESourceCannotBeEmpty = class sealed(EDownloaderArgumentException);
  ETargetCannotBeEmpty = class sealed(EDownloaderArgumentException);

implementation

end.
