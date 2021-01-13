unit Form.Main;

interface

uses
  System.Actions, System.Classes, System.RegularExpressions, System.UITypes, Vcl.ActnList,
  Vcl.Controls, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Forms, Vcl.StdCtrls, WebService.RegExLib;

type
  TMain = class sealed(TForm)
  {$REGION 'Visual Components'}
    EditEmail: TLabeledEdit;
    ActionList: TActionList;
    ActionValidate: TAction;
    ButtonValidate: TButton;
  {$ENDREGION}
    procedure ActionValidateExecute(ASender: TObject);
  strict private
    FWebService: WebServicesSoap;
  private
    procedure Validate;
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
  FWebService := WebService.RegExLib.GetWebServicesSoap(True);
end;

procedure TMain.ActionValidateExecute(ASender: TObject);
begin
  Validate;
end;

procedure TMain.Validate;
const
  EMAIL_PATTERN_ID: UInt16 = 3122;
  VALIDATE_MESSAGE: array[Boolean] of string = ('E-mail inválido.', 'E-mail válido.');
var
  LResult: Boolean;
  LEmailRegEx: RegExpDetails;
begin
  LEmailRegEx := FWebService.GetRegExpDetails(EMAIL_PATTERN_ID);
  try
    LResult := TRegEx.Create(LEmailRegEx.Regular_Expression).IsMatch(EditEmail.Text);
    MessageDlg(VALIDATE_MESSAGE[LResult], TMsgDlgType.mtInformation, [TMsgDlgBtn.mbYes], 0);
  finally
    LEmailRegEx.Free;
  end;
end;

end.

