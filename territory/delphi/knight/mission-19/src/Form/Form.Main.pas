unit Form.Main;

interface

uses
  Winapi.Windows, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls,
  Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait, Data.DB,
  FireDAC.Comp.Client, FireDAC.Phys.FB, FireDAC.Phys.IBBase, FireDAC.Comp.UI, FireDAC.Comp.Script,
  FireDAC.Comp.ScriptCommands, System.IOUtils, Vcl.StdCtrls, System.Diagnostics, System.UITypes,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt, FireDAC.Comp.DataSet, Vcl.ExtCtrls,
  System.Actions, Vcl.ActnList, FireDAC.Stan.Util, FireDAC.Phys.FBDef, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf;

type
  TMain = class sealed(TForm)
  {$REGION 'Components'}
    ButtonInsert: TButton;
    FDConnection: TFDConnection;
    FDGUIxWaitCursor: TFDGUIxWaitCursor;
    FDPhysFBDriverLink: TFDPhysFBDriverLink;
    FDQuery: TFDQuery;
    Memo: TMemo;
    Panel: TPanel;
    ActionList: TActionList;
    ActionInsert: TAction;
    FDScript: TFDScript;
  {$ENDREGION}
    procedure ActionInsertExecute(ASender: TObject);
  private
    function DatabaseExists: Boolean;
    procedure ConnectToDatabase;
    procedure LoadFile;
    procedure Insert;
    procedure RunScripts(ASender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
  end;

var
  Main: TMain;

implementation

{$R *.dfm}

constructor TMain.Create(AOwner: TComponent);
begin
  inherited;
  ConnectToDatabase;
  LoadFile;
end;

procedure TMain.ActionInsertExecute(ASender: TObject);
var
  LStopWatch: TStopWatch;
begin
  LStopWatch := TStopWatch.Create;
  LStopWatch.Start;
  Insert;
  LStopWatch.Stop;

  MessageDlg(Format('Elapsed time: %s.', [LStopWatch.Elapsed.ToString]), TMSgDlgType.mtInformation, mbOKCancel, 0);
end;

procedure TMain.ConnectToDatabase;
begin
  try
    if not DatabaseExists then
    begin
      FDConnection.AfterConnect := RunScripts;
    end;

    FDConnection.Connected := True;
  except
    on E: Exception do
    begin
      MessageDlg(Format('There was a problem connecting to the database: %s.', [E.Message]), TMSgDlgType.mtWarning, mbOKCancel, 0);
      Application.Terminate;
    end;
  end;
end;

function TMain.DatabaseExists: Boolean;
begin
  Result := TFile.Exists(FDConnection.Params.Database);
end;

procedure TMain.Insert;
type
  TParameters = (Id, Name, City, Email, Birthday, Profession, Card);
const
  ParametersNames: array[TParameters] of string = ('ID', 'NOME', 'CIDADE', 'EMAIL', 'DATANASC', 'PROFISSAO', 'CARTAO');
var
  LIndex: Integer;
  LArray: TArray<string>;
begin
  FDQuery.Params.ArraySize := Memo.Lines.Count;
  for LIndex := 0 to Pred(Memo.Lines.Count) do
  begin
    LArray := Memo.Lines[LIndex].Split([',']);

    FDQuery.ParamByName(ParametersNames[TParameters.Id]).AsIntegers[LIndex] := LArray[Ord(TParameters.Id)].ToInteger;
    FDQuery.ParamByName(ParametersNames[TParameters.Name]).AsStrings[LIndex] := LArray[Ord(TParameters.Name)];
    FDQuery.ParamByName(ParametersNames[TParameters.City]).AsStrings[LIndex] := LArray[Ord(TParameters.City)];
    FDQuery.ParamByName(ParametersNames[TParameters.Email]).AsStrings[LIndex] := LArray[Ord(TParameters.Email)];
    FDQuery.ParamByName(ParametersNames[TParameters.Birthday]).AsDateTimes[LIndex] := StrToDateTimeDef(LArray[Ord(TParameters.Birthday)], MinDateTime);
    FDQuery.ParamByName(ParametersNames[TParameters.Profession]).AsStrings[LIndex] := LArray[Ord(TParameters.Profession)];
    FDQuery.ParamByName(ParametersNames[TParameters.Card]).AsStrings[LIndex] := LArray[Ord(TParameters.Card)];
  end;

  FDQuery.Execute(FDQuery.Params.ArraySize);
end;

procedure TMain.LoadFile;
begin
  Memo.Lines.LoadFromFile('..\..\..\Dados.csv', TEncoding.UTF8);
  Memo.Lines.Delete(0);
end;

procedure TMain.RunScripts(ASender: TObject);
begin
  FDScript.ValidateAll;
  FDScript.ExecuteAll;
end;

end.

