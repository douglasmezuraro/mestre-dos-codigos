unit Form.Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, System.Actions, Vcl.ActnList,
  Impl.EmailSender, Impl.Cryptography, Vcl.ComCtrls, Impl.Types;

type
  TMain = class sealed(TForm)
    ActionList: TActionList;
    ActionSendEmail: TAction;
    PageControl: TPageControl;
    TabSheetMessage: TTabSheet;
    TabSheetConfiguration: TTabSheet;
    EditHost: TLabeledEdit;
    EditUsername: TLabeledEdit;
    EditPassword: TLabeledEdit;
    EditPort: TLabeledEdit;
    MemoBody: TMemo;
    Panel: TPanel;
    ButtonSendEmail: TButton;
    EditSubject: TLabeledEdit;
    EditRecepients: TLabeledEdit;
    GroupBoxSSL: TGroupBox;
    ComboBoxMethod: TComboBox;
    ComboBoxMode: TComboBox;
    LabelSSLMethod: TLabel;
    LabelSSLMode: TLabel;
    LabelBody: TLabel;
    ComboBoxUseTLS: TComboBox;
    LabelUseTLS: TLabel;
    ComboBoxAuthType: TComboBox;
    LabelAuthType: TLabel;
    procedure ActionSendEmailExecute(Sender: TObject);
  strict private
    function GetHost: string;
    procedure SetHost(const Value: string);
    function GetUsername: string;
    procedure SetUsername(const Value: string);
    function GetPassword: string;
    procedure SetPassword(const Value: string);
    function GetBody: TArray<string>;
    procedure SetBody(const Value: TArray<string>);
    function GetPort: Word;
    procedure SetPort(const Value: Word);
    function GetSubject: string;
    procedure SetSubject(const Value: string);
    function GetRecipients: TArray<string>;
    procedure SetRecipients(const Value: TArray<string>);
    function GetMethod: TSSLMethod;
    procedure SetMethod(const Value: TSSLMethod);
  private
    procedure SendEmail;
    function GetMode: TSSLMode;
    procedure SetMode(const Value: TSSLMode);
    function GetUseTLS: TUseTLS;
    procedure SetUseTLS(const Value: TUseTLS);
    function GetAuthType: TAuthType;
    procedure SetAuthType(const Value: TAuthType);
  public
    procedure AfterConstruction; override;

    { Message }
    property Subject: string read GetSubject write SetSubject;
    property Recipients: TArray<string> read GetRecipients write SetRecipients;
    property Body: TArray<string> read GetBody write SetBody;

    { SMTP Configuration }
    property Host: string read GetHost write SetHost;
    property Username: string read GetUsername write SetUsername;
    property Password: string read GetPassword write SetPassword;
    property Port: Word read GetPort write SetPort;
    property UseTLS: TUseTLS read GetUseTLS write SetUseTLS;
    property AuthType: TAuthType read GetAuthType write SetAuthType;

    { SSL Configuration }
    property Method: TSSLMethod read GetMethod write SetMethod;
    property Mode: TSSLMode read GetMode write SetMode;
  end;

var
  Main: TMain;

implementation

{$R *.dfm}

procedure TMain.ActionSendEmailExecute(Sender: TObject);
begin
  SendEmail;
end;

procedure TMain.AfterConstruction;

  procedure FillMethodComboBox;
  var
    Enum: TSSLMethod;
  begin
    for Enum := Low(TSSLMethod) to High(TSSLMethod) do
      ComboBoxMethod.Items.Add(Enum.ToString);
  end;

  procedure FillModeComboBox;
  var
    Enum: TSSLMode;
  begin
    for Enum := Low(TSSLMode) to High(TSSLMode) do
      ComboBoxMode.Items.Add(Enum.ToString);
  end;

  procedure FillUseTLSComboBox;
  var
    Enum: TUseTLS;
  begin
    for Enum := Low(TUseTLS) to High(TUseTLS) do
      ComboBoxUseTLS.Items.Add(Enum.ToString);
  end;

  procedure FillAuthTypeComboBox;
  var
    Enum: TAuthType;
  begin
    for Enum := Low(TAuthType) to High(TAuthType) do
      ComboBoxAuthType.Items.Add(Enum.ToString);
  end;

  procedure InitialConfig;
  begin
    Host       := 'smtp.office365.com';
    Username   := 'douglas.mezuraro@db1.com.br';
    Port       := 587;
    Subject    := 'E-mail test';
    Recipients := ['douglas.mezuraro@db1.com.br', 'douglasmez@gmail.com'];
    Body       := ['Mission 07', 'Author: Douglas Mezuraro', 'Last Modification: 28/02/2020'];
    Method     := TSSLMethod.sslvSSLv23;
    Mode       := TSSLMode.sslmClient;
    UseTLS     := TUseTLS.utUseImplicitTLS;
    AuthType   := TAuthType.satDefault;
  end;

begin
  inherited;
  PageControl.ActivePage := TabSheetMessage;

  FillMethodComboBox;
  FillModeComboBox;
  FillUseTLSComboBox;
  FillAuthTypeComboBox;

  InitialConfig;
end;

function TMain.GetAuthType: TAuthType;
begin
  Result.Parse(ComboBoxAuthType.ItemIndex);
end;

function TMain.GetBody: TArray<string>;
begin
  Result := MemoBody.Lines.ToStringArray;
end;

function TMain.GetHost: string;
begin
  Result := EditHost.Text;
end;

function TMain.GetMethod: TSSLMethod;
begin
  Result.Parse(ComboBoxMethod.ItemIndex);
end;

function TMain.GetMode: TSSLMode;
begin
  Result.Parse(ComboBoxMode.ItemIndex);
end;

function TMain.GetPassword: string;
begin
  Result := EditPassword.Text;
end;

function TMain.GetPort: Word;
begin
  Result := StrToIntDef(EditPort.Text, Word.MinValue);
end;

function TMain.GetRecipients: TArray<string>;
begin
  Result := string(EditRecepients.Text).Split([', ']);
end;

function TMain.GetSubject: string;
begin
  Result := EditSubject.Text;
end;

function TMain.GetUsername: string;
begin
  Result := EditUsername.Text;
end;

function TMain.GetUseTLS: TUseTLS;
begin
  Result.Parse(ComboBoxUseTLS.ItemIndex);
end;

procedure TMain.SendEmail;
var
  Sender: TEmailSender;
begin
  Sender := TEmailSender.Create;
  try
    Sender.Host := Host;
    Sender.Username := Username;
    Sender.Password := TCryptography.EnDeCrypt(Password);
    Sender.Port := Port;
    Sender.Subject := Subject;
    Sender.Recipients := Recipients;
    Sender.Body := Body;

    Sender.Method := Method;
    Sender.Mode := Mode;
    Sender.UseTLS := UseTLS;
    Sender.AuthType := AuthType;

    Sender.Send;
  finally
    Sender.Free;
  end;
end;

procedure TMain.SetAuthType(const Value: TAuthType);
begin
  ComboBoxAuthType.ItemIndex := Value.ToInteger;
end;

procedure TMain.SetBody(const Value: TArray<string>);
begin
  MemoBody.Clear;
  MemoBody.Lines.AddStrings(Value);
end;

procedure TMain.SetHost(const Value: string);
begin
  EditHost.Text := Value;
end;

procedure TMain.SetMethod(const Value: TSSLMethod);
begin
  ComboBoxMethod.ItemIndex := Value.ToInteger;
end;

procedure TMain.SetMode(const Value: TSSLMode);
begin
  ComboBoxMode.ItemIndex := Value.ToInteger;
end;

procedure TMain.SetPassword(const Value: string);
begin
  EditPassword.Text := Value;
end;

procedure TMain.SetPort(const Value: Word);
begin
  EditPort.Text := Value.ToString;
end;

procedure TMain.SetRecipients(const Value: TArray<string>);
begin
  EditRecepients.Text := string.Join(', ', Value);
end;

procedure TMain.SetSubject(const Value: string);
begin
  EditSubject.Text := Value;
end;

procedure TMain.SetUsername(const Value: string);
begin
  EditUsername.Text := Value;
end;

procedure TMain.SetUseTLS(const Value: TUseTLS);
begin
  ComboBoxUseTLS.ItemIndex := Value.ToInteger;
end;

end.

