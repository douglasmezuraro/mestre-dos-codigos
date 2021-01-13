unit Downloader.Thread;

interface

uses
  IdComponent, IdHTTP, System.Classes, System.SysUtils, Downloader.DTO;

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
    constructor Create(const ADTO: TDownloaderDTO); reintroduce;
    destructor Destroy; override;
  end;

implementation

constructor TThreadDownloader.Create(const ADTO: TDownloaderDTO);
begin
  inherited Create(True);
  FIdHTTP := TIdHTTP.Create;
  FIdHTTP.OnWork := ADTO.OnWork;
  FIdHTTP.OnWorkBegin := ADTO.OnWorkBegin;
  FStream := TMemoryStream.Create;
  FSource := ADTO.Source;
  FTarget := ADTO.Target;

  FreeOnTerminate := True;

  if FSource.Trim.IsEmpty then
  begin
    raise EArgumentException.Create('The source cannot be empty.');
  end;

  if FTarget.Trim.IsEmpty then
  begin
    raise EArgumentException.Create('The target cannot be empty.');
  end;
end;

destructor TThreadDownloader.Destroy;
begin
  FStream.Free;
  FIdHTTP.Free;
  inherited;
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

