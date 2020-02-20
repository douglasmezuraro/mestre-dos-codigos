unit Impl.Downloader;

interface

uses
  IdComponent, IdHTTP, System.Classes, System.Threading;

type
  TDownloader = class sealed(TThread)
  private
    FIdHTTP: TIdHTTP;
    FSource: string;
    FTarget: string;
    function GetOnWorkBegin: TWorkBeginEvent;
    function GetOnWork: TWorkEvent;
    procedure SetOnWork(const Value: TWorkEvent);
    procedure SetOnWorkBegin(const Value: TWorkBeginEvent);
  public
    constructor Create(const Suspended: Boolean); reintroduce;
    destructor Destroy; override;
    procedure Execute; override;
    property Source: string read FSource write FSource;
    property Target: string read FTarget write FTarget;
    property OnWorkBegin: TWorkBeginEvent read GetOnWorkBegin write SetOnWorkBegin;
    property OnWork: TWorkEvent read GetOnWork write SetOnWork;
  end;

implementation

constructor TDownloader.Create(const Suspended: Boolean);
begin
  inherited Create(Suspended);
 FreeOnTerminate := True;
  FIdHTTP := TIdHTTP.Create;
end;

destructor TDownloader.Destroy;
begin
  FIdHTTP.Free;
  inherited;
end;

procedure TDownloader.Execute;
var
  Stream: TMemoryStream;
begin
  Stream := TMemoryStream.Create;
  try
    FIdHttp.Get(FSource, Stream);
    Stream.SaveToFile(FTarget);
  finally
    Stream.Free;
  end;
end;

function TDownloader.GetOnWorkBegin: TWorkBeginEvent;
begin
  Result := FIdHTTP.OnWorkBegin;
end;

function TDownloader.GetOnWork: TWorkEvent;
begin
  Result := FIdHTTP.OnWork;
end;

procedure TDownloader.SetOnWorkBegin(const Value: TWorkBeginEvent);
begin
  FIdHTTP.OnWorkBegin := Value;
end;

procedure TDownloader.SetOnWork(const Value: TWorkEvent);
begin
  FIdHTTP.OnWork := Value;
end;

end.
