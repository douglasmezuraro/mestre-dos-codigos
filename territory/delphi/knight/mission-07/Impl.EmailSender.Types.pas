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
  private
    const Map: array[TSSLMethod] of string = ('SSL v2', 'SSL v23', 'SSL v3', 'TLS v1', 'TLS v1.1', 'TLS v1.2');
  public
    function ToInteger: Integer;
    function ToString: string;
    function Parse(const Index: Integer): TSSLMethod;
    class function ToArray: TArray<TSSLMethod>; static;
    class function ToStringArray: TArray<string>; static;
  end;

  TSSLModeHelper = record Helper for TSSLMode
  private
    const Map: array[TSSLMode] of string = ('Unassigned', 'Client', 'Server', 'Both');
  public
    function ToInteger: Integer;
    function ToString: string;
    function Parse(const Index: Integer): TSSLMode;
    class function ToArray: TArray<TSSLMode>; static;
    class function ToStringArray: TArray<string>; static;
  end;

  TUseTLSHelper = record Helper for TUseTLS
  private
    const Map: array[TUseTLS] of string = ('No TLS support', 'Implicit TLS', 'Require TLS', 'Explicit TLS');
  public
    function ToInteger: Integer;
    function ToString: string;
    function Parse(const Index: Integer): TUseTLS;
    class function ToArray: TArray<TUseTLS>; static;
    class function ToStringArray: TArray<string>; static;
  end;

  TAuthTypeHelper = record Helper for TAuthType
  private
    const Map: array[TAuthType] of string = ('None', 'Default', 'SASL');
  public
    function ToInteger: Integer;
    function ToString: string;
    function Parse(const Index: Integer): TAuthType;
    class function ToArray: TArray<TAuthType>; static;
    class function ToStringArray: TArray<string>; static;
  end;

implementation

{ TSSLMethodHelper }

function TSSLMethodHelper.Parse(const Index: Integer): TSSLMethod;
begin
  Result := TSSLMethod(Index);
end;

class function TSSLMethodHelper.ToArray: TArray<TSSLMethod>;
var
  Enum: TSSLMethod;
begin
  SetLength(Result, Succ(Ord(High(TSSLMethod))));
  for Enum := Low(TSSLMethod) to High(TSSLMethod) do
    Result[Ord(Enum)] := Enum;
end;

function TSSLMethodHelper.ToInteger: Integer;
begin
  Result := Ord(Self);
end;

function TSSLMethodHelper.ToString: string;
begin
  Result := Map[Self];
end;

class function TSSLMethodHelper.ToStringArray: TArray<string>;
var
  Enum: TSSLMethod;
begin
  SetLength(Result, Length(TSSLMethod.ToArray));
  for Enum := Low(TSSLMethod) to High(TSSLMethod) do
    Result[Enum.ToInteger] := Map[Enum];
end;

{ TSSLModeHelper }

function TSSLModeHelper.Parse(const Index: Integer): TSSLMode;
begin
  Result := TSSLMode(Index);
end;

class function TSSLModeHelper.ToArray: TArray<TSSLMode>;
var
  Enum: TSSLMode;
begin
  SetLength(Result, Succ(Ord(High(TSSLMode))));
  for Enum := Low(TSSLMode) to High(TSSLMode) do
    Result[Ord(Enum)] := Enum;
end;

function TSSLModeHelper.ToInteger: Integer;
begin
  Result := Ord(Self);
end;

function TSSLModeHelper.ToString: string;
begin
  Result := Map[Self];
end;

class function TSSLModeHelper.ToStringArray: TArray<string>;
var
  Enum: TSSLMode;
begin
  SetLength(Result, Length(TSSLMode.ToArray));
  for Enum := Low(TSSLMode) to High(TSSLMode) do
    Result[Enum.ToInteger] := Map[Enum];
end;

{ TUseTLSHelper }

function TUseTLSHelper.Parse(const Index: Integer): TUseTLS;
begin
  Result := TUseTLS(Index);
end;

class function TUseTLSHelper.ToArray: TArray<TUseTLS>;
var
  Enum: TUseTLS;
begin
  SetLength(Result, Succ(Ord(High(TUseTLS))));
  for Enum := Low(TUseTLS) to High(TUseTLS) do
    Result[Ord(Enum)] := Enum;
end;

function TUseTLSHelper.ToInteger: Integer;
begin
  Result := Ord(Self);
end;

function TUseTLSHelper.ToString: string;
begin
  Result := Map[Self];
end;

class function TUseTLSHelper.ToStringArray: TArray<string>;
var
  Enum: TUseTLS;
begin
  SetLength(Result, Length(TUseTLS.ToArray));
  for Enum := Low(TUseTLS) to High(TUseTLS) do
    Result[Enum.ToInteger] := Map[Enum];
end;

{ TAuthTypeHelper }

function TAuthTypeHelper.Parse(const Index: Integer): TAuthType;
begin
  Result := TAuthType(Index);
end;

class function TAuthTypeHelper.ToArray: TArray<TAuthType>;
var
  Enum: TAuthType;
begin
  SetLength(Result, Succ(Ord(High(TAuthType))));
  for Enum := Low(TAuthType) to High(TAuthType) do
    Result[Ord(Enum)] := Enum;
end;

function TAuthTypeHelper.ToInteger: Integer;
begin
  Result := Ord(Self);
end;

function TAuthTypeHelper.ToString: string;
begin
  Result := Map[Self];
end;

class function TAuthTypeHelper.ToStringArray: TArray<string>;
var
  Enum: TAuthType;
begin
  SetLength(Result, Length(TAuthType.ToArray));
  for Enum := Low(TAuthType) to High(TAuthType) do
    Result[Enum.ToInteger] := Map[Enum];
end;

end.

