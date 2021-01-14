unit Zip.Exceptions;

interface

uses
  System.SysUtils;

type
  EZipArgumentException = class abstract(EArgumentException);
  EMustSelectAtLeastOneFile = class sealed(EZipArgumentException);
  EMustSelectTheFileToBeSaved = class sealed(EZipArgumentException);
  EInvalidFileExtension = class sealed(EZipArgumentException);

implementation

end.

