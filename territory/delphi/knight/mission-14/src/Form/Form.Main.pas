unit Form.Main;

interface

uses
  Winapi.Windows, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls,
  Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait, Data.DB,
  FireDAC.Comp.Client, FireDAC.Phys.FB, FireDAC.Phys.IBBase, FireDAC.Comp.UI, FireDAC.Comp.Script,
  FireDAC.Comp.ScriptCommands, System.IOUtils, Vcl.StdCtrls, System.Diagnostics, System.UITypes,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt, FireDAC.Comp.DataSet, Vcl.ExtCtrls, FireDAC.Phys.FBDef,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, System.Actions, Vcl.ActnList, Vcl.Grids, Vcl.DBGrids,
  Vcl.ComCtrls;

type
  TMain = class sealed(TForm)
  {$REGION 'Visual Components'}
    DataSourceDepartments: TDataSource;
    DataSourceEmployees: TDataSource;
    DataSourceEmployeesDepartments: TDataSource;
    FDConnection: TFDConnection;
    FDGUIxWaitCursor: TFDGUIxWaitCursor;
    FDPhysFBDriverLink: TFDPhysFBDriverLink;
    FDQueryDepartments: TFDQuery;
    FDQueryEmployees: TFDQuery;
    FDQueryEmployeesDepartments: TFDQuery;
    GridDepartments: TDBGrid;
    GridEmployees: TDBGrid;
    GridEmployeesDepartments: TDBGrid;
    PageControl: TPageControl;
    TabSheetDepartments: TTabSheet;
    TabSheetEmployees: TTabSheet;
    TabSheetEmployeesDepartments: TTabSheet;
  {$ENDREGION}
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
  Main: TMain;

implementation

{$R *.dfm}

procedure TMain.ConnectToDatabase;
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
    on Error: Exception do
    begin
      raise Exception.CreateFmt('There was a problem connecting to the database: %s.', [Error.Message]);
      Application.Terminate;
    end;
  end;
end;

constructor TMain.Create(AOwner: TComponent);
begin
  inherited;
  ConnectToDatabase;
  SetUp;
end;

function TMain.DatabaseExists: Boolean;
begin
  Result := TFile.Exists(GetDatabasePath);
end;

function TMain.GetDatabasePath: string;
begin
  Result := 'C:\MISSION_14.fdb';
end;

function TMain.GetScripts: TArray<string>;
begin
  Result := [
    ' CREATE DOMAIN TString VARCHAR(80);                                    ',
    ' CREATE DOMAIN TDateTime TIMESTAMP;                                    ',
    ' CREATE DOMAIN TDouble DECIMAL(10, 2);                                 ',
    ' CREATE DOMAIN TInteger INTEGER;                                       ',
    ' CREATE DOMAIN TPhone CHAR(11);                                        ',
    '                                                                       ',
    ' CREATE SEQUENCE GEN_FUNCIONARIO;                                      ',
    ' CREATE SEQUENCE GEN_DEPARTAMENTO;                                     ',
    '                                                                       ',
    ' CREATE TABLE FUNCIONARIO                                              ',
    '     (                                                                 ',
    '         ID TInteger PRIMARY KEY,                                      ',
    '         NOME TString,                                                 ',
    '         ADMISSAO TDateTime,                                           ',
    '         SALARIO TDouble                                               ',
    '     );                                                                ',
    '                                                                       ',
    ' CREATE TABLE DEPARTAMENTO                                             ',
    '     (                                                                 ',
    '         ID TInteger PRIMARY KEY,                                      ',
    '         DESCRICAO TString,                                            ',
    '         TELEFONE TPhone                                               ',
    '     );                                                                ',
    '                                                                       ',
    ' CREATE TABLE FUNCIONARIO_DEPARTAMENTO                                 ',
    '     (                                                                 ',
    '         FUNCIONARIO_ID TInteger NOT NULL REFERENCES FUNCIONARIO(ID),  ',
    '         DEPARTAMENTO_ID TInteger NOT NULL REFERENCES DEPARTAMENTO(ID) ',
    '     );                                                                '
  ];
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

procedure TMain.SetUp;
begin
  FDQueryEmployees.UpdateOptions.GeneratorName := 'GEN_FUNCIONARIO';
  FDQueryEmployees.UpdateOptions.AutoIncFields := 'ID';
  FDQueryEmployees.UpdateOptions.FetchGeneratorsPoint := TFDFetchGeneratorsPoint.gpDeferred;
  FDQueryEmployees.Open('SELECT * FROM FUNCIONARIO');

  FDQueryDepartments.UpdateOptions.GeneratorName := 'GEN_DEPARTAMENTO';
  FDQueryDepartments.UpdateOptions.AutoIncFields := 'ID';
  FDQueryDepartments.UpdateOptions.FetchGeneratorsPoint := TFDFetchGeneratorsPoint.gpDeferred;
  FDQueryDepartments.Open('SELECT * FROM DEPARTAMENTO');

  FDQueryEmployeesDepartments.Open('SELECT FUNCIONARIO_ID AS FUNCIONARIO, DEPARTAMENTO_ID AS DEPARTAMENTO FROM FUNCIONARIO_DEPARTAMENTO');
end;

end.

