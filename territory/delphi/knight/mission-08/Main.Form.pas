unit Main.Form;

interface

uses
  Data.Bind.Components,
  Data.Bind.ObjectScope,
  Data.DB,
  Datasnap.DBClient,
  Helper.DBGrid,
  IPPeerClient,
  REST.Authenticator.OAuth,
  REST.Client,
  REST.Response.Adapter,
  System.Actions,
  System.Classes,
  System.SysUtils,
  Vcl.ActnList,
  Vcl.Controls,
  Vcl.DBGrids,
  Vcl.ExtCtrls,
  Vcl.Forms,
  Vcl.Grids,
  Vcl.StdCtrls;

type
  TMain = class sealed(TForm)
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
    procedure ActionSearchExecute(Sender: TObject);
  strict private
    function GetUser: string;
    procedure SetUser(const Value: string);
  private
    procedure Search;
  public
    property User: string read GetUser write SetUser;
  end;

var
  Main: TMain;

implementation

{$R *.dfm}

procedure TMain.ActionSearchExecute(Sender: TObject);
begin
  Search;
end;

function TMain.GetUser: string;
begin
  Result := EditUser.Text;
end;

procedure TMain.Search;
begin
  Request.Resource := User;
  Request.Execute;

  Grid.FitColumns;
end;

procedure TMain.SetUser(const Value: string);
begin
  EditUser.Text := Value;
end;

end.

