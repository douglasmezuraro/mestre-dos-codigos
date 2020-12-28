unit Form.Main;

interface

uses
  Winapi.Windows, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls,
  Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait, Data.DB,
  FireDAC.Comp.Client, FireDAC.Phys.FB, FireDAC.Phys.IBBase, FireDAC.Comp.UI, FireDAC.Comp.Script,
  FireDAC.Comp.ScriptCommands, System.IOUtils, Vcl.StdCtrls, System.Diagnostics, System.UITypes,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt, FireDAC.Comp.DataSet, Vcl.ExtCtrls, FireDAC.Phys.FBDef,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, System.Actions, Vcl.ActnList;

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
  {$ENDREGION}
    procedure ActionInsertExecute(Sender: TObject);
  private
    function GetDatabasePath: string;
    function DatabaseExists: Boolean;
    function GetScripts: TArray<string>;
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
    FDConnection.Params.Values['DriverID'] := 'FB';
    FDConnection.Params.Values['OpenMode'] := 'OpenOrCreate';
    FDConnection.Params.Values['CharacterSet'] := 'WIN1252';
    FDConnection.Params.Values['Database'] := GetDatabasePath;
    FDConnection.Params.Values['ExtendedMetadata'] := 'True';
    FDConnection.Params.Values['OSAuthent'] := 'No';
    FDConnection.Params.Values['Password'] := 'masterkey';
    FDConnection.Params.Values['SQLDialect'] := '3';
    FDConnection.Params.Values['User_name'] := 'sysdba';

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
  Result := TFile.Exists(GetDatabasePath);
end;

function TMain.GetDatabasePath: string;
begin
  Result := 'C:\MISSION_19.fdb';
end;

function TMain.GetScripts: TArray<string>;
begin
  Result := [
    ' CREATE TABLE FUNCIONARIO         ',
    '     (                            ',
    '         ID INTEGER,              ',
    '         NOME VARCHAR (180),      ',
    '         CIDADE VARCHAR (180),    ',
    '         EMAIL VARCHAR (180),     ',
    '         DATANASC TIMESTAMP,      ',
    '         PROFISSAO VARCHAR (180), ',
    '         CARTAO VARCHAR (180)     ',
    '     );                           '
  ];
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
var
  LRunner: TFDScript;
  LScript: TFDSQLScript;
begin
  LRunner := TFDScript.Create(Self);
  try
    LRunner.Connection := FDConnection;
    LScript := LRunner.SQLScripts.Add;
    LScript.SQL.AddStrings(GetScripts);
    LRunner.ValidateAll;
    LRunner.ExecuteAll;
  finally
    LRunner.Free;
  end;
end;

end.

