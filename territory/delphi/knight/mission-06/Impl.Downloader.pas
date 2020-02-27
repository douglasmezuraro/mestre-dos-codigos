unit Impl.Downloader;

interface

uses
  IdComponent, IdHTTP, System.Classes, System.SysUtils, Vcl.ComCtrls;

type
  TDownloader = class sealed(TThread)
  private
    FIdHTTP: TIdHTTP;
    FStream: TMemoryStream;
    FSource: TFileName;
    FTarget: TFileName;
    FProgressBar: TProgressBar;
  protected
    procedure Execute; override;
    procedure OnWork(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
    procedure OnWorkBegin(ASender: TObject; AWorkMode: TWorkMode; AWorkCountMax: Int64);
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
    procedure AfterConstruction; override;
    property Source: TFileName read FSource write FSource;
    property Target: TFileName read FTarget write FTarget;
    property ProgressBar: TProgressBar read FProgressBar write FProgressBar;
  end;

implementation

constructor TDownloader.Create;
begin
  inherited Create(True);
  FreeOnTerminate := True;
  FIdHTTP := TIdHTTP.Create;
  FStream := TMemoryStream.Create;
end;

destructor TDownloader.Destroy;
begin
  FStream.Free;
  FIdHTTP.Free;
  inherited;
end;

procedure TDownloader.Execute;
begin
  FIdHttp.Get(FSource, FStream);
  FStream.SaveToFile(FTarget);
end;

procedure TDownloader.AfterConstruction;
begin
  inherited;
  FIdHTTP.OnWork := OnWork;
  FIdHTTP.OnWorkBegin := OnWorkBegin;
end;

procedure TDownloader.OnWork(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
begin
  FProgressBar.Position := AWorkCount;
end;

procedure TDownloader.OnWorkBegin(ASender: TObject; AWorkMode: TWorkMode; AWorkCountMax: Int64);
begin
  FProgressBar.Max := AWorkCountMax;
  FProgressBar.Position := 0;
end;

end.

