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
    function DatabaseExists: Boolean;
    function GetScripts: TArray<string>;
    procedure ConnectToDatabase;
    procedure SetUp;
    procedure RunScripts(Sender: TObject);
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
  SetUp;
end;

procedure TDM.ConnectToDatabase;
begin
  try
    FDConnection.Params.Values['CharacterSet'] := 'WIN1252';
    FDConnection.Params.Values['Database'] := GetDatabasePath;
    FDConnection.Params.Values['ExtendedMetadata'] := 'True';
    FDConnection.Params.Values['OpenMode'] := 'OpenOrCreate';
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
    raise Exception.Create('There was a problem connecting to the database.');
    Application.Terminate;
  end;
end;

procedure TDM.SetUp;
begin
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

function TDM.GetScripts: TArray<string>;
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

procedure TDM.RunScripts(Sender: TObject);
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

