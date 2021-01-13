unit Repository.Impl;

interface

uses
  Repository.Cloud.API, Repository.Files.API;

type
  TData = class sealed(TInterfacedObject, ICloudRepository, IFileRepository)
  private
    procedure ICloudRepository.SaveData = SaveCloudData;
    procedure IFileRepository.SaveData = SaveFileData;
  public
    procedure SaveCloudData;
    procedure SaveFileData;
  end;

implementation

procedure TData.SaveFileData;
begin
  Writeln('IFileRepository.SaveData');
end;

procedure TData.SaveCloudData;
begin
  Writeln('ICloudRepository.SaveData');
end;

end.

