unit Email.Sender;

interface

uses
  IdMessage, IdText, IdSMTP, IdSSLOpenSSL, IdExplicitTLSClientServerBase, Impl.Cryptography,
  System.Classes, System.SysUtils, Vcl.Forms, Email.DTO;

type
  EEmailSenderArgumentException = class(EArgumentException);

  TEmailSender = class sealed(TObject)
  strict private
    FIdSMTP: TIdSMTP;
    FIdText: TIdText;
    FIdMessage: TIdMessage;
    FIOHandler: TIdSSLIOHandlerSocketOpenSSL;
  private
    procedure Validate;
  public
    constructor Create(const ADTO: TEmailDTO);
    destructor Destroy; override;
    procedure Send;
  end;

implementation

constructor TEmailSender.Create(const ADTO: TEmailDTO);
begin
  FIdSMTP := TIdSMTP.Create(nil);
  FIdMessage := TIdMessage.Create(nil);
  FIdText := TIdText.Create(FIdMessage.MessageParts);
  FIOHandler := TIdSSLIOHandlerSocketOpenSSL.Create;

  FIdSMTP.ConnectTimeout := 30000;
  FIdSMTP.IOHandler := FIOHandler;
  FIdMessage.Encoding := TIdMessageEncoding.meMIME;
  FIdText.ContentType := 'text/plain; charset=iso-8859-1';

  FIdSMTP.Host := ADTO.Host;
  FIdSMTP.Username := ADTO.Username;
  FIdMessage.From.Address := ADTO.Username;
  FIdSMTP.Password := TCryptography.Decrypt(ADTO.Password);
  FIdSMTP.Port := ADTO.Port;
  FIdText.Body.AddStrings(ADTO.Body);
  FIdMessage.Subject := ADTO.Subject;
  FIdMessage.Recipients.EMailAddresses := string.Join(', ', ADTO.Recipients);
  FIdMessage.CCList.EMailAddresses := string.Join(', ', ADTO.Recipients);
  FIdMessage.BCCList.EMailAddresses := string.Join(', ', ADTO.Recipients);
  FIOHandler.SSLOptions.Method := ADTO.IdSSLVersion;
  FIOHandler.SSLOptions.Mode := ADTO.IdSSLMode;
  FIdSMTP.UseTLS := ADTO.IdUseTLS;
  FIdSMTP.AuthType := ADTO.IdSMTPAuthenticationType;

  Validate;
end;

destructor TEmailSender.Destroy;
begin
  FIOHandler.Free;
  FIdText.Free;
  FIdMessage.Free;
  FIdSMTP.Free;
  inherited;
end;

procedure TEmailSender.Send;
begin
  FIdSMTP.Connect;
  try
    if FIdSMTP.Authenticate then
    begin
      FIdSMTP.SendMsg(FIdMessage);
    end;
  finally
    FIdSMTP.Disconnect;
  end;
end;

procedure TEmailSender.Validate;
begin
  if FIdSMTP.Host.Trim.IsEmpty then
  begin
    raise EEmailSenderArgumentException.Create('The host cannot be empty.');
  end;

  if FIdSMTP.Username.Trim.IsEmpty then
  begin
    raise EEmailSenderArgumentException.Create('The username cannot be empty.');
  end;

  if FIdMessage.From.Address.Trim.IsEmpty then
  begin
    raise EEmailSenderArgumentException.Create('The address cannot be empty.');
  end;

  if FIdSMTP.Password.Trim.IsEmpty then
  begin
    raise EEmailSenderArgumentException.Create('The password cannot be empty.');
  end;

  // Precisa validar se valor é <c>Integer.0<c>?
  // FIdSMTP.Port := ADTO.Port;

  if FIdText.Body.Count = 0 then
  begin
    raise EEmailSenderArgumentException.Create('The body cannot be empty.');
  end;

  if FIdMessage.Subject.Trim.IsEmpty then
  begin
    raise EEmailSenderArgumentException.Create('The subject cannot be empty.');
  end;

  if FIdMessage.Recipients.EMailAddresses.Trim.IsEmpty then
  begin
    raise EEmailSenderArgumentException.Create('The recipients cannot be empty.');
  end;

  // Precisa validar se o valor é <c>TIdSSLModesslmUnassigned<c>?
  // FIOHandler.SSLOptions.Mode := ADTO.IdSSLMode;

  // Precisa validar se o valor é <c>.TIdUseTLSutNoTLSSupport<c>?
  // FIdSMTP.UseTLS := ADTO.IdUseTLS;

  // Precisa validar se o valor é <c>TIdSMTPAuthenticationType.satNone<c>?
  // FIdSMTP.AuthType := ADTO.IdSMTPAuthenticationType;
end;

end.

