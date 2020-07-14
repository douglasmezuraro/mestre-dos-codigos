unit Form.Main;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ActnList, Vcl.StdCtrls,
  System.Zip, Vcl.ComCtrls, System.Generics.Collections, System.UITypes, System.Actions, System.IOUtils, Impl.Zip;

type
  TMain = class sealed(TForm)
    ActionList: TActionList;
    ActionCompress: TAction;
    ButtonCompress: TButton;
    ProgressBarCompression: TProgressBar;
    MemoFiles: TMemo;
    ButtonSelectFiles: TButton;
    ActionSelectFiles: TAction;
    ActionSelectFileName: TAction;
    EditFileName: TEdit;
    ButtonSelectFileName: TButton;
    procedure ActionCompressExecute(Sender: TObject);
    procedure OnProgress(Sender: TObject; FileName: string; Header: TZipHeader; Position: Int64);
    procedure ActionSelectFilesExecute(Sender: TObject);
    procedure ActionSelectFileNameExecute(Sender: TObject);
  private
    FZip: TZip;
    function SelectFiles: TArray<string>;
    function SelectFileName: string;
    function Validate(out Message: string): Boolean;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

var
  Main: TMain;

implementation

{$R *.dfm}

procedure TMain.ActionCompressExecute(Sender: TObject);
var
  Message: string;
begin
  if Validate(Message) then
  begin
    FZip.Compress;
    Exit;
  end;

  MessageDlg(Message, TmsgDlgType.mtWarning, [mbOk], 0);
end;

procedure TMain.ActionSelectFileNameExecute(Sender: TObject);
begin
  FZip.FileName := SelectFileName;
  EditFileName.Text := FZip.FileName;
end;

procedure TMain.ActionSelectFilesExecute(Sender: TObject);
begin
  FZip.Files := SelectFiles;
  MemoFiles.Lines.AddStrings(FZip.Files);
end;

constructor TMain.Create(AOwner: TComponent);
begin
  inherited;
  FZip := TZip.Create;
  FZip.OnProgress := OnProgress;
end;

destructor TMain.Destroy;
begin
  FZip.Free;
  inherited;
end;

procedure TMain.OnProgress(Sender: TObject; FileName: string; Header: TZipHeader; Position: Int64);
begin
  ProgressBarCompression.Position := (Position * 100) div Header.UncompressedSize;
end;

function TMain.SelectFileName: string;
var
  Dialog: TSaveDialog;
begin
  Dialog := TSaveDialog.Create(Self);
  try
    Dialog.Filter := '|*.zip';
    Dialog.DefaultExt := '.zip';

    if Dialog.Execute then
    begin
      Exit(Dialog.FileName);
    end;

    Result := string.Empty;
  finally
    Dialog.Free;
  end;
end;

function TMain.SelectFiles: TArray<string>;
var
  Dialog: TOpenDialog;
begin
  Dialog := TOpenDialog.Create(Self);
  try
    Dialog.Options := [ofFileMustExist, ofAllowMultiSelect];

    if Dialog.Execute then
    begin
      Exit(Dialog.Files.ToStringArray);
    end;

    Result := nil;
  finally
    Dialog.Free;
  end;
end;

function TMain.Validate(out Message: string): Boolean;
var
  FileName: string;
begin
  if FZip.Files = nil then
  begin
    Message := 'You must select at least one file.';
    Exit(False);
  end;

  if FZip.FileName.Trim.IsEmpty then
  begin
    Message := 'It is necessary to select the file to be saved.';
    Exit(False);
  end;

  for FileName in FZip.Files do
  begin
    if TPath.GetExtension(FileName).Equals('.exe') then
    begin
      Message := 'Files with the extension ".exe" are not allowed.';
      Exit(False);
    end;
  end;

  Result := True;
end;

end.

