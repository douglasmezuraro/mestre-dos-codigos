unit Form.Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, System.Actions, Vcl.ActnList,

  //

  System.Threading, System.IOUtils, System.Types;

type
  TPath = (A, B, C);

  TMain = class(TForm)
    GroupBoxPaths: TGroupBox;
    EditPathA: TLabeledEdit;
    EditPathB: TLabeledEdit;
    EditPathC: TLabeledEdit;
    ButtonPathA: TButton;
    ButtonPathB: TButton;
    ButtonPathC: TButton;
    ActionList: TActionList;
    ActionSelectPathA: TAction;
    ActionSelectPathB: TAction;
    ActionSelectPathC: TAction;
    MemoFilesA: TMemo;
    MemoFilesB: TMemo;
    MemoFilesC: TMemo;
    ButtonListFiles: TButton;
    ActionListFiles: TAction;
    Button1: TButton;
    procedure ActionSelectPathAExecute(Sender: TObject);
    procedure ActionSelectPathBExecute(Sender: TObject);
    procedure ActionSelectPathCExecute(Sender: TObject);
    procedure ActionListFilesExecute(Sender: TObject);
  private
    procedure SelectFolder(const Path: TPath);
    procedure ListFiles;
    function GetPath(const Path: TPath): TFileName;
    procedure SetFiles(const Path: TPath; const Files: TArray<string>);
  public
    procedure AfterConstruction; override;
  end;

var
  Main: TMain;

implementation

{$R *.dfm}

procedure TMain.ActionListFilesExecute(Sender: TObject);
begin
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
  EditPathB.Text := 'C:\Windows\System32';
  EditPathC.Text := 'C:\Windows\System32';
end;

function TMain.GetPath(const Path: TPath): TFileName;
begin
  case Path of
    TPath.A : Result := EditPathA.Text;
    TPath.B : Result := EditPathB.Text;
    TPath.C : Result := EditPathC.Text;
  end;
end;

procedure TMain.ListFiles;
var
  Tasks: array[TPath] of ITask;
begin
  Tasks[TPath.A] := TTask.Create(
    procedure
    begin
      SetFiles(TPath.A, TArray<string>(TDirectory.GetFiles(EditPathA.Text)));
    end);
  Tasks[TPath.A].Start;

  Tasks[TPath.B] := TTask.Create(
    procedure
    begin
      SetFiles(TPath.B, TArray<string>(TDirectory.GetFiles(EditPathB.Text)));
    end);
  Tasks[TPath.B].Start;

  Tasks[TPath.C] := TTask.Create(
    procedure
    begin
      SetFiles(TPath.C, TArray<string>(TDirectory.GetFiles(EditPathC.Text)));
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

procedure TMain.SetFiles(const Path: TPath; const Files: TArray<string>);

  function GetMemo: TMemo;
  begin
    case Path of
      TPath.A : Result := MemoFilesA;
      TPath.B : Result := MemoFilesB;
      TPath.C : Result := MemoFilesC;
    else
      raise EArgumentException.Create('Erro');
    end;
  end;

var
  Memo: TMemo;
begin
  Memo := GetMemo;
  Memo.Lines.Clear;
  Memo.Lines.AddStrings(Files);
end;

{$WARN SYMBOL_PLATFORM ON}

end.
