unit Form.Main;

interface

uses
  Winapi.Windows, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls,
  Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait, Data.DB,
  FireDAC.Comp.Client, FireDAC.Phys.FB, FireDAC.Phys.IBBase, FireDAC.Comp.UI, FireDAC.Comp.Script,
  FireDAC.Comp.ScriptCommands, System.IOUtils, Vcl.StdCtrls, System.Diagnostics, System.UITypes,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt, FireDAC.Comp.DataSet, Vcl.ExtCtrls, FireDAC.Phys.FBDef,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, System.Actions, Vcl.ActnList, FireDAC.Stan.Util;

type
  TMain = class sealed(TForm)
  {$REGION 'Visual Components'}
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
    procedure ActionInsertExecute(Sender: TObject);
  private
    function DatabaseExists: Boolean;
    procedure ConnectToDatabase;
    procedure LoadFile;
    procedure Insert;
    procedure RunScripts(Sender: TObject);
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

procedure TMain.ActionInsertExecute(Sender: TObject);
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
    on Error: Exception do
    begin
      raise Exception.CreateFmt('There was a problem connecting to the database: %s.', [Error.Message]);
      Application.Terminate;
    end;
  end;
end;

function TMain.DatabaseExists: Boolean;
begin
  Result := TFile.Exists(FDConnection.Params.Database);
end;

procedure TMain.Insert;
var
  LIndex: Integer;
  LArray: TArray<string>;
begin
  FDQuery.Params.ArraySize := Memo.Lines.Count;
  for LIndex := 0 to Pred(Memo.Lines.Count) do
  begin
    LArray := Memo.Lines[LIndex].Split([',']);

    FDQuery.ParamByName('ID').AsIntegers[LIndex] := LArray[0].ToInteger;
    FDQuery.ParamByName('NOME').AsStrings[LIndex] := LArray[1];
    FDQuery.ParamByName('CIDADE').AsStrings[LIndex] := LArray[2];
    FDQuery.ParamByName('EMAIL').AsStrings[LIndex] := LArray[3];
    FDQuery.ParamByName('DATANASC').AsDateTimes[LIndex] := StrToDateTimeDef(LArray[4], MinDateTime);
    FDQuery.ParamByName('PROFISSAO').AsStrings[LIndex] := LArray[5];
    FDQuery.ParamByName('CARTAO').AsStrings[LIndex] := LArray[6];
  end;

  FDQuery.Execute(FDQuery.Params.ArraySize);
end;

procedure TMain.LoadFile;
begin
  Memo.Lines.LoadFromFile('..\..\..\Dados.csv', TEncoding.UTF8);
  Memo.Lines.Delete(0);
end;

procedure TMain.RunScripts(Sender: TObject);
begin
  FDScript.ValidateAll;
  FDScript.ExecuteAll;
end;

end.

