unit Form.Main;

interface

uses
  System.Actions,
  System.Classes,
  System.RegularExpressions,
  System.UITypes,
  Vcl.ActnList,
  Vcl.Controls,
  Vcl.Dialogs,
  Vcl.ExtCtrls,
  Vcl.Forms,
  Vcl.StdCtrls,
  WebServices;

type
  TMain = class sealed(TForm)
    EditEmail: TLabeledEdit;
    ActionList: TActionList;
    ActionValidate: TAction;
    ButtonValidate: TButton;
    procedure ActionValidateExecute(Sender: TObject);
  strict private
    FEmailRegEx: RegExpDetails;
    function GetEmail: string;
    procedure SetEmail(const Value: string);
  private
    function Validate: Boolean;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Email: string read GetEmail write SetEmail;
  end;

var
  Main: TMain;

implementation

{$R *.dfm}

procedure TMain.ActionValidateExecute(Sender: TObject);
const
  VALIDATE_MESSAGE: array[Boolean] of string = ('E-mail inválido.', 'E-mail válido.');
begin
  MessageDlg(VALIDATE_MESSAGE[Validate], TMsgDlgType.mtInformation, [TMsgDlgBtn.mbYes], 0);
end;

constructor TMain.Create(AOwner: TComponent);
const
  EMAIL_PATTERN = 3122;
begin
  inherited;
  FEmailRegEx := WebServices.GetWebServicesSoap(True).GetRegExpDetails(EMAIL_PATTERN);
end;

destructor TMain.Destroy;
begin
  FEmailRegEx.Free;
  inherited;
end;

function TMain.GetEmail: string;
begin
  Result := EditEmail.Text;
end;

procedure TMain.SetEmail(const Value: string);
begin
  EditEmail.Text := Value;
end;

function TMain.Validate: Boolean;
begin
  Result := TRegEx.Create(FEmailRegEx.Regular_Expression).IsMatch(Email);
end;

end.

