unit Form.Main;

interface

uses
  System.SysUtils, System.Classes, Vcl.Buttons, System.ImageList, Vcl.ImgList, System.Actions,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ActnList, System.Threading,
  System.IOUtils, System.Types;

type
  TMain = class(TForm)
    ActionList: TActionList;
    ActionSelectPathA: TAction;
    ActionSelectPathB: TAction;
    ActionSelectPathC: TAction;
    ActionListFiles: TAction;
    MemoFilesA: TMemo;
    MemoFilesB: TMemo;
    MemoFilesC: TMemo;
    ImageList: TImageList;
    PanelPaths: TPanel;
    EditPathA: TLabeledEdit;
    ButtonPathA: TSpeedButton;
    EditPathB: TLabeledEdit;
    ButtonPathB: TSpeedButton;
    EditPathC: TLabeledEdit;
    ButtonPathC: TSpeedButton;
    ButtonListFiles: TButton;
    procedure ActionSelectPathAExecute(Sender: TObject);
    procedure ActionSelectPathBExecute(Sender: TObject);
    procedure ActionSelectPathCExecute(Sender: TObject);
    procedure ActionListFilesExecute(Sender: TObject);
  private
    type TPath = (A, B, C);
    procedure ClearMemos;
    procedure SelectFolder(const Path: TPath);
    procedure ListFiles;
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
  SelectFolder(TPath.A);
end;

procedure TMain.ActionSelectPathBExecute(Sender: TObject);
begin
  SelectFolder(TPath.B);
end;

procedure TMain.ActionSelectPathCExecute(Sender: TObject);
begin
  SelectFolder(TPath.C);
end;

procedure TMain.AfterConstruction;
begin
  inherited;
  EditPathA.Text := 'C:\Windows\System32';
  EditPathB.Text := 'C:\Windows\';
  EditPathC.Text := 'C:\Windows\SysWOW64';
end;

procedure TMain.ClearMemos;
begin
  MemoFilesA.Lines.Clear;
  MemoFilesB.Lines.Clear;
  MemoFilesC.Lines.Clear;
end;

procedure TMain.ListFiles;
var
  Tasks: array[TPath] of ITask;
begin
  Tasks[TPath.A] := TTask.Create(
    procedure
    begin
      MemoFilesA.Lines.AddStrings(TArray<string>(TDirectory.GetFiles(EditPathA.Text)));
    end);
  Tasks[TPath.A].Start;

  Tasks[TPath.B] := TTask.Create(
    procedure
    begin
      MemoFilesB.Lines.AddStrings(TArray<string>(TDirectory.GetFiles(EditPathB.Text)));
    end);
  Tasks[TPath.B].Start;

  Tasks[TPath.C] := TTask.Create(
    procedure
    begin
      MemoFilesC.Lines.AddStrings(TArray<string>(TDirectory.GetFiles(EditPathC.Text)));
    end);
  Tasks[TPath.C].Start;
end;

{$WARN SYMBOL_PLATFORM OFF}
procedure TMain.SelectFolder(const Path: TPath);
var
  Dialog: TFileOpenDialog;
begin
  Dialog := TFileOpenDialog.Create(Self);
  try
    Dialog.Options := [fdoPickFolders];

    if Dialog.Execute then
    begin
      case Path of
        TPath.A : EditPathA.Text := Dialog.FileName;
        TPath.B : EditPathB.Text := Dialog.FileName;
        TPath.C : EditPathC.Text := Dialog.FileName;
      end;
    end;
  finally
    Dialog.Free;
  end;
end;
{$WARN SYMBOL_PLATFORM ON}

end.
