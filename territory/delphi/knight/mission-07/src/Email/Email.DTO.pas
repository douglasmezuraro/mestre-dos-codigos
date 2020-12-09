unit Email.DTO;

interface

uses
  IdSMTP, IdSSLOpenSSL, IdExplicitTLSClientServerBase;

type
  TEmailDTO = record
  public
    Subject: string;
    Recipients: TArray<string>;
    Body: TArray<string>;
    Host: string;
    Username: string;
    Password: string;
    Port: Word;
    IdUseTLS: TIdUseTLS;
    IdSMTPAuthenticationType: TIdSMTPAuthenticationType;
    IdSSLVersion: TIdSSLVersion;
    IdSSLMode: TIdSSLMode
  end;

implementation

end.

