unit Form.Main;

interface

uses
  Data.DB, FireDAC.Comp.Client, FireDAC.Comp.DataSet, FireDAC.Comp.UI, FireDAC.DApt,
  FireDAC.DApt.Intf, FireDAC.DatS, FireDAC.Phys, FireDAC.Phys.Intf, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Phys.SQLiteVDataSet, FireDAC.Stan.Async, FireDAC.Stan.Def,
  FireDAC.Stan.Error, FireDAC.Stan.ExprFuncs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Pool, FireDAC.Stan.StorageXML, FireDAC.UI.Intf,
  FireDAC.VCLUI.Wait, System.Actions, System.Classes, System.SysUtils, System.Variants,
  Vcl.ActnList, Vcl.Controls, Vcl.DBGrids, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Forms, Vcl.Graphics,
  Vcl.Grids, Vcl.StdCtrls, Winapi.Windows;

type
  TMain = class sealed(TForm)
  {$REGION 'Components'}
    DataSource: TDataSource;
    FDConnection: TFDConnection;
    FDGUIxWaitCursor: TFDGUIxWaitCursor;
    FDLocalSQL: TFDLocalSQL;
    FDMemTableCities: TFDMemTable;
    FDMemTableCustomers: TFDMemTable;
    FDQuery: TFDQuery;
    FDStanStorageXMLLink: TFDStanStorageXMLLink;
    Grid: TDBGrid;
    Panel: TPanel;
    EditCitie: TEdit;
    ButtonSearch: TButton;
    ActionList: TActionList;
    ActionSearch: TAction;
  {$ENDREGION}
    procedure ActionSearchExecute(ASender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

var
  Main: TMain;

implementation

{$R *.dfm}

constructor TMain.Create(AOwner: TComponent);
begin
  inherited;
  FDMemTableCustomers.LoadFromFile('Clientes.xml');
  FDMemTableCities.LoadFromFile('Cidades.xml');

  FDConnection.Connected := True;
  FDLocalSQL.Active := True;
  FDQuery.Active := True;
end;

destructor TMain.Destroy;
begin
  FDQuery.Active := False;
  FDLocalSQL.Active := False;
  FDConnection.Connected := False;
  inherited;
end;

procedure TMain.ActionSearchExecute(ASender: TObject);
var
  LCitie: string;
begin
  LCitie := EditCitie.Text;
  FDQuery.Filter := 'UPPER(CIDADE) LIKE ''%' + LCitie.ToUpper + '%''';
  FDQuery.Filtered := not LCitie.Trim.IsEmpty;
end;

end.
