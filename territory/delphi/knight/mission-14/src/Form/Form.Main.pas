unit Form.Main;

interface

uses
  Winapi.Windows, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls,
  Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait, Data.DB,
  FireDAC.Comp.Client, FireDAC.Phys.FB, FireDAC.Phys.IBBase, FireDAC.Comp.UI, FireDAC.Comp.Script,
  FireDAC.Comp.ScriptCommands, System.IOUtils, System.UITypes, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt, FireDAC.Comp.DataSet, Vcl.ExtCtrls, System.Actions, Vcl.ActnList, Vcl.Grids, Vcl.DBGrids,
  Vcl.ComCtrls, FireDAC.Stan.Util, FireDAC.Phys.Intf, FireDAC.Phys.FBDef, FireDAC.DApt.Intf;

type
  TMain = class sealed(TForm)
  {$REGION 'Components'}
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
    FDScript: TFDScript;
  {$ENDREGION}
  private
    function DatabaseExists: Boolean;
    procedure ConnectToDatabase;
    procedure OpenDataSets;
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
  OpenDataSets;
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

procedure TMain.RunScripts(ASender: TObject);
begin
  FDScript.ValidateAll;
  FDScript.ExecuteAll;
end;

procedure TMain.OpenDataSets;
begin
  FDQueryEmployees.Open;
  FDQueryDepartments.Open;
  FDQueryEmployeesDepartments.Open;
end;

end.

