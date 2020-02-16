unit Form.Main;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ActnList, Vcl.StdCtrls,
  System.Zip, Vcl.ComCtrls, System.IOUtils, System.UITypes, System.Actions, Helper.ZipFile;

type
  TMain = class sealed(TForm)
    ActionList: TActionList;
    ActionCompress: TAction;
    ButtonCompress: TButton;
    ProgressBarCompression: TProgressBar;
    procedure ActionSelectFileExecute(Sender: TObject);
    procedure ActionCompressExecute(Sender: TObject);
    procedure OnProgress(Sender: TObject; FileName: string; Header: TZipHeader; Position: Int64);
  private
    FSourceFiles: TArray<string>;
    FTargetFile: TFileName;
    function SelectSourceFiles: Boolean;
    function SelectTargetFile: Boolean;
    procedure CompressFiles;
  end;

var
  Main: TMain;

implementation

{$R *.dfm}

procedure TMain.ActionCompressExecute(Sender: TObject);
begin
  if not SelectSourceFiles then
    Exit;

  if not SelectTargetFile then
    Exit;

  CompressFiles;
end;

procedure TMain.ActionSelectFileExecute(Sender: TObject);
begin
  SelectSourceFiles;
end;

procedure TMain.CompressFiles;
var
  ZipFile: TZipFile;
begin
  ZipFile := TZipFile.Create;
  try
    ZipFile.OnProgress := OnProgress;
    ZipFile.Open(FTargetFile, TZipMode.zmWrite);
    ZipFile.Add(FSourceFiles);
    ZipFile.Close;
  finally
    ZipFile.Free;
  end;
end;

procedure TMain.OnProgress(Sender: TObject; FileName: string; Header: TZipHeader; Position: Int64);
begin
  ProgressBarCompression.Position := (Position * 100) div Header.UncompressedSize;
end;

function TMain.SelectTargetFile: Boolean;
var
  Dialog: TSaveDialog;
begin
  Dialog := TSaveDialog.Create(Self);
  try
    Dialog.Filter := '|*.zip';
    Dialog.DefaultExt := 'zip';

    if not Dialog.Execute then
      Exit(False);

    FTargetFile := Dialog.FileName;
    Result := True;
  finally
    Dialog.Free;
  end;
end;

function TMain.SelectSourceFiles: Boolean;
var
  Dialog: TOpenDialog;
  FileName: string;
begin
  Dialog := TOpenDialog.Create(Self);
  try
    Dialog.Options := [ofFileMustExist, ofAllowMultiSelect];

    if not Dialog.Execute then
      Exit(False);

    for FileName in Dialog.Files.ToStringArray do
    begin
      if TPath.GetExtension(FileName).Equals('.exe') then
      begin
        MessageDlg('Selecting files with ".exe" extension is not allowed.', TMsgDlgType.mtWarning, [mbOk], 0);
        Exit(False);
      end;
    end;

    FSourceFiles := Dialog.Files.ToStringArray;
    Result := True;
  finally
    Dialog.Free;
  end;
end;

end.
