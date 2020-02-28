unit Impl.EmailSender;

interface

uses
  IdMessage,
  IdSMTP,
  IdSSLOpenSSL,
  IdExplicitTLSClientServerBase,
  Impl.Cryptography,
  Impl.EmailSender.Types,
  System.Classes,
  System.SysUtils;

type
  TEmailSender = class sealed
  private
    FSMTP: TIdSMTP;
    FMessage: TIdMessage;
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
    function GetMode: TSSLMode;
    procedure SetMethod(const Value: TIdSSLVersion);
    procedure SetMode(const Value: TSSLMode);
    function GetUseTLS: TUseTLS;
    procedure SetUseTLS(const Value: TUseTLS);
    function GetAuthType: TAuthType;
    procedure SetAuthType(const Value: TAuthType);
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
    property UseTLS: TUseTLS read GetUseTLS write SetUseTLS;
    property AuthType: TAuthType read GetAuthType write SetAuthType;

    { SSL Configuration }
    property Method: TIdSSLVersion read GetMethod write SetMethod;
    property Mode: TSSLMode read GetMode write SetMode;
  end;

implementation

constructor TEmailSender.Create;
begin
  FSMTP := TIdSMTP.Create(nil);
  FMessage := TIdMessage.Create(nil);
  FIOHandler := TIdSSLIOHandlerSocketOpenSSL.Create;
end;

destructor TEmailSender.Destroy;
begin
  FIOHandler.Free;
  FMessage.Free;
  FSMTP.Free;
  inherited;
end;

procedure TEmailSender.AfterConstruction;
begin
  inherited;
  FSMTP.IOHandler := FIOHandler;
  FMessage.Encoding := meMIME;
end;

function TEmailSender.GetAuthType: TAuthType;
begin
  Result := FSMTP.AuthType;
end;

function TEmailSender.GetBody: TArray<string>;
begin
  Result := FMessage.Body.ToStringArray;
end;

function TEmailSender.GetHost: string;
begin
  Result := FSMTP.Host;
end;

function TEmailSender.GetMethod: TIdSSLVersion;
begin
  Result := FIOHandler.SSLOptions.Method;
end;

function TEmailSender.GetMode: TSSLMode;
begin
  Result := FIOHandler.SSLOptions.Mode;
end;

function TEmailSender.GetPassword: string;
begin
  Result := TCryptography.EnDeCrypt(FSMTP.Password);
end;

function TEmailSender.GetPort: Word;
begin
  Result := FSMTP.Port;
end;

function TEmailSender.GetRecipients: TArray<string>;
begin
  Result := FMessage.Recipients.EMailAddresses.Split([', ']);
end;

function TEmailSender.GetSubject: string;
begin
  Result := FMessage.Subject;
end;

function TEmailSender.GetUsername: string;
begin
  Result := FSMTP.Username;
end;

function TEmailSender.GetUseTLS: TUseTLS;
begin
  Result := FSMTP.UseTLS;
end;

procedure TEmailSender.Send;
begin
  //TODO: Colocar dentro de uma anonymous thread

  FSMTP.Connect;
  try
    if FSMTP.Authenticate then
      FSMTP.SendMsg(FMessage);
  finally
    FSMTP.Disconnect;
  end;
end;

procedure TEmailSender.SetAuthType(const Value: TAuthType);
begin
  FSMTP.AuthType := Value;
end;

procedure TEmailSender.SetBody(const Value: TArray<string>);
begin
  FMessage.Body.AddStrings(Value);
end;

procedure TEmailSender.SetHost(const Value: string);
begin
  FSMTP.Host := Value;
end;

procedure TEmailSender.SetMethod(const Value: TIdSSLVersion);
begin
  FIOHandler.SSLOptions.Method := Value;
end;

procedure TEmailSender.SetMode(const Value: TSSLMode);
begin
  FIOHandler.SSLOptions.Mode := Value;
end;

procedure TEmailSender.SetPassword(const Value: string);
begin
  FSMTP.Password := TCryptography.EnDeCrypt(Value);
end;

procedure TEmailSender.SetPort(const Value: Word);
begin
  FSMTP.Port := Value;
end;

procedure TEmailSender.SetRecipients(const Value: TArray<string>);
begin
  FMessage.Recipients.EMailAddresses := string.Join(', ', Value);
end;

procedure TEmailSender.SetSubject(const Value: string);
begin
  FMessage.Subject := Value;
end;

procedure TEmailSender.SetUsername(const Value: string);
begin
  FSMTP.Username := Value;
  FMessage.From.Address := Value;
end;

procedure TEmailSender.SetUseTLS(const Value: TUseTLS);
begin
  FSMTP.UseTLS := Value;
end;

end.

