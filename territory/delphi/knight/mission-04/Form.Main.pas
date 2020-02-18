unit Form.Main;

interface

uses
  System.Actions, System.Classes, System.ImageList, System.IOUtils, System.SysUtils, System.Threading,
  System.Types, Vcl.ActnList, Vcl.Buttons, Vcl.Controls, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Forms, Vcl.ImgList,
  Vcl.StdCtrls;

type
  TMain = class sealed(TForm)
    ActionList: TActionList;
    ActionListFiles: TAction;
    ActionSelectPathA: TAction;
    ActionSelectPathB: TAction;
    ActionSelectPathC: TAction;
    ButtonListFiles: TButton;
    ButtonPathA: TSpeedButton;
    ButtonPathB: TSpeedButton;
    ButtonPathC: TSpeedButton;
    EditPathA: TLabeledEdit;
    EditPathB: TLabeledEdit;
    EditPathC: TLabeledEdit;
    ImageList: TImageList;
    MemoFilesA: TMemo;
    MemoFilesB: TMemo;
    MemoFilesC: TMemo;
    PanelPaths: TPanel;
    procedure ActionListFilesExecute(Sender: TObject);
    procedure ActionSelectPathAExecute(Sender: TObject);
    procedure ActionSelectPathBExecute(Sender: TObject);
    procedure ActionSelectPathCExecute(Sender: TObject);
  private
    procedure ClearMemos;
    procedure ListFiles;
    function SelectFolder: TFileName;
  public
    procedure AfterConstruction; override;
  end;

var
  Main: TMain;

implementation

{$R *.dfm}

procedure TMain.ActionListFilesExecute(Sender: TObject);
begin
  ClearMemos;
  ListFiles;
end;

procedure TMain.ActionSelectPathAExecute(Sender: TObject);
begin
  EditPathA.Text := SelectFolder;
end;

procedure TMain.ActionSelectPathBExecute(Sender: TObject);
begin
  EditPathB.Text := SelectFolder;
end;

procedure TMain.ActionSelectPathCExecute(Sender: TObject);
begin
  EditPathC.Text := SelectFolder;
end;

procedure TMain.AfterConstruction;
begin
  inherited;
  EditPathA.Text := 'C:\Windows\System32\';
  EditPathB.Text := 'Q:\Lib\';
  EditPathC.Text := 'C:\Windows\SysWOW64\';
end;

procedure TMain.ClearMemos;
begin
  MemoFilesA.Lines.Clear;
  MemoFilesB.Lines.Clear;
  MemoFilesC.Lines.Clear;
end;

procedure TMain.ListFiles;
type
  TPath = (A, B, C);
var
  Tasks: array[TPath] of ITask;
begin
  Tasks[A] := TTask.Create(
    procedure
    begin
      MemoFilesA.Lines.AddStrings(TArray<string>(TDirectory.GetFiles(EditPathA.Text)));
    end);
  Tasks[A].Start;

  Tasks[B] := TTask.Create(
    procedure
    begin
      MemoFilesB.Lines.AddStrings(TArray<string>(TDirectory.GetFiles(EditPathB.Text)));
    end);
  Tasks[B].Start;

  Tasks[C] := TTask.Create(
    procedure
    begin
      MemoFilesC.Lines.AddStrings(TArray<string>(TDirectory.GetFiles(EditPathC.Text)));
    end);
  Tasks[C].Start;
end;

{$WARN SYMBOL_PLATFORM OFF}
function TMain.SelectFolder: TFileName;
var
  Dialog: TFileOpenDialog;
begin
  Dialog := TFileOpenDialog.Create(Self);
  try
    Dialog.Options := Dialog.Options + [fdoPickFolders];

    if Dialog.Execute then
    begin
      Exit(Dialog.FileName);
    end;
  finally
    Dialog.Free;
  end;

  Result := string.Empty;
end;
{$WARN SYMBOL_PLATFORM ON}

end.

