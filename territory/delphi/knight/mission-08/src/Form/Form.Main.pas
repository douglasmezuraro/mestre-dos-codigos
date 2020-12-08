unit Form.Main;

interface

uses
  Data.Bind.Components, Data.Bind.ObjectScope, Data.DB, Datasnap.DBClient, Helper.DBGrid,
  IPPeerClient, REST.Authenticator.OAuth, REST.Client, REST.Response.Adapter, System.Actions,
  System.Classes, System.SysUtils, Vcl.ActnList, Vcl.Controls, Vcl.DBGrids, Vcl.ExtCtrls,
  Vcl.Forms, Vcl.Grids, Vcl.StdCtrls;

type
  TMain = class sealed(TForm)
  {$REGION 'Visual Components'}
    Panel: TPanel;
    Grid: TDBGrid;
    ButtonSearch: TButton;
    ActionList: TActionList;
    ActionSearch: TAction;
    RestClient: TRESTClient;
    DataSetAdapter: TRESTResponseDataSetAdapter;
    DataSet: TClientDataSet;
    DataSource: TDataSource;
    Response: TRESTResponse;
    Authenticator: TOAuth2Authenticator;
    Request: TRESTRequest;
    EditUser: TEdit;
  {$ENDREGION}
    procedure ActionSearchExecute(Sender: TObject);
  private
    procedure Search;
  end;

var
  Main: TMain;

implementation

{$R *.dfm}

procedure TMain.ActionSearchExecute(Sender: TObject);
begin
  Search;
end;

procedure TMain.Search;
begin
  Request.ResourceSuffix := EditUser.Text;
  Request.Execute;

  Grid.FitColumns;
end;


end.

