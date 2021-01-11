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
    procedure ActionDownloadExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure Download;
    procedure OnWork(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
    procedure OnWorkBegin(ASender: TObject; AWorkMode: TWorkMode; AWorkCountMax: Int64);
  end;

var
  Main: TMain;

implementation

{$R *.dfm}

procedure TMain.ActionDownloadExecute(Sender: TObject);
begin
  Download;
end;

procedure TMain.Download;
var
  LDTO: TDownloaderDTO;
  LDownloader: TDownloader;
begin
  LDTO.Source := EditSource.Text;
  LDTO.Target := EditTarget.Text;
  LDTO.OnWork := OnWork;
  LDTO.OnWorkBegin := OnWorkBegin;

  LDownloader := TDownloader.Create(LDTO);
  LDownloader.Start;
end;

procedure TMain.FormShow(Sender: TObject);
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

