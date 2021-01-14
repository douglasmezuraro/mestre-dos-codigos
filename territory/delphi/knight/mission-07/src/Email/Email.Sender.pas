unit Email.Sender;

interface

uses
  IdMessage, IdText, IdSMTP, IdSSLOpenSSL, IdExplicitTLSClientServerBase, IdAttachmentFile,
  Email.Cryptography, System.Classes, System.SysUtils, Email.DTO, Email.Exceptions;

type
  TEmailSender = class sealed
  strict private
    FIdSMTP: TIdSMTP;
    FIdText: TIdText;
    FIdMessage: TIdMessage;
    FIOHandler: TIdSSLIOHandlerSocketOpenSSL;
  public
    constructor Create(const AEmailDTO: TEmailDTO);
    destructor Destroy; override;
    procedure AfterConstruction; override;
    procedure Send;
  end;

implementation

constructor TEmailSender.Create(const AEmailDTO: TEmailDTO);
var
  LAttachment: string;
begin
  FIdSMTP := TIdSMTP.Create(nil);
  FIdMessage := TIdMessage.Create(nil);
  FIdText := TIdText.Create(FIdMessage.MessageParts);
  FIOHandler := TIdSSLIOHandlerSocketOpenSSL.Create;
  FIdSMTP.ConnectTimeout := 30000;
  FIdSMTP.IOHandler := FIOHandler;
  FIdMessage.Encoding := TIdMessageEncoding.meMIME;
  FIdText.ContentType := 'text/plain; charset=iso-8859-1';
  FIdSMTP.Host := AEmailDTO.Host;
  FIdSMTP.Username := AEmailDTO.Username;
  FIdMessage.From.Address := AEmailDTO.Username;
  FIdSMTP.Password := TCryptography.Decrypt(AEmailDTO.Password);
  FIdSMTP.Port := AEmailDTO.Port;
  FIdText.Body.AddStrings(AEmailDTO.Body);
  FIdMessage.Subject := AEmailDTO.Subject;
  FIdMessage.Recipients.EMailAddresses := AEmailDTO.Recipients;
  FIdMessage.CCList.EMailAddresses := AEmailDTO.CC;
  FIdMessage.BCCList.EMailAddresses := AEmailDTO.BCC;
  FIOHandler.SSLOptions.Method := AEmailDTO.IdSSLVersion;
  FIOHandler.SSLOptions.Mode := AEmailDTO.IdSSLMode;
  FIdSMTP.UseTLS := AEmailDTO.IdUseTLS;
  FIdSMTP.AuthType := AEmailDTO.IdSMTPAuthenticationType;

  for LAttachment in AEmailDTO.Attachments do
  begin
    TIdAttachmentFile.Create(FIdMessage.MessageParts, LAttachment);
  end;
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

  if FIdSMTP.Host.Trim.IsEmpty then
  begin
    raise EEmailHostCannotBeEmpty.Create('The host cannot be empty.');
  end;

  if FIdSMTP.Username.Trim.IsEmpty then
  begin
    raise EEmailUserNameCannotBeEmpty.Create('The username cannot be empty.');
  end;

  if FIdMessage.From.Address.Trim.IsEmpty then
  begin
    raise EEmailAddressCannotBeEmpty.Create('The address cannot be empty.');
  end;

  if FIdSMTP.Password.Trim.IsEmpty then
  begin
    raise EEmailPasswordCannotBeEmpty.Create('The password cannot be empty.');
  end;

  if FIdText.Body.ToString.Trim.IsEmpty then
  begin
    raise EEmailBodyCannotBeEmpty.Create('The body cannot be empty.');
  end;

  if FIdMessage.Subject.Trim.IsEmpty then
  begin
    raise EEmailSubjectCannotBeEmpty.Create('The subject cannot be empty.');
  end;

  if FIdMessage.Recipients.EMailAddresses.Trim.IsEmpty then
  begin
    raise EEmailRecipientsCannotBeEmpty.Create('The recipients cannot be empty.');
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

end.

