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
  TDM = class(TDataModule)
    FDConnection: TFDConnection;
    FDQueryEmployees: TFDQuery;
    FieldFDQueryFuncionariosID: TIntegerField;
    FieldFDQueryFuncionariosNOME: TStringField;
    TimeStampFieldFDQueryFuncionariosADMISSAO: TSQLTimeStampField;
    BCDFieldFDQueryFuncionariosSALARIO: TBCDField;
    FDQueryDepartments: TFDQuery;
    FDPhysFBDriverLink: TFDPhysFBDriverLink;
    FDGUIxWaitCursor: TFDGUIxWaitCursor;
    FDQueryEmployeesDepartments: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    function GetDatabasePath: string;
    function ConnectToDatabase: Boolean;
    function DatabaseExists: Boolean;
    procedure RunInitialMigration(Sender: TObject);
  end;

var
  DM: TDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

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

procedure TDM.DataModuleCreate(Sender: TObject);
begin
  ConnectToDatabase;
end;

function TDM.GetDatabasePath: string;
begin
  Result := 'C:\database.fdb';
end;

procedure TDM.RunInitialMigration(Sender: TObject);
const
  SQL = 'CREATE DOMAIN TString VARCHAR(80);'+
        'CREATE DOMAIN TDateTime TIMESTAMP;'+
        'CREATE DOMAIN TDouble DECIMAL(18, 4);'+
        'CREATE DOMAIN TInteger INTEGER;'+
        'CREATE DOMAIN TPhone CHAR(11);'+
        ''+
        'CREATE TABLE FUNCIONARIO'+
        '    ('+
        '        ID TInteger PRIMARY KEY,'+
        '        NOME TString,'+
        '        ADMISSAO TDateTime,'+
        '        SALARIO TDouble'+
        '    );'+
        ''+
        'CREATE TABLE DEPARTAMENTO'+
        '    ('+
        '        ID TInteger PRIMARY KEY,'+
        '        DESCRICAO TString,'+
        '        TELEFONE TPhone'+
        '    );'+
        ''+
        'CREATE TABLE FUNCIONARIO_DEPARTAMENTO'+
        '    ('+
        '        FUNCIONARIO_ID TInteger NOT NULL REFERENCES FUNCIONARIO(ID),'+
        '        DEPARTAMENTO_ID TInteger NOT NULL REFERENCES DEPARTAMENTO(ID)'+
        '    );'+
        ''+
        'CREATE SEQUENCE GEN_FUNCIONARIO;'+
        'CREATE SEQUENCE GEN_DEPARTAMENTO;';
var
  LRunner: TFDScript;
  LScript: TFDSQLScript;
begin
  LRunner := TFDScript.Create(Self);
  try
    LRunner.Connection := FDConnection;
    LScript := LRunner.SQLScripts.Add;
    LScript.SQL.Add(SQL);
    LRunner.ValidateAll;
    LRunner.ExecuteAll;
  finally
    LRunner.Free;
  end;
end;

end.

