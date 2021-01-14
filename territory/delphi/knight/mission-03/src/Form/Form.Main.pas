unit Form.Main;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ActnList, Vcl.StdCtrls,
  Vcl.ComCtrls, System.UITypes, System.Actions, Zip;

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
  private
    function SelectFiles: TArray<string>;
    function SelectFileName: string;
    procedure Compress;
  end;

var
  Main: TMain;

implementation

{$R *.dfm}

procedure TMain.ActionCompressExecute(ASender: TObject);
begin
  ProgressBar.Position := 0;
  Compress;
end;

procedure TMain.ActionSelectFileNameExecute(ASender: TObject);
begin
  EditFileName.Text := SelectFileName;
end;

procedure TMain.ActionSelectFilesExecute(ASender: TObject);
begin
  Memo.Lines.Clear;
  Memo.Lines.AddStrings(SelectFiles);
end;

procedure TMain.Compress;
var
  LZip: TZipWrapper;
  LZipDTO: TZipDTO;
begin
  try
    LZipDTO.Files := Memo.Lines.ToStringArray;
    LZipDTO.FileName := EditFileName.Text;
    LZipDTO.OnProgress := OnProgress;
    LZipDTO.InvalidExtensions := ['.exe'];

    LZip := TZipWrapper.Create(LZipDTO);
    try
      LZip.Compress;
    finally
      LZip.Free;
    end;
  except
    on E: EZipArgumentException do
    begin
      MessageDlg(E.Message, TmsgDlgType.mtWarning, [mbOk], 0);
    end;

    on E: Exception do
    begin
      MessageDlg('Unhandled error: ' + E.Message, TmsgDlgType.mtWarning, [mbOk], 0);
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

