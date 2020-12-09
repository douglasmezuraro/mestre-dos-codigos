unit Email.Sender;

interface

uses
  IdMessage, IdText, IdSMTP, IdSSLOpenSSL, IdExplicitTLSClientServerBase, IdAttachmentFile,
  Impl.Cryptography, System.Classes, System.SysUtils, Vcl.Forms, Email.DTO;

type
  EEmailSenderArgumentException = class(EArgumentException);

  TEmailSender = class sealed
  strict private
    FIdSMTP: TIdSMTP;
    FIdText: TIdText;
    FIdMessage: TIdMessage;
    FIOHandler: TIdSSLIOHandlerSocketOpenSSL;
    FEmailDTO: TEmailDTO;
  private
    procedure Validate;
    procedure Build;
  public
    constructor Create(const ADTO: TEmailDTO);
    destructor Destroy; override;
    procedure AfterConstruction; override;
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
  FEmailDTO := ADTO;
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
  Build;
  Validate;
end;

procedure TEmailSender.Build;
var
  LAttachment: string;
begin
  FIdSMTP.Host := FEmailDTO.Host;
  FIdSMTP.Username := FEmailDTO.Username;
  FIdMessage.From.Address := FEmailDTO.Username;
  FIdSMTP.Password := TCryptography.Decrypt(FEmailDTO.Password);
  FIdSMTP.Port := FEmailDTO.Port;
  FIdText.Body.AddStrings(FEmailDTO.Body);
  FIdMessage.Subject := FEmailDTO.Subject;
  FIdMessage.Recipients.EMailAddresses := FEmailDTO.Recipients;
  FIdMessage.CCList.EMailAddresses := FEmailDTO.CC;
  FIdMessage.BCCList.EMailAddresses := FEmailDTO.BCC;
  FIOHandler.SSLOptions.Method := FEmailDTO.IdSSLVersion;
  FIOHandler.SSLOptions.Mode := FEmailDTO.IdSSLMode;
  FIdSMTP.UseTLS := FEmailDTO.IdUseTLS;
  FIdSMTP.AuthType := FEmailDTO.IdSMTPAuthenticationType;

  for LAttachment in FEmailDTO.Attachments do
  begin
    TIdAttachmentFile.Create(FIdMessage.MessageParts, LAttachment);
  end;
end;

procedure TEmailSender.Send;
begin
  FIdSMTP.Connect;
  try
    if FIdSMTP.Authenticate then
    begin
      FIdSMTP.Send(FIdMessage);
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
end;

end.

