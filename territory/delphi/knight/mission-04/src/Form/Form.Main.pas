unit Form.Main;

interface

uses
  System.Actions, System.Classes, System.ImageList, System.IOUtils, System.SysUtils, System.Threading,
  System.Types, Vcl.ActnList, Vcl.Buttons, Vcl.Controls, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Forms, Vcl.ImgList,
  Vcl.StdCtrls;

type
  TMain = class sealed(TForm)
  {$REGION 'Visual Components'}
    ActionList: TActionList;
    ActionListFiles: TAction;
    ActionSelectPathA: TAction;
    ActionSelectPathB: TAction;
    ActionSelectPathC: TAction;
    ButtonListFiles: TButton;
    ButtonFirstPath: TSpeedButton;
    ButtonSecondPath: TSpeedButton;
    ButtonThirdPath: TSpeedButton;
    EditFirstPath: TLabeledEdit;
    EditSecondPath: TLabeledEdit;
    EditThirdPath: TLabeledEdit;
    ImageList: TImageList;
    MemoFirstPath: TMemo;
    MemoSecondPath: TMemo;
    MemoThirdPath: TMemo;
    Panel: TPanel;
  {$ENDREGION}
    procedure ActionListFilesExecute(Sender: TObject);
    procedure ActionSelectPathAExecute(Sender: TObject);
    procedure ActionSelectPathBExecute(Sender: TObject);
    procedure ActionSelectPathCExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure ClearMemos;
    procedure ListFiles;
    function SelectFolder: TFileName;
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
  EditFirstPath.Text := SelectFolder;
end;

procedure TMain.ActionSelectPathBExecute(Sender: TObject);
begin
  EditSecondPath.Text := SelectFolder;
end;

procedure TMain.ActionSelectPathCExecute(Sender: TObject);
begin
  EditThirdPath.Text := SelectFolder;
end;

procedure TMain.ClearMemos;
begin
  MemoFirstPath.Lines.Clear;
  MemoSecondPath.Lines.Clear;
  MemoThirdPath.Lines.Clear;
end;

procedure TMain.FormShow(Sender: TObject);
begin
  EditFirstPath.Text := 'C:\Windows\System32\';
  EditSecondPath.Text := 'C:\Windows\SysWOW64\';
  EditThirdPath.Text := 'C:\Program Files (x86)\Embarcadero\Studio\19.0\bin\';
end;

procedure TMain.ListFiles;
type
  TPath = (First, Second, Third);
var
  LTask: ITask;
  LTasks: array[TPath] of ITask;
begin
  LTasks[First] := TTask.Create(
    procedure
    begin
      MemoFirstPath.Lines.AddStrings(TArray<string>(TDirectory.GetFiles(EditFirstPath.Text)));
    end);

  LTasks[Second] := TTask.Create(
    procedure
    begin
      MemoSecondPath.Lines.AddStrings(TArray<string>(TDirectory.GetFiles(EditSecondPath.Text)));
    end);

  LTasks[Third] := TTask.Create(
    procedure
    begin
      MemoThirdPath.Lines.AddStrings(TArray<string>(TDirectory.GetFiles(EditThirdPath.Text)));
    end);

  for LTask in LTasks do
  begin
    LTask.Start;
  end;
end;

{$WARN SYMBOL_PLATFORM OFF}
function TMain.SelectFolder: TFileName;
var
  LDialog: TFileOpenDialog;
begin
  LDialog := TFileOpenDialog.Create(Self);
  try
    LDialog.Options := [TFileDialogOption.fdoPickFolders];

    if LDialog.Execute then
    begin
      Exit(LDialog.FileName);
    end;

    Result := string.Empty;
  finally
    LDialog.Free;
  end;
end;
{$WARN SYMBOL_PLATFORM ON}

end.

