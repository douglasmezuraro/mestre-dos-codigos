unit Form.Main;

interface

uses
  System.Actions, System.Classes, Vcl.ActnList, Vcl.Controls, Vcl.ExtCtrls, Vcl.Forms, Vcl.Graphics,
  Vcl.Mask, Vcl.StdCtrls, WebService.Correios;

type
  TMain = class sealed(TForm)
  {$REGION 'Visual Components'}
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
  {$ENDREGION}
    procedure ActionSearchExecute(ASender: TObject);
    procedure FormShow(ASender: TObject);
  strict private
    FWebService: AtendeCliente;
  private
    procedure Search;
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
  FWebService := WebService.Correios.GetAtendeCliente(True);
end;

procedure TMain.ActionSearchExecute(ASender: TObject);
begin
  Search;
end;

procedure TMain.FormShow(ASender: TObject);
begin
  EditCEP.SetFocus;
end;

procedure TMain.Search;
var
  LData: EnderecoERP;
begin
  LData := FWebService.ConsultaCEP(EditCEP.Text);
  try
    EditAddress.Text := LData.End_;
    EditNeibourhood.Text := LData.Bairro;
    EditCity.Text := LData.Cidade;
    EditUF.Text := LData.UF;
  finally
    LData.Free;
  end;
end;

end.

