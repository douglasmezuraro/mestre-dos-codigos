unit Zip;

interface

uses
  Zip.Wrapper, Zip.DTO, Zip.Exceptions, System.Zip;

type
  TZipHeader = System.Zip.TZipHeader;
  TZipWrapper = Zip.Wrapper.TZipWrapper;
  TZipDTO = Zip.DTO.TZipDTO;

  EZipArgumentException = Zip.Exceptions.EZipArgumentException;
  EZipMustSelectAtLeastOneFile = Zip.Exceptions.EZipMustSelectAtLeastOneFile;
  EZipMustSelectTheFileToBeSaved = Zip.Exceptions.EZipMustSelectTheFileToBeSaved;
  EZipInvalidFileExtension = Zip.Exceptions.EZipInvalidFileExtension;

implementation

end.

