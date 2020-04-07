unit Form.Main;

interface

uses
  System.Actions,
  System.Classes,
  Vcl.ActnList,
  Vcl.Controls,
  Vcl.ExtCtrls,
  Vcl.Forms,
  Vcl.Graphics,
  Vcl.Mask,
  Vcl.StdCtrls,
  WebServices;

type
  TMain = class sealed(TForm)
    ActionList: TActionList;
    ActionSearch: TAction;
    GroupBoxAddress: TGroupBox;
    EditAddress: TLabeledEdit;
    EditNeibourhood: TLabeledEdit;
    EditCity: TLabeledEdit;
    EditUF: TLabeledEdit;
    GroupBoxSearch: TGroupBox;
    EditCEP: TMaskEdit;
    ButtonSearch: TButton;
    procedure ActionSearchExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
  strict private
    FWebService: AtendeCliente;
    function GetCEP: string;
    procedure SetCEP(const Value: string);
    function GetAddress: string;
    procedure SetAddress(const Value: string);
    function GetCity: string;
    procedure SetCity(const Value: string);
    function GetUF: string;
    procedure SetUF(const Value: string);
    function GetNeibourhood: string;
    procedure SetNeibourhood(const Value: string);
  private
    procedure Search;
  public
    constructor Create(AOwner: TComponent); override;
    property CEP: string read GetCEP write SetCEP;
    property Address: string read GetAddress write SetAddress;
    property Neibourhood: string read GetNeibourhood write SetNeibourhood;
    property City: string read GetCity write SetCity;
    property UF: string read GetUF write SetUF;
  end;

var
  Main: TMain;

implementation

{$R *.dfm}

constructor TMain.Create(AOwner: TComponent);
begin
  inherited;
  FWebService := WebServices.GetAtendeCliente(True);
end;

procedure TMain.ActionSearchExecute(Sender: TObject);
begin
  Search;
end;

procedure TMain.FormShow(Sender: TObject);
begin
  EditCEP.SetFocus;
end;

function TMain.GetAddress: string;
begin
  Result := EditAddress.Text;
end;

function TMain.GetCEP: string;
begin
  Result := EditCEP.Text;
end;

function TMain.GetCity: string;
begin
  Result := EditCity.Text;
end;

function TMain.GetNeibourhood: string;
begin
  Result := EditNeibourhood.Text;
end;

function TMain.GetUF: string;
begin
  Result := EditUF.Text;
end;

procedure TMain.Search;
var
  Data: EnderecoERP;
begin
  Data := FWebService.ConsultaCEP(CEP);
  try
    Address := Data.End_;
    Neibourhood := Data.Bairro;
    City := Data.Cidade;
    UF := Data.UF;
  finally
    Data.Free;
  end;
end;

procedure TMain.SetAddress(const Value: string);
begin
  EditAddress.Text := Value;
end;

procedure TMain.SetCEP(const Value: string);
begin
  EditCEP.Text := Value;
end;

procedure TMain.SetCity(const Value: string);
begin
  EditCity.Text := Value;
end;

procedure TMain.SetNeibourhood(const Value: string);
begin
  EditNeibourhood.Text := Value;
end;

procedure TMain.SetUF(const Value: string);
begin
  EditUF.Text := Value;
end;

end.

