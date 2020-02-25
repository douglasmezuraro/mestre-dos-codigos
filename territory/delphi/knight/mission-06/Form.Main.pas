unit Form.Main;

interface

uses
  System.SysUtils, System.Classes, System.Actions, Vcl.Controls, Vcl.Forms, Vcl.ActnList, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.ComCtrls, Impl.Downloader, IdCOmponent;

type
  TMain = class sealed(TForm)
    EditSource: TLabeledEdit;
    ButtonDownload: TButton;
    ActionList: TActionList;
    ActionDownload: TAction;
    ProgressBar: TProgressBar;
    EditTarget: TLabeledEdit;
    procedure ActionDownloadExecute(Sender: TObject);
    procedure OnWork(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
    procedure OnWorkBegin(ASender: TObject; AWorkMode: TWorkMode; AWorkCountMax: Int64);
  private
    procedure Download;
    function GetSource: TFileName;
    function GetTarget: TFileName;
    procedure SetSource(const Value: TFileName);
    procedure SetTarget(const Value: TFileName);
  public
    procedure AfterConstruction; override;
    property Source: TFileName read GetSource write SetSource;
    property Target: TFileName read GetTarget write SetTarget;
  end;

var
  Main: TMain;

implementation

{$R *.dfm}

procedure TMain.ActionDownloadExecute(Sender: TObject);
begin
  Download;
end;

procedure TMain.AfterConstruction;
begin
  inherited;
  Source := 'https://speed.hetzner.de/100MB.bin';
  Target := 'C:\100MB.bin';
end;

procedure TMain.Download;
var
  Downloader: TDownloader;
begin
  Downloader := TDownloader.Create;
  Downloader.Source := Source;
  Downloader.Target := Target;
  Downloader.ProgressBar := ProgressBar;

  Downloader.Start;
end;

function TMain.GetSource: TFileName;
begin
  Result := EditSource.Text;
end;

function TMain.GetTarget: TFileName;
begin
  Result := EditTarget.Text;
end;

procedure TMain.OnWork(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
begin
  ProgressBar.Position := AWorkCount;
  Application.ProcessMessages;
end;

procedure TMain.OnWorkBegin(ASender: TObject; AWorkMode: TWorkMode; AWorkCountMax: Int64);
begin
  ProgressBar.Max := AWorkCountMax;
  ProgressBar.Position := 0;
end;

procedure TMain.SetSource(const Value: TFileName);
begin
  EditSource.Text := Value;
end;

procedure TMain.SetTarget(const Value: TFileName);
begin
  EditTarget.Text := Value;
end;

end.

