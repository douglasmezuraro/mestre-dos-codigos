unit Impl.Downloader;

interface

uses
  IdComponent, IdHTTP, System.Classes, System.SysUtils;

type
  TDownloader = class sealed(TThread)
  strict private
    FIdHTTP: TIdHTTP;
    FStream: TMemoryStream;
    FSource: string;
    FTarget: string;
  private
    function GetOnWork: TWorkEvent;
    procedure SetOnWork(const AOnWorkEvent: TWorkEvent);
    function GetOnWorkBegin: TWorkBeginEvent;
    procedure SetOnWorkBegin(const AOnWorkBeginEvent: TWorkBeginEvent);
  protected
    procedure Validate;
    procedure Execute; override;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
    property Source: string read FSource write FSource;
    property Target: string read FTarget write FTarget;
    property OnWork: TWorkEvent read GetOnWork write SetOnWork;
    property OnWorkBegin: TWorkBeginEvent read GetOnWorkBegin write SetOnWorkBegin;
  end;

implementation

constructor TDownloader.Create;
begin
  inherited Create(True);
  FIdHTTP := TIdHTTP.Create;
  FStream := TMemoryStream.Create;
  FreeOnTerminate := True;
end;

destructor TDownloader.Destroy;
begin
  FStream.Free;
  FIdHTTP.Free;
  inherited;
end;

procedure TDownloader.Execute;
begin
  try
    Validate;
    FIdHttp.Get(FSource, FStream);
    FStream.SaveToFile(FTarget);
  except
    on Error: Exception do
    begin
      ApplicationShowException(Error);
    end;
  end;
end;

function TDownloader.GetOnWork: TWorkEvent;
begin
  Result := FIdHTTP.OnWork;
end;

procedure TDownloader.SetOnWork(const AOnWorkEvent: TWorkEvent);
begin
  FIdHTTP.OnWork := AOnWorkEvent;
end;

function TDownloader.GetOnWorkBegin: TWorkBeginEvent;
begin
  Result := FIdHTTP.OnWorkBegin;
end;

procedure TDownloader.SetOnWorkBegin(const AOnWorkBeginEvent: TWorkBeginEvent);
begin
  FIdHTTP.OnWorkBegin := AOnWorkBeginEvent;
end;

procedure TDownloader.Validate;
begin
  if FSource.Trim.IsEmpty then
  begin
    raise EArgumentException.Create('The source cannot be empty.');
  end;

  if FTarget.Trim.IsEmpty then
  begin
    raise EArgumentException.Create('The target cannot be empty.');
  end;
end;

end.

