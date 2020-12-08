unit Form.Main;

interface

uses
  System.Classes, System.Actions, Vcl.Controls, Vcl.Forms, Vcl.ActnList, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.ComCtrls, Impl.Downloader, System.IOUtils, IdComponent;

type
  TMain = class sealed(TForm)
  {$REGION 'Visual Components'}
    EditSource: TLabeledEdit;
    ButtonDownload: TButton;
    ActionList: TActionList;
    ActionDownload: TAction;
    ProgressBar: TProgressBar;
    EditTarget: TLabeledEdit;
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
  LDownloader: TDownloader;
begin
  LDownloader := TDownloader.Create;
  LDownloader.Source := EditSource.Text;
  LDownloader.Target := EditTarget.Text;
  LDownloader.OnWork := OnWork;
  LDownloader.OnWorkBegin := OnWorkBegin;
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

