unit Form.Main;

interface

uses
  System.Classes, System.Actions, Vcl.Controls, Vcl.Forms, Vcl.ActnList, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.ComCtrls, System.IOUtils, Downloader;

type
  TMain = class sealed(TForm)
  {$REGION 'Components'}
    ActionDownload: TAction;
    ActionList: TActionList;
    ButtonDownload: TButton;
    EditSource: TLabeledEdit;
    EditTarget: TLabeledEdit;
    ProgressBar: TProgressBar;
  {$ENDREGION}
    procedure ActionDownloadExecute(ASender: TObject);
    procedure FormShow(ASender: TObject);
    procedure FormCloseQuery(ASender: TObject; var ACanClose: Boolean);
  strict private
    FDownloader: TDownloader;
  private
    procedure Download;
    procedure OnWork(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
    procedure OnWorkBegin(ASender: TObject; AWorkMode: TWorkMode; AWorkCountMax: Int64);
  end;

var
  Main: TMain;

implementation

{$R *.dfm}

procedure TMain.ActionDownloadExecute(ASender: TObject);
begin
  Download;
end;

procedure TMain.Download;
var
  LDTO: TDownloaderDTO;
begin
  LDTO.Source := EditSource.Text;
  LDTO.Target := EditTarget.Text;
  LDTO.OnWork := OnWork;
  LDTO.OnWorkBegin := OnWorkBegin;

  FDownloader := TDownloader.Create(LDTO);
  FDownloader.Start;
end;

procedure TMain.FormCloseQuery(ASender: TObject; var ACanClose: Boolean);
begin
  ACanClose := FDownloader = nil;
end;

procedure TMain.FormShow(ASender: TObject);
begin
  EditSource.Text := 'https://speed.hetzner.de/100MB.bin';
  EditTarget.Text := TPath.Combine(TPath.GetDocumentsPath, 'downloaded-file.bin');
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

end.

