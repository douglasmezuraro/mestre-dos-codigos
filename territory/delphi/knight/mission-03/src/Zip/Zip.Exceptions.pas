unit Zip.Exceptions;

interface

uses
  System.SysUtils;

type
  EZipArgumentException = class abstract(EArgumentException);
  EZipMustSelectAtLeastOneFile = class sealed(EZipArgumentException);
  EZipMustSelectTheFileToBeSaved = class sealed(EZipArgumentException);
  EZipInvalidFileExtension = class sealed(EZipArgumentException);

implementation

end.

