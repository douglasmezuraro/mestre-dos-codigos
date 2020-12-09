unit Form.Main;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ActnList, Vcl.StdCtrls,
  System.Zip, Vcl.ComCtrls, System.UITypes, System.Actions, Impl.Zip;

type
  TMain = class sealed(TForm)
    ActionList: TActionList;
    ActionCompress: TAction;
    ButtonCompress: TButton;
    ProgressBarCompression: TProgressBar;
    ActionSelectFiles: TAction;
    ActionSelectFileName: TAction;
    GroupBoxInput: TGroupBox;
    MemoFiles: TMemo;
    ButtonSelectFiles: TButton;
    GroupBox1: TGroupBox;
    EditFileName: TEdit;
    ButtonSelectFileName: TButton;
    procedure ActionCompressExecute(Sender: TObject);
    procedure OnProgress(Sender: TObject; FileName: string; Header: TZipHeader; Position: Int64);
    procedure ActionSelectFilesExecute(Sender: TObject);
    procedure ActionSelectFileNameExecute(Sender: TObject);
  private
    FZipWrapper: TZipWrapper;
    function SelectFiles: TArray<string>;
    function SelectFileName: string;
    procedure Compress;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

var
  Main: TMain;

implementation

{$R *.dfm}

procedure TMain.ActionCompressExecute(Sender: TObject);
begin
  ProgressBarCompression.Position := 0;
  Compress;
end;

procedure TMain.ActionSelectFileNameExecute(Sender: TObject);
begin
  FZipWrapper.FileName := SelectFileName;
  EditFileName.Text := FZipWrapper.FileName;
end;

procedure TMain.ActionSelectFilesExecute(Sender: TObject);
begin
  FZipWrapper.Files := SelectFiles;
  MemoFiles.Lines.Clear;
  MemoFiles.Lines.AddStrings(FZipWrapper.Files);
end;

procedure TMain.Compress;
begin
  try
    FZipWrapper.Compress;
  except
    on Exception: EArgumentException do
    begin
      MessageDlg(Exception.Message, TmsgDlgType.mtWarning, [mbOk], 0);
    end;

    on Exception: Exception do
    begin
      MessageDlg('Unhandled error: ' + Exception.Message, TmsgDlgType.mtWarning, [mbOk], 0);
    end;
  end;
end;

constructor TMain.Create(AOwner: TComponent);
begin
  inherited;
  FZipWrapper := TZipWrapper.Create;
  FZipWrapper.OnProgress := OnProgress;
end;

destructor TMain.Destroy;
begin
  FZipWrapper.Free;
  inherited;
end;

procedure TMain.OnProgress(Sender: TObject; FileName: string; Header: TZipHeader; Position: Int64);
begin
  ProgressBarCompression.Position := (Position * 100) div Header.UncompressedSize;
end;

function TMain.SelectFileName: string;
var
  LDialog: TSaveDialog;
begin
  LDialog := TSaveDialog.Create(Self);
  try
    LDialog.Filter := '|*.zip';
    LDialog.DefaultExt := '.zip';

    if LDialog.Execute then
    begin
      Exit(LDialog.FileName);
    end;

    Result := string.Empty;
  finally
    LDialog.Free;
  end;
end;

function TMain.SelectFiles: TArray<string>;
var
  LDialog: TOpenDialog;
begin
  LDialog := TOpenDialog.Create(Self);
  try
    LDialog.Options := [ofFileMustExist, ofAllowMultiSelect];

    if LDialog.Execute then
    begin
      Exit(LDialog.Files.ToStringArray);
    end;

    Result := nil;
  finally
    LDialog.Free;
  end;
end;

end.

