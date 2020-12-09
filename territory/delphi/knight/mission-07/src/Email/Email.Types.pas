unit Email.Types;

interface

uses
  IdSMTP, IdSSLOpenSSL, IdExplicitTLSClientServerBase;

type
  TSSLMethod = TIdSSLVersion;
  TSSLMOde = TIdSSLMode;
  TUseTLS = TIdUseTLS;
  TAuthType = TIdSMTPAuthenticationType;

  TSSLModeHelper = record Helper for TSSLMode
  private
    const Map: array[TSSLMode] of string = ('Unassigned', 'Client', 'Server', 'Both');
  public
    function ToInteger: Integer;
    function ToString: string;
    function Parse(const AIndex: Integer): TSSLMode;
    class function ToArray: TArray<TSSLMode>; static;
    class function ToStringArray: TArray<string>; static;
  end;

  TUseTLSHelper = record Helper for TUseTLS
  private
    const Map: array[TUseTLS] of string = ('No TLS support', 'Implicit TLS', 'Require TLS', 'Explicit TLS');
  public
    function ToInteger: Integer;
    function ToString: string;
    function Parse(const AIndex: Integer): TUseTLS;
    class function ToArray: TArray<TUseTLS>; static;
    class function ToStringArray: TArray<string>; static;
  end;

  TAuthTypeHelper = record Helper for TAuthType
  private
    const Map: array[TAuthType] of string = ('None', 'Default', 'SASL');
  public
    function ToInteger: Integer;
    function ToString: string;
    function Parse(const AIndex: Integer): TAuthType;
    class function ToArray: TArray<TAuthType>; static;
    class function ToStringArray: TArray<string>; static;
  end;

implementation

{ TSSLModeHelper }

function TSSLModeHelper.Parse(const AIndex: Integer): TSSLMode;
begin
  Result := TSSLMode(AIndex);
end;

class function TSSLModeHelper.ToArray: TArray<TSSLMode>;
var
  LEnum: TSSLMode;
begin
  SetLength(Result, Succ(Ord(High(TSSLMode))));
  for LEnum := Low(TSSLMode) to High(TSSLMode) do
  begin
    Result[Ord(LEnum)] := LEnum;
  end;
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
  LEnum: TSSLMode;
begin
  SetLength(Result, Length(TSSLMode.ToArray));
  for LEnum := Low(TSSLMode) to High(TSSLMode) do
  begin
    Result[LEnum.ToInteger] := Map[LEnum];
  end;
end;

{ TUseTLSHelper }

function TUseTLSHelper.Parse(const AIndex: Integer): TUseTLS;
begin
  Result := TUseTLS(AIndex);
end;

class function TUseTLSHelper.ToArray: TArray<TUseTLS>;
var
  LEnum: TUseTLS;
begin
  SetLength(Result, Succ(Ord(High(TUseTLS))));
  for LEnum := Low(TUseTLS) to High(TUseTLS) do
  begin
    Result[Ord(LEnum)] := LEnum;
  end;
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
  LEnum: TUseTLS;
begin
  SetLength(Result, Length(TUseTLS.ToArray));
  for LEnum := Low(TUseTLS) to High(TUseTLS) do
  begin
    Result[LEnum.ToInteger] := Map[LEnum];
  end;
end;

{ TAuthTypeHelper }

function TAuthTypeHelper.Parse(const AIndex: Integer): TAuthType;
begin
  Result := TAuthType(AIndex);
end;

class function TAuthTypeHelper.ToArray: TArray<TAuthType>;
var
  LEnum: TAuthType;
begin
  SetLength(Result, Succ(Ord(High(TAuthType))));
  for LEnum := Low(TAuthType) to High(TAuthType) do
  begin
    Result[Ord(LEnum)] := LEnum;
  end;
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
  LEnum: TAuthType;
begin
  SetLength(Result, Length(TAuthType.ToArray));
  for LEnum := Low(TAuthType) to High(TAuthType) do
  begin
    Result[LEnum.ToInteger] := Map[LEnum];
  end;
end;

end.

