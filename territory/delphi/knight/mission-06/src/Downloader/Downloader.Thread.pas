unit Downloader.Thread;

interface

uses
  IdHTTP, System.Classes, System.SysUtils, Downloader.Exceptions, Downloader.DTO;

type
  TThreadDownloader = class sealed(TThread)
  strict private
    FIdHTTP: TIdHTTP;
    FStream: TMemoryStream;
    FSource: string;
    FTarget: string;
  protected
    procedure Execute; override;
  public
    constructor Create(const ADownloaderDTO: TDownloaderDTO); reintroduce;
    destructor Destroy; override;
    procedure AfterConstruction; override;
  end;

implementation

constructor TThreadDownloader.Create(const ADownloaderDTO: TDownloaderDTO);
begin
  inherited Create(True);
  FIdHTTP := TIdHTTP.Create;
  FIdHTTP.OnWork := ADownloaderDTO.OnWork;
  FIdHTTP.OnWorkBegin := ADownloaderDTO.OnWorkBegin;
  FStream := TMemoryStream.Create;
  FSource := ADownloaderDTO.Source;
  FTarget := ADownloaderDTO.Target;

  FreeOnTerminate := True;
end;

destructor TThreadDownloader.Destroy;
begin
  FStream.Free;
  FIdHTTP.Free;
  inherited;
end;

procedure TThreadDownloader.AfterConstruction;
begin
  inherited;

  if FSource.Trim.IsEmpty then
  begin
    raise EDownloaderSourceCannotBeEmpty.Create('The source cannot be empty.');
  end;

  if FTarget.Trim.IsEmpty then
  begin
    raise EDownloaderTargetCannotBeEmpty.Create('The target cannot be empty.');
  end;
end;

procedure TThreadDownloader.Execute;
begin
  try
    FIdHttp.Get(FSource, FStream);
    FStream.SaveToFile(FTarget);
  except
    on E: Exception do
    begin
      ApplicationShowException(E);
    end;
  end;
end;

end.

