unit Email;

interface

uses
  Email.Cryptography, Email.DTO, Email.Sender, Email.Exceptions, IdSMTP, IdSSLOpenSSL,
  IdExplicitTLSClientServerBase;

type
  TIdSSLVersion = IdSSLOpenSSL.TIdSSLVersion;
  TIdSSLMode = IdSSLOpenSSL.TIdSSLMode;
  TIdUseTLS = IdExplicitTLSClientServerBase.TIdUseTLS;
  TIdSMTPAuthenticationType = IdSMTP.TIdSMTPAuthenticationType;
  TEmailDTO = Email.DTO.TEmailDTO;
  TEmailSender = Email.Sender.TEmailSender;
  TCryptography = Email.Cryptography.TCryptography;

  EEmailSenderArgumentException = Email.Exceptions.EEmailSenderArgumentException;
  EEmailEmptyHost = Email.Exceptions.EEmailEmptyHost;
  EEmailEmptyUsername = Email.Exceptions.EEmailEmptyUsername;
  EEmailEmptyAddress = Email.Exceptions.EEmailEmptyAddress;
  EEmailEmptyPassword = Email.Exceptions.EEmailEmptyPassword;
  EEmailEmptyBody = Email.Exceptions.EEmailEmptyBody;
  EEmailEmptySubject = Email.Exceptions.EEmailEmptySubject;
  EEmailEmptyRecipients = Email.Exceptions.EEmailEmptyRecipients;

  TIdSSLVersionHelper = record Helper for TIdSSLVersion
  private
    const Map: array[TIdSSLVersion] of string = ('SSL v2', 'SSL v23', 'SSL v3', 'TLS v1', 'TLS v1.1', 'TLS v1.2');
  public
    function ToInteger: Integer;
    function ToString: string;
    class function Parse(const AIndex: Integer): TIdSSLVersion; static;
    class function ToArray: TArray<TIdSSLVersion>; static;
    class function ToStringArray: TArray<string>; static;
  end;

  TIdSSLModeHelper = record Helper for TIdSSLMode
  private
    const Map: array[TIdSSLMode] of string = ('Unassigned', 'Client', 'Server', 'Both');
  public
    function ToInteger: Integer;
    function ToString: string;
    class function Parse(const AIndex: Integer): TIdSSLMode; static;
    class function ToArray: TArray<TIdSSLMode>; static;
    class function ToStringArray: TArray<string>; static;
  end;

  TIdUseTLSHelper = record Helper for TIdUseTLS
  private
    const Map: array[TIdUseTLS] of string = ('No TLS support', 'Implicit TLS', 'Require TLS', 'Explicit TLS');
  public
    function ToInteger: Integer;
    function ToString: string;
    class function Parse(const AIndex: Integer): TIdUseTLS; static;
    class function ToArray: TArray<TIdUseTLS>; static;
    class function ToStringArray: TArray<string>; static;
  end;

  TIdSMTPAuthenticationTypeHelper = record Helper for TIdSMTPAuthenticationType
  private
    const Map: array[TIdSMTPAuthenticationType] of string = ('None', 'Default', 'SASL');
  public
    function ToInteger: Integer;
    function ToString: string;
    class function Parse(const AIndex: Integer): TIdSMTPAuthenticationType; static;
    class function ToArray: TArray<TIdSMTPAuthenticationType>; static;
    class function ToStringArray: TArray<string>; static;
  end;

implementation

{ TIdSSLVersionHelper }

class function TIdSSLVersionHelper.Parse(const AIndex: Integer): TIdSSLVersion;
begin
  Result := TIdSSLVersion(AIndex);
end;

class function TIdSSLVersionHelper.ToArray: TArray<TIdSSLVersion>;
var
  LEnum: TIdSSLVersion;
begin
  SetLength(Result, Succ(Ord(High(TIdSSLVersion))));
  for LEnum := Low(TIdSSLVersion) to High(TIdSSLVersion) do
  begin
    Result[Ord(LEnum)] := LEnum;
  end;
end;

function TIdSSLVersionHelper.ToInteger: Integer;
begin
  Result := Ord(Self);
end;

function TIdSSLVersionHelper.ToString: string;
begin
  Result := Map[Self];
end;

class function TIdSSLVersionHelper.ToStringArray: TArray<string>;
var
  LEnum: TIdSSLVersion;
begin
  SetLength(Result, Length(TIdSSLVersion.ToArray));
  for LEnum := Low(TIdSSLVersion) to High(TIdSSLVersion) do
  begin
    Result[LEnum.ToInteger] := Map[LEnum];
  end;
end;

{ TIdSSLModeHelper }

class function TIdSSLModeHelper.Parse(const AIndex: Integer): TIdSSLMode;
begin
  Result := TIdSSLMode(AIndex);
end;

class function TIdSSLModeHelper.ToArray: TArray<TIdSSLMode>;
var
  LEnum: TIdSSLMode;
begin
  SetLength(Result, Succ(Ord(High(TIdSSLMode))));
  for LEnum := Low(TIdSSLMode) to High(TIdSSLMode) do
  begin
    Result[Ord(LEnum)] := LEnum;
  end;
end;

function TIdSSLModeHelper.ToInteger: Integer;
begin
  Result := Ord(Self);
end;

function TIdSSLModeHelper.ToString: string;
begin
  Result := Map[Self];
end;

class function TIdSSLModeHelper.ToStringArray: TArray<string>;
var
  LEnum: TIdSSLMode;
begin
  SetLength(Result, Length(TIdSSLMode.ToArray));
  for LEnum := Low(TIdSSLMode) to High(TIdSSLMode) do
  begin
    Result[LEnum.ToInteger] := Map[LEnum];
  end;
end;

{ TIdUseTLSHelper }

class function TIdUseTLSHelper.Parse(const AIndex: Integer): TIdUseTLS;
begin
  Result := TIdUseTLS(AIndex);
end;

class function TIdUseTLSHelper.ToArray: TArray<TIdUseTLS>;
var
  LEnum: TIdUseTLS;
begin
  SetLength(Result, Succ(Ord(High(TIdUseTLS))));
  for LEnum := Low(TIdUseTLS) to High(TIdUseTLS) do
  begin
    Result[Ord(LEnum)] := LEnum;
  end;
end;

function TIdUseTLSHelper.ToInteger: Integer;
begin
  Result := Ord(Self);
end;

function TIdUseTLSHelper.ToString: string;
begin
  Result := Map[Self];
end;

class function TIdUseTLSHelper.ToStringArray: TArray<string>;
var
  LEnum: TIdUseTLS;
begin
  SetLength(Result, Length(TIdUseTLS.ToArray));
  for LEnum := Low(TIdUseTLS) to High(TIdUseTLS) do
  begin
    Result[LEnum.ToInteger] := Map[LEnum];
  end;
end;

{ TIdSMTPAuthenticationTypeHelper }

class function TIdSMTPAuthenticationTypeHelper.Parse(const AIndex: Integer): TIdSMTPAuthenticationType;
begin
  Result := TIdSMTPAuthenticationType(AIndex);
end;

class function TIdSMTPAuthenticationTypeHelper.ToArray: TArray<TIdSMTPAuthenticationType>;
var
  LEnum: TIdSMTPAuthenticationType;
begin
  SetLength(Result, Succ(Ord(High(TIdSMTPAuthenticationType))));
  for LEnum := Low(TIdSMTPAuthenticationType) to High(TIdSMTPAuthenticationType) do
  begin
    Result[Ord(LEnum)] := LEnum;
  end;
end;

function TIdSMTPAuthenticationTypeHelper.ToInteger: Integer;
begin
  Result := Ord(Self);
end;

function TIdSMTPAuthenticationTypeHelper.ToString: string;
begin
  Result := Map[Self];
end;

class function TIdSMTPAuthenticationTypeHelper.ToStringArray: TArray<string>;
var
  LEnum: TIdSMTPAuthenticationType;
begin
  SetLength(Result, Length(TIdSMTPAuthenticationType.ToArray));
  for LEnum := Low(TIdSMTPAuthenticationType) to High(TIdSMTPAuthenticationType) do
  begin
    Result[LEnum.ToInteger] := Map[LEnum];
  end;
end;

end.
