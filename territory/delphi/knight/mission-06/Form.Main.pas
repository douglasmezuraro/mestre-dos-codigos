unit Form.Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Actions, Vcl.ActnList, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.ComCtrls, System.Threading,

  {}

  Impl.Downloader, IdCOmponent;

type
  TMain = class sealed(TForm)
    EditURL: TLabeledEdit;
    ButtonDownload: TButton;
    ActionList: TActionList;
    ActionDownload: TAction;
    ProgressBar: TProgressBar;
    procedure ActionDownloadExecute(Sender: TObject);
    procedure OnWork(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
    procedure OnWorkBegin(ASender: TObject; AWorkMode: TWorkMode; AWorkCountMax: Int64);
  private
    procedure Download;
    function GetSource: string;
    function GetTarget: string;
    procedure SetSource(const Value: string);
    procedure SetTarget(const Value: string);
  public
    procedure AfterConstruction; override;
    property Source: string read GetSource write SetSource;
    property Target: string read GetTarget write SetTarget;
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
  EditURL.Text := 'https://speed.hetzner.de/100MB.bin';
end;

procedure TMain.Download;
var
  Downloader: TDownloader;
begin
  Downloader := TDownloader.Create(True);
  try
    Downloader.OnWorkBegin := OnWorkBegin;
    Downloader.OnWork := OnWork;
    Downloader.Source := Source;
    Downloader.Target := Target;

    Downloader.Execute;
  finally
    Downloader.Free;
  end;
end;

function TMain.GetSource: string;
begin
  Result := EditURL.Text;
end;

function TMain.GetTarget: string;
begin
  Result := 'C:\100MB.bin';
end;

procedure TMain.OnWork(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
begin
  ProgressBar.Position := AWorkCount;
end;

procedure TMain.OnWorkBegin(ASender: TObject; AWorkMode: TWorkMode; AWorkCountMax: Int64);
begin
  ProgressBar.Max := AWorkCountMax;
  ProgressBar.Position := 0;
end;

procedure TMain.SetSource(const Value: string);
begin
  EditURL.Text := Value;
end;

procedure TMain.SetTarget(const Value: string);
begin

end;

end.
