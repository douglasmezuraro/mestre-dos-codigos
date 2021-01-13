unit Form.Main;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ActnList, Vcl.StdCtrls,
  System.Zip, Vcl.ComCtrls, System.UITypes, System.Actions, Impl.Zip;

type
  TMain = class sealed(TForm)
  {$REGION 'Components'}
    ActionCompress: TAction;
    ActionList: TActionList;
    ActionSelectFileName: TAction;
    ActionSelectFiles: TAction;
    ButtonCompress: TButton;
    ButtonSelectFileName: TButton;
    ButtonSelectFiles: TButton;
    EditFileName: TEdit;
    GroupBoxInput: TGroupBox;
    GroupBoxOutput: TGroupBox;
    Memo: TMemo;
    ProgressBar: TProgressBar;
  {$ENDREGION}
    procedure ActionCompressExecute(ASender: TObject);
    procedure OnProgress(ASender: TObject; FileName: string; AHeader: TZipHeader; APosition: Int64);
    procedure ActionSelectFilesExecute(ASender: TObject);
    procedure ActionSelectFileNameExecute(ASender: TObject);
  strict private
    FZipWrapper: TZipWrapper;
  private
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

procedure TMain.ActionCompressExecute(ASender: TObject);
begin
  ProgressBar.Position := 0;
  Compress;
end;

procedure TMain.ActionSelectFileNameExecute(ASender: TObject);
begin
  FZipWrapper.FileName := SelectFileName;
  EditFileName.Text := FZipWrapper.FileName;
end;

procedure TMain.ActionSelectFilesExecute(ASender: TObject);
begin
  FZipWrapper.Files := SelectFiles;
  Memo.Lines.Clear;
  Memo.Lines.AddStrings(FZipWrapper.Files);
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

procedure TMain.OnProgress(ASender: TObject; FileName: string; AHeader: TZipHeader; APosition: Int64);
begin
  ProgressBar.Position := (APosition * 100) div AHeader.UncompressedSize;
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

