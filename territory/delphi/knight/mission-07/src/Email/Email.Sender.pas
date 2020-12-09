unit Email.Sender;

interface

uses
  IdMessage, IdText, IdSMTP, IdSSLOpenSSL, IdExplicitTLSClientServerBase, Impl.Cryptography,
  System.Classes, System.SysUtils, Vcl.Forms;

type
  TEmailSender = class sealed(TObject)
  private
    FIdSMTP: TIdSMTP;
    FIdText: TIdText;
    FIdMessage: TIdMessage;
    FIOHandler: TIdSSLIOHandlerSocketOpenSSL;
    function GetHost: string;
    procedure SetHost(const Value: string);
    function GetUsername: string;
    procedure SetUsername(const Value: string);
    function GetPassword: string;
    procedure SetPassword(const Value: string);
    function GetPort: Word;
    procedure SetPort(const Value: Word);
    function GetBody: TArray<string>;
    procedure SetBody(const Value: TArray<string>);
    function GetSubject: string;
    procedure SetSubject(const Value: string);
    function GetRecipients: TArray<string>;
    procedure SetRecipients(const Value: TArray<string>);
    function GetMethod: TIdSSLVersion;
    function GetMode: TIdSSLMode;
    procedure SetMethod(const Value: TIdSSLVersion);
    procedure SetMode(const Value: TIdSSLMode);
    function GetUseTLS: TIdUseTLS;
    procedure SetUseTLS(const Value: TIdUseTLS);
    function GetAuthType: TIdSMTPAuthenticationType;
    procedure SetAuthType(const Value: TIdSMTPAuthenticationType);
    procedure OnFailedRecipient(Sender: TObject; const AAddress, ACode, AText: String;
      var VContinue: Boolean);
    procedure OnTLSNotAvailable(Asender: TObject; var VContinue: Boolean);
  public
    constructor Create;
    destructor Destroy; override;
    procedure AfterConstruction; override;

    procedure Send;

    { Message }
    property Subject: string read GetSubject write SetSubject;
    property Recipients: TArray<string> read GetRecipients write SetRecipients;
    property Body: TArray<string> read GetBody write SetBody;

    { STMP Configuration}
    property Host: string read GetHost write SetHost;
    property Username: string read GetUsername write SetUsername;
    property Password: string read GetPassword write SetPassword;
    property Port: Word read GetPort write SetPort;
    property UseTLS: TIdUseTLS read GetUseTLS write SetUseTLS;
    property AuthType: TIdSMTPAuthenticationType read GetAuthType write SetAuthType;

    { SSL Configuration }
    property Method: TIdSSLVersion read GetMethod write SetMethod;
    property Mode: TIdSSLMode read GetMode write SetMode;
  end;

implementation

constructor TEmailSender.Create;
begin
  FIdSMTP := TIdSMTP.Create(nil);
  FIdMessage := TIdMessage.Create(nil);
  FIdText := TIdText.Create(FIdMessage.MessageParts);
  FIOHandler := TIdSSLIOHandlerSocketOpenSSL.Create;
  FIdSMTP.OnFailedRecipient := OnFailedRecipient;
  FIdSMTP.OnTLSNotAvailable := OnTLSNotAvailable;
end;

destructor TEmailSender.Destroy;
begin
  FIOHandler.Free;
  FIdText.Free;
  FIdMessage.Free;
  FIdSMTP.Free;
  inherited;
end;

procedure TEmailSender.AfterConstruction;
begin
  inherited;
  FIdSMTP.ConnectTimeout := 30000;
  FIdSMTP.IOHandler := FIOHandler;
  FIdMessage.Encoding := TIdMessageEncoding.meMIME;
  FIdText.ContentType := 'text/plain; charset=iso-8859-1';
end;

function TEmailSender.GetAuthType: TIdSMTPAuthenticationType;
begin
  Result := FIdSMTP.AuthType;
end;

function TEmailSender.GetBody: TArray<string>;
begin
  Result := FIdText.Body.ToStringArray;
end;

function TEmailSender.GetHost: string;
begin
  Result := FIdSMTP.Host;
end;

function TEmailSender.GetMethod: TIdSSLVersion;
begin
  Result := FIOHandler.SSLOptions.Method;
end;

function TEmailSender.GetMode: TIdSSLMode;
begin
  Result := FIOHandler.SSLOptions.Mode;
end;

function TEmailSender.GetPassword: string;
begin
  Result := TCryptography.Encrypt(FIdSMTP.Password);
end;

function TEmailSender.GetPort: Word;
begin
  Result := FIdSMTP.Port;
end;

function TEmailSender.GetRecipients: TArray<string>;
begin
  Result := FIdMessage.Recipients.EMailAddresses.Split([', ']);
end;

function TEmailSender.GetSubject: string;
begin
  Result := FIdMessage.Subject;
end;

function TEmailSender.GetUsername: string;
begin
  Result := FIdSMTP.Username;
end;

function TEmailSender.GetUseTLS: TIdUseTLS;
begin
  Result := FIdSMTP.UseTLS;
end;

procedure TEmailSender.OnFailedRecipient(Sender: TObject; const AAddress, ACode, AText: String;
  var VContinue: Boolean);
begin
  raise Exception.Create('Error Message');
end;

procedure TEmailSender.Send;
begin
  FIdSMTP.Connect;
  try
    if FIdSMTP.Authenticate then
      FIdSMTP.SendMsg(FIdMessage);
  finally
    FIdSMTP.Disconnect;
  end;
end;

procedure TEmailSender.SetAuthType(const Value: TIdSMTPAuthenticationType);
begin
  FIdSMTP.AuthType := Value;
end;

procedure TEmailSender.SetBody(const Value: TArray<string>);
begin
  FIdText.Body.AddStrings(Value);
end;

procedure TEmailSender.SetHost(const Value: string);
begin
  FIdSMTP.Host := Value;
end;

procedure TEmailSender.SetMethod(const Value: TIdSSLVersion);
begin
  FIOHandler.SSLOptions.Method := Value;
end;

procedure TEmailSender.SetMode(const Value: TIdSSLMode);
begin
  FIOHandler.SSLOptions.Mode := Value;
end;

procedure TEmailSender.SetPassword(const Value: string);
begin
  FIdSMTP.Password := TCryptography.Decrypt(Value);
end;

procedure TEmailSender.SetPort(const Value: Word);
begin
  FIdSMTP.Port := Value;
end;

procedure TEmailSender.SetRecipients(const Value: TArray<string>);
begin
  FIdMessage.Recipients.EMailAddresses := string.Join(', ', Value);
  FIdMessage.CCList.EMailAddresses := string.Join(', ', Value);
  FIdMessage.BccList.EMailAddresses := string.Join(', ', Value);
end;

procedure TEmailSender.SetSubject(const Value: string);
begin
  FIdMessage.Subject := Value;
end;

procedure TEmailSender.SetUsername(const Value: string);
begin
  FIdSMTP.Username := Value;
  FIdMessage.From.Address := Value;
end;

procedure TEmailSender.SetUseTLS(const Value: TIdUseTLS);
begin
  FIdSMTP.UseTLS := Value;
end;

procedure TEmailSender.OnTLSNotAvailable(Asender: TObject; var VContinue: Boolean);
begin
  raise Exception.Create('siodioasd');
end;

end.

