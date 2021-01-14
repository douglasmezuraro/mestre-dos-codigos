unit Zip;

interface

uses
  Zip.Wrapper, Zip.DTO, Zip.Exceptions, System.Zip;

type
  TZipWrapper = Zip.Wrapper.TZipWrapper;
  TZipDTO = Zip.DTO.TZipDTO;
  EZipArgumentException = Zip.Exceptions.EZipArgumentException;
  EMustSelectAtLeastOneFile = Zip.Exceptions.EMustSelectAtLeastOneFile;
  EMustSelectTheFileToBeSaved = Zip.Exceptions.EMustSelectTheFileToBeSaved;
  EInvalidFileExtension = Zip.Exceptions.EInvalidFileExtension;
  TZipHeader = System.Zip.TZipHeader;

implementation

end.

