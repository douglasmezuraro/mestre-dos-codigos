unit DataModule.Global;

interface

uses
  System.SysUtils, System.Classes, System.IOUtils, Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait,
  FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Script, FireDAC.Comp.ScriptCommands, Vcl.Forms,
  FireDAC.Comp.UI, FireDAC.Phys.IBBase;

type
  TDM = class sealed(TDataModule)
    FDConnection: TFDConnection;
    FDQueryEmployees: TFDQuery;
    FDQueryDepartments: TFDQuery;
    FDPhysFBDriverLink: TFDPhysFBDriverLink;
    FDGUIxWaitCursor: TFDGUIxWaitCursor;
    FDQueryEmployeesDepartments: TFDQuery;
  private
    function GetDatabasePath: string;
    function ConnectToDatabase: Boolean;
    function DatabaseExists: Boolean;
    function GetScript: TArray<string>;
    procedure RunInitialMigration(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
  end;

var
  DM: TDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

constructor TDM.Create(AOwner: TComponent);
begin
  inherited;
  ConnectToDatabase;
end;

function TDM.ConnectToDatabase: Boolean;
begin
  if not DatabaseExists then
  begin
    FDConnection.AfterConnect := RunInitialMigration;
  end;

  FDConnection.Params.Values['Database'] := GetDatabasePath;

  FDConnection.Connected := True;
  Result := FDConnection.Connected;

  FDQueryEmployees.UpdateOptions.GeneratorName := 'GEN_FUNCIONARIO';
  FDQueryEmployees.UpdateOptions.AutoIncFields := 'ID';
  FDQueryEmployees.UpdateOptions.FetchGeneratorsPoint := TFDFetchGeneratorsPoint.gpDeferred;
  FDQueryEmployees.Open('SELECT * FROM FUNCIONARIO');

  FDQueryDepartments.UpdateOptions.GeneratorName := 'GEN_DEPARTAMENTO';
  FDQueryDepartments.UpdateOptions.AutoIncFields := 'ID';
  FDQueryDepartments.UpdateOptions.FetchGeneratorsPoint := TFDFetchGeneratorsPoint.gpDeferred;
  FDQueryDepartments.Open('SELECT * FROM DEPARTAMENTO');

  FDQueryEmployeesDepartments.Open('SELECT * FROM FUNCIONARIO_DEPARTAMENTO');
end;

function TDM.DatabaseExists: Boolean;
begin
  Result := TFile.Exists(GetDatabasePath);
end;

function TDM.GetDatabasePath: string;
begin
  Result := 'C:\database.fdb';
end;

function TDM.GetScript: TArray<string>;
var
  LResourceStream: TResourceStream;
  LStringList: TStringList;
begin
  LStringList := TStringList.Create;
  LResourceStream := TResourceStream.Create(HInstance, 'script', PChar('sql'));
  try
    LResourceStream.Position := 0;
    LStringList.LoadFromStream(LResourceStream);
    Result := LStringList.ToStringArray;
  finally
    LResourceStream.Free;
    LStringList.Free;
  end;
end;

procedure TDM.RunInitialMigration(Sender: TObject);
var
  LRunner: TFDScript;
  LScript: TFDSQLScript;
begin
  LRunner := TFDScript.Create(Self);
  try
    LRunner.Connection := FDConnection;
    LScript := LRunner.SQLScripts.Add;
    LScript.SQL.AddStrings(GetScript);
    LRunner.ValidateAll;
    LRunner.ExecuteAll;
  finally
    LRunner.Free;
  end;
end;

end.

