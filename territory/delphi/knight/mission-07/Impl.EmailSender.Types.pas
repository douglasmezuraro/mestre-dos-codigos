unit Impl.EmailSender.Types;

interface

uses
  IdSMTP,
  IdSSLOpenSSL,
  IdExplicitTLSClientServerBase;

type
  TSSLMethod = TIdSSLVersion;
  TSSLMOde = TIdSSLMode;
  TUseTLS = TIdUseTLS;
  TAuthType = TIdSMTPAuthenticationType;

  TSSLMethodHelper = record Helper for TSSLMethod
  public
    function ToInteger: Integer;
    function ToString: string;
    function Parse(const Index: Integer): TSSLMethod;
  end;

  TSSLModeHelper = record Helper for TSSLMode
  public
    function ToInteger: Integer;
    function ToString: string;
    function Parse(const Index: Integer): TSSLMode;
  end;

  TUseTLSHelper = record Helper for TUseTLS
  public
    function ToInteger: Integer;
    function ToString: string;
    function Parse(const Index: Integer): TUseTLS;
  end;

  TAuthTypeHelper = record Helper for TAuthType
  public
    function ToInteger: Integer;
    function ToString: string;
    function Parse(const Index: Integer): TAuthType;
  end;

implementation

{ TSSLMethodHelper }

function TSSLMethodHelper.Parse(const Index: Integer): TSSLMethod;
begin
  Result := TSSLMethod(Index);
end;

function TSSLMethodHelper.ToInteger: Integer;
begin
  Result := Ord(Self);
end;

function TSSLMethodHelper.ToString: string;
const
  Map: array[TSSLMethod] of string = ('SSL v2', 'SSL v23', 'SSL v3', 'TLS v1', 'TLS v1.1', 'TLS v1.2');
begin
  Result := Map[Self];
end;

{ TSSLModeHelper }

function TSSLModeHelper.Parse(const Index: Integer): TSSLMode;
begin
  Result := TSSLMode(Index);
end;

function TSSLModeHelper.ToInteger: Integer;
begin
  Result := Ord(Self);
end;

function TSSLModeHelper.ToString: string;
const
  Map: array[TSSLMode] of string = ('Unassigned', 'Client', 'Server', 'Both');
begin
  Result := Map[Self];
end;

{ TUseTLSHelper }

function TUseTLSHelper.Parse(const Index: Integer): TUseTLS;
begin
  Result := TUseTLS(Index);
end;

function TUseTLSHelper.ToInteger: Integer;
begin
  Result := Ord(Self);
end;

function TUseTLSHelper.ToString: string;
const
  Map: array[TUseTLS] of string = ('No TLS support', 'Implicit TLS', 'Require TLS', 'Explicit TLS');
begin
  Result := Map[Self];
end;

{ TAuthTypeHelper }

function TAuthTypeHelper.Parse(const Index: Integer): TAuthType;
begin
  Result := TAuthType(Index);
end;

function TAuthTypeHelper.ToInteger: Integer;
begin
  Result := Ord(Self);
end;

function TAuthTypeHelper.ToString: string;
const
  Map: array[TAuthType] of string = ('None', 'Default', 'SASL');
begin
  Result := Map[Self];
end;

end.

