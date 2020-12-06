unit Impl.Data;

interface

uses
  API.CloudRepository, API.FileRepository, System.IOUtils, System.SysUtils;

type
  TData = class sealed(TInterfacedObject, ICloudRepository, IFileRepository)
  private
    procedure ICloudRepository.SaveData = SaveCloudData;
    procedure IFileRepository.SaveData = SaveFileData;
    procedure SaveCloudData;
    procedure SaveFileData;
  public
    procedure Save;
  end;

implementation

procedure TData.Save;
begin
  SaveCloudData;
  SaveFileData;
end;

procedure TData.SaveFileData;
var
  LPath: TFileName;
begin
  LPath := TPath.Combine(TPath.GetDirectoryName(ParamStr(0)), 'File.txt');
  TFile.WriteAllText(LPath, 'IFileRepository.SaveData');
end;

procedure TData.SaveCloudData;
var
  LPath: TFileName;
begin
  LPath := TPath.Combine(TPath.GetDirectoryName(ParamStr(0)), 'Cloud.txt');
  TFile.WriteAllText(LPath, 'ICloudRepository.SaveData');
end;
end.

