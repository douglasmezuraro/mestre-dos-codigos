unit Form.Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Comp.Client, FireDAC.Phys.SQLiteVDataSet, FireDAC.Comp.DataSet,
  FireDAC.Stan.Async, FireDAC.DApt, System.IOUtils, FireDAC.Stan.StorageXML, FireDAC.UI.Intf,
  FireDAC.VCLUI.Wait, FireDAC.Comp.UI, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys,
  FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, System.Actions, Vcl.ActnList,
  Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TMain = class sealed(TForm)
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
